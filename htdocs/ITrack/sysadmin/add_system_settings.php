<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Add system settings');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['filter_used']) && isset($_GET['page_from']))
{
    extract($_GET);
}

if(xsrf_guard())
{
    extract($_POST);
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header("location: listview_system_settings.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    if($_POST['submit'])
    {
        log_action('Pressed submit button', $_SERVER[PHP_SELF]);

        require_once 'validation_class.php';
        require_once 'subclasses/system_settings.php';
        $dbh_system_settings = new system_settings;
        $validator = new validation;

        $message .= $dbh_system_settings->sanitize($_POST);
        extract($_POST);

        if($dbh_system_settings->check_uniqueness($_POST)) ;
        else $message = "Record already exists with the same primary identifiers!";

        if($message=="")
        {
            $dbh_system_settings->add($_POST);
            header("location: listview_system_settings.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
        }
    }
}
require_once 'subclasses/system_settings_html.php';
$html = new system_settings_html;
$html->draw_header('Add system settings', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);
$html->draw_controls('add');
$html->draw_footer();
