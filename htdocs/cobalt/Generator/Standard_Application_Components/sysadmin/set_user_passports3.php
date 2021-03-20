<?php
//******************************************************************
//This file was generated by Cobalt, a rapid application development 
//framework developed by JV Roig (jvroig@jvroig.com).
//
//Cobalt on the web: http://cobalt.jvroig.com
//******************************************************************
require 'path.php';
init_cobalt('Set User Passports');

if(!isset($_POST['form_key'])) log_action("Module Access", $_SERVER['PHP_SELF']);

if ($_GET['Username'] != "")
{
    $Username = $_GET['Username'];
    $fromSuccess="YES";
}

if(xsrf_guard())
{
    
    if($_POST['cancel']) 
    {
        log_action('Pressed cancel button', $_SERVER[PHP_SELF]);
        header('location: ' . HOME_PAGE);
        exit();
    }
    
    extract($_POST);
    
    if($role!='') $_POST['roleButton'] = TRUE;
    
    if(($_POST['find']) || ($_POST['roleButton']) || ($fromSuccess=="YES"))
    {
        $data_con = new data_abstraction;
        $data_con->set_fields('a.person_id, b.user_type, c.first_name, c.middle_name, c.last_name');
        $data_con->set_table('user a, user_types b, person c');
        $data_con->set_where("a.username='$Username' AND a.user_type_id = b.user_type_id AND a.person_id = c.person_id");
        $result = $data_con->make_query();
        $numrows = $data_con->num_rows;
        $data_con->close_db();
        
        if($numrows==1)
        {
            $data = $result->fetch_assoc();
            extract($data);
            $Name = $first_name . ' ' . $middle_name . ' ' . $last_name;
            $Type = $user_type;
            
            if($role!='')
            {
                require_once 'subclasses/user_role_links.php';
                $obj_role = new user_role_links;
                $obj_role->get_user_role_links($role);
                $arrLinkName = $obj_role->arr_link_name;
                $numLinks = $obj_role->num_rows;
                $obj_role->close_db();
                $showPermissions=TRUE;
            }
        }
        elseif($numrows==0) 
        {
            $message = 'No match found for username you entered.';
            $message_type = 'error';
            $_POST['passportButton'] = FALSE;
            $_POST['find'] = FALSE;
            $Name="";
            $Type="";
        }
        
    }
    
    if($_POST['btn_submit'])
    {
        if($exclusive==TRUE)
        {
            //Delete all existing permissions, so that the assigned role
            //will be the exclusive role of the user.
            $dbh = new data_abstraction();
            $dbh->set_query_type('DELETE');
            $dbh->set_table('user_passport');
            $dbh->set_where("username='$Username'");
            $dbh->make_query();
            $dbh->close_db();
        }
        
        //Get the role permissions
        require_once 'subclasses/user_role_links.php';
        $obj_role = new user_role_links;
        $obj_role->get_user_role_links($role);
        $arrLink = $obj_role->arr_link;
        $numLinks = $obj_role->num_rows;
        $obj_role->close_db();
        
        //Assign permissions to user
        foreach($arrLink as $link_id)
        {
            $dbh = new data_abstraction();
            $dbh->set_query_type('SELECT');
            $dbh->set_table('user_passport');
            $dbh->set_where("username='$Username' AND link_id='$link_id'");
            $dbh->make_query();
            if($dbh->num_rows == 0)
            {
                $dbh->set_query_type('INSERT');
                $dbh->set_fields('username, link_id');
                $dbh->set_values("'$Username','$link_id'");
                $dbh->make_query();
            }
            $dbh->close_db();
        }
        
        $message = 'Success! User passport has been updated.';
        $message_type='system';
    }
}
$html_writer = new html;
$html_writer->draw_header('Set User Passports', $message, $message_type);
?>

<div class="container_mid_huge2">
<fieldset class="top"> Role-Based Access Control Interface</fieldset>
<fieldset class="middle">
<table class="input_form" width="900">
<tr><td><a class="listview" href="set_user_passports.php">[Set Permissions Per User]</a> :: <a class="listview" href="set_user_passports2.php">[View and Remove Permissions Per Module]</a> :: [Role-Based Access Control Interface]<hr></td>
</table>
<table width=75% border=0 cellpadding=2 cellspacing=2 align=center class=tableContent>
<tr><td align=right> Username: </td><td colspan=3><input type=text name="Username" value="<?php echo $Username; ?>"> <input type=submit name=find value="FIND" class=button1></td></tr>
<tr><td align=right> Full Name: </td><td><input type=text name="Name" size=30 value="<?php echo $Name; ?>" readonly></td>
    <td align=right> User Type: </td><td><input type=text name="Type" value="<?php echo $Type; ?>" readonly></td></tr>
<tr><td align=right> Role: </td><td colspan="3">
<?php
$query="SELECT role_id, role AS `role_name` FROM user_role ORDER BY role";
$value='role_id';
$items=array('role_name');
$html_writer->draw_select_field_from_query($query, $value, $items, '','role',FALSE, FALSE,'','onChange="this.form.submit()"');
?>
<input type="checkbox" id="exclusive" name="exclusive" value="YES"><label for="exclusive"> Exclusive Role</td>
</tr>
</table>

<?php
if($showPermissions)
{
    echo '<table width="700" align="center" class="listView">';
    echo '<tr class="listRowHead"><td colspan="2">Permissions</td></tr>';
    if(is_array($arrLinkName))
    {
        for($a=0; $a<$numLinks; $a+=2)
        {
            if($a%4==0) $class='listRowEven';
            else $class='listRowOdd';
            
            echo '<tr class="' . $class . '">';
            echo '<td>' . $arrLinkName[$a] . '</td>';
            
            $b = $a+1;
            if(isset($arrLinkName[$b])) echo '<td>' . $arrLinkName[$b] . '</td>';
            else echo '<td> &nbsp; </td>';
                             
            echo '</tr>';
        }
        echo '<tr><td colspan="2" align="center">
                <input type="submit" name="btn_submit" value="ASSIGN ROLE" class="button1">
              </td></tr>';
    }
    else
    {
        echo '<tr><td align="center"> No permissions set for this role </td></tr>';
    }
    echo '</table>';
}
?>
</fieldset>
</div>

<?php $html_writer->draw_footer();
