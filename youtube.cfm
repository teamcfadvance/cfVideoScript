<cfsetting showdebugoutput="false">
<link rel="stylesheet" type="text/css" href="ajaxtabs/ajaxtabs.css" />
<script type="text/javascript" src="ajaxtabs/ajaxtabs.js"></script>
<ul id="countrytabs" class="shadetabs">
<li><a href="ytcategories.cfm" rel="countrydivcontainer" class="selected">Categories</a></li>
<li><a href="ytplaylist.cfm" rel="countrycontainer">Playlists</a></li>
</ul>

<div id="countrydivcontainer" style="width:auto; margin: 1em;">
</div>
<script type="text/javascript">
var countries=new ddajaxtabs("countrytabs", "countrydivcontainer")
countries.setpersist(true)
countries.setselectedClassTarget("link") //"link" or "linkparent"
countries.init()
</script>