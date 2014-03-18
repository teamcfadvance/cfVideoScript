<cfif listlast(cgi.script_name, "/") eq "accounts.cfm">
  <cflocation url="index.cfm?action=accounts" addtoken="no">
</cfif>
<cfif isdefined('form.newSubmit')>
  <cfinvoke component="#request.cfcPath#.video" method="getOld" argumentcollection="#form#" returnvariable="gOldPass"/>
  <cfif gOldPass.npwd NEQ form.oldpass>
    <cfset msg = "Error! Old Password Incorrect">
    <cfelseif len(form.oldpass) IS 0>
    <cfset msg = "Error! Provide Old password Please">
    <cfelseif len(form.newpass) IS 0>
    <cfset msg = "Error! Provide New password">
    <cfelse>
    <cfinvoke component="#request.cfcPath#.video" method="changePass" argumentcollection="#form#"/>
    <cfset msg = "Cool! Password Changed Successfully">
  </cfif>
</cfif>
<div align="center" class="oncaption"><b><cfif IsUserInRole(3)><cfelse>
<a href="index.cfm?action=accounts&accept=true">Create New Account</a></cfif></b></div><br>
<cfif IsUserInRole(1)>
<cfinvoke component="#request.cfcPath#.video" method="getMods" isNowSuper="1" returnvariable="gResults"/>
<cfset variables.newrow = False>
<table align="center" width="100%">
  <tr>
    <td colspan="6" class="botpreview"><strong>List of Admins</strong></td>
  </tr>
  <cfif variables.newrow EQ true>
    <tr>
  </cfif>
  <cfif gResults.recordcount>
    <cfoutput query="gResults">
	<td height="30" valign="middle"><a href="index.cfm?action=accounts&accept=True&info=#URLEncodedFormat(ID)#">
        <cfif valid IS 0>
          <span class="red">*</span>
        </cfif>#nusername#</a>&nbsp;<a href="javascript:void(0);" title="Manage Administrators Account" onclick="WinOpen('manageusers.cfm?del=#URLEncodedFormat(ID)#&i=#URLEncodedFormat(ToBase64(emailaddress))#&valid=#valid#','400','400');"><img src="icons/account.jpg" title="Manage Administrators Account" border="0" /></a></td>
      <cfif gResults.currentRow MOD 6 EQ 0>
        </tr>
        <cfset variables.newrow = true>
        <cfelse>
        <cfset variables.newrow = false>
      </cfif>
    </cfoutput>
    <cfelse>
    <tr>
      <td colspan="6" align="center">No Admin Account!</td>
    </tr>
  </cfif>
</table>
</cfif>
<br />
<cfif IsUserInRole(1) OR IsUserInRole(2)>
  <cfinvoke component="#request.cfcPath#.video" method="getMods" NowisMods="3" returnvariable="gResults3"/>
  <cfset variables.newrow = False>
  <table align="center" width="100%">
    <tr>
      <td colspan="6" class="botpreview"><strong>List of Moderators</strong></td>
    </tr>
    <cfif variables.newrow EQ true>
      <tr>
      
    </cfif>
    <cfif gResults3.recordcount>
      <cfoutput query="gResults3">
	<td height="30" valign="middle"><a href="index.cfm?action=accounts&accept=True&info=#URLEncodedFormat(ID)#">
          <cfif valid IS 0>
            <span class="red">*</span>
          </cfif>
#nusername#</a>&nbsp;<a href="javascript:void(0);" title="Manage Moderator Account" onclick="WinOpen('manageusers.cfm?del=#URLEncodedFormat(ID)#&i=#URLEncodedFormat(ToBase64(emailaddress))#&valid=#valid#','400','400');"><img src="icons/account.jpg" title="Manage Moderator Account" border="0" /></a></td>
        <cfif gResults3.currentRow MOD 6 EQ 0>
          </tr>
          
          <cfset variables.newrow = true>
          <cfelse>
          <cfset variables.newrow = false>
        </cfif>
      </cfoutput>
      <cfelse>
      <tr>
        <td colspan="6" align="center">No Moderators Account!</td>
      </tr>
    </cfif>
    <tr>
      <td colspan="6" class="darkred">* Indicates that the Account is temporarily Suspended</td>
    </tr>
  </table>
