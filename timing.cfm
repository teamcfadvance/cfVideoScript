<cfoutput>
<cfset theDate = now()>
<cfset yrs = datediff("yyyy",published,theDate)>
<cfset mons = datediff("m",published,theDate) mod 12>

<cfif val(yrs)>
  <cfif yrs eq 1>
    One year
    <cfelse>
    #yrs# years
  </cfif>
  <cfif mons eq 1>
    one month ago
    <cfelseif val(mons)>
    #mons# months
  </cfif>
  <cfelseif val(mons)>
  <cfif mons eq 1>
    One month ago
    <cfelse>
    #mons# months
  </cfif>
  <cfelse>
  <cfset days = datediff("d",published,theDate) mod 31>
  <cfif days eq 0>
    <cfset hrs  = datediff("h",published,theDate) mod 24>
    <cfif val(hrs) eq 1>
      One hour ago
      <cfelseif val(hrs)>
      #hrs# hours ago
      <cfelse>
      <cfset mins = datediff("h",published,theDate) mod 60>
      #mins# minutes ago
    </cfif>
    <cfelseif days eq 1>
    Yesterday
    <cfelse>
    #days# days ago
  </cfif>
</cfif>
</cfoutput>