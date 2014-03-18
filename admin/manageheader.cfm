<cfif listlast(cgi.script_name, "/") eq "managerheader.cfm">
  <cflocation url="index.cfm?action=header" addtoken="no">
</cfif>
<cfparam name="form.width" default="239">
<cfparam name="form.height" default="74">
<cfset editMode = IsDefined('url.edit') and url.edit NEQ "" and IsNumeric(url.edit)>
<cfif editMode>
  <cfinvoke component="#request.cfcPath#.video" method="getHeaders" displayID="#trim(url.edit)#" returnvariable="Recordset1"/>
  <cfset header = "#Recordset1.header#">
  <cfset heraderImage = "#Recordset1.headerImage#">
  <cfset active = "#Recordset1.usethis#">
  <cfset displayID = "#Recordset1.displayID#">
  <cfset btnLabel = "Edit Header">
  <cfset btnText = "editheader">
  <cfelse>
  <cfparam name="header" default="">
  <cfparam name="heraderImage" default="">
  <cfset btnLabel = "New Header">
  <cfset btnText = "newHead">
</cfif>
<cftry>
  <cfif StructKeyExists(FORM,'newHead')>
    <cfif len('form.header') IS 0>
      <cfset n = "Error! Provide Header Name">
      <cfelse>
      <cfif isDefined('form.headerImage') and form.headerImage IS NOT "">
        <cfset destination = ExpandPath("headers")>
        <cffile action="upload" accept="image/*" filefield="headerImage" destination="#destination#\" nameconflict="makeunique">
        <cfset uploadfile = #cffile.ServerFile#>
        <cfif IsImageFile("#request.file_path#headers\#uploadfile#")>
        <cfimage action="resize" width="#form.width#" height="#form.height#" source="#destination#\#uploadfile#" 
        destination="#destination#\#uploadfile#" overwrite="yes">
        </cfif>
        <cfset form.uploadfile = "#uploadfile#">
        <cfelse>
        <cfset form.uploadfile = "">
      </cfif>
      <cfinvoke component="#request.cfcPath#.video" method="addHeaders" structForm="#form#" returnvariable="str"/>
      <cfset n = "#Trim(str)#">
    </cfif>
  </cfif>
  <cfcatch>
    <cfset n = "Error! #cfcatch.Detail# #cfcatch.Message#">
  </cfcatch>
</cftry>

<cftry>
  <cfif StructKeyExists(FORM,'editheader')>
    <cfif len('form.header') IS 0>
      <cfset n = "Error! Provide Header Name">
      <cfelse>
      <cfset destination = ExpandPath("headers")>
      <cfif isDefined('form.headerImage') and form.headerImage IS NOT "">
        <cffile action="upload" accept="image/*" filefield="headerImage" destination="#destination#\" nameconflict="makeunique">
        <cfset uploadfile = #cffile.ServerFile#>
        <cfif IsImageFile("#request.file_path#headers\#uploadfile#")>
        <cfimage action="resize" width="#form.width#" height="#form.height#" source="#destination#\#uploadfile#" 
        destination="#destination#\#uploadfile#" overwrite="yes">
        </cfif>
        <cfset form.uploadfile = "#uploadfile#">
        	<cfif FileExists("#request.file_path#headers\#oldheaderImage#")>
            	<cffile action="delete" file="#request.file_path#headers\#oldheaderImage#">
            </cfif>
        <cfelse>
        <cfif form.width IS NOT "" aND form.height IS NOT "">
        	<cfimage action="resize" width="#form.width#" height="#form.height#" source="#destination#\#form.oldheaderImage#" 
        destination="#destination#\#form.oldheaderImage#" overwrite="yes">
        	<cfset form.uploadfile = "#form.oldheaderImage#">
        <cfelse>
        	<cfset form.uploadfile = "#form.oldheaderImage#">
        </cfif>    
      </cfif>
      <cfinvoke component="#request.cfcPath#.video" method="updateHeaders" structform="#form#" returnvariable="str"/>
      <cfset n = "#Trim(str)#">
    </cfif>
  </cfif>
  <cfcatch>
    <cfset n = "Error! #cfcatch.Detail# #cfcatch.Message#">
  </cfcatch>
</cftry>
<cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" enctype="multipart/form-data">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td colspan="2" align="center" class="oncaption"><strong>Manage Header</strong></td>
  </tr>
  <tr>
    <td height="21" class="darkred"><a href="index.cfm?action=editheaders" class="txtn">Edit Headers</a></td>
    <td height="21" align="right" class="txt">* Indicates Required Fields</td>
  </tr>
  <cfif isDefined('n')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#n#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" class="txt">Header Name<span class="darkred">*</span></td>
    <td><cfinput type="text" name="header" message="Error! Please enter Header Name" required="yes" class="o" id="header" tabindex="1" maxlength="255" value="#header#"></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Header Image<span class="darkred">*</span></td>
    <td><cfif editMode>
    	<cfoutput>
		<cfif heraderImage IS "">
	        <img src="images/noimage.jpg" border="0" alt="No Image Avaliable" title="No Image avaliable"/>
        <cfelse>
        	<img src="headers/#heraderImage#" border="0" alt="The Header Image" title="This Header Image"/>
        </cfif>
        </cfoutput>
        <br /><br />
    <cfinput type="file" name="headerImage" id="headerImage" tabindex="2" class="o">
    <cfinput type="hidden" name="oldheaderImage" id="oldheaderImage" value="#heraderImage#">           
    <cfelse>
    <cfinput type="file" name="headerImage" id="headerImage" tabindex="2" class="o" required="yes" message="Error Provide Image File">
    </cfif>
    </td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Header Image Size</td>
    <td class="txt"><cfinput name="width" type="text" class="o" id="width" tabindex="3" maxlength="3" style="width:20px;" required="no" validate="integer" message="Error! Provide Width value in Numbers"> 
      width 
      <cfinput name="height" type="text" class="o" id="height" tabindex="4" maxlength="3" style="width:20px;" required="no" validate="integer" message="Error! Provide height value in Numbers"> 
      height</td>
  </tr>
  <tr>
    <td class="middleright">&nbsp;</td>
    <td><cfinput name="#btnText#" type="submit" class="border" id="#btnText#" tabindex="4" value="#btnLabel#">&nbsp;&nbsp;
      <cfif editMode>
        <cfinput type="hidden" name="displayID" value="#displayID#">
      </cfif>
      <input name="rest" type="reset" class="border" id="rest" tabindex="5" value="Clear"></td>
  </tr>
</table>
</cfform>