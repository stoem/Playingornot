<cfcomponent>
	
    <cffunction name="getLatestPlayTime" access="public" returntype="string">
    <cffunction name="getLatestPlayTime" access="public" returntype="query">
    
		<cfset todayDate = Now()>
        <cfquery name="rsPlaytimes" datasource="#application.dsn#">
        <cfquery name="rsLatest" datasource="#application.dsn#">
            SELECT * FROM playtimes
            WHERE playtime > current_date
            ORDER by playtime ASC
            LIMIT 1
        </cfquery>  
        
		<cfreturn rsPlaytimes.playtime>
		<cfreturn rsLatest>
	</cffunction>
    
    
    <cffunction name="getNextPlayTimes" access="public" returntype="query">
    
        <cfquery name="rsPlaytimes" datasource="#application.dsn#">
            SELECT * FROM playtimes            
            WHERE playtime > current_date
            ORDER by playtime ASC
        </cfquery>  
        
		<cfreturn rsPlaytimes>
	</cffunction>

    
</cfcomponent>