</cfif>
<br>
<cfif isdefined('url.accept') AND url.accept EQ True>
  <cfif isdefined('form.editregistration')>
      <cfif len(form.password) IS 0>
      <cfset reg = "Error! Password is required">
      <cfelseif len(form.password) NEQ len(form.cuserpass)>
      <cfset reg = "Error! Both Passwords does not match">
      <cfelseif NOT REFindnocase("^[-_!a-z0-9\.]+@([-_a-z0-9]+\.)+[a-z]{2,6}$", emailaddress)>
      <cfset reg = "Error! Email address Invalid">
      <cfelseif form.role IS "">
      <cfset reg = "Error! Please Select the Permissions for the Account">
      <cfelse>
      <cfif form.password IS 'keepold'>
    	<cfset form.oldpassword = "#form.oldpass#">  
      </cfif>  
      <cfinvoke component="#request.cfcPath#.video" method="updateregistration" structForm="#form#" returnvariable="str"/>
      <cfset reg = "#str#">
    </cfif>
  </cfif>
  <cfif isdefined('form.NewRegistration')>
      <cfif len(form.username) IS 0>
      <cfset reg = "Error! Username is required">
      <cfelseif len(form.password) IS 0>
      <cfset reg = "Error! Password is required">
      <cfelseif len(form.password) NEQ len(form.cuserpass)>
      <cfset reg = "Error! Both Passwords does not match">
      <cfelseif len(form.emailaddress) IS 0>
      <cfset reg = "Error! Provide Email Address">
      <cfelseif NOT REFindnocase("^[-_!a-z0-9\.]+@([-_a-z0-9]+\.)+[a-z]{2,6}$", emailaddress)>
      <cfset reg = "Error! Email address Invalid">
      <cfelseif form.role IS "">
      <cfset reg = "Error! Please Select the Permissions for the Account">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="newregistration" structForm="#form#" returnvariable="str"/>
      <cfset reg = "#str#">
    </cfif>
  </cfif>
  <cfset editMode = IsDefined('url.info') AND IsNumeric(url.info)>
  <cfif editMode>
    <cfinvoke component="#request.cfcPath#.video" method="checkstuff" sID="#trim(url.info)#" returnvariable="showinfo"/>
    <cfparam name="emailaddress" default="#showinfo.emailaddress#">
    <cfparam name="username" default="#showinfo.nusername#">
    <cfparam name="password" default="#showinfo.npwd#">
    <cfparam name="cuserpass" default="#showinfo.npwd#">
    <cfparam name="ID" default="#showinfo.ID#">
    <cfparam name="valid" default="#showInfo.valid#">
    <cfparam name="role" default="#showInfo.role#">    
    <cfelse>
    <cfparam name="emailaddress" default="">
    <cfparam name="username" default="">
    <cfparam name="password" default="">
    <cfparam name="cuserpass" default="">
    <cfparam name="valid" default="">
    <cfparam name="role" default="">
  </cfif>
  <cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="registration" method="post">
  <table width="100%" border="0" cellpadding="1" cellspacing="2">
    <tr>
      <td colspan="2" align="center" class="botpreview">Manage Admin/Moderator</td>
    </tr>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfif isdefined('reg')>
          <cfoutput>#trim(reg)#</cfoutput>
        </cfif></td>
    </tr>
    <tr>
      <td width="25%" class="middleright">Email Address:</td>
      <td><cfinput type="text" value="#emailaddress#" name="emailaddress" class="o" id="emailaddress" tabindex="3" required="yes" message="Error! Email address invalid" validate="email"></td>
    </tr>
    <tr>
      <td width="25%" class="middleright">Username:</td>
      <td><cfif editMode>
          <cfoutput>#showinfo.nusername#</cfoutput> <span class="darkred">(* Cannot be Changed)</span>
          <cfelse>
          <cfinput type="text" value="#username#" name="username" id="username" class="o" tabindex="4" required="yes" message="Error! Username required">
        </cfif></td>
    </tr>
    <tr>
      <td width="25%" class="middleright">Password:</td>
      <td><cfinput type="password" value="" name="password" id="password" class="o" tabindex="5" required="yes" message="Error! Password required at last 6 characters" onvalidate="validatePassword"><br />
          <cfif editMode>
          (*Please Type <span class="darkred">KEEPOLD</span> to keep old Password in both Password &amp; Confrm Password fields)</cfif> </td>
    </tr>
    <tr>
      <td width="25%" class="middleright">Confirm Password:</td>
      <td><cfinput type="password" value="" name="cuserpass" id="cuserpass" class="o" tabindex="5" required="yes" message="Error! Passwords do not match" onvalidate="checkPasswordsMatch"></td>
    </tr>
    <tr>
      <td valign="top" class="middleright">User Account:</td>
      <td><select name="role" tabindex="16" class="o">
          <option value="" selected>(Select One...)</option>
          <cfif IsUserInRole(1)>
            <option value="2" <cfif role IS 2>selected</cfif>>Administrators</option>
            <option value="3" <cfif role IS 3>selected</cfif>>Moderators</option>
            <cfelseif IsUserInRole(2)>
            <option value="3" <cfif role IS 3>selected</cfif>>Moderators</option>
          </cfif>
        </select></td>
    </tr>
    <cfif valid IS 0>
      <tr>
        <td width="25%" class="middleright">Enable Account:</td>
        <td><cfinput type="checkbox" name="valid" checked="yes" class="o" value="1" />
          Enable Account</td>
      </tr>
    </cfif>
    <tr>
      <td><cfif editMode>
          <cfoutput>
            <input type="hidden" name="old_email" value="#emailaddress#" />
            <input type="hidden" name="ID" value="#ID#" />
            <input type="hidden" name="oldUser" value="#username#" />
            <input type="hidden" name="oldpass" value="#password#" />
          </cfoutput>
        </cfif></td>
      <td><input type="submit" name="<cfif editMode>editregistration<cfelse>NewRegistration</cfif>"value="<cfif editMode>Edit Registration<cfelse>Register</cfif>" class="border"></td>
    </tr>
  </table>
  </cfform>
