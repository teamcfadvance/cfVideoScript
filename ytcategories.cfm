<cfsetting showdebugoutput="false">
<cfset yt = createObject("component", "#request.cfcPath#.youtube")>
<cfset youtubeCategories = #yt.getCategories()#>
<ul>
<cfloop array="#youtubeCategories#" index="i">
<cfoutput>	
    	<li><a href="videos.cfm?action=categories&catname=#i#&ID=0" title="#i#">#i#</a></li>
</cfoutput>       
</cfloop>
</ul>