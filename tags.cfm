<cfinvoke component="#request.cfcPath#.video" method="getTags" getmain="1" returnvariable="showTags"/>
<table align="left" width="100%" cellpadding="0" cellspacing="0">
<tr><td>
<ul>
<cfoutput query="showTags">	
    	<li><a href="videos.cfm?action=tags&tagname=#tagname#&tID=#Val(ID)#" title="Search for this #tagname# related videos.">#tagname#</a></li>
</cfoutput>
</ul>
</td></tr>
</table>