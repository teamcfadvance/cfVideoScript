<cfset yt = createObject("component", "#request.cfcPath#.youtube")>
<cfset getDetails = yt.getVideo(trim(url.myid))>
<cfset getComment = yt.getComments("#getDetails.commentsurl#")>
<cfset getEmbeddedCode = yt.getEmbedCode(trim(url.myid))>
<cfinclude template="admin/inc/ActivateURL.cfm">
<cfoutput>
  <table align="left" width="100%">
  	<tr><td colspan="2" align="left"><h3>Details about this Video</h3></td></tr>
    <tr>
      <td colspan="2"><strong>Category:</strong>&nbsp;&nbsp;<a href="videos.cfm?action=categories&catname=#getDetails.categories#&ID=0" title="View Videos under This category">#getDetails.categories#</a></td>
    </tr>
    <tr>
      <td colspan="2"><hr /></td>
    </tr>
    <tr>
      <td colspan="2">
      #getEmbeddedCode#<br />
      <cfif getdetails.duration IS ""><cfelse><strong>Duration:</strong>&nbsp;&nbsp;#getDetails.duration# frames. </cfif>
      </td>
    </tr>
    <tr>
      <td colspan="2"><hr /></td>
    </tr>
    <tr>
      <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="33%"><strong>Published:</strong>&nbsp;&nbsp;#getDetails.published#</td>
          <td width="34%"><strong>Updated:</strong>&nbsp;&nbsp;#getDetails.updated#</td>
          <td width="33%"><strong>Total Views:</strong>&nbsp;&nbsp;#getDetails.viewcount#</td>
        </tr>
      </table></td>
    </tr>
    <tr><td colspan="2">Rating:&nbsp;&nbsp; 
    <cfif getDetails.averagerating GT 0>
            #repeatstring('<img src="images/star.png" width="16" height="16" title="#getDetails.averagerating#" alt="Avg Rating: ' & getDetails.averagerating &'">', int(getDetails.averagerating))#
            <cfif int(#getDetails.averagerating#) LT 5>
              #repeatstring('<img src="images/star-blank.png" width="16" height="16" title="#getDetails.averagerating#" alt="Avg Rating: ' & getDetails.averagerating &'">', 5-int(getDetails.averagerating))#
            </cfif>
            <cfelse>
            #repeatstring('<img src="images/star-blank.png" width="16" height="16" alt="not rated yet" title="not rated yet">', 5)#
          </cfif>
    &nbsp;&nbsp;/&nbsp;&nbsp;#getDetails.numratings#&nbsp;&nbsp;times.</td></tr>
    <tr><td colspan="2"><strong>Author:&nbsp;&nbsp;</strong><a href="videos.cfm?action=author&code=#ListLast(getDetails.authorurl,'/')#">#getDetails.author#</a></td></tr>
    <tr><td colspan="2">Description:&nbsp;&nbsp;<br /><br />
    <cfif getDetails.content IS "">#ParagraphFormat(ActivateURL(getDetails.description))#
    <cfelseif getDetails.description IS "">#ParagraphFormat(ActivateURL(getDetails.content))#<cfelse>No Details</cfif></td></tr>
    <tr>
    	<td colspan="2">
        	<table align="center" width="100%" bgcolor="##D5D5D5">
            <tr><td colspan="2"><h3>Comments related to this Video&nbsp;&nbsp;<em>(#getDetails.numcomments#) comments.</em></h3></td></tr>
            <tr><td colspan="2"><hr /></td></tr>
            <cfif getComment.recordcount>
            <cfdiv>
            <cfloop query="getComment">
            	<cfoutput>
                <tr>
                  <td colspan="2"><h3>#title#</h3></td>
                </tr>
                <tr>
                  <td colspan="2">#ParagraphFormat(ActivateURL(content))#</td>
                </tr>
                <tr><td>Author:&nbsp;&nbsp;</td>
                  <td><a href="videos.cfm?action=author&code=#ListLast(authorurl,'/')#">#author#</a></td>
                </tr>
                <tr>
                  <td width="17%">Published On:&nbsp;&nbsp;</td>
                  <td width="83%">#published#</td>
                </tr>
                </cfoutput>
            </cfloop>
            </cfdiv>
            <cfelse>
            <tr><td colspan="4" align="center">
              <img src="images/smilo.gif" alt="No Comment added to this video" border="0" /><br /><br />
              No Comments added to this video Yet!
              </td></tr>
              </cfif>
            </table>
        </td>
    </tr>    
  </table>
</cfoutput>