<cfif listlast(cgi.script_name, "/") eq "settings.cfm">
  <cflocation url="index.cfm?action=settings" addtoken="no">
</cfif>
<cfinvoke component="#request.cfcpath#.video" method="getConfig" returnvariable="showmeta"/>
<cftry>
<cfif isDefined('form.submitMeta')>
  <cfif len(form.site_title) IS 0>
    <cflocation addtoken="no" url="index.cfm?action=settings&msg=1">
    <cfelse>
    <cfinvoke component="#request.cfcpath#.video" method="updatemeta" argumentcollection="#form#"/>
    <cflocation addtoken="no" url="index.cfm?action=settings&msg=2">
  </cfif>
</cfif>
<cfcatch>
	<cfset i = "Error! #cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>
<cfif showmeta.recordcount>
	<cfparam name="site_title" default="#site_title#">
	<cfparam name="site_email" default="#site_email#">
	<cfparam name="site_desc" default="#site_desc#">
	<cfparam name="site_keys" default="#site_keys#">
	<cfparam name="site_publisher" default="#site_publisher#">
	<cfparam name="site_revisit" default="#site_revisit#">
	<cfparam name="site_generator" default="#site_generator#">
	<cfparam name="site_copyright" default="#site_copyright#">
	<cfparam name="site_enable" default="#site_enable#">
	<cfparam name="site_ID" default="#mid#">
<cfelse>
	<cfparam name="site_title" default="">
	<cfparam name="site_email" default="">
	<cfparam name="site_desc" default="">
	<cfparam name="site_keys" default="">
	<cfparam name="site_revisit" default="">
	<cfparam name="site_publisher" default="">
	<cfparam name="site_generator" default="">
	<cfparam name="site_copyright" default="">
	<cfparam name="site_enable" default="">
	<cfparam name="site_ID" default="0">
</cfif>	

<cfoutput>
  <cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
    <table width="100%" border="0" cellpadding="1" cellspacing="2">
      <tr>
        <td colspan="2" align="center" class="oncaption">Manage Configuration</td>
      </tr>
      <cfif isdefined('msg')>
        <tr>
          <td colspan="2" align="center" class="MainBar"><cfif msg IS 1>
              Error! Please Provide Site Title
              <cfelseif msg IS 2>
              Cool! Configration Setting Completed Successfully.
            </cfif></td>
        </tr>
      </cfif>
      <tr>
        <td width="19%" align="right" class="txt">Site Title:</td>
        <td width="81%"><cfinput type="text" name="site_title" class="o" id="site_title" tabindex="1" value="#site_title#"></td>
      </tr>
      <tr>
        <td align="right" class="txt">Site Email Address:</td>
        <td><cfinput type="text" name="site_email" class="o" id="site_email" tabindex="2" value="#site_email#"></td>
      </tr>
      <tr>
        <td align="right" valign="top" class="txt">Site Description:</td>
        <td><textarea name="site_desc" cols="45" rows="5" class="o" id="site_desc" tabindex="3"><cfoutput>#site_desc#</cfoutput></textarea></td>
      </tr>
      <tr>
        <td align="right" valign="top" class="txt">Site Keywords:</td>
        <td><textarea name="site_keys" cols="45" rows="5" class="o" id="site_keys" tabindex="4"><cfoutput>#site_keys#</cfoutput></textarea>
        <input type="hidden" name="site_ID" id="site_ID" value="#site_ID#"></td>
      </tr>
      <tr>
        <td align="right" class="txt">Publisher:</td>
        <td><cfinput type="text" name="site_publisher" class="o" id="site_publisher" tabindex="5" value="#site_publisher#"></td>
      </tr>
      <tr>
        <td align="right" class="txt">Generator:</td>
        <td><cfinput type="text" name="site_generator" class="o" id="site_generator" tabindex="6" value="#site_generator#"></td>
      </tr>
      <tr>
        <td align="right" class="txt">Copyright:</td>
        <td><cfinput type="text" name="site_copy" class="o" id="site_copy" tabindex="7" value="#site_copyright#"></td>
      </tr>
      <tr>
        <td align="right" class="txt">Revisit:</td>
        <td><cfinput type="text" name="site_revisit" class="o" id="site_revisit" tabindex="8" value="#site_revisit#"></td>
      </tr>
      <tr>
        <td align="right" valign="top" class="txt">Enable SEO:</td>
        <td class="txt"><input name="enable" type="checkbox" id="enable" value="Yes" <cfif #site_enable# IS 'Yes'>checked="checked"<cfelse></cfif>>
          <cfif #site_enable# IS 'Yes'>
            SEO Enabled
            <cfelse>
            Enable SEO
          </cfif>
          <cfif #site_enable# IS 'Yes'>
            <br />
            To Disable SEO, UnCheck the Checkbox
        </cfif></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input name="submitMeta" type="submit" class="border" id="submitMeta" tabindex="10" value="Configure Website"></td>
      </tr>
    </table>
  </cfform>
</cfoutput>