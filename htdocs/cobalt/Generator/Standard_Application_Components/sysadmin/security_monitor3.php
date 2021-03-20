<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require 'path.php';
init_cobalt('Security Monitor');

if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if(isset($_GET['DateTimeOptions']))
{
    extract($_GET);

    $TimeStart = $_GET['TimeStart'];
    $TimeEnd = $_GET['TimeEnd'];
    $Username = $_GET['Username'];
    $Module = $_GET['Module'];
    $DateTimeOptions=$_GET['DateTimeOptions'];
    $UserOptions=$_GET['UserOptions'];
    $ModuleOptions=$_GET['ModuleOptions'];

    $settings="<br />";
    if($DateTimeOptions=="ViewAll")
    {
        $settings.= "No date and time range. <br />";
        $TimeFilter= "1=1";
    }
    else
    {
        $settings.= "Start search at ". DATE("F d Y, g:i a",$TimeStart)." and end at ". DATE("F d Y, g:i a",$TimeEnd)." <br />";
        $TimeFilter = "datetime >= '$TimeStart' AND datetime <= '$TimeEnd'";
    }

    if($UserOptions=="ViewAll")
    {
        $settings.="View all users. <br />";
        $UserFilter = "1=1";
    }
    else 
    {
        $settings.="View only user '".$Username."'.<br />";
        $UserFilter = "user = '$Username'";
    }

    if($ModuleOptions=="ViewAll")
    {
        $settings.="View all events in all modules. <br />";
        $ModuleFilter="1=1";
    }
    else
    {
        $settings.="View only events at module '".$Module."'<br />";
        $ModuleFilter="module LIKE '%$Module%'";
    }

    if($KeywordSearch=="Off")
    {
        $settings.="No keywords used to filter results. <br />";
        $KeywordFilter="1=1";
    }
    else
    {
        $settings.="Used the following keyword(s) as filter: '".$Keyword."'<br />";
        $KeywordFilter="action LIKE '%$Keyword%'";
    }

    if($IPAddressOptions=="Off")
    {
        $settings.="No IP address used to filter results. <br />";
        $IPAddressFilter="1=1";
    }
    else
    {
        $settings.="Used the following as IP address filter: '".$IPAddress."'<br />";
        $IPAddressFilter="ip_address LIKE '%$IPAddress%'";
    }
}

if(!isset($start)) $start=0;

$data_con = new data_abstraction;
$data_con->set_fields("entry_id, ip_address, user, datetime, action, module");
$data_con->set_table("`system_log`");
$data_con->set_where("$TimeFilter AND $UserFilter AND $ModuleFilter AND $KeywordFilter AND $IPAddressFilter");
$data_con->set_order("entry_id");

?>
<html>
<head><title>Security Monitor :: Printer-Friendly Version</title>
</head>
<body>
<?php 
$html_writer = new html;
$html_writer->draw_page_title('Security Monitor');
echo $settings;
?>

<input type=hidden name=TimeFilter value="<?php echo $TimeFilter;?>">
<input type=hidden name=UserFilter value="<?php echo $UserFilter;?>">
<input type=hidden name=ModuleFilter value="<?php echo $ModuleFilter;?>">
<input type=hidden name=KeywordFilter value="<?php echo $KeywordFilter;?>">
<input type=hidden name=IPAddressFilter value="<?php echo $IPAddressFilter;?>">
<input type=hidden name=settings value="<?php echo $settings;?>">
<table border=1 width=100% cellpadding0 cellspacing=0>
<tr>
    <td>Entry ID</td>
    <td>IP Address</td>
    <td>User</td>
    <td>Timestamp</td>
    <td>Action</td>
    <td>Module</td>
</tr>

<?php
    if($result = $data_con->make_query())
    {
        $numrows = $data_con->num_rows;

        if($numrows == 1) $record = 'record';
        else $record = 'records';

        while($row = $result->fetch_assoc())
        {
            extract($row);
            echo "<tr><td> $entry_id </td><td> $ip_address </td><td> $user </td><td>" . date("l, F d, Y -- h:i:s a", $datetime) ."</td><td> $action </td><td> $module </td> </tr>\n";
        }
        $result->close();
    }
    else die("Error getting log entries: " . $data_con->error);
?>
</table>
</body>
</html>
