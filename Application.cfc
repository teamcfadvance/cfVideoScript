<cfcomponent name="Application" displayname="Application Component for the Video">
<cfsetting requesttimeout="3000000">
<cfset this.name = "VideoManagement">
<cfset this.applicationTimeout = CreateTimeSpan(0,0,60,0)>
<cfset this.sessionManagement = "true">
<cfset this.sessionTimeout = CreateTimeSpan(0,0,30,0)>
<cfset this.clientManagement = "true">
<cffunction name="onApplicationStart" returntype="boolean" output="true">
  <cfset Application.configured = 1>
  <cfset Application.datetimeConfigured = TimeFormat(Now(), "hh:mm tt") & "  " & DateFormat(Now(), "mm.dd.yyyy")>
  <cfset Application.currentSessions = 0>
  <!--- Application Addresses --->
  <cfset setLocale("English (US)")>
  <!--- Set the session page encoding --->
  <cfset setencoding("URL", "utf-8")>
  <cfset setencoding("Form", "utf-8")>
  <cfcontent type="text/html; charset=utf-8">
  <cfreturn true>
</cffunction>
<cffunction name="onSessionStart" returntype="void">
</cffunction>
<cffunction name="onSessionEnd" returntype="void">
  <cfargument name="SessionScope" required="true">
  <cfargument name="ApplicationScope" required="true">
  <cflock name="lck_currentSessions" throwontimeout="Yes" timeout="7" type="EXCLUSIVE">
    <cfset sessionPosition = ListFind(ArrayToList(arguments.ApplicationScope.sessionData), arguments.SessionScope.sessionid)>
    <cfif sessionPosition neq 0>
      <cfset ArrayDeleteAt(arguments.ApplicationScope.sessionData, sessionPosition)>
      <cfset arguments.ApplicationScope.currentSessions = arguments.ApplicationScope.currentSessions - 1>
    </cfif>
  </cflock>
</cffunction>
<cffunction name="onRequestStart" returntype="boolean">
  <!--- Set up request variables here. --->
  <cfset request.dsn = "cfm_videos">
  <cfset request.user = "root">
  <cfset request.pass = "">
  <cfif (Not IsDefined("request.siteURL")) OR IsDefined("URL.flush")>
    <cflock scope="request" timeout="#CreateTimeSpan(0,0,20,0)#">
      <cfset request.SiteURL = replace(GetDirectoryFromPath("http://"&cgi.server_name&cgi.path_info),"\","")>
      <cfset request.file_path = GetDirectoryFromPath(GetCurrentTemplatePath())>
    </cflock>
  </cfif>
  <cfset request.basePath = "http://localhost/videoscript/">
  <cfset request.absoluteDIR='c:\inetpub\wwwroot\videoscript\'>
  <cfset request.absoluteURL='/videoscript/'>
  <cfset request.cfcPath = "admin.com">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="getemailsettings">
	SELECT * from mailsettings
  </cfquery>
  <cfif getemailsettings.recordcount>
  <cfoutput query="getemailsettings">
    <cfif getemailsettings.usethis EQ 1>
      <cfif getemailsettings.alais IS "">
        <cfset request.w = "#lcase(getemailsettings.msendusername)#">
        <cfelse>
        <cfset request.w = "#getemailsettings.alais# <#lcase(getemailsettings.msendusername)#>">
      </cfif>
      <cfset request.Mailpass = "#getemailsettings.password#">
      <cfset request.MailUser = "#lcase(getemailsettings.username)#">
      <cfset request.MServer = "#getemailsettings.MailServer#">
      <cfset request.MPort = "#getemailsettings.port#">
      <cfset request.Mfailto = "#getemailsettings.err#">
    </cfif>
  </cfoutput>
  </cfif>
  <cfset request.startTimer = getTickCount()>
  <cfset request.emailOwner = "urname@urdomain.com">
  <cftry>
    <CFSET SQL_Words="[ ;](insert +into.+values|drop +table|create +table)">
    <CFLOOP COLLECTION="#url#" ITEM="var">
      <CFIF IsSimpleValue(Evaluate(var)) AND REFindNoCase(SQL_Words, Evaluate(var)) NEQ 0>
        <CFTHROW TYPE="SQLAttack" MESSAGE="Invalid URL value passed.">
      </CFIF>
    </CFLOOP>
    <CFLOOP COLLECTION="#form#" ITEM="var">
      <CFIF IsSimpleValue(Evaluate(var)) AND REFindNoCase(SQL_Words, Evaluate(var)) NEQ 0>
        <CFTHROW TYPE="SQLAttack" MESSAGE="Invalid Form value passed.">
      </CFIF>
    </CFLOOP>
    <cfcatch type="any">
      <div align="center">
        <h3><cfoutput>#cfcatch.Detail#</cfoutput></h3>
      </div>
      <cfabort>
    </cfcatch>
  </cftry>
  <cfreturn true>
</cffunction>
<cffunction name="onRequestEnd" returntype="void">
  <!--- Write any code that needs to run when the page request ends. This replaces onRequestEnd.cfm --->
</cffunction>
<cffunction  name="onError" output="true">
  <cfargument name="exception" required=true/>
  <cfargument name="eventName" type="String" required=true/>
  <cfif (trim(arguments.eventName) IS NOT "onSessionEnd") AND (trim(arguments.eventName) IS NOT "onApplicationEnd")>
    <cflog file="#this.name#" type="error"
                text="Event name: #arguments.eventName#" >
    <cflog file="#this.name#" type="error"
                text="Message: #arguments.exception.message#">
    <cfoutput>
      <h2>An unexpected error occurred.</h2>
      <p>Please provide the following information to technical support:</p>
      <p>Error Event:#arguments.eventName#</p>
      <p>Error details:</p>
    </cfoutput>
    <cfdump var=#arguments.exception#>
    <cfelseif (arguments.eventName IS "onApplicationEnd")>
    <cflog file="#this.name#" type="Information"
            text="Application #this.name# Ended" >
  </cfif>
</cffunction>
</cfcomponent>
