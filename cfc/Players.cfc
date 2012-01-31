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
            </cflogin>
			<cfreturn true>
		<cfelse>
        	<cfreturn false>
        </cfif>
    </cffunction>
    
    <cffunction name="getAllPlayers" access="public" returntype="query">    
		
        <cfquery name="rsPlayers" datasource="#application.dsn#">
            SELECT * FROM players
            ORDER by firstname ASC
        </cfquery>  
        
		<cfreturn rsPlayers>
	</cffunction>
        
    <cffunction name="PlayerbyID" access="public" returntype="query">
        <cfargument name="id" required="yes">
        
        <cfquery name="rsPlayer" datasource="#application.dsn#">
            SELECT * FROM players
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
        </cfquery>  
        
		<cfreturn rsPlayer>
	</cffunction>
                
    
    <cffunction name="storePlayAvailability" access="remote" returntype="boolean">
    	<cfargument name="playerid" required="yes">
        <cfargument name="playtimeid" required="yes">
        <cfargument name="status" required="yes">
    	
        <!--- check if this player is changing or inserting new availability --->
        <cfquery name="checkRecordExists" datasource="#application.dsn#">
        	SELECT id from availability
            WHERE playerid =#arguments.playerid#
            AND playtimeid = #arguments.playtimeid#
        </cfquery>
        
        <cfif checkRecordExists.RecordCount EQ 1>
        	<cfquery name="storeAvailability" datasource="#application.dsn#">
                UPDATE availability 
                SET status = #arguments.status#
                WHERE playerid =#arguments.playerid#
                AND playtimeid = #arguments.playtimeid#
        	</cfquery>
        <cfelse>        
            <cfquery name="storeAvailability" datasource="#application.dsn#">
                INSERT INTO availability 
                (playerid, playtimeid, status)
                VALUES 
                (#arguments.playerid#, #arguments.playtimeid#, #arguments.status#)
            </cfquery>
        </cfif>
        
		<cfreturn true>
	</cffunction>
                    
    
    <cffunction name="getPlayAvailability" access="public" returntype="query">
    	<cfargument name="playerid" required="yes">
        
        <cfquery name="rsAvailability" datasource="#application.dsn#">
            SELECT * from availability
            WHERE playerid = #arguments.playerid#            
        </cfquery>
        
		<cfreturn rsAvailability>
	</cffunction>
    
</cfcomponent>