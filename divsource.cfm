<cfset yt = createObject("component", "#request.cfcPath#.youtube")>
<cfset pl = yt.getPlaylists("#url.view#")>
<cfif pl.recordCount>
	<cfset plurl = pl.url[1]>
</cfif>