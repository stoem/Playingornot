<cfif isUserLoggedIn() EQ "NO">
	<cfset referer=CGI.SCRIPT_NAME>
    <cfif CGI.QUERY_STRING NEQ "">
    	<cfset referer=referer & "?" & CGI.QUERY_STRING>
    </cfif>
    
    <cfset failureURL="#APPLICATION.base_url#/index.cfm?accessdenied=" & URLEncodedFormat(referer)>
    <cflocation url="#failureURL#" addtoken="no">
</cfif>