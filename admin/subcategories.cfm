<cfif listlast(cgi.script_name, "/") eq "subcategories.cfm">
  <cflocation url="index.cfm?action=subcats" addtoken="no">
</cfif>
<cfinvoke component="#request.cfcPath#.video" method="getCats" sortorder="1" returnvariable="showmain"/>
<cfset editMode = IsDefined('url.edit') and url.edit NEQ "" and IsNumeric(url.edit)>
<cfif editMode>
  <cfinvoke component="#request.cfcPath#.video" method="getSubCats" SubcatID="#trim(url.edit)#" returnvariable="Recordset1"/>
  <cfset subCatDesc = "#Recordset1.subCatDesc#">
  <cfset active = "#Recordset1.status#">
  <cfset subcatID = "#Recordset1.subcatID#">
  <cfset McatID = "#Recordset1.catID#">
  <cfset btnLabel = "Edit Category">
  <cfset btnText = "editCategory">
  <cfelse>
  <cfparam name="subCatDesc" default="">
  <cfparam name="active" default="">
  <cfparam name="maincategory" default="">
  <cfset btnLabel = "New Sub-Category">
  <cfset btnText = "newSubCat">
  <cfparam name="McatID" default="">
</cfif>

<cftry>
  <cfif StructKeyExists(FORM,'editCategory')>
    <cfif len('form.subCatDesc') IS 0>
      <cfset n = "Error! Provide Category Name">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="updatesubcategory" argumentcollection="#form#" returnvariable="str"/>
      <cfset n = "#Trim(str)#">
  </cfif>
  </cfif>
  <cfcatch>
    <cfset n = "Error! #cfcatch.Detail# #cfcatch.Message#">
  </cfcatch>
</cftry>

<cftry>
  <cfif StructKeyExists(FORM,'newSubCat')>
    <cfif len('form.subCatDesc') IS 0>
      <cfset n = "Error! Provide Category Name">
      <cfelse>
      <cfinvoke component="#request.cfcPath#.video" method="addsubcategory" argumentcollection="#form#" returnvariable="str"/>
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
    <td colspan="2" align="center" class="oncaption"><strong>Create Sub-Category</strong></td>
  </tr>
  <cfif editMode>
  <tr>
    <td colspan="2" class="txt"><cfoutput>
    <a href="index.cfm?action=subcats&edit=#edit#">Refresh to See Updated Contents</a>
    </cfoutput></td>
  </tr>
  </cfif>
  <tr>
    <td height="21" class="darkred"><a href="index.cfm?action=editsubcategories" class="txtn">Edit Sub-Categories</a></td>
    <td height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('n')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" class="txt">Sub-Category Name:<span class="darkred">*</span></td>
    <td><cfinput type="text" name="subCatDesc" message="Error! Please enter Sub-Category Name" required="yes" class="o" id="subCatDesc" tabindex="1" maxlength="255" value="#subCatDesc#"></td>
  </tr>
  <tr>
    <td align="right" class="txt">Status:</td>
    <td><cfselect name="active" size="1" class="o" id="active" tabindex="2">
      <option value="1" <cfif active IS 1>selected</cfif>>Yes</option>
      <option value="0" <cfif active IS 0>selected</cfif>>No</option>
      </cfselect></td>
  </tr>
  <tr>
    <td align="right" class="txt"><cfif editMode>Under<cfelse>Choose</cfif> Category:</td>
    <td><select name="maincategory" id="maincategory" class="o" <cfif editmode>disabled</cfif>>
    <cfoutput query="showmain">
    	<option value="#showmain.CatID#" <cfif McatID eq #showmain.CatID#>selected</cfif>>#showmain.CatName#</option>
    </cfoutput>	
    </select></td>
  </tr>
  <tr>
    <td class="middleright">&nbsp;</td>
    <td><cfoutput>
        <input name="#btnText#" type="submit" class="border" id="#btnText#" tabindex="6" value="#btnLabel#">
      </cfoutput> &nbsp;&nbsp;
      <cfif editMode>
      	<cfoutput>
        <input type="hidden" name="subcatID" value="#subcatID#">
        <input type="hidden" name="old_subcatDesc" value="#subcatDesc#">
        </cfoutput>
      </cfif>
      <input name="rest" type="reset" class="border" id="rest" tabindex="7" value="Clear"></td>
  </tr>
</table>
</cfform>
