<cfcomponent displayname="This will handle all Processing related to the videos">
<cffunction name="checklogin" access="public" returntype="query">
  <cfargument name="nusername" type="string" required="yes">
  <cfargument name="npassword" type="string" required="yes">
  <cfset var myResult="">
  <cfquery name="myResult" datasource="#request.dsn#" username="#request.user#" password="#request.pass#">
		SELECT *
		FROM users
		WHERE nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.nUsername)#"> 
        AND 
        npwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.nPassword)#">
        AND 
        valid = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
		</cfquery>
  <cfreturn myResult>
</cffunction>

<cffunction access="public"  name="getSearchTerms" returntype="query">
    	<cfargument name="searchKeyWord" default="" required="yes" type="string">
        <cfset var searchdata = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="searchdata">
        select * from 
        search_terms where 
        term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.searchKeyWord)#">
        </cfquery>
        <cfreturn searchdata>
   </cffunction>
   
    <cffunction access="public"  name="UpdateSearchTerms" returntype="void">
    	<cfargument name="searchKeyWord" default="" required="yes" type="string">
        <cfset var searchdata = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="searchdata">
        UPDATE 
        search_terms 
        SET count = count+1 
        where 
        term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.searchKeyWord)#">
        </cfquery>
    </cffunction>
    
    <cffunction access="public"  name="InsertSearchTerms" returntype="void">
    	<cfargument name="searchKeyWord" default="" required="yes" type="string">
        <cfset var searchdata = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="searchdata">
        Insert Into 
        search_terms(term,count) 
        VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.searchKeyWord)#">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="1">)
        </cfquery>
    </cffunction>
    
<cffunction access="public" name="getLogin" returntype="string">
    	<cfargument name="provideemail" required="yes">
        <cfset var myset = "">
        <cfset var str = "">
        <cfset var sendmail = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        select npwd, emailaddress, nusername 
        from users 
        where 
        emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.provideemail)#">
        </cfquery>
        <cfif myset.recordcount>
        <cfmail to="#retrieve.emailaddress#" from="#request.w#" username="#request.Mailuser#" password="#request.Mailpass#" 
        server="#request.Mserver#" failto="#request.Mfailto#" port="#request.Mport#" 
        subject="Admin Account Login Information Requested for  #request.defaultLink#" type="html" query="myset">
    	Here are Login Credentials:<br>
    	<hr>
    	<blockquote>
        	Your New Changed Login details are:<br>
            <strong>Username:</strong> #myset.nusername#<br>
            <strong>Password:</strong> #myset.npwd#<br>
        </blockquote>
        <br>
        <hr>
        Regards<br>
        #request.defaultLink#    
        </cfmail>
    	<cfset str = "Cool! Mail dispatched. Check your email">
        <cfelse>
        <cfset str = "Email address not found">
        </cfif>
        <cfreturn str>
    </cffunction>
    
  <cffunction access="public" name="getCats" returntype="query">
  <cfargument name="catID" default="" required="no" type="any">
  <cfargument name="soul" default="" required="no" type="any">
  <cfargument name="searchcatname" default="" required="no" type="any">
  <cfargument name="set" default="" required="no" type="any">
  <cfargument name="l" default="" required="no" type="any">
  <cfargument name="status" default="" required="no">
  <cfargument name="onlydesc" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT <cfif isDefined('arguments.onlydesc') and arguments.onlydesc IS 1>catname, CatDesc<cfelse>*</cfif>
        FROM categories 
        <cfif isDefined('arguments.catID') AND arguments.catID NEQ "">
        WHERE catID = <cfqueryparam value="#trim(arguments.catID)#" cfsqltype="cf_sql_numeric">
        </cfif>
        <cfif isDefined('arguments.set') AND arguments.set EQ 1>
        WHERE 
        catName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchcatname#%"> 
        </cfif>
        <cfif isDefined('arguments.status') AND arguments.status EQ 1>
        WHERE 
        active = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
        </cfif>
        <cfif isDefined('arguments.l') AND arguments.l NEQ "">
        WHERE 
        catName LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
        </cfif>
        ORDER BY 
        <cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
        catName <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
        <cfelse>
        catID DESC 
        </cfif>
        </cfquery>
  <cfreturn myset>
</cffunction>

<cffunction access="public" name="addcategory" returntype="string">
	<cfargument name="structForm" required="yes" type="struct">
    <cfset var myset = "">
    <cfset var str = "">
    <cfset var newcheck = "">
    	<cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="newcheck">
        select catname from categories 
        where 
        catname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structForm.catName#">
        </cfquery>
        <cfif newcheck.recordcount>
        <cfset str = "Error! Category already Exists">
        <cfelse>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        INSERT INTO categories(catName, catDesc, active) 
        values(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.catname)#" maxlength="255">,
        <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.structform.catdesc#">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.structform.active#">)
        </cfquery>
        <cfset str = "Cool! New Category added Successfully">
        </cfif>
        <cfreturn str>
</cffunction>

<cffunction access="public" name="updatecatActiveness" returntype="void">
  <cfargument name="mode" default="" required="no">
  <cfargument name="catID" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        UPDATE categories 
        SET active = 
        	<cfif arguments.mode EQ 1>
            	<cfqueryparam cfsqltype="cf_sql_numeric" value="0">
            <cfelseif arguments.mode EQ 0>    
            	<cfqueryparam cfsqltype="cf_sql_numeric" value="1">
            </cfif>
        WHERE 
        catID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.catID)#">        
        </cfquery>
</cffunction>

