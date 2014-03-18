<cfif listlast(cgi.script_name, "/") eq "clouds.cfm">
  <cflocation url="index.cfm?action=tagclouds" addtoken="no">
</cfif>
<cfparam name="cloudname" default="">
<cfset btnLabel = "Add New">
<cfset btnText = "addnew">
<cftry>
  <cfif StructKeyExists(FORM,'addnew')>
    <cfif len('form.cloudname') IS 0>
      <cfset n = "Error! Please provide Cloud Name">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="addclouds" structForm="#form#" returnvariable="str"/>
      <cfset n = "#Trim(str)#">
    </cfif>
  </cfif>
  <cfcatch>
    <cfset n = "Error! #cfcatch.Detail# #cfcatch.Message#">
  </cfcatch>
</cftry>
<cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td colspan="2" align="center" class="oncaption"><strong>New Tag Clouds</strong></td>
  </tr>
  <tr>
    <td height="21" class="darkred"><a href="index.cfm?action=viewtags" class="txtn">View Tag Clouds</a></td>
    <td height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('n')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" class="txt">Tag Cloud<span class="darkred">*</span></td>
    <td><cfinput type="text" name="cloudname" message="Error! Please Provide Cloud name" required="yes" class="o" id="cloudname" tabindex="1" maxlength="255" value="#cloudname#"></td>
  </tr>
  <tr>
    <td class="middleright">&nbsp;</td>
    <td>
      <cfinput name="#btnText#" type="submit" class="border" id="#btnText#" tabindex="4" value="#btnLabel#">
      &nbsp;&nbsp;
      <input name="rest" type="reset" class="border" id="rest" tabindex="5" value="Clear"></td>
  </tr>
  <tr>
    <td colspan="2" class="txt">(* if the Name you will be entering already exists in the database, it will be incremented)</td>
  </tr>
</table>
</cfform>
