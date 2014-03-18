<cfif listlast(cgi.script_name, "/") eq "editheaders.cfm">
  <cflocation url="index.cfm?action=header" addtoken="no">
</cfif>
<cfparam name="sort" default="1">
<cfparam name="l" default="a">
<cfif isDefined('url.searchheaders')>
  <cfinvoke component="#request.cfcPath#.video" method="getHeaders" searchheaders="#url.searchheaders#" set="1" returnvariable="Recordset1"/>
  <cfelseif isDefined('url.l')>
  <cfinvoke component="#request.cfcPath#.video" method="getHeaders" l="#url.l#" returnvariable="Recordset1"/>
  <cfelse>
  <cfinvoke component="#request.cfcPath#.video" method="getHeaders" sortorder="#sort#" returnvariable="Recordset1"/>
</cfif>
<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_Recordset1" default="1">
<cfset MaxRows_Recordset1=10>
<cfset StartRow_Recordset1=Min((PageNum_Recordset1-1)*MaxRows_Recordset1+1,Max(Recordset1.RecordCount,1))>
<cfset EndRow_Recordset1=Min(StartRow_Recordset1+MaxRows_Recordset1-1,Recordset1.RecordCount)>
<cfset TotalPages_Recordset1=Ceiling(Recordset1.RecordCount/MaxRows_Recordset1)>
<cfset QueryString_Recordset1=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_Recordset1,"PageNum_Recordset1=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_Recordset1=ListDeleteAt(QueryString_Recordset1,tempPos,"&")>
</cfif>
<cfif isDefined('url.delete')>
  <cfinvoke component="#request.cfcpath#.video" method="deleteHeader" displayID="#trim(url.delete)#"/>
  <cfset n = "Cool! Header Deleted Successfully">
  <cflocation addtoken="no" url="index.cfm?action=editheaders&n=#ToBase64(n)#">
</cfif>
<cfif isDefined('url.value')>
  <cfinvoke component="#request.cfcpath#.video" method="updateHeadersActiveness" displayID="#trim(url.value)#"/>
  <cfset n = "Cool! Status updated Successfully">
  <cflocation addtoken="no" url="index.cfm?action=editheaders&n=#ToBase64(n)#">
</cfif>

<table align="center" width="100%">
  <tr align="center" class="oncaption">
    <td><a href="index.cfm?action=header">Create New-Header</a></td>
  </tr>
  <tr align="left">
    <td><a href="<cfoutput>#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</cfoutput>">Records Not seen as Updated, Refresh Page</a></td>
  </tr>
  <cfform method="get" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
  <tr align="left">
    <td align="center"><label>Find by Name:</label>
      <input type="text" name="searchheaders" id="searchheaders" />
      &nbsp;
      <input type="submit" name="action" value="View" /></td>
  </tr>
  </cfform>
</table>
<br />
<div align="center"> <cfoutput>Records #StartRow_Recordset1# to #EndRow_Recordset1# of #Recordset1.RecordCount# </cfoutput> </div>
<div align="left"> <cfoutput><a href="index.cfm?action=editheaders&sort=1">Sort by A-Z</a> | <a href="index.cfm?action=editheaders&sort=2">Sort by Z-A</a></cfoutput> </div>
<div align="center"> <cfoutput>
    <cfset alpha = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
    <Cfloop from="1" to="#ListLen(alpha)#" index="L">
      <cfif L neq "1">
        |
      </cfif>
      <a href="index.cfm?action=editheaders&l=#listgetat(alpha, L)#">#listgetat(alpha, L)#</span></a>
    </CFLOOP>
    | <a href="index.cfm?action=editheaders"><strong>All</strong></a> </cfoutput> </div>
<table width="100%" border="0" align="center">
  <cfif isdefined('n')>
    <tr>
      <td colspan="4" align="center" class="MainBar"><cfoutput>#ToString(ToBinary(n))#</cfoutput></td>
    </tr>
  </cfif>
  <tr align="left" class="tablerow">
    <th width="25%">Header Name</th>
    <th width="47%">Usage</th>
    <th width="17%">Action</th>
  </tr>
  <cfif Recordset1.recordcount>
    <cfoutput query="Recordset1" startRow="#StartRow_Recordset1#" maxRows="#MaxRows_Recordset1#">
      <tr class="#IIf(CurrentRow Mod 2, DE('rowOdd'), DE('rowEven'))#" 
    onmouseover="this.className='rowHighlight'" 
	<cfif CurrentRow Mod 2>onmouseout="this.className='rowOdd'"<cfelse>
    onmouseout="this.className='rowEven'"</cfif>">
        <td><cftooltip autoDismissDelay="200000" hideDelay="2500" preventOverlap="false" showDelay="2000" 
                sourcefortooltip="showimg.cfm?ID=#displayID#"> #Recordset1.header# </cftooltip></td>
        <td><a href="index.cfm?action=editheaders&value=#displayID#">
          <cfif #usethis# IS 0>
            Not In Use
            <cfelse>
            In Use
          </cfif>
          </a></td>
        <td><cfif usethis IS 1><cfelse><a href="index.cfm?action=editheaders&delete=#URLEncodedFormat(displayID)#" onClick="return confirm('Are you Sure.');">Delete</a> | </cfif><a href="index.cfm?action=header&edit=#URLEncodedFormat(displayID)#">Edit</a></td>
      </tr>
    </cfoutput>
    <cfelse>
    <tr>
      <td colspan="4" align="center">No Header(s) Found</td>
    </tr>
  </cfif>
  <tr>
    <td colspan="4">Only 1 header can be used at One Time. The one which is in Use cannot be deleted</td>
  </tr>
</table>
<br>
<table border="0" align="center">
  <cfoutput>
    <tr>
      <td><cfif PageNum_Recordset1 GT 1>
          <a href="#CurrentPage#?PageNum_Recordset1=1#QueryString_Recordset1#">First</a>
        </cfif></td>
      <td><cfif PageNum_Recordset1 GT 1>
          <a href="#CurrentPage#?PageNum_Recordset1=#Max(DecrementValue(PageNum_Recordset1),1)##QueryString_Recordset1#">Previous</a>
        </cfif></td>
      <td><cfif PageNum_Recordset1 LT TotalPages_Recordset1>
          <a href="#CurrentPage#?PageNum_Recordset1=#Min(IncrementValue(PageNum_Recordset1),TotalPages_Recordset1)##QueryString_Recordset1#">Next</a>
        </cfif></td>
      <td><cfif PageNum_Recordset1 LT TotalPages_Recordset1>
          <a href="#CurrentPage#?PageNum_Recordset1=#TotalPages_Recordset1##QueryString_Recordset1#">Last</a>
        </cfif></td>
    </tr>
  </cfoutput>
</table>