<cffunction access="public" name="updatecategory" returntype="string">
  <cfargument name="catname" default="" required="no" type="string">
  <cfargument name="CatDesc" default="" required="no" type="string">
  <cfargument name="active" default="0" required="no" type="string">
  <cfargument name="catID" required="no" type="numeric">
  <cfargument name="old_catName" default="" required="no" type="string">
  <cfset var myset = "">
  <cfset var pageName = true>
  <cfset var checkPageName = "">
  <cfset var str = "">
  <cfif trim(arguments.old_catName) neq trim(arguments.catname)>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="checkPageName">
        SELECT catName 
        FROM categories 
        WHERE catName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.catname)#">
        </cfquery>
    <cfif checkPageName.recordcount>
      <cfset pageName = false>
      <cfset str = "Error! Category Name is Conflicting, try another">
    </cfif>
  </cfif>
  <cfif pageName>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        UPDATE categories 
        SET 
        catName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.catname)#">,
        catDesc = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#trim(arguments.CatDesc)#">,
        active = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.active)#">
        WHERE 
        catID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.catID)#">
        </cfquery>
    <cfset str = "Cool! Category Status Updated Successfully">
  </cfif>
  <cfreturn str>
</cffunction>

<cffunction access="public" name="deleteCategory" returntype="void">
  <cfargument name="catID" type="any" required="yes">
  <cfset var deletcategory = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="deletcategory">
    DELETE FROM categories 
    WHERE 
    catID IN (<cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.catID)#" list="yes">)
   </cfquery>
</cffunction>

<cffunction access="public" name="getSubCats" returntype="query">
  <cfargument name="SubCatID" default="" required="no" type="any">
  <cfargument name="CatID" default="" required="no" type="any">
  <cfargument name="soul" default="" required="no" type="any">
  <cfargument name="searchcatname" default="" required="no" type="any">
  <cfargument name="set" default="" required="no" type="any">
  <cfargument name="l" default="" required="no" type="any">
  <cfargument name="view" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT subcategories.*, categories.catDesc as MainCat
        FROM subcategories 
        inner join categories on categories.catID = subcategories.catID
        <cfif isDefined('arguments.SubCatID') AND arguments.SubCatID NEQ "">
        WHERE SubCatID = <cfqueryparam value="#trim(arguments.SubCatID)#" cfsqltype="cf_sql_numeric">
        </cfif>
        <cfif isDefined('arguments.catID') AND arguments.catID NEQ "">
        WHERE subcategories.catID = <cfqueryparam value="#trim(arguments.catID)#" cfsqltype="cf_sql_numeric">
        	<cfif isDefined('arguments.view') and arguments.view eq 1>
            and subcategories.status = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
            </cfif>
        </cfif>
        <cfif isDefined('arguments.set') AND arguments.set EQ 1>
        WHERE 
        SubCatDesc LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchcatname#%"> 
        </cfif>
        <cfif isDefined('arguments.l') AND arguments.l NEQ "">
        WHERE 
        SubCatDesc LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
        </cfif>
        ORDER BY 
        <cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
        SubCatDesc <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
        <cfelse>
        SubCatID DESC 
        </cfif>
        </cfquery>
  <cfreturn myset>
</cffunction>
<cffunction access="public" name="updatesubcategory" returntype="string">
  <cfargument name="subCatDesc" default="" required="no" type="string">
  <cfargument name="active" default="0" required="no" type="string">
  <cfargument name="subcatID" required="no" type="numeric">
  <cfargument name="old_subCatDesc" default="" required="no" type="string">
  <cfset var myset = "">
  <cfset var pageName = true>
  <cfset var checkPageName = "">
  <cfset var str = "">
  <cfif trim(arguments.old_subCatDesc) neq trim(arguments.subCatDesc)>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="checkPageName">
        SELECT subCatDesc 
        FROM subcategories 
        WHERE subCatDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.subCatDesc)#">
        </cfquery>
    <cfif checkPageName.recordcount>
      <cfset pageName = false>
      <cfset str = "Error! Sub-Category Name is Conflicting, try another">
    </cfif>
  </cfif>
  <cfif pageName>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        UPDATE subcategories 
        SET 
        subCatDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.subCatDesc)#">,
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.active)#">
        WHERE 
        subcatID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.subcatID)#">
        </cfquery>
    <cfset str = "Cool! Sub-Category Status Updated Successfully">
  </cfif>
  <cfreturn str>
</cffunction>

<cffunction access="public" name="addsubcategory" returntype="string">
  <cfargument name="subCatDesc" default="" required="no" type="string">
  <cfargument name="active" default="0" required="no" type="string">
  <cfargument name="maincategory" default="0" required="no" type="numeric">
  <cfset var myset = "">
  <cfset var myset2 = "">
  <cfset var myset3 = "">
  <cfset var str = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT subcatDesc
        from subcategories 
        WHERE 
        subCatDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.subCatDesc)#">
        </cfquery>
  <cfif myset.recordcount>
    <cfset str = "Error! Sub-Category Name must be unique. It is Conflicting with other Name">
    <cfelse>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset2">
        INSERT INTO subcategories (catID,subCatDesc,status) 
        VALUES(<cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.maincategory)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.subCatDesc)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.active)#">)
        </cfquery>
    <cfset str = "Cool! New Sub-Category Added Successfully">
  </cfif>
  <cfreturn str>
</cffunction>

<cffunction access="public" name="deleteSubCategory" returntype="void">
  <cfargument name="subcatID" type="numeric" required="yes">
  <cfset var deletcategory = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="deletcategory">
        DELETE FROM subcategories 
        WHERE 
        subcatID IN (<cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.subcatID)#" list="yes">)
        </cfquery>
</cffunction>

<cffunction access="public" name="updateSubcatActiveness" returntype="void">
  <cfargument name="mode" default="" required="no">
  <cfargument name="SubcatID" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        UPDATE subcategories 
        SET status = 
        	<cfif arguments.mode EQ 1>
            	<cfqueryparam cfsqltype="cf_sql_numeric" value="0">
            <cfelseif arguments.mode EQ 0>    
            	<cfqueryparam cfsqltype="cf_sql_numeric" value="1">
            </cfif>
        WHERE 
        subcatID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.subcatID)#">        
        </cfquery>
