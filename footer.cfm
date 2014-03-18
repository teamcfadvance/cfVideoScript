<cfinclude template="admin/inc/stripHTML.cfm">
<table align="center" width="100%">
<tr><td><a href="index.cfm" id="current">Home</a></td>
<td><a href="videos.cfm?action=toprecentfeatured">Most Recently Featured</a></td>
<td><a href="videos.cfm?action=topviewed">Most Viewed</a></td>
<td><a href="videos.cfm?action=topdiscussed">Most Dicussed</a></td>
<td><a href="videos.cfm?action=toplinked">Most Linked</a></td>
<td><a href="videos.cfm?action=toprecent">Most Recent</a></td>
<td><a href="videos.cfm?action=toprespond">Most Responded</a></td>
<td><a href="videos.cfm?action=topfavs">Most Favorites</a></td>
<td><a href="videos.cfm?action=toprated">Most Rated</a></td>
<td><a href="videos.cfm?action=mobiles">All Time Mobile Videos</a></td>
</tr>
<tr>
<td colspan="10">
<cfif FileExists("#Expandpath("admin/footer/footer.htm")#")>
   	<cffile action="read" file="#Expandpath("admin/footer/footer.htm")#" variable="footers">
<cfprocessingdirective suppresswhitespace="yes">    
<cfoutput>
#stripHTML(footers)#</cfoutput>
</cfprocessingdirective>
</cfif>
</td>
</tr>
</table>