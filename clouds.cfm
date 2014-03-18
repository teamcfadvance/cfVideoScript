<cfinvoke component="#request.cfcPath#.video" method="searchfind" returnvariable="tags"/>
<cfset tagValueArray = ListToArray(ValueList(tags.tagCount))>
<cfset max = ArrayMax(tagValueArray)>
<cfset min = ArrayMin(tagValueArray)>

<cfset diff = max - min>
<cfset distribution = diff / 3>
<cfoutput query="tags">
	<cfif tags.tagCount EQ min>
		<cfset class="smallestTag">
	<cfelseif tags.tagCount EQ max>
		<cfset class="largestTag">
	<cfelseif tags.tagCount GT (min + (distribution*2))>
		<cfset class="largeTag">
	<cfelseif tags.tagCount GT (min + distribution)>
		<cfset class="mediumTag">
	<cfelse>
		<cfset class="smallTag">
	</cfif>
	<a href="results.cfm?searchvideos=#Trim(term)#&action=go" class="#class#">#tags.term#</a>
</cfoutput>