<cfcomponent
    displayname="Application"
    output="true"
    hint="Handle the application.">
     
    <!--- Set up the application. --->
    <cfset THIS.Name = "playingornot" />
    <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 ) />
    <cfset THIS.SessionManagement = true />
    	
     
    <cffunction
        name="OnApplicationStart"
        access="public"
        returntype="boolean"
        output="true"
        hint="Fires when the application is first created.">
     	
        <cfset application.dsn = "playingornot">
        <cfset application.base_url = "playingornot">
        <cfset application.base_url = "http://playingornot">
        
    	<!--- Return out. --->
    	<cfreturn true />
    </cffunction>
     
    <cffunction
        name="OnRequestStart"
        access="public"
        returntype="boolean"
        output="true"
        hint="Fires at first part of page processing.">
        
		<cfif structKeyExists(url, "init")>
        	initting
			<cfset onApplicationStart()>
		</cfif>
        
   	 	<!--- Return out. --->
    	<cfreturn true />
    </cffunction>
    
   
     
</cfcomponent>