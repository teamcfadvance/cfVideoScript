<cfif listlast(cgi.script_name, "/") eq "extra.cfm">
  <cflocation url="index.cfm?action=extra" addtoken="no">
</cfif>
<cfinvoke component="#request.cfcpath#.video" method="getExtra" returnvariable="showextra"/>
<cfif isDefined('form.submitSettings')>
	<cfinvoke component="#request.cfcPath#.video" method="updateExtra" structform="#form#" returnvariable="str"/>
    <cfset msg = "#str#">
</cfif>
<cfoutput query="showextra">
<cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
    <table width="100%" border="0" cellpadding="1" cellspacing="2">
      <tr>
        <td colspan="3" align="center" class="oncaption">Manage Display Settings</td>
      </tr>
      <cfif isdefined('msg')>
        <tr>
          <td colspan="3" align="center" class="MainBar">
              <cfoutput>#msg#</cfoutput></td>
        </tr>
      </cfif>
      <tr>
        <td width="19%" align="right" class="txt">Show Tags</td>
        <td width="5%"><input tabindex="1" name="showtags" type="checkbox" id="showtags" value="Yes" <cfif #showtags# IS 'Yes'>checked="checked"<cfelse></cfif>>
        </td>
        <td width="76%" class="txt">Show tags in Front End</td>
      </tr>
      <tr>
        <td align="right" class="txt">Show Categories</td>
        <td><input name="showCategories" tabindex="2" type="checkbox" id="showCategories" value="Yes" <cfif #showCategories# IS 'Yes'>checked="checked"<cfelse></cfif>></td>
        <td class="txt">Show Categories on Website</td>
      </tr>
      <tr>
        <td align="right" class="txt">Show Subcategories:</td>
        <td><input name="Showsubcategories" tabindex="3" type="checkbox" id="Showsubcategories" value="Yes" <cfif #Showsubcategories# IS 'Yes'>checked="checked"<cfelse></cfif>></td>
        <td class="txt">Show Subcategories under Categories</td>
      </tr>
      <tr>
        <td align="right" class="txt">Show Tag Couds:</td>
        <td><input name="ShowTagClouds" type="checkbox" tabindex="4" id="ShowTagClouds" value="Yes" <cfif #ShowTagClouds# IS 'Yes'>checked="checked"<cfelse></cfif>></td>
        <td class="txt">Show Most recently Searched Items</td>
      </tr>
      <tr>
        <td><input type="hidden" name="ID" value="#ID#"></td>
        <td colspan="2"><input name="submitSettings" type="submit" class="border" id="submitSettings" tabindex="5" value="Configure"></td>
      </tr>
    </table>
  </cfform>
</cfoutput>  