</cffunction>

<cffunction access="public" name="getConfig" returntype="query">
    	<cfset var myset = "">
        <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
        SELECT * FROM websitesettings
        </cfquery>
        <cfreturn myset>
    </cffunction>
    
    <cffunction access="public" name="updatemeta" returntype="void">
	<cfargument name="site_title" type="string">
    <cfargument name="site_email" type="string">
    <cfargument name="site_desc" type="string">
    <cfargument name="site_keys" type="string">
    <cfargument name="site_publisher" type="string">
    <cfargument name="site_generator" type="string">
    <cfargument name="site_copy" type="string">
    <cfargument name="site_revisit" type="string">
    <cfargument name="enable" type="string" default="No">
    <cfargument name="site_ID" type="numeric">
	<cfset var myset = "">
    <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
    UPDATE websitesettings 
    SET 
    site_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_title)#">,
    site_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_email)#">,
    site_desc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_desc)#">,
    site_keys = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#trim(arguments.site_keys)#">,
    site_publisher = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#trim(arguments.site_publisher)#">,
    site_generator = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_generator)#">,
    site_copyright = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_copy)#">,
    site_revisit = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.site_revisit)#">,
    <cfif isDefined('arguments.enable') AND arguments.enable NEQ "">
    site_enable = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.enable)#">
    </cfif>
    WHERE 
    site_ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.site_ID)#">
    </cfquery>
</cffunction>

  <cffunction access="public" name="gChanged" returntype="query">
  <cfargument type="numeric" required="no" name="mID">
  <cfset var myString = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myString">
        SELECT * from mailsettings 
        <cfif isdefined('arguments.mID') AND arguments.mID NEQ "">
        WHERE 
        mID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.mID)#">
        </cfif>
        </cfquery>
  <cfreturn myString>
</cffunction>

<cffunction access="public" name="updateuse" returntype="void">
  <cfargument name="gShow" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#">      
    UPDATE mailsettings
    SET  
    usethis = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
    WHERE 
    mID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.gShow)#">
    </cfquery>
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#">      
    UPDATE mailsettings
    SET  
    usethis = <cfqueryparam cfsqltype="cf_sql_numeric" value="0">
    WHERE 
    mID <> <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.gShow)#">
    </cfquery>
</cffunction>

<cffunction access="public" name="delteSelectedMail" returntype="void">
  <cfargument name="dID" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#">      
    DELETE FROM mailsettings 
    WHERE 
    mID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.dID)#">
    </cfquery>
</cffunction>

<cffunction access="public" name="editOld" returntype="void">
  <cfargument name="mailusername" default="" type="string">
  <cfargument name="msendusername" default="" type="string">
  <cfargument name="alais" default="" type="string">
  <cfargument name="mailpassword" default="" type="string">
  <cfargument name="mailserver" default="" type="string">
  <cfargument name="port" default="" type="string">
  <cfargument name="err" default="" type="string">
  <cfargument name="mID" default="" type="numeric">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">      
    UPDATE mailsettings
    SET 
    mailusername=<cfif IsDefined("arguments.mailusername") AND #arguments.mailusername# NEQ "">
    <cfqueryparam value="#arguments.mailusername#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , msendusername=<cfif IsDefined("arguments.msendusername") AND #arguments.msendusername# NEQ "">
    <cfqueryparam value="#arguments.msendusername#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , alais=<cfif IsDefined("arguments.alais") AND #arguments.alais# NEQ "">
    <cfqueryparam value="#arguments.alais#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , mailpassword=<cfif IsDefined("arguments.mailpassword") AND #arguments.mailpassword# NEQ "">
    <cfqueryparam value="#arguments.mailpassword#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , MailServer=<cfif IsDefined("arguments.mailserver") AND #arguments.mailserver# NEQ "">
    <cfqueryparam value="#arguments.mailserver#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , Port=<cfif IsDefined("arguments.port") AND #arguments.port# NEQ "">
    <cfqueryparam value="#arguments.port#" cfsqltype="cf_sql_clob" maxlength="100">
    <cfelse>
    ''
    </cfif>
    , err=<cfif IsDefined("arguments.err") AND #arguments.err# NEQ "">
    <cfqueryparam value="#arguments.err#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    WHERE mID=<cfqueryparam value="#arguments.mID#" cfsqltype="cf_sql_numeric">
</cfquery>
</cffunction>

