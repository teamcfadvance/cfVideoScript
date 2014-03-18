<cfif IsDefined("cookie.username")>
    <!--- a cookie exist, so let's put in this username automatically into the form --->
    <cfset username = cookie.username>
<cfelse>
    <!--- a cookie DOES NOT exist, so let's put a blank value in the username field --->
    <cfset username = "">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Please Login Admin Panel</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfif IsUserLoggedIn() eq "No">
<cfif isDefined('form.fetchemail')>
	<cfinvoke component="#request.cfcPath#.video" method="getLogin" argumentcollection="#form#" returnvariable="str"/>
    <cfset s = "#trim(str)#">
</cfif>
<table width="1000" border="0" align="center" cellpadding="1" cellspacing="2" class="border">
  <tr class="bluebar">
    <td align="left"><h1><strong class="px5">Video Manager</strong></h1></td>
  </tr>
  <tr>
    <td height="9"><hr width="100%" style="color:#8fbc8f;background-color:#8fbc8f;height:5px;" /></td>
  </tr>
  <tr>
    <td><cfoutput>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td valign="center" align="center"><table class="border" border="0" cellpadding="1" cellspacing="2" width="500">
            <tr>
              <td><cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
                <table border="0" cellpadding="1" cellspacing="2" width="100%">
                  <tr>
                    <td colspan="2" align="center" class="oncaption"><strong>Admin Login</strong></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="txt" align="center">You aren't logged in or your session has expired.<br/>
                      Please enter your Username and Password below and click Login.</td>
                  </tr>
                  <cfif IsDefined('invalid')>
                    <tr>
                      <td align="center" colspan="2"><div class="MainBar">
                          <cfif invalid IS 1>
                            Please Provide Username/Password
                            <cfelseif invalid IS 2>
                            Invalid Username/Password
                          </cfif>
                        </div></td>
                    </tr>
                  </cfif>
                  <tr>
                    <td  align="right" width="160"><strong>Username:&nbsp;</strong></td>
                    <td width="340"><cfinput type="text" name="j_username" message="You must provide a Username." required="Yes" class="o" tabindex="1" size="25" maxlength="15" value="#username#"></td>
                  </tr>
                  <tr>
                    <td  align="right" width="160"><strong>Password:&nbsp;</strong></td>
                    <td width="340"><cfinput type="password" name="j_password" message="You must provide a Password." required="Yes" class="o" size="25" maxlength="15" tabindex="2"></td>
                  </tr>
                  <tr>
                    <td align="right">&nbsp;</td>
                    <td align="left" ><input type="checkbox" name="RememberMe" tabindex="3" value="Yes" <cfif IsDefined("cookie.username")> CHECKED</cfif>>
                      Remember Me</td>
                  </tr>
                  <tr>
                    <td align="center">&nbsp;</td>
                    <td align="left"><input type="submit" class="border" tabindex="4" value="Login">
                      &nbsp;&nbsp;
                      <input type="reset" value="Clear" class="border" tabindex="5"></td>
                  </tr>
                </table>
                </cfform></td>
            </tr>
            <tr>
              <td align="center" class="txtn">Forgot Your Details</td>
            </tr>
            <tr>
              <td><cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
                <table width="100%" border="0" cellspacing="2" cellpadding="1">
                  <cfif isDefined('s')>
                    <tr>
                      <td colspan="3" align="center" class="<cfif refindnocase("Error",s)>error<cfelse>info</cfif>"><cfoutput>#s#</cfoutput></td>
                    </tr>
                  </cfif>
                  <tr>
                    <td width="40%"><strong>Provide Your Email Address: </strong></td>
                    <td width="32%" class="txt"><cfinput type="text" name="provideemail" message="Error! Provide valid email adrdess" validate="email" required="yes" class="o"></td>
                    <td width="28%"><input name="fetchemail" type="submit" class="border" value="Retrieve Login"></td>
                  </tr>
                </table>
                </cfform></td>
            </tr>
          </table></td>
      </tr>
    </table>
  </cfoutput>
<cfelse>
<cflocation addtoken="no" url="index.cfm"> 
</cfif>
</td>
  </tr>
  <tr>
    <td height="9"><cfinclude template="footer.cfm"></td>
  </tr>
</table>
</body>
</html>