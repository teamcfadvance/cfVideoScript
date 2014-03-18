<cfsetting showdebugoutput="false">
<cfcontent type="text/css">
<cfset bodybgcolor = "##FFFFFF">
<cfset themefontcolot = "##000000">
<cfset themetopcell = "##999999">
<cfset themebtmcell = "##036399">
<cfset themebrdcolor = "##cccccc">
<cfset themebrdsize = "0">
<cfset themebrdcolor = "##B1B1B1">
<cfset themeMenucolor = "##4B4B4B">
<cfset themelnkcolor = "##4B4B4B">
<cfset themelnkaction = "none">
<cfset themehvraction = "underline">
<cfset themeboximagecolor = "##a6ba53">
<cfset themeboximagecolorbottom = "##a6ba53">
<cfset boximagecolor = "images/fon02.gif">
<cfset repeatMode = "repeat-x">

body{
 margin:5px;
 padding:0;
 border:0;
 font-family: Arial, Helvetica, Verdana; 
 font-size:12px;
 background-color:<cfoutput>#bodybgcolor#</cfoutput>;
 color:<cfoutput>#themefontcolot#</cfoutput>;
 background-repeat:repeat-x;
 }
 .mine {
 border:1px solid <cfoutput>#themebrdcolor#</cfoutput>;
 height:5px;
 background-color:<cfoutput>#themebrdcolor#</cfoutput>;
 }
 .border {
 border:1px solid <cfoutput>#themebrdcolor#</cfoutput>;
 }
 tr.rowOdd {background-color: #CCCCCC;}
tr.rowEven {background-color: #E7E7E7;}
tr.rowHighlight {background-color: #FFFF99;}
 .hintanchor{ /*CSS for link that shows hint onmouseover*/
 font-weight: bold;
 color: navy;
 margin: 3px 8px;
 }
 .fullback {
 background:url(<cfoutput>#boximagecolor#</cfoutput>);
 height:20px;
 padding:5px;
 }
 .fccolor {
 color:white;
 }
 input submit
 {
 border:1px solid #000;
 }
 ul li {
 list-style-image:url(images/bullet-1.gif);
 padding:2px;
 }
 hr {
 color:<cfoutput>#themebrdcolor#</cfoutput>;
 background-color:<cfoutput>#themebrdcolor#</cfoutput>;
 height:5px;
 }
 .c
 {
 background:url(<cfoutput>#boximagecolor#</cfoutput>);
 }
 .errString
 {
 color:red;
 }
 .modee
 {
 font-weight:bold;
 border-bottom-style:solid; border-bottom-color:#666; border-bottom-width:thin;
 height:30px;
 width:auto;
 padding-left:5px;
 }
 th {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 font-size : 14px;
 font-family : Tahoma,Verdana,Arial;
 }
 a:link 
 {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 text-decoration: <cfoutput>#themelnkaction#</cfoutput>;
 }
 a:hover 
 {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 text-decoration: <cfoutput>#themehvraction#</cfoutput>;
 } 
 a:active {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 text-decoration: <cfoutput>#themehvraction#</cfoutput>;
 }        
 .leftcontent { 
 position: relative;
 width:200px;
 border:1px solid <cfoutput>#themebrdcolor#</cfoutput>;
 }
 .leftcontentDIV { 
 position: relative;
 width:140px;
 padding:2px;
 background:#EAEAEA;
 border:1px solid <cfoutput>#themebrdcolor#</cfoutput>;
 }
 caption
 {
 color: <cfoutput>#themetopcell#</cfoutput>;
 text-transform:uppercase;
 text-align: left;
 font-weight: bold;
 letter-spacing: 0.1em;
 font-family:Tahoma,Verdana,Arial;
 background-color: <cfoutput>#themebtmcell#</cfoutput>;
 padding: 0.375em;
 font-size:12px;
 border-top: solid 1px <cfoutput>#themebrdcolor#</cfoutput>;
 border-bottom: solid 1px <cfoutput>#themebrdcolor#</cfoutput>;
 }
 th {
 background-color: <cfoutput>#themebtmcell#</cfoutput>;
 }
 .string {
 font-family:Tahoma,Verdana,Arial;
 font-size:10px;
 padding-top:5px;
 padding-bottom:5px;
 padding-right:20px;
 }
 .px {
 padding-top : 0px;
 padding-bottom : 0px;
 padding-left : 0px;
 padding-right : 0px;
 margin-top : 2px;
 margin-bottom : 0px;
 margin-left : 0px;
 margin-right : 0px;
 }
 .px5 {
 padding-top : 0px;
 padding-bottom : 0px;
 padding-left : 0px;
 padding-right : 0px;
 margin-top : 5px;
 margin-bottom : 0px;
 margin-left : 0px;
 margin-right : 0px;
 }
 .title01 {
 color : #F92700;
 margin-top : 5px;
 padding-bottom : 0px;
 margin-bottom : 0px;
 margin-left : 2px;
 margin-right : 10px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 }
 .list {
 color : #FFFFFF;
 margin-top : 3px;
 padding-bottom : 3px;
 margin-bottom : 0px;
 margin-left : 10px;
 margin-right : 10px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 font-weight: bold;
 }
 .right {
 color : #FFFFFF;
 margin-top : 5px;
 padding-bottom : 10px;
 margin-bottom : 0px;
 margin-left : 10px;
 margin-right : 10px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 font-weight: bold;
 }
 .right a, .list a {
 color : #FFFFFF;
 }
 .right a:hover {
 color : #AAAAAA;
 }
 .left {
 color : #000000;
 margin-top : 10px;
 padding-bottom : 5px;
 margin-bottom : 0px;
 margin-left : 25px;
 margin-right : 10px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 font-weight: bold;
 }
 .left b {
 color : #FFFFFF;
 }
 p {
 color : #000000;
 margin-top : 5px;
 padding-bottom : 10px;
 margin-bottom : 0px;
 margin-left : 10px;
 margin-right : 10px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 }
 .menu01 {
 color : <cfoutput>#themeMenucolor#</cfoutput>;
 margin-top : 7px;
 padding-bottom : 5px;
 margin-bottom : 0px;
 margin-left : 5px;
 margin-right : 5px;
 font-size : 16px;
 font-family : Arial, Helvetica, Verdana;
 font-weight: bold;
 }
 .menu01 a {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 text-decoration: <cfoutput>#themelnkaction#</cfoutput>;
 }
 .menu01 a:hover {
 color : #EEEEEE;
 text-decoration:<cfoutput>#themehvraction#</cfoutput>;
 }
 .menu02 {
 color : <cfoutput>#themeMenucolor#</cfoutput>;
 margin-top : 0px;
 padding-bottom : 0px;
 margin-bottom : 0px;
 margin-left : 45px;
 margin-right : 0px;
 font-size : 12px;
 font-family : Tahoma,Verdana,Arial;
 font-weight: bold;
 }
 .menu02 a {
 color : <cfoutput>#themelnkcolor#</cfoutput>;
 text-decoration: <cfoutput>#themelnkaction#</cfoutput>;
 }
 .menu02 a:hover {
 text-decoration:<cfoutput>#themehvraction#</cfoutput>;
 }
 .textfield_effect    {
 /*we will first set the border styles.*/
 border-width: 1px;
 border-style: solid;
 border-color: <cfoutput>#themetopcell#</cfoutput>;
 /*we are now going to add in the shadow image that we created earlier*/
 background-repeat: repeat-x;
 background-image: url(admin/images/bgcolor.jpg);
 /*I am going to add some text formatting of my own*/
 font-family: Arial, Verdana, tahoma;
 font-size: 12px;
 color: <cfoutput>#themebrdcolor#</cfoutput>;
 width: 130px;
 height: 20px;
 font-weight: bold;
 }
 .textfield_input  {
 /*we will first set the border styles.*/
 border-width: 1px;
 border-style: solid;
 border-color: <cfoutput>#themetopcell#</cfoutput>;
 /*we are now going to add in the shadow image that we created earlier*/
 background-repeat: repeat-x;
 background-image: url(admin/images/bgcolor.jpg);
 /*I am going to add some text formatting of my own*/
 font-family: Arial, Verdana, tahoma;
 font-size: 12px;
 color: <cfoutput>#themebrdcolor#</cfoutput>;
 width: 380px;
 font-weight: bold;
 }
 .textfield_area 
 {
 border-width: 1px;
 border-style: solid;
 border-color: <cfoutput>#themetopcell#</cfoutput>;
 background-repeat: repeat-x;
 background-image:url(../images/bgcolor.jpg);
 font-family: Verdana;
 font-size: 12px;
 color: <cfoutput>#themebrdcolor#</cfoutput>;
 width: 150px;
 height:60px;
 font-weight: bold;
 }
 .textfield_area:hover    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 
 .textfield_area:focus    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 /*we are now going to style how the textfield will look when we
 hover over it and when we actually have it selected*/
 
 .textfield_effect:hover    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 
 .textfield_effect:focus    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 .textfield_input:hover    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 
 .textfield_input:focus    {
 border-color: <cfoutput>#themebrdcolor#</cfoutput>;
 border-width: 1px;
 }
 /*you may also like to add some styles for the rest of the form*/
 
 fieldset    {
 width: 95%;
 border-style: solid;
 border-width: 1px;
 border-color: <cfoutput>#themebtmcell#</cfoutput>;
 margin-left: auto;
 margin-right: auto;
 background-color: #ffffff;
 } 
 
 fieldset:hover    {
 border-color: #a6ba53;
 }
 legend    {
 font-family: sans-serif;
 font-size: 18px;
 color: #097bc3;
 font-weight: bold;
 }
.smallestTag { font-size: xx-small; color:<cfoutput>#themebtmcell#</cfoutput>; }
.smallTag { font-size: small; color:<cfoutput>#themetopcell#</cfoutput>;}
.mediumTag { font-size: medium; color:<cfoutput>#themelnkcolor#</cfoutput>;}
.largeTag { font-size: large; color:<cfoutput>#themeMenuColor#</cfoutput>;}
.largestTag { font-size: xx-large; color:<cfoutput>#themefontcolot#</cfoutput>;} 

#menu ul {margin:0; width: 100%; padding: 5px 0; background-color: <cfoutput>#bodybgcolor#</cfoutput>;}
#menu ul li {display:inline; list-style-type: none;}
#menu ul li a:link, #menu ul li a:visited { background-color: <cfoutput>#themebtmcell#</cfoutput>; color:<cfoutput>#themelnkcolor#</cfoutput>; text-decoration:none; padding: 5px;}
#menu ul li a:hover {color: <cfoutput>themefontcolot</cfoutput>; border-top: .25em solid black; border-bottom: .25em solid black; background-color: <cfoutput>#themeMenuColor#</cfoutput>;}
.pagination
{
	font-size:11px;
	line-height:20px;
	clear:both;
	display:block;
	text-align: center;
	margin:0 auto;
	padding:4px 6px 4px 0;
	background-color:#fff;
	color:#313031;
	padding-right:17px;
	padding-top:20px;
	
}
.pagination a {
	color:#424242;
	text-decoration:none;
	padding:5px 6px 4px 5px;
	margin:0 3px 0 3px;
	border:1px solid #A1C5E5;
}

.pagination a:hover, .pagination a:active {
	color:#424242;
	border:1px solid #A1C5E5;
	background-color:#E8F1FA;
}
.pagination span.selected {
	padding:5px 6px 4px 5px;
	margin:0 3px 0 3px;
	border:1px solid #A1C5E5;
	font-weight:bold;
	color:#424242;
	background-color:#E8F1FA;
    display:block;
}
.pagination span.disabled {
	padding:5px 6px 4px 5px;
	margin:0 3px 0 3px;
	border:1px solid #cccccc;
	color:#cccccc;
    display:block;
}