<cffunction access="public" name="insertEmail" returntype="void">
  <cfargument name="mailusername" default="" type="string">
  <cfargument name="msendusername" default="" type="string">
  <cfargument name="alais" default="" type="string">
  <cfargument name="mailpassword" default="" type="string">
  <cfargument name="mailserver" default="" type="string">
  <cfargument name="port" default="" type="string">
  <cfset var myset = "">
  <cfset var myset2 = "">
  <cfquery datasource="#request.dsn#" name="myset2" username="#request.user#" password="#request.pass#">   
    SELECT * FROM mailsettings 
    WHERE 
    mailusername = <cfqueryparam value="#arguments.mailusername#" cfsqltype="cf_sql_clob" maxlength="255">
    AND 
    msendusername = <cfqueryparam value="#arguments.msendusername#" cfsqltype="cf_sql_clob" maxlength="255">
    AND 
    alais = <cfqueryparam value="#arguments.alais#" cfsqltype="cf_sql_clob" maxlength="255">
    AND 
    mailpassword = <cfqueryparam value="#arguments.mailpassword#" cfsqltype="cf_sql_clob" maxlength="255">
    AND 
    MailServer = <cfqueryparam value="#arguments.mailserver#" cfsqltype="cf_sql_clob" maxlength="255">
    AND 
    Port = <cfqueryparam value="#arguments.port#" cfsqltype="cf_sql_clob" maxlength="100">
    AND 
    err = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.err#" maxlength="255">
    </cfquery>
  <cfif myset2.recordcount>
    <cfelse>
    <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">   
    INSERT INTO mailsettings (mailusername, msendusername, alais, mailpassword, MailServer, Port, err)
    VALUES (<cfif IsDefined("arguments.mailusername") AND #arguments.mailusername# NEQ "">
    <cfqueryparam value="#arguments.mailusername#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.msendusername") AND #arguments.msendusername# NEQ "">
    <cfqueryparam value="#arguments.msendusername#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.alais") AND #arguments.alais# NEQ "">
    <cfqueryparam value="#arguments.alais#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.mailpassword") AND #arguments.mailpassword# NEQ "">
    <cfqueryparam value="#arguments.mailpassword#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.mailserver") AND #arguments.mailserver# NEQ "">
    <cfqueryparam value="#arguments.mailserver#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.port") AND #arguments.port# NEQ "">
    <cfqueryparam value="#arguments.port#" cfsqltype="cf_sql_clob" maxlength="100">
    <cfelse>
    ''
    </cfif>
    , <cfif IsDefined("arguments.err") AND #arguments.err# NEQ "">
    <cfqueryparam value="#arguments.err#" cfsqltype="cf_sql_clob" maxlength="255">
    <cfelse>
    ''
    </cfif>
    )
    </cfquery>
  </cfif>
</cffunction>

<cffunction access="public" name="getExtra" returntype="query">
    	<cfset var myset = "">
        <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
        SELECT * FROM extra
        </cfquery>
        <cfreturn myset>
</cffunction>

<cffunction access="public" name="updateExtra" returntype="string">
	<cfargument name="structform" required="yes" type="struct">
	<cfset var str = "">
    <cfset var myset = "">
    <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
    UPDATE extra 
    SET 
	<cfif isDefined('arguments.structform.showtags') AND arguments.structform.showtags NEQ "">
    	showtags = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structform.showtags#">,
    <cfelse>
    	showtags = <cfqueryparam cfsqltype="cf_sql_varchar" value="No">,
    </cfif>    
    <cfif isDefined('arguments.structform.showcategories') AND arguments.structform.showcategories NEQ "">
    	showcategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structform.showcategories#">,
    <cfelse>
    	showcategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="No">,
    </cfif>    
    <cfif isDefined('arguments.structform.Showsubcategories') AND arguments.structform.Showsubcategories NEQ "">
    	Showsubcategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structform.Showsubcategories#">,
    <cfelse>
    	Showsubcategories = <cfqueryparam cfsqltype="cf_sql_varchar" value="No">,
    </cfif>    
    <cfif isDefined('arguments.structform.ShowTagClouds') AND arguments.structform.ShowTagClouds NEQ "">
    	ShowTagClouds = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structform.ShowTagClouds#">
    <cfelse>
    	ShowTagClouds = <cfqueryparam cfsqltype="cf_sql_varchar" value="No">
    </cfif>    
    WHERE 
    ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.structform.ID#">
    </cfquery>
    <cfset str = "Cool! Your settings have seen Saved">
    <cfreturn str>
</cffunction>

<cffunction access="public" name="getbanned" returntype="query">
	<cfset var mybans = "">
    <CFQUERY datasource="#request.dsn#" name="mybans" username="#request.user#" password="#request.pass#">
	SELECT * FROM bans
	</CFQUERY>
	<cfreturn mybans>
</cffunction>

<cffunction access="public" name="addban" returntype="void">
	<cfargument name="ips" default="" required="no">
	<cfset var mybans = "">
    <cfset var mycheck = "">
    <CFQUERY datasource="#request.dsn#" name="mycheck" username="#request.user#" password="#request.pass#">
	SELECT * FROM bans 
    WHERE 
    ban_ip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.ips)#">
	</CFQUERY>
    <cfif mycheck.recordcount>
    <cfelse>
    <CFQUERY datasource="#request.dsn#" name="mybans" username="#request.user#" password="#request.pass#">
    INSERT INTO bans (ban_IP) VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ips#">)
    </CFQUERY>
    </cfif>
</cffunction>

<cffunction access="public" name="removebans" returntype="void">
	<cfargument name="r" default="" required="no">
	<cfset var mybans = "">
    <cfloop from="1" to="#ListLen(arguments.structform.removeip)#" index="r">
    <CFQUERY datasource="#request.dsn#" name="mybans" username="#request.user#" password="#request.pass#">
    DELETE From	bans
    WHERE 
    ban_ip = '#ListGetAt(arguments.structform.removeip, r)#'
    </CFQUERY>
    </cfloop>
</cffunction>

