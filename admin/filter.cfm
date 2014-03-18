<cfif listlast(cgi.script_name, "/") eq "filter.cfm">
  <cflocation url="index.cfm?action=filter" addtoken="no">
</cfif>
<table align="center" width="100%">
<tr><td>
<cfoutput>
<table align="left" width="100%">
	<tr align="center" class="oncaption">
    	<td width="33%"><a href="index.cfm?action=filter&add=1">Add Keyword</a></td>
        <td width="33%"><a href="index.cfm?action=filter&add=3">Manage Keywords</a></td>
        <td width="34%"><a href="index.cfm?action=filter&add=2">Generate Text File</a></td>
    </tr>    
</table>
</cfoutput>
</td></tr>
<cfif isDefined('url.add') and url.add eq 1>
<cfif isDefined('form.sbtkeyword')>
	<cfif len(form.keywords) IS 0>
    	<cfset n = "Error! Please Define the word">
    <cfelse>
    <cfinvoke component="#request.cfcPath#.video" method="addbadword" structform="#form#" returnvariable="str"/>
    	<cfset n = "#str#">
    </cfif>    
</cfif>
<tr><td>
<cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
 <cfif isdefined('n')>
  <tr>
    <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
  </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" class="txt">Add Keyword</td>
    <td width="80%"><cfinput type="text" name="keywords" tabindex="1" id="keywords" required="yes" message="Error! Please Provide words which are bad." class="o"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="sbtkeyword" id="sbtkeyword" value="Add Words" tabindex="2" class="border"></td>
  </tr>
</table>
</cfform>
</td></tr>
</cfif>
<cfif isDefined('url.add') and url.add eq 2>
<tr><td>
<cfinvoke component="#request.cfcPath#.video" method="getList" returnvariable="showall"/>
<table align="left" width="100%">
	<tr><td class="info" align="center">
    <cfprocessingdirective suppresswhitespace="yes">
	<cfsavecontent variable="savecontent">
    	<cfoutput>
        	#trim(ValueList(showall.badword))#
        </cfoutput>
    </cfsavecontent>
    <cffile action="write" output="#savecontent#" file="#request.absoluteDIR#admin\badwordslist\badwords.txt">
    <div class="MainBar">The File has been generated Successfully</div>
    </cfprocessingdirective>
    </td></tr>
</table>
</td></tr>
</cfif>
<cfif isDefined('url.add') and url.add eq 3 OR isdefined('url.searchbadWord')>
<tr><td>
    	<cfinclude template="managekeywords.cfm">
</td></tr>
</cfif>
</table>