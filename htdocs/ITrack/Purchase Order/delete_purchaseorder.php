<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Delete purchaseorder');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['id']))
{
    extract($_GET);

    $page_from = htmlentities($_GET['page_from']);
    $filter_used = htmlentities($_GET['filter_used']);
    $filter_field_used = htmlentities($_GET['filter_field_used']);

    require_once 'subclasses/purchaseorder.php';
    $dbh_purchaseorder = new purchaseorder;
    $dbh_purchaseorder->set_where("id='$id'");
    if($result = $dbh_purchaseorder->make_query())
    {
        $data = $result->fetch_assoc();
        extract($data);
        
        $data = explode('-',$DateOfDelivery);
        $DateOfDelivery_year = $data[0];
        $DateOfDelivery_month = $data[1];
        $DateOfDelivery_day = $data[2];        
        $data = explode('-',$Date);
        $year = $data[0];
        $month = $data[1];
        $day = $data[2];
    }

    require_once 'subclasses/orderdetails.php';
    $dbh_purchaseorder = new orderdetails;
    $dbh_purchaseorder->set_fields('Quantity, Inventory');
    $dbh_purchaseorder->set_where("id='$id'");
    if($result = $dbh_purchaseorder->make_query())
    {
        $num_orderdetails = $dbh_purchaseorder->num_rows;
        for($a=0; $a<$num_orderdetails; $a++)
        {
            $data = $result->fetch_row();
            $cf_orderdetails_Quantity[$a] = $data[0];
            $cf_orderdetails_Inventory[$a] = $data[1];
        }
    }


}
elseif(xsrf_guard())
{
    extract($_POST);
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header("location: listview_purchaseorder.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    elseif($_POST['delete'])
    {
        log_action('Pressed delete button', $_SERVER[PHP_SELF]);
        require_once 'subclasses/purchaseorder.php';
        require_once 'validation_class.php';
        $dbh_purchaseorder = new purchaseorder;
        $validator = new validation;

        $dbh_purchaseorder->del($_POST);

        require_once 'subclasses/orderdetails.php';
        $dbh_purchaseorder = new orderdetails;
        $dbh_purchaseorder->del($_POST);


        header("location: listview_purchaseorder.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }
}
require_once 'subclasses/purchaseorder_html.php';
$html = new purchaseorder_html;
$html->draw_header('Delete purchaseorder', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);

echo "<input type=hidden name='id' value='$id'>";

$html->detail_view = TRUE;
$html->draw_controls('off',TRUE,'Delete Record',TRUE,'container_mid_huge');


$cf_orderdetails_Inventory_query = "SELECT inventory.id AS `New_id`, inventory.Name FROM inventory";
$cf_orderdetails_Inventory_list_value = "New_id";
$cf_orderdetails_Inventory_list_items = array('Name');

$multifield_settings = array(
                             'field_labels' => array('Quantity','Inventory'),
                             'field_controls' => array('draw_text_field_mf','draw_select_field_from_query_mf'),
                             'field_parameters' => array(
                                                    array('cf_orderdetails_Quantity','text'),
                                                        array($cf_orderdetails_Inventory_query, $cf_orderdetails_Inventory_list_value, $cf_orderdetails_Inventory_list_items,'cf_orderdetails_Inventory')
                                                        )
                            );
$html->detail_view = TRUE;
$html->draw_multifield_auto('Orderdetails', $multifield_settings, 'num_orderdetails');


$html->draw_controls_multifield_end('delete');

$html->draw_footer();