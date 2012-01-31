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
                
        <cfargument type="String" name="targetPage" required=true/>
        
        <cflog file="#this.name#" type="information" text="#arguments.targetPage#">
        
		<cfif structKeyExists(url, "init")>
			<cfset onApplicationStart()>
		</cfif>
        
   	 	<!--- check if user is logged in.--->
        <cfif isUserLoggedIn() EQ "NO" AND listlast(arguments.targetPage,"/") IS NOT "index.cfm" AND listlast(arguments.targetPage,"/") IS NOT "Auth.cfc" >
            <!--- for ajax requests, throw an error --->
            <cfset reqData = getHTTPRequestData()>
            
            <cfif structKeyExists(reqData.headers,"X-Requested-With") AND reqData.headers["X-Requested-With"] eq "XMLHttpRequest">
            	timeout
                <cfheader name="SessionTimeout" value="1">
            	<cfthrow message="SessionTimeout">
            <cfelse>
            	<cflocation url="index.cfm">
            </cfif>
        </cfif>
        
    	<cfreturn true />
    </cffunction>   
     
</cfcomponent>