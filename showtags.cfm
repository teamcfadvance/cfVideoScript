<cfset variables.newrow = False>
<cfset yt = createObject("component", "#request.cfcpath#.youtube")>
<cfset tick = GetTickCount()>
<cfset getbyTag = #yt.getVideosByCategoriesKeywords('keywords=#url.tagName#')#>
<cfset tock = GetTickCount()>
<table align="center" width="100%">
<cfoutput>
<cfset _searchtime = (tock - tick)/1000>
<tr><td colspan="4"><div style="float:left;">Fetching data took <b class="errString">#_searchtime#</b> (locally) seconds</div></td></tr>
</cfoutput>
  <cfif variables.newrow EQ true>
    <tr>
  </cfif>
  <cfif getbyTag.recordcount>
  <cfoutput query="getbyTag">
    <td align="center" height="30" valign="middle"><div class="leftcontentDIV">
    <strong><a href="videos.cfm?action=show&ID=#ID#">
    <img src="#thumbnail_url#" width="#thumbnail_width#" height="#thumbnail_height#" title="#title#" border="0"/></a><br>
    <cfinclude template="timing.cfm"><br>
    <div align="center">#Left(title,10)#...<br>    
    <cfif averagerating GT 0>
        #repeatstring('<img src="images/star.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', int(averagerating))#
        <cfif int(#averagerating#) LT 5>
          #repeatstring('<img src="images/star-blank.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', 5-int(averagerating))#
        </cfif>
    <cfelse>
      #repeatstring('<img src="images/star-blank.png" width="16" height="16" alt="not rated yet" title="not rated yet">', 5)#
    </cfif><br>
    <cfif #viewcount# IS "">0<cfelse>#viewcount#</cfif> views<br>
    <a href="videos.cfm?action=author&code=#author#" title="All Videos by #author#">#author#</a></div>
    </strong>
    </div>
      </td>
      <cfif getbyTag.currentRow MOD 4 EQ 0>
        </tr>
        <cfset variables.newrow = true>
        <cfelse>
        <cfset variables.newrow = false>
      </cfif>
  </cfoutput>
  <cfelse>
  <cfoutput>
  <tr>
      <td colspan="4" align="center"><img src="images/smilo.gif" alt="No videos Found" border="0" /><br />
        <br />
        No videos Found under Tags <strong><em>#url.tagname#</em></strong>! </td>
    </tr>
    <tr><td colspan="4">Please Try <a href="results.cfm?searchvideos=#trim(url.tagname)#&action=go">Search</a> here to find Videos related to <em><strong>#url.tagname#</strong></em></td></tr>
    </cfoutput>
  </cfif>
  <tr>
</table>
