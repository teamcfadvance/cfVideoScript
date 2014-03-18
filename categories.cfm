<cfinvoke component="#request.cfcPath#.video" method="getCats" returnvariable="showcats"/>
<ul>
<cfoutput query="showcats">	
    	<li><a href="videos.cfm?action=categories&catname=#catname#&ID=#Val(catID)#">#catname#</a></li>
</cfoutput>
</ul>