<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfinclude template="meta.cfm">
<cfinclude template="inc.cfm">
<link href="style.cfm" rel="stylesheet" type="text/css" />
<cfajaximport tags="cfdiv">
</head>
<body>
<table width="1024" border="0" align="center" cellpadding="1" cellspacing="2" class="border">
  <tr>
    <td><cfinclude template="header.cfm"></td>
  </tr>
  <tr>
  	<td><hr width="100%"/></td>
  </tr> 
  <tr><td>
  <div id="menu">
<ul>
<li><a href="index.cfm" id="current">Home</a></li>
<li><a href="videos.cfm?action=toprecentfeatured">Most Recently Featured</a></li>
<li><a href="videos.cfm?action=topviewed">TopMost Viewed</a></li>
<li><a href="videos.cfm?action=topdiscussed">Most Dicussed</a></li>
<li><a href="videos.cfm?action=toplinked">Most Linked</a></li>
<li><a href="videos.cfm?action=toprecent">Most Recent</a></li>
<li><a href="videos.cfm?action=toprespond">Most Responded</a></li>
<li><a href="videos.cfm?action=topfavs">Top Favorites</a></li>
<li><a href="videos.cfm?action=toprated">Top Rated</a></li>
<li><a href="videos.cfm?action=mobiles">All Time Mobile Videos</a></li>
</ul>
</div>
  </td></tr> 
<tr><td><cfinclude template="subtags.cfm"></td></tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="1" cellpadding="1">
      <tr>
        <td width="20%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
          <tr>
            <td class="fullback"><strong class="fccolor">Categories</strong></td>
          </tr>
          <tr>
            <td><cfinclude template="categories.cfm"></td>
          </tr>
        </table>
        <br />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
          <tr>
            <td class="fullback"><strong class="fccolor">Sub Categories</strong></td>
          </tr>
          <tr>
          	<td><cfinclude template="subcats.cfm"></td>
          </tr>
        </table>      
        <br />  
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
          <tr>
            <td class="fullback"><strong class="fccolor">Main Tags</strong></td>
          </tr>
          <tr>
            <td><cfinclude template="tags.cfm"></td>
          </tr>
        </table>
        <br />
         <table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
          <tr>
            <td class="fullback"><strong class="fccolor">Ad</strong></td>
          </tr>
          <tr>
            <td><!---<cfinclude template="leftad.cfm">---></td>
          </tr>
        </table>
        </td>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td class="fullback"><strong class="fccolor">Video Listings</strong></td>
          </tr>  
          <tr>
            <td><cfinclude template="manage.cfm"></td>
          </tr>
        </table></td>
        <td width="20%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <cfif isDefined('url.action') and url.action eq 'show'>
          <tr>
            <td>
            <table align="left" width="100%" class="border" cellpadding="0" cellspacing="0">
            	<tr><td class="fullback"><strong class="fccolor">Video Options</strong></td></tr>
                <tr>
                	<td><strong>Share Video</strong></td>
                </tr> 
                <tr><td><!-- AddThis Button BEGIN -->
<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pub=xa-4abf7fdb33a2264d"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4abf7fdb33a2264d"></script>
<!-- AddThis Button END --></td></tr>   
                <tr>
                	<td><strong>Embed Code</strong></td>
                </tr>
                <tr><td><cfoutput><textarea name="embedcode" rows="5">#trim(getEmbeddedCode)#</textarea></cfoutput></td></tr>  
                <tr>
                	<td><strong>Search Keywords</strong></td>
                </tr>
                <tr><td><cfset listval = "#ListChangeDelims(getDetails.keywords,',')#">
            <cfoutput>
              <cfloop list ="#listval#" index="i" delimiters=",">
                <a href="results.cfm?searchvideos=#i#&action=go" title="#i#">#i#</a>
              </cfloop>
            </cfoutput></td></tr>      
            </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          </cfif>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" class="border">
        <tr><td class="fullback"><strong class="fccolor">Keywords Searched&nbsp;&nbsp;</strong></td></tr>
        <tr><td>
          <cfinclude template="clouds.cfm">
          </td></tr>
        </table>
        <br />
        <table align="center" border="0" width="100%" cellpadding="0" cellspacing="0" class="border">
        <tr><td class="fullback"><strong class="fccolor">Youtube Features</strong></td></tr>
        <tr><td>
          <cfinclude template="youtube.cfm">
          </td></tr>
        </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><cfinclude template="footer.cfm"></td>
  </tr>
</table>

</body>
</html>