<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Welcome to Video Manager</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="javascript1.2" src="js/validate.js" type="text/javascript"></script>
</head>
<body>
<table width="1000" border="0" align="center" cellpadding="1" cellspacing="2" class="border">
  <tr class="bluebar">
    <td colspan="2" align="left"><h1><strong class="px5">Video Manager</strong></h1></td>
  </tr>
  <tr>
    <td height="9" colspan="2"><hr width="100%" style="color:#8fbc8f;background-color:#8fbc8f;height:5px;" /></td>
  </tr>
  <tr>
    <td height="9" colspan="2" align="right"><cfform>
      <input name="logout" type="submit" class="border" id="logout" value="Sign Out" />
    </cfform></td>
  </tr>
  <tr>
    <td width="25%" height="9" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td><a href="index.cfm">Home</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=cats">Categories</a> / <a href="index.cfm?action=subcats">Sub-Categories</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=settings">Website Settings</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=mail">Mail Settings</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=newtag">Tagging</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=filter">Family Filter</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=config">Configration</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=tagclouds">Tag Clouds</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=accounts">Accounts Management</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=ads">Ads Management</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=header">Header</a> / <a href="index.cfm?action=footer">Footer</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=extra">Extra Settings</a></td>
      </tr>
      <tr>
        <td><a href="index.cfm?action=bans">Ban Settings</a></td>
      </tr>
    </table></td>
    <td valign="top" style="border-left:2px solid #8fbc8f;"><table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td><cfinclude template="types.cfm"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="9" colspan="2" valign="top"><hr width="100%" style="color:#8fbc8f;background-color:#8fbc8f;height:5px;" /></td>
  </tr>
  <tr>
    <td height="9" colspan="2" valign="top">&nbsp;</td>
  </tr>
  
  
</table>  
</body>
</html>