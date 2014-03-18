<cfparam name="invalid" default="0">
<!--- Check for login here --->   
<cflogin idletimeout="1800">
<cfif Not IsDefined('cflogin')>
  <cfinclude template="login1.cfm">
  <cfabort>
  <cfelse>
  <cfif cflogin.name IS "" OR cflogin.password IS "">
    <cfset invalid  = 1>
    <cfinclude template="login1.cfm">
    <cfabort>
    <cfelse>
    <cfinvoke component="#request.cfcPath#.video" method="checklogin" returnvariable="getChkrecords">
    <cfinvokeargument name="nusername" value="#trim(cflogin.name)#">
    <cfinvokeargument name="npassword" value="#trim(cflogin.password)#">
    </cfinvoke>
    <cfif getChkrecords.role NEQ "">
      <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" roles="#getChkrecords.role#">
      <cfif IsDefined("RememberMe")>
         <!--- members wants their information remembered, so set the cookies --->
          <cfcookie name="username" value="#cflogin.name#" expires="NEVER">
      <cfelse>
          <!--- member does NOT want their information remember, EXPIRE their cookies NOW so they are deleted for good! --->
          <cfcookie name="username" value="#cflogin.name#" expires="NOW">
      </cfif>
      <cfelse>
      <cfset invalid = 2>
      <cfinclude template="login1.cfm">
      <cfabort>
    </cfif>
  </cfif>
</cfif>
</cflogin>
