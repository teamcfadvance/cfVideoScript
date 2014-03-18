<cfif listlast(cgi.script_name, "/") eq "ads.cfm">
  <cflocation url="index.cfm?action=ads" addtoken="no">
</cfif>
<cfparam name="bannertop" default="">
<cfparam name="bannerright" default="">
<cfparam name="bannerbottom" default="">
<cfparam name="enablebanner" default="">
<cfparam name="squarebanner" default="">
<cfinvoke component="#request.cfcPath#.video" method="CheckIfEmpty" returnvariable="seeit">
<cfif IsDefined('form.banner')>
	<cfif seeit.recordcount>
    	<cfinvoke component="#request.cfcPath#.video" method="updateBanner" argumentcollection="#form#" returnvariable="str">
        <cfset msg = "#str#">
    <cfelse>
    	<cfinvoke component="#request.cfcPath#.video" method="addNewBanner" argumentcollection="#form#">
    </cfif>
</cfif>
<cfif seeit.recordcount>
	<cfset bannertop = #trim(seeit.bannertop)#>
    <cfset bannerright = #trim(seeit.bannerright)#>
    <cfset bannerbottom = #trim(seeit.bannerbottom)#>
    <cfset squarebanner = #trim(seeit.squarebanner)#>
    <cfset bText = "Update Banner">
    <cfset editID = #trim(seeit.bannerID)#>
    <cfset enablebanner = #trim(seeit.enablebanner)#>
<cfelse>
	<cfset bannertop = "">
    <cfset bannerright = "">
    <cfset bannerbottom = "">
    <cfset squarebanner = "">
    <cfset bText = "Add Banner Info">
    <cfset editID = 0>
    <cfparam name="enablebanner" default="0">
</cfif>
<cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post" name="banner">
<table width="100%" border="0" cellpadding="2" cellspacing="1">
  <tr>
  	<td colspan="2" align="center" class="oncaption">Manage Ads</td></tr>
  <cfif isdefined('msg')>
    <tr>
      <td colspan="2" align="center" class="MainBar"><cfoutput>#str#</cfoutput></td>
    </tr>
  </cfif>
  <tr>
    <td width="25%" align="right" valign="top" class="txt">Banner Top</td>
    <td><textarea name="bannertop" cols="45" rows="5" class="o" id="bannertop" tabindex="1"><cfoutput>#bannertop#</cfoutput></textarea></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Banner Right</td>
    <td><textarea name="bannerRight" cols="45" rows="5" class="o" id="bannerRight" tabindex="2"><cfoutput>#bannerright#</cfoutput></textarea></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Banner Bottom</td>
    <td><textarea name="bannerBottom" cols="45" rows="5" class="o" id="bannerBottom" tabindex="3"><cfoutput>#bannerbottom#</cfoutput></textarea></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Square Banner</td>
    <td><textarea name="squarebanner" cols="45" rows="5" class="o" id="squarebanner" tabindex="4"><cfoutput>#squarebanner#</cfoutput></textarea></td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">Enable Banner</td>
    <td class="txt"><cfinput type="text" name="enablebanner" class="o" tabindex="5" style="width:15px;" value="#enablebanner#">
      <br>
    (* Write 1 or Enabling and 0 for disabling) </td>
  </tr>
  <tr>
    <td align="right" valign="top" class="txt">&nbsp;</td>
    <td class="txt"><cfoutput>
    <input type="hidden" name="editID" value="#editID#">
      <input type="submit" name="banner" id="banner" value="#bText#" tabindex="6" class="border">
    </cfoutput></td>
  </tr>
  <tr>
    <td colspan="2" class="txt">Note: Enter Any Ads Code /Google Ad Sese Code/ Image Tage Code for Image Banner Ads </td>
  </tr>
</table>
</cfform>
