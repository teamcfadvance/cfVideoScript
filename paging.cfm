<cfset pagination = createObject("component", "#request.cfcPath#.Pagination").init() />
<cfif IsDefined('URL.action') AND url.action IS 'toprated'>
<cfset pagination.setQueryToPaginate(toprated) />
<cfelseif IsDefined('URL.action') AND url.action IS 'toprecentfeatured'> 
<cfset pagination.setQueryToPaginate(mostrecent) />
<cfelseif IsDefined('URL.action') AND url.action IS 'topviewed'> 
<cfset pagination.setQueryToPaginate(topviewed) />
<cfelseif IsDefined('URL.action') AND url.action IS 'topdiscussed'> 
<cfset pagination.setQueryToPaginate(mostdiscussed) />
<cfelseif IsDefined('URL.action') AND url.action IS 'toplinked'> 
<cfset pagination.setQueryToPaginate(toplinked) />
<cfelseif IsDefined('URL.action') AND url.action IS 'toprecent'> 
<cfset pagination.setQueryToPaginate(toprecent) />
<cfelseif IsDefined('URL.action') AND url.action IS 'toprespond'> 
<cfset pagination.setQueryToPaginate(toprespond) />
<cfelseif IsDefined('URL.action') AND url.action IS 'topFavs'> 
<cfset pagination.setQueryToPaginate(topFavs) />
<cfelseif IsDefined('URL.action') AND url.action IS 'mobiles'> 
<cfset pagination.setQueryToPaginate(mobilevideo) />
<cfelseif IsDefined('URL.action') AND url.action IS 'author'> 
<cfset pagination.setQueryToPaginate(byAuthor) />
<cfelseif IsDefined('URL.action') AND url.action IS 'categories' OR url.action IS 'subcategories'> 
<cfset pagination.setQueryToPaginate(showus) />
<cfelseif IsDefined('url.searchvideos')>
<cfset pagination.setQueryToPaginate(searched) />
</cfif>
<cfif isDefined('url.searchstring')>
<cfset pagination.setBaseLink("advresults.cfm?searchstring=#url.searchstring#&select_lang=#url.select_lang#&racedcondition=#url.racedcondition#&timeconstraint=#url.timeconstraint#&author=#url.author#&sbtSearch=Search+Videos") />
<cfelseif IsDefined('URL.action') AND url.action IS 'toprated'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=toprated&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=toprated") />
    </cfif>
<cfelseif IsDefined('URL.action') AND url.action IS 'toprecentfeatured'> 
	<cfset pagination.setBaseLink("videos.cfm?action=toprecentfeatured") />
<cfelseif IsDefined('URL.action') AND url.action IS 'topviewed'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=topviewed&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=topviewed") />
    </cfif> 
<cfelseif IsDefined('URL.action') AND url.action IS 'topdiscussed'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=topdiscussed&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=topdiscussed") />
    </cfif> 
<cfelseif IsDefined('URL.action') AND url.action IS 'toplinked'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=toplinked&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=toplinked") />
    </cfif>  
<cfelseif IsDefined('URL.action') AND url.action IS 'toprecent'> 
	<cfset pagination.setBaseLink("videos.cfm?action=toprecent") />
<cfelseif IsDefined('URL.action') AND url.action IS 'toprespond'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=toprespond&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=toprespond") />
    </cfif>  
<cfelseif IsDefined('URL.action') AND url.action IS 'topFavs'>
	<cfif isDefined('url.time')>
		<cfset pagination.setBaseLink("videos.cfm?action=topFavs&time=#url.time#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=topFavs") />
    </cfif> 
<cfelseif IsDefined('URL.action') AND url.action IS 'mobiles'> 
	<cfset pagination.setBaseLink("videos.cfm?action=mobiles") />  
<cfelseif IsDefined('URL.action') AND url.action IS 'author'> 
	<cfif isDefined('url.code')>
		<cfset pagination.setBaseLink("videos.cfm?action=author&code=#url.code#") />
    <cfelse>
    	<cfset pagination.setBaseLink("videos.cfm?action=author") />
    </cfif> 
<cfelseif IsDefined('URL.action') AND url.action IS 'categories'> 
	<cfset pagination.setBaseLink("videos.cfm?action=categories&catname=#url.catname#&ID=#url.ID#") />
<cfelseif IsDefined('URL.action') AND url.action IS 'subcategories'> 
	<cfset pagination.setBaseLink("videos.cfm?action=subcategories&subcatname=#url.subcatname#&subID=#url.subID#") />
<cfelse>
	<cfset pagination.setBaseLink("videos.cfm?searchvideos=#url.searchvideos#&action=Go") />                 
</cfif>
<cfset pagination.setItemsPerPage(12) />
<cfset pagination.setShowNumericLinks(true) />
<cfset pagination.getTotalNumberOfPages()/>