<cfsetting showdebugoutput="false">
<cfparam name="url.action" default="">
<cfswitch expression="#url.action#">
	<cfcase value="categories">
    	<cfinclude template="showbycategory.cfm">
    </cfcase>
    <cfcase value="subcategories">
    	<cfinclude template="showbysubcategory.cfm">
    </cfcase>
    <cfcase value="show">
    	<cfinclude template="showvideobyID.cfm">
    </cfcase>
    <cfcase value="toprecentfeatured">
    	<cfinclude template="toprecentfeatured.cfm">
    </cfcase>
    <cfcase value="mobiles">
    	<cfinclude template="mobilevideos.cfm">
    </cfcase>
    <cfcase value="topviewed">
    	<cfinclude template="topviewed.cfm">
    </cfcase>
    <cfcase value="topdiscussed">
    	<cfinclude template="topdiscussed.cfm">
    </cfcase>
    <cfcase value="toplinked">
    	<cfinclude template="toplinked.cfm">
    </cfcase>
    <cfcase value="toprecent">
    	<cfinclude template="toprecent.cfm">
    </cfcase>
    <cfcase value="toprespond">
    	<cfinclude template="toprespond.cfm">
    </cfcase>
    <cfcase value="topfavs">
    	<cfinclude template="topfavorites.cfm">
    </cfcase>
    <cfcase value="toprated">
    	<cfinclude template="toprated.cfm">
    </cfcase>
    <cfcase value="author">
    	<cfinclude template="author.cfm">
    </cfcase>
    <cfcase value="advsearch">
    	<cfinclude template="advsearch.cfm">
    </cfcase>
    <cfcase value="tags">
    	<cfinclude template="showtags.cfm">
    </cfcase>
    <cfcase value="alltags">
    	<cfinclude template="alltags.cfm">
    </cfcase>
</cfswitch>