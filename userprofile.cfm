<cfset yt = createObject("component", "#request.cfcPath#.youtube")>
<!--- Get a valid user. --->
<cfdump var="#yt.getProfile('#trim(url.code)#')#" label="Result of profile on 'cfjedimaster'">
<!--- Get an invalid user. --->
<cftry>
	<cfset p = yt.getProfile("parishiltonlovesbillgates")>
	<cfcatch>
		<cfdump var="#cfcatch#" label="Error from calling invalid profile.">
	</cfcatch>
</cftry>
