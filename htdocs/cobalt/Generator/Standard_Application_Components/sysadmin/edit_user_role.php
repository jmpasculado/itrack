<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Edit user role');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['role_id']))
{
    extract($_GET);
    require_once 'subclasses/user_role.php';
    $dbh_user_role = new user_role;
    $dbh_user_role->set_where("role_id='$role_id'");
    if($result = $dbh_user_role->make_query())
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
        header("location: listview_user_role.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    if($_POST['submit'])
    {
        log_action('Pressed submit button', $_SERVER[PHP_SELF]);

        require_once 'validation_class.php';
        require_once 'subclasses/user_role.php';
        $dbh_user_role = new user_role;
        $validator = new validation;

        $message .= $dbh_user_role->sanitize($_POST);
        extract($_POST);

        if($dbh_user_role->check_uniqueness_for_editing($_POST)) ;
        else $message = "Record already exists with the same primary identifiers!";

        if($message=="")
        {
            $dbh_user_role->edit($_POST);
            header("location: listview_user_role.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
        }
    }
}
require_once 'subclasses/user_role_html.php';
$html = new user_role_html;
$html->draw_header('Edit user role', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);
echo "<input type=hidden name='role_id' value='$role_id'>";
$html->draw_controls('edit');
$html->draw_footer();
