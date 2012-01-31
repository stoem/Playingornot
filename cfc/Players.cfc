<cfcomponent>
    
    <cffunction name="getAllPlayers" access="remote" returntype="query">    
		
        <cfquery name="rsPlayers" datasource="#application.dsn#">
            SELECT * FROM players
            ORDER by firstname ASC
        </cfquery>  
        
		<cfreturn rsPlayers>
	</cffunction>
        
    <cffunction name="getPlayerInfo" access="remote" returntype="array">
        
        <cfset userid = ListLast(getauthUser(), "|")>

        <cfquery name="rsPlayer" datasource="#application.dsn#">
            SELECT * FROM players
            WHERE id = #userid#
        </cfquery>  
        
        <cfset result = QueryToArray( rsPlayer ) />
        <cfcontent type="application/json" reset="yes"> 
		<cfreturn result>
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
    
    
    <cffunction name="QueryToArray" access="public" returntype="array" output="false" hint="This turns a query into an array of structures.">

    <!--- Define arguments. --->
    <cfargument name="Data" type="query" required="yes" />
		<cfscript>		
			// Define the local scope.
			var LOCAL = StructNew();		
			// Get the column names as an array.
			LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );		
			// Create an array that will hold the query equivalent.
			LOCAL.QueryArray = ArrayNew( 1 );		
			// Loop over the query.
			for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){		
					// Create a row structure.
					LOCAL.Row = StructNew();				
					// Loop over the columns in this row.
					for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1))
					{
					// Get a reference to the query column.
					LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];				
					// Store the query cell value into the struct by key.
					LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];			
				}			
				// Add the structure to the query array.
				ArrayAppend( LOCAL.QueryArray, LOCAL.Row );			
			}
		
			// Return the array equivalent.
			return( LOCAL.QueryArray );    
        </cfscript>
    </cffunction>
    
</cfcomponent>