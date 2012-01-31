<cfcomponent>
	
    <cffunction name="login" access="remote" returntype="boolean">    
		
        <cfargument name="username" type="string" required="yes">
        <cfargument name="password" type="string" required="yes">
        
        <cfquery name="rsLogin" datasource="#application.dsn#">
            SELECT * FROM players
            WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
            AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(arguments.password)#">
        </cfquery>
        
        <cfif rsLogin.RecordCount EQ 1>
        	<cflogin>
            	<cfloginuser name="#rsLogin.id#" password="#rsLogin.password#" roles="#rsLogin.role#">
                <cfset session.loggedin = "1">
            </cflogin>
			<cfreturn true>
		<cfelse>
        	<cfreturn false>
        </cfif>
    </cffunction>
    
</cfcomponent>