<style>
.yui-tt {
	color: #000000;
	font-size:110%;
	border: 2px solid #8fbc8f;
	background-color: #8fbc8f;
	padding: 10px;
	width:300px;
	height:200px;
}
</style>
<cfinvoke component="#request.cfcPath#.video" method="getHeaders" displayID="#ID#" returnvariable="details"/>
<cfoutput>
  <table align="left" width="100%">
    <tr>
      <td><cfif details.headerImage IS "">
          <img src="img/nomovieimage.jpg" border="0" alt="Category Image not Avaliable"/>
          <cfelse>
          <img src="headers/#details.headerImage#" border="0" alt="The Category Image"/>
        </cfif></td>
    </tr>
  </table>
</cfoutput>