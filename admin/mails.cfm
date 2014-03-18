<cfif listlast(cgi.script_name, "/") eq "mails.cfm">
  <cflocation url="index.cfm?action=mail" addtoken="no">
</cfif>
<cfparam name="form.select_mail" default="">
<cfset editMode = IsDefined('form.select_mail') AND form.select_mail NEQ "">
<cfif editMode>
    <cfinvoke component="#request.cfcPath#.video" method="gChanged" returnvariable="gChan" mID="#Trim(form.select_mail)#"/>
    <cfparam name="mailserver" default="#trim(gChan.mailserver)#">
    <cfparam name="mailusername" default="#trim(gChan.mailusername)#">
    <cfparam name="mailpassword" default="#trim(gChan.mailpassword)#">
    <cfparam name="msendusername" default="#trim(gChan.msendusername)#">
    <cfparam name="alais" default="#trim(gChan.alais)#">
    <cfparam name="port" default="#trim(gChan.port)#">
    <cfparam name="err" default="#trim(gChan.err)#">
    <cfparam name="mID" default="#trim(gChan.mID)#">
<cfelse>
    <cfparam name="mailserver" default="">
    <cfparam name="mailusername" default="">
    <cfparam name="mailpassword" default="">
    <cfparam name="msendusername" default="">
    <cfparam name="alais" default="">
    <cfparam name="err" default="">
    <cfparam name="port" default="26">
</cfif>
<cfif isdefined('form.usethis')>
<cftry>
<cfinvoke component="#request.cfcPath#.video" method="updateuse" argumentcollection="#form#"/>
<cfset newmsg = "Cool! New Mail Server Selected Sucessfully">
<cfcatch type="any">
	<cfset newmsg = "Error! #cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>
</cfif>

<cfif isdefined('url.delID')>
	<cfinvoke component="#request.cfcPath#.video" method="delteSelectedMail" dID="#trim(url.delID)#"/>
	<cfset newmsg = "Cool! The Selected mail Settings Deleted">    	
</cfif>
<cfif IsDefined('form.editold')>
	<cftry>
    <cfif Len(form.mailserver) IS 0>
      <cfset msg = "Error! Mail Server name is Missing.">
      <cfelseif Len(form.mailusername) IS 0>
      <cfset msg = "Error! Mail Username name is Missing.">
      <cfelseif Len(form.mailpassword) IS 0>
      <cfset msg = "Error! Mail password is missing.">
      <cfelseif Len(form.msendusername) IS 0>
      <cfset msg = "Error! Mail Sending Username is Missing.">
      <cfelseif Len(form.alais) IS 0>
      <cfset msg = "Error! Mail Username Alais Name is Missing.">
      <cfelseif Len(form.port) IS 0>
      <cfset msg = "Error! MailServer Port is Missing.">
      <cfelseif Len(form.err) IS 0>
      <cfset msg = "Error! Catch Invalid Email address missing.">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="editOld" argumentcollection="#form#"/>
      <cfset msg = "Cool! Mail Server Updated Successfully">
    </cfif>
    <cfcatch type="any">
      <cfset msg = "Error! #cfcatch.Detail# #cfcatch.Message#">
    </cfcatch>
  </cftry>
</cfif>

<cfif IsDefined('form.addnew')>
  <cftry>
    <cfif Len(form.mailserver) IS 0>
      <cfset msg = "Error! Mail Server name is Missing.">
      <cfelseif Len(form.mailusername) IS 0>
      <cfset msg = "Error! Mail Username name is Missing.">
      <cfelseif Len(form.mailpassword) IS 0>
      <cfset msg = "Error! Mail password is missing.">
      <cfelseif Len(form.msendusername) IS 0>
      <cfset msg = "Error! Mail Sending Username is Missing.">
      <cfelseif Len(form.alais) IS 0>
      <cfset msg = "Error! Mail Username Alais Name is Missing.">
      <cfelseif Len(form.port) IS 0>
      <cfset msg = "Error! MailServer Port is Missing.">
      <cfelseif Len(form.err) IS 0>
      <cfset msg = "Error! Catch Invalid Email address missing.">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="insertEmail" argumentcollection="#form#"/>
      <cfset msg = "Cool! New Mail Server Added Successfully">
    </cfif>
    <cfcatch type="any">
      <cfset msg = "Error! #cfcatch.Detail# #cfcatch.Message#">
    </cfcatch>
  </cftry>
</cfif>
<link href="css/style.css" rel="stylesheet" type="text/css">

