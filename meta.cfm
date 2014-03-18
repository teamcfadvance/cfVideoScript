<cfinvoke component="#request.cfcPath#.video" method="getConfig" returnvariable="showmetatag"/>
<cfif showmetatag.site_enable EQ 'Yes'>
<cfoutput query="showmetatag">
<META NAME="DESCRIPTION" CONTENT="#site_desc#">
<META NAME="KEYWORDS" CONTENT="#site_keys#">
<META NAME="Generator" CONTENT="#site_generator#">
<META NAME="PUBLISHER" CONTENT="#site_publisher#">
<META NAME="LANGUAGE" CONTENT="English">
<META NAME="COPYRIGHT" CONTENT="#site_copyright#">
<META NAME="ROBOTS" CONTENT="index">
<META NAME="ROBOTS" CONTENT="follow">
<META NAME="REVISIT-AFTER" CONTENT="#site_revisit#">
<title>#site_title#</title>
<cfset t = #site_title#>
<cfset webemail = "#site_email#">
</cfoutput>
<cfelse>
<title>Video Management! Your Solution to Everything</title>
<cfset webemail = "#request.emailOwner#">
</cfif>