<cfsetting showdebugoutput="false">
<cfform>
<table width="100%" border="0" cellspacing="2" cellpadding="1">
    <tr>
      <td>Enter Username</td>
    </tr>
    <tr>
      <td><input type="text" name="playlistuser" id="playlistuser" class="textfield_input" style="width:100px;" title="Enter the name of the User to load his/her Playlist" /></td>
    </tr>
    <tr>
      <td><cfoutput>
      <a onclick="ColdFusion.navigate('divsource.cfm?view='+document.getElementById('playlistuser'), 'theDiv')">Fetch</a>
      </cfoutput>
      </td>
    </tr>
  </table>
</cfform>  
<cfdiv bind="url:'divsource.cfm?view='+document.getElementById('playlistuser').value" ID="theDiv"/>