<cfform name="form1" method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
  <table align="center" width="100%">
    <tr>
      <td colspan="2" align="center" class="oncaption"><strong>Mail Settings</strong></td>
    </tr>
    <cfif isdefined('msg')>
        <tr>
          <td colspan="2" align="center" class="MainBar"><cfoutput>#trim(msg)#</cfoutput></td>
        </tr>
      </cfif>
    <tr>
      <td width="34%" class="txt"><div align="right">Mail Server</div></td>
      <td width="66%"><cfinput type="text" name="mailserver" message="Please Provide Mail Server Name" required="yes" class="o" id="mailserver" tabindex="1" value="#mailserver#" maxlength="250">
        *</td>
    </tr>
    <tr>
      <td class="txt"><div align="right">Mail Sending Username</div></td>
      <td><cfinput type="text" name="msendusername" message="Provide the Username by which the Mails will be send" required="yes" class="o" id="msendusername" tabindex="2" value="#msendusername#" maxlength="250" />
        *</td>
    </tr>
    <tr>
      <td class="txt"><div align="right">Mail Sending Username Alais<br>
      (You can enter any short name you like to send emails with)</div></td>
      <td><cfinput type="text" name="alais" message="Provide Alais name to appear before email address" required="yes" class="o" id="alais" tabindex="3" value="#alais#" maxlength="250" />
        *</td>
    </tr>
    <tr>
      <td class="txt"><div align="right">Mail Username</div></td>
      <td><cfinput type="text" name="mailusername" message="Mail Username required" required="yes" class="o" id="mailusername" tabindex="4" value="#mailusername#" maxlength="250">
        *</td>
    </tr>
    <tr>
      <td class="txt"><div align="right">Mail Password</div></td>
      <td><cfinput type="password" name="mailpassword" message="Mail password required" required="yes" class="o" id="mailpassword" tabindex="5" value="#mailpassword#" maxlength="250">
        *</td>
    </tr>
    <tr>
      <td class="txt"><div align="right">Port</div></td>
      <td><cfinput type="text" name="port" class="o" id="port" tabindex="6" value="#port#" size="4" maxlength="3">
        *</td>
    </tr>
    <tr>
    	<td class="txt"><div align="right">Catch Failed Emails</div></td>
        <td><cfinput type="text" name="err" validate="email" class="o" id="err" tabindex="6" value="#err#" message="Error! Invalid Email address">
        *</td>
    </tr>    
    <tr>
      <td><cfif editMode><cfoutput><input type="hidden" name="mID" value="#mID#"></cfoutput><cfelse>&nbsp;</cfif></td>
      <td><input name="<cfif editMode>editold<cfelse>addnew</cfif>" type="submit" class="border" id="<cfif editMode>editold<cfelse>addnew</cfif>" tabindex="7" value="<cfif editMode>Edit Mail Server<cfelse>Add New Mail Server</cfif>" />
        &nbsp;<cfif editMode><a href="index.cfm?action=mail" class="txt">Add New Mail Server</a><cfelse>
        <a href="index.cfm?action=mail&edit=go" class="txt">Edit Mail Settings</a></cfif></td>
    </tr>
  </table>
</cfform>
<cfif isDefined('url.edit') AND url.edit eq 'go'>
<cfinvoke component="#request.cfcPath#.video" method="gChanged" returnvariable="getemail"/>
  <br>
  <cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
    <table align="center" width="80%" class="border">
      <tr>
        <td align="left" class="txtn"><strong>Select Email to Set Up?</strong></td>
      </tr>
      <cfif getemail.recordcount>
        <tr>
          <td><select name="select_mail" id="select_mail" tabindex="1" class="o" style="height:20px;">
              <cfoutput query="getemail">
                <option value="#mID#">#trim(Mid)# - #trim(mailserver)#</option>
              </cfoutput>
          </select></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><input type="submit" name="editing" tabindex="2" value="Edit Mail Setting" class="border" />
          &nbsp;&nbsp;&nbsp;<input type="button" name="useemail" onClick="location.href='index.cfm?action=mail&edit=go&use=yes';" value="Email Server to Use" class="border">
          </td>
        </tr>
        <cfelse>
        <tr>
          <td align="center" class="txt">No Mail Server Specified?</td>
        </tr>
      </cfif>
    </table>
  </cfform>
</cfif>
<cfif isdefined('url.use') AND url.use eq 'yes'>
<cfinvoke component="#request.cfcPath#.video" method="gChanged" returnvariable="getemail"/>
<br>
<cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
<table width="80%" border="0" align="center" cellpadding="2" cellspacing="2" class="border">
  <tr>
    <td colspan="4" align="left" class="txtn"><strong>Choose Which Mail Server</strong></td>
  </tr>
 <cfif IsDefined('newmsg')>
  <tr>
  	<td colspan="4" align="center" class="MainBar"><cfoutput>#trim(newmsg)#</cfoutput></td>
  </tr>
  </cfif>
  <tr align="left" class="tablerow">
    <th class="box">S.No</th>
    <th class="box">Mail Server</th>
    <th class="box">Mail Username</th>
    <th class="box">Action</th>
  </tr>
  <cfoutput query="getemail">
  <tr class="#IIf(CurrentRow Mod 2, DE('rowOdd'), DE('rowEven'))#" 
    onmouseover="this.className='rowHighlight'" 
	<cfif CurrentRow Mod 2>onmouseout="this.className='rowOdd'"<cfelse>
    onmouseout="this.className='rowEven'"</cfif>">
    <td width="20"><cfinput type="radio" name="gShow" message="Please Choose 1 Mail Server" required="yes" class="inputstyle" value="#mID#"></td>
    <td width="261">#mailServer#</td>
    <td width="357">#mailUsername#&nbsp;&nbsp;<cfif #usethis# IS 1><span style="color:red;">[This Mail Server is Used]</cfif></td>
    <td><cfif #usethis# IS 1><cfelse><cfif IsUserInRole(3)><cfelse><a href="index.cfm?action=mail&edit=go&use=yes&delid=#URlEncodedFormat(mID)#" onClick="return confirm('Are you Sure');">Delete</a></cfif></cfif></td>
  </tr>
  </cfoutput>
  <tr><td colspan="4"><input type="submit" class="border" name="usethis" value="Use This Email Settings" /></td>
  </tr>
</table>
</cfform>
</cfif> 