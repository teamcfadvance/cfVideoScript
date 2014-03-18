<cfinvoke component="#request.cfcPath#.video" method="getHeaders"status="1" returnvariable="showheader"/>
<cfoutput query="showheader">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td width="65%"><cfif headerImage IS "">
    <cfelse>
    	<img src="admin/headers/#headerImage#" border="0" alt="Videos" title="#header#"/>
    </cfif></td>
    <td width="35%" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="1" cellspacing="2" class="search_home">
      <tr>
        <td class="fullback"><strong class="fccolor">Search Website</strong></td>
      </tr>
      <tr>
        <td><cfform method="get" action="results.cfm">
          <input name="searchvideos" type="text" id="searchvideos" size="25" maxlength="255" class="textfield_input" style="width:200px;" />
          &nbsp;&nbsp;
          <input type="submit" name="action" id="action" value="Go" class="border" />&nbsp;&nbsp;<a title="Go for an Advanced Search" href="videos.cfm?action=advsearch">Advanced</a>
        </cfform></td>
      </tr>
      <tr>
        <td class="menu02">(Search Videos from Youtube. right here)</td>
      </tr>
    </table></td>
  </tr>
  <tr class="bigtitle"><td><strong>#header#</strong></td>
    </tr>
</table>
</cfoutput>