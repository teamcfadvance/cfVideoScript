<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfinclude template="meta.cfm">
<link href="style.cfm" rel="stylesheet" type="text/css" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfif IsDefined('url.searchvideos')>
<cfinvoke component="#request.cfcpath#.video" method="getSearchTerms" searchKeyWord="#url.searchvideos#" returnvariable="searchedvalue"/>
<cfif searchedvalue.recordcount>
<cfinvoke component="#request.cfcpath#.video" method="UpdateSearchTerms" searchKeyWord="#url.searchvideos#"/>
<cfelse>
<cfinvoke component="#request.cfcpath#.video" method="insertSearchTerms" searchKeyWord="#url.searchvideos#"/>
</cfif>
</cfif>
<table width="1000" border="0" align="center" cellpadding="1" cellspacing="2" class="border">
  <tr>
    <td><cfinclude template="header.cfm"></td>
  </tr>
  <tr>
    <td><hr width="100%"/></td>
  </tr>
  <tr>
    <td><div id="menu">
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
      </div></td>
  </tr>
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
            <cfif isDefined('url.ID') AND url.ID NEQ "" AND IsNumeric(url.ID) AND url.ID Neq 0>
            <br />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
              <tr>
                <td class="fullback"><strong class="fccolor">Sub Categories</strong></td>
              </tr>
              <tr>
                <td><cfinclude template="subcats.cfm"></td>
              </tr>
            </table>      
            </cfif>
            <br />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
              <tr>
                <td class="fullback"><strong class="fccolor">Main Tags</strong></td>
              </tr>
              <tr>
                <td><cfinclude template="tags.cfm"></td>
              </tr>
            </table></td>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><cfset variables.newrow = False>
                  <cfset yt = createObject("component", "#request.cfcpath#.youtube")>
                  <cfset tick = GetTickCount()>
                  <cfset searched = #yt.getVideosBySearch("#url.searchvideos#","relevance",1,50)#>
                  <cfset tock = GetTickCount()>
                  <cfset thelinkID = #ListLast(searched.ID,':')#>
                  <table align="center" width="100%">
                    <tr>
                      <td colspan="4">
					  <cfset _searchtime = (tock - tick)/1000>
                        <cfoutput>Search Took <b class="errString">#_searchtime#</b> (locally) seconds.</cfoutput></td>
                    </tr>
                    <cfif variables.newrow EQ true>
                      <tr>
                      
                    </cfif>
                    <cfif searched.recordcount>
                    <cfinclude template="paging.cfm">
                    <br />
                    <div align="center">
                    <cfoutput>
                    Displaying <b>#pagination.getStartRow()#</b> to <b>#pagination.getMaxRows()#</b> of <b>#searched.total#</b> Records.
                    </cfoutput>
                    </div>
                    <cfoutput>#pagination.getRenderedHTML()#</cfoutput>
                    <cfoutput query="searched" startrow="#pagination.getStartRow()#" maxrows="#pagination.getMaxRows()#">
                        <td height="30" valign="middle">
                        <div class="leftcontentDIV" align="center"> <strong><a href="videos.cfm?action=show&video=#thelinkID#"> <img src=
                        "#thumbnail_url#" width="#thumbnail_width#" height="#thumbnail_height#" title="#title#" border="0"/></a><br>
                        <cfinclude template="timing.cfm">
                        <br>
                        <div align="center">#Left(title,10)#...<br>
                          <cfif averagerating GT 0>
                            #repeatstring('<img src="images/star.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', int(averagerating))#
                            <cfif int(#averagerating#) LT 5>
                              #repeatstring('<img src="images/star-blank.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', 5-int(averagerating))#
                            </cfif>
                            <cfelse>
                            #repeatstring('<img src="images/star-blank.png" width="16" height="16" alt="not rated yet" title="not rated yet">', 5)#
                          </cfif>
                          <br>
                          <cfif #viewcount# IS "">0<cfelse>#viewcount#</cfif> views<br>
                          <a href="videos.cfm?action=author&code=#author#" title="All Videos by #author#">#author#</a></div>
                        </strong> </div>
                        </td>
                        <cfif searched.currentRow MOD 4 EQ 0>
                          </tr>
                          
                          <cfset variables.newrow = true>
                          <cfelse>
                          <cfset variables.newrow = false>
                        </cfif>
                      </cfoutput>
                      <cfelse>
                      <tr>
                        <td colspan="4" align="center"><img src="images/smilo.gif" alt="No Searched videos Found" border="0" /><br />
                          <br />
                          Search results is Empty, try again!
                          </td>
                      </tr>
                    </cfif>
                    <tr>
                  </table></td>
              </tr>
            </table></td>
          <td width="20%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="border">
              <cfif isDefined('url.action') and url.action eq 'show'>
                <tr>
                  <td><table align="left" width="100%">
                      <tr>
                        <td class="fullback"><strong class="fccolor">Video Options</strong></td>
                      </tr>
                      <tr>
                        <td>Share Video</td>
                      </tr>
                      <tr>
                        <td><!-- AddThis Button BEGIN -->
                          <a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pub=xa-4abf7fdb33a2264d"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
                          <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4abf7fdb33a2264d"></script>
                          <!-- AddThis Button END --></td>
                      </tr>
                      <tr>
                        <td>Embed Code</td>
                      </tr>
                      <tr>
                        <td><cfoutput>
                            <textarea name="embedcode" rows="5">#trim(getEmbeddedCode)#</textarea>
                          </cfoutput></td>
                      </tr>
                      <tr>
                        <td>Search Keywords</td>
                      </tr>
                      <tr>
                        <td><cfset listval = "#ListChangeDelims(getDetails.keywords,',')#">
                          <cfoutput>
                            <cfloop list ="#listval#" index="i" delimiters=",">
                               <a href="results.cfm?searchvideos=#i#">#i#</a>
                            </cfloop>
                          </cfoutput></td>
                      </tr>
                    </table></td>
                </tr>
              </cfif>
              <tr>
                <td><cfinclude template="clouds.cfm"></td>
              </tr>
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
</table>
</body>
</html>