<cffunction access="public" name="getTags" returntype="query">
    	<cfargument name="ID" default="" required="no" type="any">
        <cfargument name="searchtagname" default="" required="no" type="any">
        <cfargument name="sortorder" default="" required="no" type="any">
        <cfargument name="l" default="" required="no" type="any">
        <cfargument name="soul" default="" required="no">
        <cfargument name="set" default="">
        <cfargument name="getmain" default="" required="no">
        <cfargument name="getrelated" default="" required="no">
        <cfargument name="tagID" default="" required="no">
    	<cfset var myset = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT tagging.*
        FROM tagging 
        <cfif isDefined('arguments.ID') AND arguments.ID NEQ "">
        WHERE ID = <cfqueryparam value="#trim(arguments.ID)#" cfsqltype="cf_sql_numeric">
        </cfif>
        <cfif isDefined('arguments.soul') AND arguments.soul EQ 1>
        WHERE ID != <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
        </cfif>
        <cfif isdefined('arguments.getmain') and arguments.getmain eq 1>
        WHERE parentID = <cfqueryparam cfsqltype="cf_sql_numeric" value="0">
        </cfif>
        <cfif isdefined('arguments.getrelated') and arguments.getrelated eq 10>
        WHERE parentID IN (<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.tagID#" list="yes">)
        </cfif>
        <cfif isDefined('arguments.set') AND arguments.set EQ 1>
        WHERE 
        tagname LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchtagname#%">
        </cfif>
        <cfif isDefined('arguments.l') AND arguments.l NEQ "">
        WHERE 
        tagname LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
        </cfif>
        ORDER BY 
        <cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
        tagname <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
        <cfelse>
        ID DESC 
        </cfif>
        </cfquery>
        <cfreturn myset>
    </cffunction>
    
    <cffunction access="public" name="addtags" returntype="string">
    	<cfargument name="structform" default="" required="yes" type="struct">
        <cfset var mycheck = "">
        <cfset var str = "">
        <cfset var newtags = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="mycheck">
        select * from tagging 
        where 
        tagname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.tagname)#" maxlength="255">
        AND 
        parentID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.category)#">
        AND
        status = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.status)#">
        </cfquery>
        <cfif mycheck.recordcount>
        <cfset str = "Error! Cannot add again & again the Same TagName">
        <cfelse>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="newtags">
        INSERT INTO tagging(tagname,parentID, status) 
        VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.tagname)#" maxlength="255">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.category)#">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.status)#">)
        </cfquery>
        <cfset str = "Cool! New Tag has been added">
        </cfif>
        <cfreturn str>
    </cffunction>
    
    <cffunction access="public" name="updatetagging" returntype="string">
    	<cfargument name="structform" default="" required="yes" type="struct">
        <cfset var str = "">
        <cfset var updTags = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="updTags">
        UPDATE tagging SET 
        tagname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.tagname)#" maxlength="255">,
        parentID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.category)#">,
        status = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.status)#">
        WHERE 
        ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.ID)#">
        </cfquery>
        <cfset str = "Cool! Tag has been Updated">
        <cfreturn str>
    </cffunction>
    
    <cffunction access="public" name="deleteTags" returntype="void">
    	<cfargument name="ID" default="" required="no" type="numeric">
        <cfset var myset = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        DELETE FROM tagging 
        WHERE 
        ID IN (<cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.ID#" list="yes">)
        </cfquery>
    </cffunction>
    
    <cffunction access="public" name="updateTagsActiveness" returntype="void">
      <cfargument name="mode" default="" required="no">
      <cfargument name="ID" default="" required="no">
      <cfset var myset = "">
      <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
            UPDATE tagging 
            SET status = 
                <cfif arguments.mode EQ 1>
                    <cfqueryparam cfsqltype="cf_sql_numeric" value="0">
                <cfelseif arguments.mode EQ 0>    
                    <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
                </cfif>
            WHERE 
            ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.ID)#">        
            </cfquery>
    </cffunction>
    
    <cffunction access="public" name="getlist" returntype="query">
	<cfargument name="searchbadWord" default="" required="no">
    <cfargument name="sortorder" default="">
    <cfargument name="bad" default="" required="no">
    <cfargument name="l" default="" required="no">
	<cfset var myset = "">
    <cfquery name="myset" datasource="#request.dsn#" username="#request.user#" password="#request.pass#">
  	select * from 
  	badwords 
    <cfif isdefined('arguments.searchbadWord') and arguments.searchbadWord neq "">
    WHERE 
    badword LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchbadWord#%">
    </cfif>
    <cfif isdefined('arguments.bad') and arguments.bad neq "">
    WHERE 
    badword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.bad#">
    </cfif>
    <cfif isdefined('arguments.l') and arguments.l neq "">
    WHERE 
    badword LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
    </cfif>
    ORDER BY 
	<cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
    badword <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
    <cfelse>
    badword DESC 
    </cfif>
  </cfquery>
  <cfreturn myset>
</cffunction>

<cffunction access="public" name="deleteKeywords" returntype="void">
	<cfargument name="keyword" required="yes" type="string">
    <cfset var myset = "">
    <cfquery name="myset" datasource="#request.dsn#" username="#request.user#" password="#request.pass#">
    DELETE FROM badwords 
    WHERE badword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.keyword)#">
    </cfquery>
</cffunction>	 

