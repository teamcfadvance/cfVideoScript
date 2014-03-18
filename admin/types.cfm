<cfparam name="url.action" default="" type="string">
<cfswitch expression="#url.action#">
	<cfcase value="cats">
    	<cfinclude template="categories.cfm">
    </cfcase>
    <cfcase value="editcategories">
    	<cfinclude template="editcategories.cfm">
    </cfcase>
    <cfcase value="search">
    	<cfinclude template="editcategories.cfm">
    </cfcase>
    <cfcase value="subcats">
    	<cfinclude template="subcategories.cfm">
    </cfcase>
    <cfcase value="editsubcategories">
    	<cfinclude template="editsubcategories.cfm">
    </cfcase>
    <cfcase value="Find">
    	<cfinclude template="editsubcategories.cfm">
    </cfcase>
    <cfcase value="settings">
    	<cfinclude template="settings.cfm">
    </cfcase>
    <cfcase value="mail">
    	<cfinclude template="mails.cfm">
    </cfcase>
    <cfcase value="extra">
	    <cfinclude template="extra.cfm">
    </cfcase>  
    <cfcase value="bans">
    	<cfinclude  template="bans.cfm">
    </cfcase>  
    <cfcase value="tags">
    	<cfinclude template="tags.cfm">
    </cfcase>
    <cfcase value="newtag">
    	<cfinclude template="newtag.cfm">
    </cfcase>
    <cfcase value="filter">
    	<cfinclude template="filter.cfm">
    </cfcase>
    <cfcase value="BadWord">
    	<cfinclude template="filter.cfm">
    </cfcase>
    <cfcase value="header">
    	<cfinclude template="manageheader.cfm">
    </cfcase>
    <cfcase value="editheaders">
    	<cfinclude template="editheaders.cfm">
    </cfcase>
    <cfcase value="view">
    	<cfinclude template="editheaders.cfm">
    </cfcase>
    <cfcase value="footer">
    	<cfinclude template="managefooter.cfm">
    </cfcase>
    <cfcase value="ads">
    	<cfinclude template="ads.cfm">
    </cfcase>
    <cfcase value="tagclouds">
    	<cfinclude template="clouds.cfm">
    </cfcase>
    <cfcase value="viewtags">
    	<cfinclude template="viewclouds.cfm">
    </cfcase>
    <cfcase value="accounts">
    	<cfinclude template="accounts.cfm">
    </cfcase>
    <cfcase value="config">
    	<cfinclude template="config.cfm">
    </cfcase>
</cfswitch>