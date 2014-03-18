<cfform name="form1" method="get" action="advresults.cfm">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
  <tr>
    <td width="11%">Keyword:</td>
    <td width="89%"><cfinput name="searchstring" type="text" id="searchstring" tabindex="1" size="70" maxlength="255" class="textfield_input" required="yes" message="Error! Please Provide keyword to search"></td>
  </tr>
  <tr>
    <td>Language:</td>
    <td><select name="select_lang" id="select_lang" tabindex="2" class="textfield_effect">
        <option value="0">Any Language</option>
        <option value="ar">Arabic</option>
        <option value="bg">Bulgarian</option>
        <option value="ca">Catalan</option>
        <option value="zh-cn">Chinese (Simplified)</option>
        <option value="zh-tw">Chinese (Traditional)</option>
        <option value="hr">Croatian</option>
        <option value="cs">Czech</option>
        <option value="da">Danish</option>
        <option value="nl">Dutch</option>
        <option value="en">English</option>
        <option value="et">Estonian</option>
        <option value="fi">Finnish</option>
        <option value="fr">French</option>
        <option value="de">German</option>
        <option value="er">Greek</option>
        <option value="iw">Hebrew</option>
        <option value="hu">Hungarian</option>
        <option value="is">Icelandic</option>
        <option value="it">Italian</option>
        <option value="ja">Japanese</option>
        <option value="ko">Korean</option>
        <option value="lv">Latvian</option>
        <option value="lt">Lithuanian</option>
        <option value="no">Norwegian</option>
        <option value="pl">Polish</option>
        <option value="pt">Portuguese</option>
        <option value="ro">Romanian</option>
        <option value="ru">Russian</option>
        <option value="sr">Serbian</option>
        <option value="sk">Slovak</option>
        <option value="sl">Slovenian</option>
        <option value="es">Spanish</option>
        <option value="sv">Swedish</option>
        <option value="tr">Turkish</option>
      </select></td>
  </tr>
  <tr>
    <td>Racy:</td>
    <td><input type="radio" name="racedcondition" id="radio" value="True" tabindex="3">
      True
      <input name="racedcondition" type="radio" id="radio" tabindex="4" value="False" checked>
      False</td>
  </tr>
  <tr>
    <td>Time:</td>
    <td><select name="timeconstraint" id="timeconstraint" tabindex="5" class="textfield_effect">
        <option value="all_time" selected>All Time</option>
        <option value="today">Today</option>
        <option value="this_week">This Week</option>
        <option value="this_month">This Month</option>
      </select></td>
  </tr>
  <tr>
    <td>Author:</td>
    <td><input type="text" name="author" id="author" tabindex="6" class="textfield_input"></td>
  </tr>
  <tr>
    <td>Order By:</td>
    <td><select name="orderby" id="orderby" tabindex="7" class="textfield_effect">
    	<option value="relevance">By Relevance</option>
        <option value="published">Published</option>
        <option value="viewcount">View Count</option>
        <option value="rating">Rating</option>
    </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="sbtSearch" id="sbtSearch" value="Search Videos" class="border" tabindex="8"></td>
  </tr>
</table>
</cfform>
