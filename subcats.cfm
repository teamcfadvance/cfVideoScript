<cfif Not StructKeyExists(URL,'ID')>
<p>Please choose a Category to Load its relevant Subcategories</p>
<cfelse>
<cfinvoke component="#request.cfcPath#.video" method="getSubCats" catID="#trim(url.ID)#" view="1" returnvariable="showsubcats"/>
<ul>
<cfoutput query="showsubcats">
<cfset modifySubcatName = #Replace(SubcatDesc,"%20","+","One")#>
    	<li><a href="videos.cfm?action=subcategories&subcatname=#modifySubcatName#&subID=#Val(subCatID)#&ID=#Val(catID)#">#SubcatDesc#</a></li>
</cfoutput>
</ul>
</cfif>
