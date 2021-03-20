<?php
require '../Core/SCV2_Core.php';
init_SCV2();

if(isset($_GET['DB_ID']) AND $_GET['DB_ID'] > 0)
{
    //$DB_ID was passed, signalling that redirection came from option after creating the connection.
    //Short-circuit the process to simulate the choosing of this connection and hitting the submit button.

    $_SESSION['formKey'] ='x';
    $_POST['formKey']='x';
    $_POST['Submit'] = TRUE;
    $_POST['DB_Connection_ID'] = $_GET['DB_ID'];
}


if($_POST['formKey'] == $_SESSION['formKey'])
{
    if($_POST['Cancel']) header("location: ListView_Tables.php");


    if($_POST['Submit'])
    {
        extract($_POST);
        $errMsg = scriptCheckIfNull('DB Connection', $DB_Connection_ID);


        //Verify that the DB_Connection_ID supplied is valid for this project/
        $mysqli = connect_DB();
        $mysqli->real_query("SELECT * FROM database_connection WHERE Project_ID='$_SESSION[Project_ID]' AND DB_Connection_ID='$DB_Connection_ID'");
        if($result = $mysqli->use_result())
        {
            while($row = $result->fetch_assoc())
            {
                //Nothing
            }
            $num_rows = $result->num_rows;
            $result->close();
        }

        if($num_rows == 0)
        {
            $errMsg="Invalid database connection supplied. Please specify a valid connection from the drop-down list below";
        }

        if($errMsg=="")
        {
            $time_start = microtime(true);
            
            //Get the database credentials supplied, establish connection to server.
            $mysqli = connect_DB();
            $mysqli->real_query("SELECT `Hostname`, `Username`, `Password`, `Database`, `DB_Connection_Name` FROM database_connection WHERE DB_Connection_ID='$DB_Connection_ID'");
            if($result = $mysqli->store_result())
            {
                $data = $result->fetch_assoc();
                extract($data);
            }
            else die('Error getting database credentials: '. $mysqli->error);
            $mysqli->close();

            //...this is where we establish connection to server using retrieved credentials.
            $mysqli = @new mysqli($Hostname, $Username, $Password, $Database);
            if (mysqli_connect_errno())
            {
                $errMsg = "There seems to be an error in the database connection you specified.";
               	drawHeader($errMsg);
                drawPageTitle('Import Tables', 'Cobalt cannot connect to the database using the database credentials specified in the chosen connection.');
                echo '<div class="container_mid">
                      <fieldset class="top">
                      &nbsp;
                      </fieldset>
                      <fieldset class="middle">
                            To fix this error, try the following:<br /><br />
                            <ul>
                                <li> Go back to Database Connections and verify that you entered the correct
                                     HOSTNAME, DATABASE NAME, USERNAME and PASSWORD. <br><br>
                                <li> Log in to MySQL or phpMyAdmin and verify that the database you entered in
                                     Database Connections exists. <br><br>
                                <li> Also in MySQL/phpMyAdmin, verify that the user you entered in Database
                                     Connections exists.<br><br>
                                <li> Also in MySQL/phpMyAdmin, verify that the password you entered for the connection is
                                     the same password assigned to the user.<br><br>
                             </ul>
                      </table>
                      </fieldset>
                      <fieldset class="bottom">
                      <input type="submit" value="BACK" name="Back">
                      </fieldset>
                      </div>';
                drawFooter();
                die();
            }
            

            if($tablesReady==FALSE)
            {

                //Now let's get all the tables in the database.
                //NOTE: We should skip tables that are from SCV2 framework: system_settings, user, user_links, etc.
                $SCV2_tables = array('person','system_log','system_settings','system_skins','user','user_links',
                                      'user_passport','user_passport_groups','user_role','user_role_links','user_types');
                $tables_found = array();
                $mysqli->real_query("SHOW TABLES");
                if($result = $mysqli->store_result())
                {
                    for($a=0; $a<$result->num_rows; $a++)
                    {
                        $data = $result->fetch_row();
                        if(!in_array($data[0], $SCV2_tables)) $tables_found[] = $data[0];
                    }
                    $ShowTables=TRUE;
                }
                else die('Error getting tables: ' . $mysqli->error());
            }
            else
            {
                //Create a new database object, using SCV2 connection.
                //We will use this object to insert records into SCV2 based on retrieved table and field info.
                $SCV2_con  = connect_DB();

                foreach($checkbox as $key=>$current_table)
                {
                    //Check if a table with this name already exists and delete it if it does exist.
                    $result2 = $SCV2_con->query("SELECT Table_ID FROM `table` WHERE Table_Name = '$current_table' AND Project_ID='$_SESSION[Project_ID]'");
                    if($result2->num_rows > 0)
                    {

                        $param = $result2->fetch_array();
                        queryDeleteTable($param, $SCV2_con);
                        $result2->close();                        
                    }


                    $SCV2_con->query("OPTIMIZE TABLE `table_fields`");

                    //Get new Table_ID
                    $result2 = $SCV2_con->query("SELECT MAX(Table_ID) AS `Max_ID` FROM `table`");
                    $data = $result2->fetch_assoc();
                    $result2->close();
                    $Table_ID = $data['Max_ID'];
                    $Table_ID++;	

                    $SCV2_con->real_query("INSERT INTO `table`(Table_ID, Project_ID, DB_Connection_ID, Table_Name, Remarks) 
                                                        VALUES('$Table_ID', 
                                                               '$_SESSION[Project_ID]', 
                                                               '$DB_Connection_ID', 
                                                               '$current_table', 
                                                               '')"
                                         );

                    $add_file = 'add_' . $current_table . '.php';
                    $edit_file = 'edit_' . $current_table . '.php';
                    $detail_file = 'detailview_' . $current_table . '.php';
                    $list_file = 'listview_' . $current_table . '.php';
                    $delete_file = 'delete_' . $current_table . '.php';
                    $CSV_file = 'csv_' . $current_table . '.php';

                    if($folder[$key] != '')
                    {
                        $add_file = $folder[$key] . '/' . $add_file;
                        $edit_file = $folder[$key] . '/' . $edit_file;
                        $detail_file = $folder[$key] . '/' . $detail_file;
                        $list_file = $folder[$key] . '/' . $list_file;
                        $delete_file = $folder[$key] . '/' . $delete_file;
                        $CSV_file = $folder[$key] . '/' . $CSV_file;
                    }
                    $SCV2_con->real_query("INSERT INTO `table_pages`(Table_ID, Page_ID, Path_Filename) 
                                                            VALUES('$Table_ID','1','$add_file'),
                                                                  ('$Table_ID','2','$edit_file'),
                                                                  ('$Table_ID','3','$detail_file'),
                                                                  ('$Table_ID','4','$list_file'),
                                                                  ('$Table_ID','5','$delete_file'),
                                                                  ('$Table_ID','6','$CSV_file')");

                    $mysqli->real_query("SHOW COLUMNS FROM `$current_table`");
                    if($result2 = $mysqli->store_result())
                    {
                        for($b=0; $b<$result2->num_rows; $b++)
                        {
                            $data = $result2->fetch_assoc();
                            $field_name = $data['Field'];
                            $field_type = $data['Type'];
                            $field_key = $data['Key'];
                            $field_extra = $data['Extra'];

                            $control_type = '';
                            $no_parentheses = array('double','float','date','text','tinytext','mediumtext','longtext');
                            if(!in_array($field_type, $no_parentheses))
                            {
                                $x = strpos($field_type, '(');
                                $y = strpos($field_type, ')');
                                if($x>0)
                                {
                                    $data_type = substr($field_type, 0, $x);
                                    if($data_type != 'enum') $length = substr($field_type, $x+1, $y-$x-1);
                                    else $length = '255';
                                }
                                else 
                                {
                                    $errMsg .= "Currently unsupported data type has been used: '$field_type' for `$field_name` in table `$current_table`. This has been ignored and replaced with Varchar(255). <br>";
                                    $data_type = 'varchar';
                                    $length = '255';
                                }
                            }
                            else
                            {
                                $data_type = $field_type;
                                $length = 0;
                            }

                            $control_type='textbox';
                            switch($data_type)
                            {
                                case 'binary'       :
                                case 'varbinary'    : $data_type = 'binary'; break;

                                case 'tinyint'      :
                                case 'mediumint'    : 
                                case 'bigint'       :
                                case 'int'          : $data_type = 'integer'; break;

                                case 'enum'         :
                                case 'char'         :
                                case 'varchar'      : $data_type = 'varchar'; break;

                                case 'bool'         : $data_type = 'bool'; break;

                                case 'double'       :
                                case 'float'        : $data_type = 'double or float'; break;

                                case 'text'         :
                                case 'tinytext'     :
                                case 'mediumtext'   :
                                case 'longtext'     : $data_type = 'text';
                                                      $control_type = 'textarea';
                                                      break;
                                
                                case 'date'         : $control_type = 'date controls'; break;
                                
                                default:
                            }

                            //Some field names are to be interpreted as needing a textarea
                            $textareaFieldNames = array('ADDRESS',
                                                        'COMMENT','COMMENTS',
                                                        'DESCRIPTION',
                                                        'REMARK','REMARKS');
                            if(in_array(strtoupper($field_name), $textareaFieldNames))
                            {
                                $data_type = 'text';
                                $control_type = 'textarea';
                            }

                            $in_listview = 'yes'; //this is the default, might be changed by some conditions found below
                            $label = str_replace('_',' ',$field_name);
                            $label = ucwords($label);
                            if($field_key=="PRI") $attribute = 'primary key';
                            else $attribute = 'required';
                            if($field_extra == 'auto_increment') 
                            {
                                $control_type='none';
                                $in_listview = 'no';
                            }

                            //Get new Field_ID
                            $result3 = $SCV2_con->query("SELECT MAX(Field_ID) AS `Max_ID` FROM `table_fields`");
                            $data = $result3->fetch_assoc();
                            $result3->close();
                            $Field_ID = $data['Max_ID'];
                            $Field_ID++;

                            $SCV2_con->real_query("INSERT INTO `table_fields`(Field_ID, Table_ID, Field_Name, Data_Type, Length, Attribute, Control_Type, Label, In_Listview) 
                                                                VALUES('$Field_ID', 
                                                                       '$Table_ID', 
                                                                       '$field_name', 
                                                                       '$data_type',
                                                                       '$length',
                                                                       '$attribute', 
                                                                       '$control_type',
                                                                       '$label',
                                                                       '$in_listview')");
                        }
                    }
                    else die('Error getting columns of table: ' . $mysqli->error());
                }
                $time_end = microtime(true);
                $process_time = $time_end - $time_start;

                //Draw success page.
                drawHeader();
                drawPageTitle('Successfully Imported Tables', 
                              'Cobalt successfully imported the tables you have chosen. 
                               The process took ' . number_format($process_time,5,'.',',') . 
                               ' seconds.<br>
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                               <input type=submit name=BACK value=BACK>', 'system');
                if($errMsg != '')
                {
                    displayInfo('<b>Table Import Notes:</b> <br />' . $errMsg);
                }
                drawFooter();
                die();
            }
        }
    }
}
else $ShowTables = FALSE;
drawHeader();
if($errMsg=='')
{
    $errMsg ='Cobalt will import all tables it can find using the database connection you specify.';
    $msgType = 'info'; 
}
drawPageTitle('Import Tables', $errMsg, $msgType);
?>

<script language="JavaScript" type="text/JavaScript">
function checkAll(field)
{
    if(field.length > 1)
    {
        for (i = 0; i < field.length; i++)
    	    field[i].checked = true ;
    }
    else field.checked = true;
}
function uncheckAll(field)
{
    if(field.length > 1)
    {
        for (i = 0; i < field.length; i++)
    	    field[i].checked = false ;
    }
    else field.checked = false;
}
</script>

<?php
if($ShowTables==FALSE)
{
    displayTip('Cobalt can handle multiple databases. <br />Add as many Database Connections pointing to different 
                databases as you need and import all of their tables here, one connection at a time.');

    ?>
    <div class="container_mid">
    <fieldset class="top">
    Import Tables
    </fieldset>

    <fieldset class="middle">
    <table class="input_form">
    <?php
	drawSelectField('drawDBConnection', 'DB Connection', 'DB_Connection_ID');
	echo '<input type="hidden" name="tablesReady" value="0">';
	?>
    </table>
    </fieldset>
    <fieldset class="bottom">
    <?php
    drawSubmitCancel();
    ?>
    </fieldset>
    </div>
    <?php	
}
else
{
	echo '<input type="hidden" name="tablesReady" value="1">';	
	echo '<input type="hidden" name="DB_Connection_ID" value="' . $DB_Connection_ID . '">';	
    ?>
    <div class="container_mid_huge">
    <fieldset class="container">
        <fieldset class="top">
        Import Tables
        </fieldset>

        <fieldset class="middle">
        <table width="100%" border="1" class="listView">
        <?php
		    echo '<tr><td colspan="2">
		                <input type=submit name=BACK value=BACK class=button1>
		                <input type=button name=CHECK value="CHECK ALL" class=button1 onClick=\'checkAll(checkfield);\'>
		                <input type=button name=UNCHECK value="UNCHECK ALL" class=button1 onClick=\'uncheckAll(checkfield);\'>
		              </td></tr>';
		    echo '<tr class="listRowHead"><td> Table </td><td> Folder / Subdirectory </td></tr>';
		    for($a=0; $a<count($tables_found); $a++)
		    {
			    if($a%2==0) $class='listRowEven';
			    else $class='listRowOdd';
			    echo "<tr class=\"$class\"><td><input type=\"checkbox\" ID='checkfield' name='checkbox[$a]' value='$tables_found[$a]' checked> $tables_found[$a] </td><td>";
			    drawTextField(' ', "folder[$a]", FALSE, 'text', FALSE);
			    echo '</td></tr>' . "\n";
		    }
	    ?>
        </table>
       </fieldset>
        <fieldset class="bottom">
        <?php
        drawSubmitCancel();
        ?>
        </fieldset>
        
    </fieldset>
    <br>
    </div>
    <?php
}
?>

<?php
drawFooter();
