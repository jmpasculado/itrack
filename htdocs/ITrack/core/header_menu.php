<div class='HeaderMenu'>
    <table width="100%">
    <tr>
        <td class="menu" width="100" align="left"> <a target="content_frame" href='/ITrack/main.php' class="menu">  HOME  </a> </td>
        <td class="menu" width="100" align="left"> <a target="content_frame" href='/ITrack/change_password.php' class="menu">  PASSWORD  </a> </td>
        <td class="menu" width="100" align="left"> <a target="content_frame" href='/ITrack/change_skin.php' class="menu">  SKIN  </a> </td>
        
        <td align="right"> You are logged in as <span class="text-info"><?php echo $_SESSION['user'];?></span></td>
        <td class="menu" width="75"> <a target="_parent" onClick="return confirm('Are you sure you wish to logout?')" href='/ITrack/end.php' class="menu">  [LOGOUT]  </a> </td>
    </tr>
    </table>
</div>