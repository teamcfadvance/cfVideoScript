<cfif listlast(cgi.script_name, "/") eq "config.cfm">
  <cflocation url="index.cfm?action=config" addtoken="no">
</cfif>
<cfinvoke component="#request.cfcPath#.video" method="getallapi" returnvariable="giveall"/>
<link href="css/style.css" rel="stylesheet" type="text/css">
<cfif isDefined('form.sbtAPI')>
	<cfif form.chooseapi IS "">
    	<cfset n = "Error! Please Choose the API for the website">
    <cfelse>
    	<cfinvoke component="#request.cfcPath#.video" method="updateAPI" structform="#form#" returnvariable="str"/>
        <cfset n = "#str#">
    </cfif>     
</cfif>
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td align="center" class="oncaption">Configure Website API's</td>
  </tr>
  <tr>
    <td align="left" class="txtn">Select one API with which to Populate The videos with the website</td>
  </tr>
  <cfif isdefined('n')>
        <tr>
          <td colspan="2" align="center" class="MainBar"><cfoutput>#trim(n)#</cfoutput></td>
        </tr>
      </cfif>
  <tr>
    <td align="left">
    <cfform method="post" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
      <table width="100%" border="0" cellspacing="2" cellpadding="1">
        <tr>
          <td width="25%" align="right" class="txt">Choose API*</td>
          <td><cfselect name="chooseapi" id="chooseapi" tabindex="1">
          	<option value="" selected="selected">(Select One...)</option>
          	<option value="1" <cfif giveall.youtubeAPI IS 0>selected</cfif>>You Tube/Google API</option>
            <option value="2" <cfif giveall.truveoAPI IS 0>selected</cfif>>Truveo API</option>
          </cfselect></td>
        </tr>
        <tr>
          <td align="right"><cfinput type="hidden" name="ID" value="#giveall.ID#"></td>
          <td><input name="sbtAPI" type="submit" class="border" id="sbtAPI" tabindex="2" value="Choose API" /></td>
        </tr>
      </table>
    </cfform></td>
  </tr>
</table>
