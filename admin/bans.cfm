<cfif listlast(cgi.script_name, "/") eq "bans.cfm">
  <cflocation url="index.cfm?action=bans" addtoken="no">
</cfif>
<cfinvoke component="#request.cfcPath#.video" method="getbanned" returnvariable="Getbans"/>
<cfif isdefined ("form.Add")>
	<cfif listlen(form.ip) LT "4">
		<cfset looplen = 4 - listlen(form.ip)>
		<cfloop from="1" to="#looplen#" index="B">
			<cfset form.ip = listappend(form.ip, "*")>
		</cfloop>
	</cfif>	
	<cfset form.ips = rereplace(form.ip,  ",",  "." ,  "ALL")>
    <cfinvoke component="#request.cfcPath#.video" method="addban" ips="#form.ips#"/>
    <cfset n = "Cool! Ban IP has been added Successfully">
</cfif>

<cfif isdefined ("form.Remove")>
<cfinvoke component="#request.cfcPath#.video" method="RemoveBans" returnvariable="str" structform="#form#"/>
<cfset n = "Cool! Ban IP has been removed Successfully">
</cfif>
<TABLE border="0" cellpadding="2" cellspacing="2" width="100%" class="pClrBody" bgcolor="#topcell#">
  <TR>
    <TD align="center" class="oncaption"><strong>Forbidden IPs</strong></TD>
  </TR>
  <cfif isDefined('n')>
  	<tr><td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td></tr>
  </cfif>
</TABLE>
<TABLE border="0" cellpadding="2" cellspacing="2" width="100%" class="pClrBody" bgcolor="#topcell#">
  <TR>
    <TD align="Left" class="txt"><a href="<cfoutput>#cgi.script_name#?#cgi.query_string#</cfoutput>">Refresh this page, If records does not appear Updated oce you add or Remove</a></TD>
  </TR>
  <TR>
    <cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post">
      <TD align="center" class="txt"><strong>Add Forbidden IP Address:</strong>&nbsp;
        <input type="text" name="IP" size="1">
        .
        <input type="text" name="IP" size="1">
        .
        <input type="text" name="IP" size="1">
        .
        <input type="text" name="IP" size="1">
        &nbsp;
        <input name="Add" type="submit" class="border" value="Add"></TD>
    </cfform>
  </TR>
  <TR>
    <td align="left"><cfif GetBans.recordcount gt 0>
        <table width="50%" border="0" cellspacing="1" align="center" class="pClrBody">
          <tr>
            <td height="20" colspan="2"></td>
          </tr>
          <tr>
            <td align="right" valign="top" class="txt">IP Address List</td>
            <td><cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post">
                <select name="RemoveIP" size="10" multiple>
                  <cfoutput query="getbans">
                    <option value="#ban_ip#">#ban_ip# 
                  </cfoutput>
                </select>
                <input name="Remove" type="submit" class="border" value="Remove">
              </cfform></td>
          </tr>
        </table>
        <cfelse>
        <TABLE border="0" cellpadding="2" cellspacing="2" width="100%">
          <tr>
            <td height="100"></td>
          </tr>
          <TR>
            <td align="center" class="txt">There are no Forbidden IP Address.</td>
          </TR>
        </TABLE>
      </cfif></td>
  </TR>
  <tr>
    <td height="50"></td>
  </tr>
  <tr>
    <td><table width="100%" class="pClrBody">
        <tr>
          <td colspan="2" class="txt"><u><strong>How to Block IP Address </strong></u></td>
        </tr>
        <tr>
          <td colspan="2"><span class="txt"> You can fill up to four ip fields depending on your scope of a forbidden ip as follows: </span></td>
        </tr>
        <tr>
          <td><span class="txt">Putting 192 in the first field will ban</span></td>
          <td><span class="txt"><strong>192 . * . * . *</strong></span></td>
        </tr>
        <tr>
          <td><span class="txt">Putting 192 & 168 in the first two fields will ban</span></td>
          <td><span class="txt"><strong>192 . 168 . * . *</strong></span></td>
        </tr>
        <tr>
          <td><span class="txt">Putting 192 & 168 & 123 in the first three fields will ban</span></td>
          <td><span class="txt"><strong>192 . 168 . 123 . *</strong></span></td>
        </tr>
        <tr>
          <td><span class="txt">Putting 192 & 168 & 123 & 12 in the fields will ban</span></td>
          <td><span class="txt"><strong>192 . 168 . 123 . 12 </strong></span></td>
        </tr>
      </table></td>
  </tr>
</TABLE>
