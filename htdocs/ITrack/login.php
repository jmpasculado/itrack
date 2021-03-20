<?php
$start = microtime(true);
define('PROCESS_START_TIME', $start);
session_start();

if($_SESSION['logged'] == 'Logged')
{
    header("location: main.php");
}

require_once 'core/html_class.php';
require_once 'core/data_abstraction_class.php';
require_once 'core/validation_class.php';
require_once 'core/cobalt_core.php';
require_once 'core/global_config.php';

if($_POST['form_key'] === $_SESSION['cobalt_form_keys'][$_SERVER['PHP_SELF']])
{
    if($_POST['Submit'])
    {
        $error_message = '';
        extract($_POST);

        require_once 'core/cobalt_core.php';
        init_cobalt();
        $data_con = new data_abstraction;
        $mysqli = $data_con->connect_db();
        $clean_username = $mysqli->real_escape_string($username);
        $clean_password = cobalt_password_hash('RECREATE', $mysqli->real_escape_string($password), $clean_username);
        $mysqli->real_query("SELECT `username`, `password`, `skin_id` FROM `user` WHERE `username`='$clean_username' AND `password`='$clean_password'");
        if($result = $mysqli->use_result())
        {
            if($data = $result->fetch_assoc())
            {
                $result->close();
                extract($data);
                
                $data_con = new data_abstraction;
                $data_con->set_fields('skin_name, header, footer, css');
                $data_con->set_table('system_skins');
                $data_con->set_where("skin_id='$skin_id'");
                $result = $data_con->make_query();
                $numrows = $data_con->num_rows;
                $data_con->close_db();

                $_SESSION['logged'] = 'Logged';
                $_SESSION['user'] = $username;
                
                if($numrows==1)
                {
                    $data = $result->fetch_assoc();
                    extract($data);
                    $_SESSION['header'] = $header;
                    $_SESSION['footer'] = $footer;
                    $_SESSION['skin'] = $skin_name;
                    $_SESSION['css'] = $css;
                }

                log_action('Logged in', $_SERVER[PHP_SELF]);
                header("location: start.php");
                exit();
            }
            else $error_message = "Check username and password.";
        }
        else die($mysqli->error);
        $data_con->close_db();
    }
}

$html = new html;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>

    <script language="JavaScript" type="text/javascript">
    if (top.location != location)
    {
        top.location.href = document.location.href ;
    }
	var myVideo=document.getElementById("video1"); 
	function playvideo()
	{ 
  		myVideo.play(); 
	} 

    </script>
    <title> ITrack - Powered by Cobalt</title>
    <link href="css/login.css" rel="stylesheet" type="text/css">
    <meta http-equiv="content-type" content="text/html; charset=<?php echo MULTI_BYTE_ENCODING; ?>" />
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="document.getElementById('username').focus(); onload="playvideo()";>
<br /><br /><br /><br />
<br /><br /><br /><br />
<?php
echo '<form method="POST" action="' . $_SERVER[PHP_SELF] . '">';
$form_key = generate_token();
$form_identifier = $_SERVER['PHP_SELF'];
$_SESSION['cobalt_form_keys'][$form_identifier] = $form_key;
echo '<input type=hidden name=form_key value="' . $form_key .'">';
?>
<center>
<div class="vertical_center">
    <div class="container">
    <fieldset class="container">
        <fieldset class="top">
               <div style="text-align:center"> 
				  <video id="video1" width="450" height="200" loop autoplay >
				    <source src="images/video.mp4" type="video/mp4">
				    <source src="images/video.ogg" type="video/ogg">
				    Your browser does not support HTML5 video.
				  </video>
				</div> 


        </fieldset>
      <fieldset class="middle">
            <div class="container_error">
            	<script type="text/javascript">
tday  =new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");

function GetClock(){
d = new Date();
nday   = d.getDay();
nmonth = d.getMonth();
ndate  = d.getDate();
nyear = d.getYear();
nhour  = d.getHours();
nmin   = d.getMinutes();
nsec   = d.getSeconds();

if(nyear<1000) nyear=nyear+1900;

     if(nhour ==  0) {ap = " AM";nhour = 12;} 
else if(nhour <= 11) {ap = " AM";} 
else if(nhour == 12) {ap = " PM";} 
else if(nhour >= 13) {ap = " PM";nhour -= 12;}

if(nmin <= 9) {nmin = "0" +nmin;}
if(nsec <= 9) {nsec = "0" +nsec;}


document.getElementById('clockbox').innerHTML=""+tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+"<br>"+nhour+":"+nmin+":"+nsec+ap+"";
setTimeout("GetClock()", 1000);
}
window.onload=GetClock;
</script>
              <?php $html->display_errors($error_message);?>
            </div>

        <table border="0" width="100%" cellspacing="1">
            <tr>
            	<div id="clockbox"></div>

			            <br/>
               <td align="left">&nbsp;Username:
               <?php $html->draw_text_field('','username',FALSE,'text',FALSE, 'id="username" size="37"'); ?></td>
            </tr>
            <tr>
                <td align="left"><br></td>
            </tr>
            <tr>
                <td align="left">&nbsp;Password:
                <?php $html->draw_text_field('','password',FALSE,'password',FALSE,'size="37"'); ?></td>
            </tr>
          </table>
      </fieldset>
        <fieldset class="bottom">
        <center><input type=submit value="Log in" name="Submit" /></center>	
        </fieldset>
    </fieldset>
    </div>
  <span class="bottom">

</span></div>
</center>
</form>
<span class="vertical_center"><span class="middle">

</span></span>
<center><p style="font-size:10px; font-family:Century Gothic"><br>EuroHealthCare Exponents Inc SCMS is a prototype by <br/>Adrian Santos, Jake Pasculado, Nabil Al-Hamadah</p></center>
</body>
</html>