<cffunction name="addbadword" access="public" returntype="string">
  <cfargument name="structform" type="struct" required="yes">
  <cfset var myResult="">
  <cfset var str = "">
  <cfset var mycheck = "">
  <cfquery name="mycheck" datasource="#request.dsn#" username="#request.user#" password="#request.pass#">
  select badword from 
  badwords where 
  badword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.keywords)#" maxlength="255">
  </cfquery>
  <cfif mycheck.recordcount>
  <cfset str = "Error! Badword Exists, add another">
  <cfelse>
  <cfquery name="myResult" datasource="#request.dsn#" username="#request.user#" password="#request.pass#">
  INSERT INTO badwords(badword) 
  values(<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.structform.keywords#" maxlength="255">)
  </cfquery>
  <cfset str = "Cool! New word added Successfully">
  </cfif>
  <cfreturn str>
</cffunction>  

 <cffunction access="public" name="addHeaders" returntype="string">
    	<cfargument name="structform" default="" required="yes" type="struct">
        <cfset var mycheck = "">
        <cfset var str = "">
        <cfset var newheader = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="mycheck">
        select * from displaysettings 
        where 
        header = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.header)#" maxlength="255">
        AND 
        headerImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.uploadfile)#">
        </cfquery>
        <cfif mycheck.recordcount>
        <cfset str = "Error! Cannot add again & again the Same Header">
        <cfelse>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="newheader">
        INSERT INTO displaysettings(header,headerImage) 
        VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.header)#" maxlength="255">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.uploadfile)#">)
        </cfquery>
        <cfset str = "Cool! New Header has been Generated & stored">
        </cfif>
        <cfreturn str>
    </cffunction>
    
    <cffunction access="public" name="updateHeaders" returntype="string">
    	<cfargument name="structform" default="" required="yes" type="struct">
        <cfset var str = "">
        <cfset var updheader = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="updheader">
        UPDATE displaysettings 
        SET header = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.header)#" maxlength="255">,
        headerImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.uploadfile)#"> 
        where 
        displayID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.structform.displayID)#">
        </cfquery>
        <cfset str = "Cool! Header has been Updated & stored">
        <cfreturn str>
    </cffunction>
    
  <cffunction access="public" name="getheaders" returntype="query">
  <cfargument name="displayID" default="" required="no" type="any">
  <cfargument name="soul" default="" required="no" type="any">
  <cfargument name="searchheaders" default="" required="no" type="any">
  <cfargument name="set" default="" required="no" type="any">
  <cfargument name="l" default="" required="no" type="any">
  <cfargument name="status" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT *
        FROM displaysettings 
        <cfif isDefined('arguments.displayID') AND arguments.displayID NEQ "">
        WHERE displayID = <cfqueryparam value="#trim(arguments.displayID)#" cfsqltype="cf_sql_numeric">
        </cfif>
        <cfif isDefined('arguments.set') AND arguments.set EQ 1>
        WHERE 
        header LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchheaders#%"> 
        </cfif>
        <cfif isDefined('arguments.status') AND arguments.status EQ 1>
        WHERE 
        usethis = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> 
        </cfif>
        <cfif isDefined('arguments.l') AND arguments.l NEQ "">
        WHERE 
        header LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
        </cfif>
        ORDER BY 
        <cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
        header <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
        <cfelse>
        displayID DESC 
        </cfif>
        </cfquery>
  <cfreturn myset>
</cffunction>

<cffunction access="public" name="updateHeadersActiveness" returntype="void">
  <cfargument name="displayID" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#">      
    UPDATE displaysettings 
    SET  
    usethis = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
    WHERE 
    displayID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.displayID)#">
    </cfquery>
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#">      
    UPDATE displaysettings
    SET  
    usethis = <cfqueryparam cfsqltype="cf_sql_numeric" value="0">
    WHERE 
    displayID <> <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.displayID)#">
    </cfquery>
</cffunction>

<cffunction name="getAvailableFontNames" access="public" returntype="array" output="false"
		hint="Returns an array of all available system fonts. This is useful when deciding on fonts.">
		<cfset var allFonts = CreateObject("java", "java.awt.GraphicsEnvironment").getLocalGraphicsEnvironment().getAllFonts() />
		<cfset var fontArray = ArrayNew(1) />
		<cfset var i = "" />
				
		<cfloop from="1" to="#ArrayLen(allFonts)#" index="i">
			<cfset ArrayAppend(fontArray, allFonts[i].getName()) />
		</cfloop>

		<cfreturn fontArray />
</cffunction>
    
<cffunction  access="public" name="searchfind" returntype="query">
    	<cfset var mystr = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="mystr">
        select count as tagCount, term
        from search_terms  
        limit 0,50
        </cfquery>
        <cfreturn mystr>    
</cffunction>

<cffunction access="public" name="viewtags" returntype="query">
  <cfargument name="soul" default="" required="no" type="any">
  <cfargument name="searchtags" default="" required="no" type="any">
  <cfargument name="set" default="" required="no" type="any">
  <cfargument name="l" default="" required="no" type="any">
  <cfargument name="status" default="" required="no">
  <cfset var myset = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        SELECT *
        FROM search_terms 
        <cfif isDefined('arguments.set') AND arguments.set EQ 1>
        WHERE 
        term LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.searchtags#%"> 
        </cfif>
        <cfif isDefined('arguments.l') AND arguments.l NEQ "">
        WHERE 
        term LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.l#%">
        </cfif>
        ORDER BY 
        <cfif isdefined('arguments.sortorder') and arguments.sortorder neq "">
        term <cfif arguments.sortorder IS 1>asc<cfelse>desc</cfif>
        <cfelse>
        term DESC 
        </cfif>
        </cfquery>
  <cfreturn myset>
</cffunction>

 
<cffunction access="public" name="CheckIfEmpty" returntype="query">
    <cfargument name="getbanner" default="" required="no">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="check">
        Select * from banners 
        <cfif isDefined('arguments.getbanner') and arguments.getbanner eq 1>
        where 
        enablebanner = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">
        </cfif>
        </cfquery>
  <cfreturn check>
</cffunction>

<cffunction access="public" name="updatebanner" returntype="string">
  <cfargument name="bannertop" required="yes">
  <cfargument name="bannerright" required="yes">
  <cfargument name="bannerbottom" required="yes">
  <cfargument name="editID" required="yes">
  <cfargument name="enablebanner" required="no">
  <cfargument name="squarebanner" required="no">
  <cfset var MyScope = "">
  <cfset var str = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="MyScope">
        UPDATE banners SET 
        bannertop = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannertop)#">, 
        bannerright = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannerright)#">, 
        bannerbottom = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannerbottom)#">,
        enablebanner = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.enablebanner)#">,
        squareBanner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.squarebanner)#"> 
        WHERE 
        bannerID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.editID)#">
  </cfquery>
  <cfset str = "Cool! The banner has been Updated Successfully">
  <cfreturn str>
</cffunction>

<cffunction access="public" name="addnewbanner" returntype="void">
  <cfargument name="bannertop" required="yes">
  <cfargument name="bannerright" required="yes">
  <cfargument name="bannerbottom" required="yes">
  <cfargument name="enablebanner" required="yes">
  <cfargument name="squarebanner" required="no">
  <cfset var MyScope = "">
  <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="MyScope">
        INSERT INTO banners(bannertop, bannerright, bannerbottom,squarebanner,enablebanner) 
        VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannertop)#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannerright)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.bannerbottom)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.squarebanner)#">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.enablebanner)#">)
        </cfquery>
