<cfif listlast(cgi.script_name, "/") eq "cats.cfm">
  <cflocation url="index.cfm?action=cats" addtoken="no">
</cfif>
<cfset editMode = IsDefined('url.edit') and url.edit NEQ "" and IsNumeric(url.edit)>
<cfif editMode>
  <cfinvoke component="#request.cfcPath#.video" method="getCats" catID="#trim(url.edit)#" returnvariable="Recordset1"/>
  <cfset catName = "#Recordset1.catName#">
  <cfset catDesc = "#Recordset1.catDesc#">
  <cfset active = "#Recordset1.active#">
  <cfset catID = "#Recordset1.catID#">
  <cfset btnLabel = "Edit Category">
  <cfset btnText = "editCategory">
  <cfelse>
  <cfparam name="catName" default="">
  <cfparam name="catDesc" default="">
  <cfparam name="active" default="">
  <cfset btnLabel = "New Category">
  <cfset btnText = "newCat">
</cfif>
<cftry>
  <cfif StructKeyExists(FORM,'newCat')>
    <cfif len('form.catName') IS 0>
      <cfset n = "Error! Provide Category Name">
      <cfelseif len('form.CatDesc') IS 0>
      <cfset n = "Error! Provide Category Description Please">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="addcategory" structForm="#form#" returnvariable="str"/>
      <cfset n = "#Trim(str)#">
    </cfif>
  </cfif>
  <cfcatch>
    <cfset n = "Error! #cfcatch.Detail# #cfcatch.Message#">
  </cfcatch>
</cftry>

<cftry>
  <cfif StructKeyExists(FORM,'editCategory')>
    <cfif len('form.catName') IS 0>
      <cfset n = "Error! Provide Category Name">
      <cfelseif len('form.CatDesc') IS 0>
      <cfset n = "Error! Provide Category Description Please">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="updatecategory" argumentcollection="#form#" returnvariable="str"/>
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
    <td colspan="2" align="center" class="oncaption"><strong>Create Category</strong></td>
  </tr>
  <tr>
    <td height="21" class="darkred"><a href="index.cfm?action=editcategories" class="txtn">Edit Categories</a></td>
    <td height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('n')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" class="txt">Category Name:<span class="darkred">*</span></td>
    <td><cfinput type="text" name="catName" message="Error! Please enter Category Name" required="yes" class="o" id="catName" tabindex="1" maxlength="255" value="#catname#"></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Category Description:<span class="darkred">*</span></td>
    <td><textarea name="catDesc" cols="45" rows="5" class="o" id="catDesc" tabindex="2" required="yes"><cfoutput>#trim(catDesc)#</cfoutput></textarea></td>
  </tr>
  <tr>
    <td align="right" class="txt">Status:</td>
    <td><cfselect name="active" size="1" class="o" id="active" tabindex="3">
      <option value="1" selected <cfif active IS 1>selected</cfif>>Yes</option>
      <option value="0" <cfif active IS 0>selected</cfif>>No</option>
      </cfselect></td>
  </tr>
  <tr>
    <td class="middleright">&nbsp;</td>
    <td><cfoutput>
      <input name="#btnText#" type="submit" class="border" id="#btnText#" tabindex="4" value="#btnLabel#">
      </cfoutput> &nbsp;&nbsp;
      <cfif editMode>
      	<cfoutput>
        <input type="hidden" name="catID" value="#catID#">
        <input type="hidden" name="old_catName" value="#catName#">
        </cfoutput>
      </cfif>
      <input name="rest" type="reset" class="border" id="rest" tabindex="5" value="Clear"></td>
  </tr>
</table>
</cfform>
