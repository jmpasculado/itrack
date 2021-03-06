<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Delete customer');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['id']))
{
    extract($_GET);

    $page_from = htmlentities($_GET['page_from']);
    $filter_used = htmlentities($_GET['filter_used']);
    $filter_field_used = htmlentities($_GET['filter_field_used']);

    require_once 'subclasses/customer.php';
    $dbh_customer = new customer;
    $dbh_customer->set_where("id='$id'");
    if($result = $dbh_customer->make_query())
    {
        $data = $result->fetch_assoc();
        extract($data);

    }


}
elseif(xsrf_guard())
{
    extract($_POST);
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header("location: listview_customer.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    elseif($_POST['delete'])
    {
        log_action('Pressed delete button', $_SERVER[PHP_SELF]);
        require_once 'subclasses/customer.php';
        require_once 'validation_class.php';
        $dbh_customer = new customer;
        $validator = new validation;

        $dbh_customer->del($_POST);


        header("location: listview_customer.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }
}
require_once 'subclasses/customer_html.php';
$html = new customer_html;
$html->draw_header('Delete customer', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);

echo "<input type=hidden name='id' value='$id'>";

$html->detail_view = TRUE;

$html->draw_controls('delete');

$html->draw_footer();