<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Add customer');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['filter_field_used']) && isset($_GET['filter_used']) && isset($_GET['page_from']))
{
    $page_from = htmlentities($_GET['page_from']);
    $filter_used = htmlentities($_GET['filter_used']);
    $filter_field_used = htmlentities($_GET['filter_field_used']);
}

if(xsrf_guard())
{
    extract($_POST);
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header("location: listview_customer.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    if($_POST['submit'])
    {
        log_action('Pressed submit button', $_SERVER[PHP_SELF]);


        require_once 'validation_class.php';
        require_once 'subclasses/customer.php';
        $dbh_customer = new customer;
        $validator = new validation;

        $message .= $dbh_customer->sanitize($_POST);
        extract($_POST);

        if($dbh_customer->check_uniqueness($_POST)) ;
        else $message = "Record already exists with the same primary identifiers!";

        if($message=="")
        {
            $dbh_customer->add($_POST);
            

            header("location: listview_customer.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
        }
    }
}
require_once 'subclasses/customer_html.php';
$html = new customer_html;
$html->draw_header('Add customer', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);

$html->draw_controls('add');

$html->draw_footer();