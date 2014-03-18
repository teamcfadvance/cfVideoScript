<cfset variables.newrow = False>
<cfset yt = createObject("component", "#request.cfcpath#.youtube")>
<cfif isDefined('url.searchstring') AND url.select_lang EQ 0 AND url.author EQ "">
	<cfset tick = GetTickCount()>
		<cfset searched = #yt.getVideosBySearch(search=#url.searchstring#)#>
    <cfset tock = GetTickCount()>
    
<cfelseif isDefined('url.searchstring') AND url.select_lang NEQ 0 AND url.author NEQ "">
	<cfinvoke component="#request.cfcpath#.youtube" method="getVideosBySearch" returnvariable="searched">
    	<cfinvokeargument name="search" value="#url.searchstring#">
        <cfinvokeargument name="lang" value="#url.select_lang#">
        <cfinvokeargument name="author" value="#url.author#">
        <cfinvokeargument name="time" value="#url.timeconstraint#">
    </cfinvoke>
<cfelseif isDefined('url.searchstring') AND url.select_lang NEQ 0 AND url.author eq "">    
	<cfinvoke component="#request.cfcpath#.youtube" method="getVideosBySearch" returnvariable="searched">
    	<cfinvokeargument name="search" value="#url.searchstring#">
        <cfinvokeargument name="lang" value="#url.select_lang#">
        <cfinvokeargument name="time" value="#url.timeconstraint#">
    </cfinvoke>
<cfelseif isDefined('url.searchstring') AND url.select_lang EQ 0 AND url.author NEQ "">
	<cfinvoke component="#request.cfcpath#.youtube" method="getVideosBySearch" returnvariable="searched">
    	<cfinvokeargument name="search" value="#url.searchstring#">
        <cfinvokeargument name="author" value="#url.author#">
        <cfinvokeargument name="time" value="#url.timeconstraint#">
    </cfinvoke>   
</cfif>
<cfdump var="#searched#">
<table align="center" width="100%">
<tr>
      <td align="right" class="menu02"><cfset _searchtime = (tock - tick)/1000>
        <cfoutput>Search Took <b>#_searchtime#</b> (locally) seconds.</cfoutput></td>  
</tr>
<cfif searched.recordcount>
      <tr>
        <td><div align="center">
            <cfinclude template="paging.cfm">
            Showing <cfoutput>#pagination.getStartRow()# to #pagination.getMaxRows()# of total of #searched.recordcount#</cfoutput>
            <br />
            <cfoutput>#pagination.getRenderedHTML()#</cfoutput></div></td>
      </tr>
      <cfoutput query="searched" startrow="#pagination.getStartRow()#" maxrows="#pagination.getMaxRows()#">
      <tr><td>
      	<img src="#thumbnail_url#" width="#thumbnail_width#" height="#thumbnail_height#" title="#title#" border="0"/>
      </td></tr>
      </cfoutput>
</cfif>      
</table>    