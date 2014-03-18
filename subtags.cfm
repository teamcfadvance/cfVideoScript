<cfparam name="tID" default="0">
<cfif tID IS 0>
<cfelse>
<cfinvoke component="#request.cfcPath#.video" method="getTags" getrelated="10" tagID="#Val(tID)#" returnvariable="showsubs"/>
<table align=center cellspacing=0 cellpadding=0>
<tr>
<cfif showsubs.recordcount>
	<td style="background-color:#EBEBEB">
    	<cfinclude template="marquee.cfm">
    </td>
<cfelse>
</cfif>
</tr>
</table>
</cfif>