<cfif listlast(cgi.script_name, "/") eq "newtag.cfm">
  <cflocation url="index.cfm?action=newtag" addtoken="no">
</cfif>
<cfset editMode = IsDefined('url.edit') AND url.edit NEQ "">
<cfinvoke component="#request.cfcPath#.video" method="gettags" returnvariable="Stuff"/>
<cfinclude template="QueryTreeSort.cfm">
<cfset NewQuery=QueryTreeSort(Stuff)>
<cftry>
<cfif isDefined('form.addnewTags')>
  <cfif Len(form.tagname) IS 0>
    <cfset s = "Error! provide Tag Name at least 4 to 64 characters">
    <cfelse>
    <cfinvoke component="#request.cfcPath#.video" method="addtags" structform="#form#" returnvariable="str"/>
    <cfset s = "#str#">
    <cflocation addtoken="no" url="index.cfm?action=newtag&s=#s#">
  </cfif>
</cfif>
<cfcatch>
	<cfset s = "Error! #cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>

<cftry>
<cfif isDefined('form.updateoldtags')>
  <cfif Len(form.tagname) IS 0>
    <cfset s = "Error! Provide TagName at least 4 to 32 characters">
    <cfelse>
    <cfinvoke component="#request.cfcPath#.video" method="updatetagging" structform="#form#" returnvariable="str"/>
    <cfset s = "#str#">
    <cflocation addtoken="no" url="index.cfm?action=newtag&s=#s#">
  </cfif>
</cfif>
<cfcatch>
	<cfset s = "Error! #cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>

<cfif editMode>
  <cfinvoke component="#request.cfcPath#.video" method="gettags" ID="#trim(url.edit)#" returnvariable="gm"/>
  <cfset tagName = #gm.tagName#>
  <cfset tagStatus = #gm.status#>
  <cfset parentID = #gm.parentID#>
  <cfset btext = "updateoldtags">
  <cfset blabel = "Update Tag">
  <cfset ID = #gm.ID#>
  <cfelse>
  <cfset tagname = "">
  <cfset tagStatus = "">
  <cfset parentID = "">
  <cfset btext = "addnewTags">
  <cfset blabel = "Submit Tag">
</cfif>
<cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" enctype="multipart/form-data">
<table width="100%"  class="border">
  <tr>
    <td colspan=2 align="center" class="oncaption">Create New Category</td>
  </tr>
   <tr>
    <td height="21" class="darkred"><a href="index.cfm?action=tags" class="txtn">Edit Tags</a></td>
    <td height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('s')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#trim(s)#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width=25% valign="top" class="txt"><div align=right>Parent Tag Category</div></td>
    <td width=72% valign="top"><cfoutput> <span class="txt">#ListFromQueryTree(Query=NewQuery,TitleColumn="tagname",IDColumn="ID",selected="#parentID#")#</span> </cfoutput></td>
  </tr>
  <tr>
    <td width=28% class="txt"><div align=right>Tag Name</div></td>
    <td width=72%><cfinput type="text" name="tagname" message="Error! Provide Tag Name (Use letters & space)" pattern="^([a-zA-z\s]{4,32})$" validate="regular_expression" required="yes" class="o" value="#tagname#"></td>
  </tr>
  <tr>
    <td width=28% class="txt"><div align=right>Status</div></td>
    <td width=72%><select name="status" class="o">
        <option value="1"<cfif tagStatus IS 1> selected</cfif>>On - Enabled</option>
        <option value="0"<cfif tagStatus IS 0> selected</cfif>>Off - Inactive</option>
    </select></td>
  </tr>
  <tr>
    <td class="txt">&nbsp;</td>
    <td><cfif editMode>
        <cfinput type="hidden" name="ID" value="#ID#">
      </cfif>
      <cfinput type="submit" name="#btext#" value="#blabel#" class="border"></td>
  </tr>
</table>
</cfform>