</cfif>
<cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
  <table width="100%" border="0" cellspacing="2" cellpadding="1">
    <tr>
      <td><table width="80%" border="0" align="center" cellpadding="1" cellspacing="2" class="border">
          <tr>
            <td colspan="2" align="center" class="txtn"><strong>Change 
      <cfif IsUserInRole(3)>
                Moderator
                <cfelseif IsUserInRole(2)>Admin<cfelse>Super Admin
                </cfif>
            </strong></td>
          </tr>
  <cfif isdefined('msg')>
            <tr>
              <td colspan="2" align="center" class="red"><cfoutput>#msg#</cfoutput></td>
            </tr>
          </cfif>
          <tr>
            <td width="30%">Old Password:</td>
            <td width="70%"><cfinput name="oldPass" type="password" class="o" id="oldPass" required="yes" message="Error! Provide Old password" maxlength="255"></td>
          </tr>
          <tr>
            <td>New Password:</td>
            <td><cfinput name="newPass" type="password" class="o" id="newPass" required="yes" message="Error! Provide New Password" maxlength="255"></td>
          </tr>
          <tr>
            <td><cfinput type="hidden" name="nusername" value="#GetAuthUser()#">
              </td>
            <td><cfinput name="newSubmit" type="submit" class="border" id="newSubmit" value="Update Account"></td>
          </tr>
      </table></td>
    </tr>
  </table>
</cfform>