</cffunction>

<cffunction access="public" name="addclouds" returntype="string">
	<cfargument name="structform" type="struct" required="yes">
    <cfset var myset = "">
    <cfset var str = "">
    <cfset var myset2 = "">
    <cfset var myset3 = "">
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
    SELECT * from search_terms 
    WHERE 
    term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.cloudname)#">
    </cfquery>
    <cfif myset.recordcount>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset2">
    UPDATE search_terms 
    SET count = count+1 
    WHERE 
    term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.cloudname)#">
    </cfquery>
    <cfset str = "Cool! The Tag Cloud name already exists and It has been incremented">
    <cfelse>
    <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset3">
    INSERT INTO search_terms(term,count)
    VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structform.cloudname)#">,
    <cfqueryparam cfsqltype="cf_sql_numeric" value="1">) 
    </cfquery>
    <cfset str = "Cool! The New Tag Cloud has been added">
    </cfif>
    <cfreturn str>
</cffunction>

<cffunction access="public" name="getOld" returntype="query">
        <cfargument name="nusername" required="no" default="" type="string">
        <cfargument name="ID" required="no" default="" type="any">
        <cfset var myset = "">
        <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
        SELECT nusername,npwd 
        FROM users 
        <cfif isDefined('arguments.ID') and arguments.ID NEQ "">
        WHERE 
        ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.ID)#">
        <cfelse>
        WHERE 
        nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.nusername)#">
        </cfif>
        </cfquery>
        <cfreturn myset>
    </cffunction>
    
  <cffunction access="public" name="changepass" returntype="void">
        <cfargument name="newPass" required="no" default="" type="string">
        <cfargument name="nusername" required="no" default="" type="string">
        <cfset var myset2 = "">
        <cfquery datasource="#request.dsn#" name="myset2" username="#request.user#" password="#request.pass#">
        UPDATE users  
        SET 
        npwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.newpass)#" maxlength="255">
        WHERE 
        nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.nusername)#"> 
        </cfquery>
    </cffunction>  
    
    <cffunction access="public" name="getMods" returntype="query">
    	<cfargument name="isNowSuper" default="" required="no" type="any">
        <cfargument name="NowisMods" default="" required="no" type="any">
    	<cfset var myset = "">
        <cfquery datasource="#request.dsn#" name="myset" username="#request.user#" password="#request.pass#">
        select *
        from users 
        <cfif isDefined('arguments.isNowSuper') AND arguments.isNowSuper EQ 1>
        where 
        role = <cfqueryparam cfsqltype="cf_sql_varchar" value="2"> 
        </cfif>
        <cfif isdefined('arguments.NowisMods') AND arguments.NowisMods EQ 3>
        where 
        role = <cfqueryparam cfsqltype="cf_sql_varchar" value="3">
        </cfif>
        </cfquery>
        <cfreturn myset>
    </cffunction>
    
    <cffunction access="public" name="checkStuff" returntype="query">
        <cfargument name="chk1email" type="string" required="no">
        <cfargument name="chkuser" type="string" required="no">
        <cfargument name="mode" type="numeric" required="no">
        <cfargument name="susername" type="string" required="no">
        <cfargument name="sID" type="numeric" required="no">
        <cfset var myresult = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myResult">
        SELECT * from users 
        <cfif isdefined('arguments.chkuser') AND arguments.chkuser NEQ "">
        WHERE 
        nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.chkuser)#">
        </cfif>
        <cfif isdefined('arguments.mode') AND arguments.mode EQ 1>
        WHERE 
        emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.chk1email)#">
        </cfif>
        <cfif isdefined('arguments.susername') AND arguments.susername NEQ "">
        WHERE 
        nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.susername)#">
        </cfif>
        <cfif isdefined('arguments.sID') AND arguments.sID NEQ "">
        WHERE 
        ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#trim(arguments.sID)#">
        </cfif>
        </cfquery>
        <cfreturn myresult>
    </cffunction> 
    
    <cffunction access="public" name="updateregistration" returntype="string">
    	<cfargument name="structForm" required="yes" type="struct">
        <cfset var pageName = true>
	  	<cfset var checkPageName = "">
      	<cfset var str = "">
        <cfset var myInsert = "">
      	<cfif trim(arguments.structForm.old_email) neq trim(arguments.structForm.emailaddress)>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="checkPageName">
            SELECT emailaddress 
            FROM users 
            WHERE emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(arguments.structForm.emailaddress)#">
        </cfquery>
        <cfif checkPageName.recordcount>
          <cfset pageName = false>
          <cfset str = "Error! Email address is Conflicting, try another">
        </cfif>
      	</cfif>
      <cfif pageName>
      <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myInsert">
      	 UPDATE users SET 
         emailaddress = <cfqueryparam value="#arguments.structForm.emailaddress#" cfsqltype="cf_sql_clob" maxlength="255">       
        <cfif isDefined('arguments.structForm.oldpassword') AND arguments.structForm.oldpassword NEQ "">
        ,npwd=<cfqueryparam value="#arguments.structForm.oldpassword#" cfsqltype="cf_sql_clob" maxlength="255">
        <cfelse>
        ,npwd=<cfqueryparam value="#Hash(arguments.structForm.password)#" cfsqltype="cf_sql_clob" maxlength="255">
        </cfif>
        ,role=<cfqueryparam value="#arguments.structForm.role#" cfsqltype="cf_sql_numeric">
        ,valid=<cfqueryparam cfsqltype="cf_sql_numeric" value="1">
        WHERE 
        ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.structForm.ID#">
      </cfquery>
      <cfmail to="#arguments.structForm.emailaddress#" from="#request.w#" username="#request.MailUser#" password="#request.Mailpass#" 
       port="#request.MPort#" type="html" subject="Account has been Updated" server="#request.MServer#" failto="#request.Mfailto#">
        Admin has Changed Your Account Information. <br />
        <br />#request.basepath#         <br />
        <br />
        If You have not updated Your Account, Please go to website and Report us an Error!!! <br>
        Login Information<br />
        <br />
        <strong>Username:</strong> #arguments.structForm.oldUser#<br />
        <strong>Password:</strong> #arguments.structForm.password#<br />
        <hr />
        <br />
        Regards, <br />
        <br />
        <strong>#Request.basepath#</strong> <br />
      </cfmail>
      <cfset str = "Cool! Account Updated Successfully and mailed">
      </cfif>
      <cfreturn str>
    </cffunction> 
    
    <cffunction access="public" name="newregistration" returntype="string">
    	<cfargument name="structForm" required="yes" type="struct">
        <cfset var str = "">
        <cfset var checknow = "">
        <cfset var myInsert = "">
        <cfset var checknow2 = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="checknow">
        SELECT emailaddress from users 
        where 
        emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(arguments.structForm.emailaddress)#">
        </cfquery>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="checknow2">
        SELECT nusername from users 
        where 
        nusername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(arguments.structForm.username)#">
        </cfquery>
        <cfif checknow.recordcount>
        	<cfset str = "Error! Email address is in Use, Choose another one">
        <cfelseif checknow2.recordcount>
        	<cfset str = "Error! Username is in use, Choose another">
        <cfelse>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myInsert">
        INSERT INTO users(emailaddress, nusername, npwd, role, valid)
        VALUES (<cfqueryparam value="#arguments.structForm.emailaddress#" cfsqltype="cf_sql_clob" maxlength="255">
        ,<cfqueryparam value="#arguments.structForm.username#" cfsqltype="cf_sql_clob" maxlength="255">
        ,<cfqueryparam value="#Hash(arguments.structForm.password)#" cfsqltype="cf_sql_clob" maxlength="255">
        ,<cfqueryparam value="#arguments.structForm.role#" cfsqltype="cf_sql_numeric">,
        <cfqueryparam cfsqltype="cf_sql_numeric" value="1">)
        </cfquery>
        <cfset subject = "New Admin/Mod Priveleges Account has been Added. Need not validate.">
        <cfmail to="#arguments.structform.emailaddress#" from="#request.w#" username="#request.MailUser#" password="#request.Mailpass#" 
    	port="#request.MPort#" type="html" subject="#subject#" server="#request.MServer#" failto="#request.Mfailto#">
          You are Now a registered Member of The website. <br />
          <br />#request.basePath#<br />
          <br />
          You have your account already activated. Login now<br>
          <br>
          <strong>Username:</strong> #arguments.structForm.username#<br>
          <strong>Password:</strong> #arguments.structForm.password#<br />
          <hr />
          <br />
          Regards, <br />
          <br />
          <strong>#Request.basePath#</strong> <br />
        </cfmail>
        <cfset str = "Cool! Account registered. Check Your Email for furthur action">
        </cfif>    
        <cfreturn str>
    </cffunction>
    
    <cffunction access="public" name="getallapi" returntype="query">
    	<cfset var myset = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        select * from apis 
        </cfquery>
        <cfreturn myset>
    </cffunction>
    
    <cffunction access="public" name="updateAPI" returntype="string">
    	<cfargument name="structform" required="yes" type="struct">
    	<cfset var myset = "">
        <cfset var str = "">
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="check">
        select * from apis 
        </cfquery>
        <cfif check.recordcount>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        UPDATE apis 
        SET <cfif arguments.structform.chooseapi IS 1>
        youtubeAPI = <cfqueryparam cfsqltype="cf_sql_numeric" value="1">,
        truveoAPI = <cfqueryparam cfsqltype="cf_sql_numeric" value="0"> 
        <cfelseif arguments.structform.chooseapi IS 2>
        youtubeAPI = <cfqueryparam cfsqltype="cf_sql_numeric" value="0">,
        truveoAPI = <cfqueryparam cfsqltype="cf_sql_numeric" value="1"> 
        </cfif>
        WHERE 
        ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.structform.ID#">
        </cfquery>
        <cfelse>
        <cfquery datasource="#request.dsn#" username="#request.user#" password="#request.pass#" name="myset">
        INSERT INTO apis(youtubeAPI,truveoAPI) 
        VALUES(
		<cfif arguments.structform.chooseapi IS 1>
        	<cfqueryparam cfsqltype="cf_sql_numeric" value="1">,
        	<cfqueryparam cfsqltype="cf_sql_numeric" value="0"> 
        <cfelseif arguments.structform.chooseapi IS 2>
        	<cfqueryparam cfsqltype="cf_sql_numeric" value="0">,
        	<cfqueryparam cfsqltype="cf_sql_numeric" value="1">
		</cfif>
        ) 
        </cfquery>
        </cfif>
        <cfset str = "Cool! The selected API Has been Choosen and Updated">
        <cfreturn str>
    </cffunction>
    
    <cffunction access="public" name="sefurls" output="true" returntype="struct">
        <cfargument name="URLList" type="string" required="yes" default="" />
        <cfscript>
            LoopIterations = ListLen(URLList, "/") / 2;
        </cfscript>
            <cfloop from="1" to="#LoopIterations#" index="i">
                <cfset tmp = SetVariable("URL.#ListGetAt(URLList, 1, "/")#", "#ListGetAt(URLList, 2, "/")#")>
                <cfset URLList = ListDeleteAt(URLList, 1, "/")>
                <cfset URLList = ListDeleteAt(URLList, 1, "/")>
            </cfloop>
        <cfreturn url>
    </cffunction>
</cfcomponent>

