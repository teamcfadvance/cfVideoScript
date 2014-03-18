<cfscript>
function stripHTML(str) {
str = reReplaceNoCase(str, "<.*?>","","all");
//get partial html in front
str = reReplaceNoCase(str, "^.*?>","");
//get partial html at end
str = reReplaceNoCase(str, "<.*$","");
return str;
}
</cfscript>