<cfif listlast(cgi.script_name, "/") eq "managerfooter.cfm">
  <cflocation url="index.cfm?action=footer" addtoken="no">
</cfif>
<cfinclude template="inc/striphtml.cfm">
<cfif isDefined('form.sbtfooter')>
<cfprocessingdirective suppresswhitespace="yes" pageencoding="utf8">
<cfsavecontent variable="footerDetails">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td><cfoutput>#Trim(form.footerDetails)#</cfoutput></td>
  </tr>
</table>
</cfsavecontent>
</cfprocessingdirective>
<cffile action="write" file="#ExpandPath("footer/footer.htm")#" addnewline="yes" output="#footerDetails#">
<cfset n = "Cool! Footer Has been Generated Successfully">
</cfif>
<cfif FileExists("#Expandpath("footer/footer.htm")#")>
   	<cffile action="read" file="#Expandpath("footer/footer.htm")#" variable="footers">
<cfprocessingdirective suppresswhitespace="yes">    
<cfsavecontent variable="show">        
<cfoutput>
#stripHTML(footers)#</cfoutput>
</cfsavecontent>
</cfprocessingdirective>
</cfif>
<cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td colspan="2" align="center" class="oncaption"><strong>Manage Footer</strong></td>
  </tr>
  <tr>
    <td colspan="2" height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('n')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" valign="top" class="txt">Footer Details<span class="darkred">*</span></td>
    <td><textarea name="footerdetails" cols="45" rows="5" class="o" id="footerdetails" tabindex="1"><cfoutput>#trim(show)#</cfoutput>
    </textarea></td>
  </tr>
  <tr>
    <td class="middleright">&nbsp;</td>
    <td><input name="sbtfooter" type="submit" class="border" id="sbtfooter" tabindex="2" value="Footer">
      &nbsp;&nbsp;
      <input name="rest" type="reset" class="border" id="rest" tabindex="3" value="Clear"></td>
  </tr>
</table>
</cfform>
