<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require_once 'path.php';
init_cobalt('Delete user');
if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['username']))
{
    extract($_GET);
    require_once 'subclasses/user.php';
    $dbh_user = new user;
    $dbh_user->set_where("username='$username'");
    if($result = $dbh_user->make_query())
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
        header("location: listview_user.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }

    elseif($_POST['delete'])
    {
        log_action('Pressed delete button', $_SERVER[PHP_SELF]);
        require_once 'subclasses/user.php';
        require_once 'validation_class.php';
        $dbh_user = new user;
        $validator = new validation;

        $dbh_user->del($_POST);
        header("location: listview_user.php?filter_field=$filter_field_used&filter=$filter_used&page_from=$page_from");
    }
}
require_once 'subclasses/user_html.php';
$html = new user_html;
$html->draw_header('Delete user', $message, $message_type);
$html->draw_listview_referrer_info($filter_field_used, $filter_used, $page_from);
echo "<input type=hidden name='username' value='$username'>";
$html->detail_view = TRUE;
$html->draw_controls('delete');
$html->draw_footer();