<cfif listlast(cgi.script_name, "/") eq "tags.cfm">
  <cflocation url="index.cfm?action=tags" addtoken="no">
</cfif>
<cfparam name="sort" default="1">
<cfif isDefined('url.searchtagname')>
<cfinvoke component="#request.cfcPath#.video" method="getTags" searchtagname="#url.searchtagname#" set="1" 
returnvariable="Recordset1"/>
<cfelseif isDefined('url.l')>
  <cfinvoke component="#request.cfcPath#.video" method="getTags" l="#url.l#" returnvariable="Recordset1"/>
<cfelse>
<cfinvoke component="#request.cfcPath#.video" method="getTags" sortorder="#sort#" returnvariable="Recordset1"/>
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
	<cfinvoke component="#request.cfcpath#.video" method="deleteTags" ID="#trim(url.delete)#"/>
    <cfset n = "Cool! Category deleted Successfully.">
</cfif>
<cfif isDefined('url.mode')>
  <cfinvoke component="#request.cfcpath#.video" method="updateTagsActiveness" mode="#url.mode#" ID="#trim(url.value)#"/>
  <cfset n = "Cool! Tags Status updated Successfully">
</cfif>

<table align="center" width="100%">
  <tr align="center" class="oncaption">
    <td><a href="index.cfm?action=newtag">Add New Tag</a></td>
  </tr>
  <tr align="left">
    <td><a href="<cfoutput>#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</cfoutput>">Records Not seen as Updated, Refresh Page</a></td>
  </tr>
  <cfform method="get" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#">
  <tr align="left">
    <td align="center"><label>Find Tags:</label>
    <input type="text" name="searchtagname" id="searchtagname" />&nbsp;
    <input type="submit" name="action" value="Tags" /></td>
  </tr>
  </cfform>
</table>
<br />
<div align="center">
<cfoutput>Records #StartRow_Recordset1# to #EndRow_Recordset1# of #Recordset1.RecordCount# </cfoutput>
</div>
<div align="left">
<cfoutput><a href="index.cfm?action=tags&sort=1">Sort by A-Z</a> | 
<a href="index.cfm?action=tags&sort=2">Sort by Z-A</a></cfoutput>
</div>
<div align="center"> <cfoutput>
    <cfset alpha = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
    <Cfloop from="1" to="#ListLen(alpha)#" index="L">
      <cfif L neq "1">
        |
      </cfif>
      <a href="index.cfm?action=tags&l=#listgetat(alpha, L)#">#listgetat(alpha, L)#</span></a>
    </CFLOOP>
    | <a href="index.cfm?action=tags"><strong>All</strong></a> </cfoutput> </div>

<table width="100%" border="0" align="center">
<cfif isdefined('n')>
	<tr><td colspan="4" align="center" class="MainBar"><cfoutput>#trim(n)#</cfoutput></td></tr>
</cfif>
  <tr align="left" class="tablerow">
    <th width="72%">Name</th>
    <th width="28%">Action</th>
  </tr>
  <cfif Recordset1.recordcount>
  <cfoutput query="Recordset1" startRow="#StartRow_Recordset1#" maxRows="#MaxRows_Recordset1#">
    <tr class="#IIf(CurrentRow Mod 2, DE('rowOdd'), DE('rowEven'))#" 
    onmouseover="this.className='rowHighlight'" 
	<cfif CurrentRow Mod 2>onmouseout="this.className='rowOdd'"<cfelse>
    onmouseout="this.className='rowEven'"</cfif>">
      <td>#Recordset1.tagname#
      <cfif parentID IS NOT 0><span style="color:red">*</span></cfif>
      </td>
      <td><a href="index.cfm?action=tags&delete=#URLEncodedFormat(ID)#" onClick="return confirm('Are you Sure');">Delete |  
      <a href="index.cfm?action=newtag&edit=#URLEncodedFormat(ID)#">Edit</a> | <a href="index.cfm?action=tags&mode=#status#&value=#URLEncodedFormat(ID)#"><cfif status IS 0>Inactive<cfelse>Active</cfif></a></td>
    </tr>
  </cfoutput>
   <cfelse>
  <tr><td colspan="4" align="center">No Defined tags Found</td></tr>
  </cfif>
  <tr><td colspan="4" align="left">(* Indicates that these are Subcategories)</td></tr>
</table>
<br>
<table border="0" align="center">
  <cfoutput>
    <tr>
      <td><cfif PageNum_Recordset1 GT 1>
        <a href="#CurrentPage#?PageNum_Recordset1=1#QueryString_Recordset1#">First</a>
      </cfif>
      </td>
      <td><cfif PageNum_Recordset1 GT 1>
        <a href="#CurrentPage#?PageNum_Recordset1=#Max(DecrementValue(PageNum_Recordset1),1)##QueryString_Recordset1#">Previous</a>
      </cfif>
      </td>
      <td><cfif PageNum_Recordset1 LT TotalPages_Recordset1>
        <a href="#CurrentPage#?PageNum_Recordset1=#Min(IncrementValue(PageNum_Recordset1),TotalPages_Recordset1)##QueryString_Recordset1#">Next</a>
      </cfif>
      </td>
      <td><cfif PageNum_Recordset1 LT TotalPages_Recordset1>
        <a href="#CurrentPage#?PageNum_Recordset1=#TotalPages_Recordset1##QueryString_Recordset1#">Last</a>
      </cfif>
      </td>
    </tr>
  </cfoutput>
</table>

