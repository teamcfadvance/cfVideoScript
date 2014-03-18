<cfset variables.newrow = False>
<cfset yt = createObject("component", "#request.cfcpath#.youtube")>
<!---<cfset tick = GetTickCount()>--->
<!---<cfset tock = GetTickCount()>--->
<cfif url.start lt 41>
	<cfset perpage = 10>
    <cfparam name="url.start" default="1">
    <cfif StructKeyExists(URL,'time')>	
                <cfset toprated = #yt.getTopRatedVideos("#url.time#",1,50)#>
    <cfelse>
                <cfset toprated = #yt.getTopRatedVideos("",1,50)#>
    </cfif>
    <cfif not isNumeric(url.start) or url.start lt 1 or url.start gt toprated.recordCount or round(url.start) neq url.start>
        <cfset url.start = 1>
    </cfif>
<cfelse>
	<cfset perpage = 10>
    <cfparam name="url.start" default="51">
    <cfif StructKeyExists(URL,'time')>	
                <cfset toprated = #yt.getTopRatedVideos("#url.time#",51,100)#>
    <cfelse>
                <cfset toprated = #yt.getTopRatedVideos("",51,100)#>
    </cfif>
    <cfif not isNumeric(url.start) or url.start lt 51 or url.start gt toprated.recordCount or round(url.start) neq url.start>
        <cfset url.start = 51>
    </cfif>
</cfif>
<table align="center" width="100%">
<cfoutput>
<!---<cfset _searchtime = (tock - tick)/1000>  --->
    <tr>
      <td colspan="4"><div style="float:left;"><!---Fetching data took <b class="errString">#_searchtime#</b> (locally) seconds---></div><div style="float:right;">&nbsp;&nbsp;<a href="videos.cfm?action=toprated&time=today" title="Show Todays's Top rated videos">Today</a> | <a href="videos.cfm?action=toprated&time=this_week" title="Show this week's top rated videos">This week</a> | <a href="videos.cfm?action=toprated&time=this_month" title="Show this month's top rated videos">This Month</a> | <a href="videos.cfm?action=toprated&time=all_time" title="Ahow all time Top rated Videos">All Time</a></div></td>
    </tr>
</cfoutput>
<cfif variables.newrow EQ true>
    <tr>
  </cfif>  
  <cfif toprated.recordcount>
	<!---<cfinclude template="paging.cfm">
	<br />
    <div align="center">
    <cfoutput>
    Displaying <b>#pagination.getStartRow()#</b> to <b>#pagination.getMaxRows()#</b> of <b>#toprated.total#</b> Records.
    </cfoutput>
    </div>
    <cfoutput>#pagination.getRenderedHTML()#</cfoutput>--->
    [
<cfif url.start gt 1>
    <cfset link = cgi.script_name & "?start=" & (url.start - perpage)>
    <cfoutput><a href="#link#">Previous Page</a></cfoutput>
<cfelse>
    Previous Page
</cfif>
/
<cfif (url.start + perpage - 1) lt toprated.recordCount>
    <cfset link = cgi.script_name & "?action=toprated&time=#url.time#&start=" & (url.start + perpage)>
    <cfoutput><a href="#link#">Next Page</a></cfoutput>
<cfelse>
    Next Page
</cfif>
]
    <cfoutput query="toprated" startrow="#url.start#" maxrows="#perpage#">
     <td height="30" valign="middle">
      <div class="leftcontentDIV" align="center"> <strong><a href="videos.cfm?action=show&ID=#ID#"> <img src="#thumbnail_url#" width="#thumbnail_width#" height="#thumbnail_height#" title="#title#" border="0"/></a><br>
        <cfinclude template="timing.cfm">
        <br>
        <div align="center">#Left(title,10)#...<br>
          <cfif averagerating GT 0>
            #repeatstring('<img src="images/star.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', int(averagerating))#
            <cfif int(#averagerating#) LT 5>
              #repeatstring('<img src="images/star-blank.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', 5-int(averagerating))#
            </cfif>
            <cfelse>
            #repeatstring('<img src="images/star-blank.png" width="16" height="16" alt="not rated yet" title="not rated yet">', 5)#
          </cfif>
          <br>
          <cfif #viewcount# IS "">0<cfelse>#viewcount#</cfif> views<br>
          <a href="videos.cfm?action=author&code=#author#" title="All Videos by #author#">#author#</a></div>
        </strong> </div>
      </td>
      
      <cfif toprated.currentRow MOD 4 EQ 0>
        </tr>
        
        <cfset variables.newrow = true>
        <cfelse>
        <cfset variables.newrow = false>
      </cfif>
    </cfoutput>
    <cfelse>
    <tr>
      <td colspan="4" align="center"><img src="images/smilo.gif" alt="No Top rated videos Found" border="0" /><br />
        <br />
        No Top rated videos Found! </td>
    </tr>
  </cfif>
  </tr>
  
</table>
