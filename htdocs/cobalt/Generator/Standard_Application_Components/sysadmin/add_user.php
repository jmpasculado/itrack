<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Add user');
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
        header("location: listview_user.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    if($_POST['submit'])
    {
        log_action('Pressed submit button', $_SERVER[PHP_SELF]);

        require_once 'validation_class.php';
        require_once 'subclasses/user.php';
        $dbh_user = new user;
        $validator = new validation;

        $message .= $dbh_user->sanitize($_POST);
        extract($_POST);

        if($dbh_user->check_uniqueness($_POST)) ;
        else $message = "Record already exists with the same primary identifiers!";

        if($message=="")
        {
            //Hash the password using default Cobalt password hashing technique
            $_POST['password'] = cobalt_password_hash('NEW',$_POST['password'], $_POST['username'], $_POST['salt'], $_POST['iteration'], $_POST['method']);
            $dbh_user->add($_POST);
            header("location: listview_user.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
        }
    }
}
require_once 'subclasses/user_html.php';
$html = new user_html;
$html->draw_header('Add user', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);
$html->draw_controls('add');
$html->draw_footer();
