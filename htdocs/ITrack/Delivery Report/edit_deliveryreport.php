<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Edit deliveryreport');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['id']))
{
    extract($_GET);

    $page_from = htmlentities($_GET['page_from']);
    $filter_used = htmlentities($_GET['filter_used']);
    $filter_field_used = htmlentities($_GET['filter_field_used']);

    require_once 'subclasses/deliveryreport.php';
    $dbh_deliveryreport = new deliveryreport;
    $dbh_deliveryreport->set_where("id='$id'");
    if($result = $dbh_deliveryreport->make_query())
    {
        $data = $result->fetch_assoc();
        extract($data);

        
        $data = explode('-',$Date);
        $year = $data[0];
        $month = $data[1];
        $day = $data[2];
    }


}
elseif(xsrf_guard())
{
    extract($_POST);
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header("location: listview_deliveryreport.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    if($_POST['submit'])
    {
        log_action('Pressed submit button', $_SERVER[PHP_SELF]);

        $Date = $year . '-' . $month . '-' . $day;

        $_POST['Date'] = $Date;
        require_once 'validation_class.php';
        require_once 'subclasses/deliveryreport.php';
        $dbh_deliveryreport = new deliveryreport;
        $validator = new validation;

        $message .= $dbh_deliveryreport->sanitize($_POST);
        extract($_POST);

        if($dbh_deliveryreport->check_uniqueness_for_editing($_POST)) ;
        else $message = "Record already exists with the same primary identifiers!";

        if($message=="")
        {
            $dbh_deliveryreport->edit($_POST);


            header("location: listview_deliveryreport.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
        }
    }
}
require_once 'subclasses/deliveryreport_html.php';
$html = new deliveryreport_html;
$html->draw_header('Edit deliveryreport', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);
echo "<input type=hidden name='id' value='$id'>";


$html->draw_controls('edit');

$html->draw_footer();