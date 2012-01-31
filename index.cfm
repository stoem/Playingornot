<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Are you playing or not?</title>

<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1"> 

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />

<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
<script src="js/index.js"></script>
<script src="js/home.js"></script>
    
<body>

<div data-role="page" id="login" data-title="Login" data-theme="e">

    <div data-role="header" data-theme="e">		
        <h1>Playingornot.com - Login</h1>
	</div>
	<div data-role="content">
        <p>Who are you?</p>
       
        <div data-role="fieldcontain" class="ui-hide-label">
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" value="Stefan" placeholder="Username"/>
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" value="abc" placeholder="Password"/>
            <input type="submit" value="Login" id="submit" data-inline="true">
        </form>
        </div>		
	</div>
	
    <cfinclude template="includes/footer.cfm">
</div>


<div data-role="page" id="home" data-title="Home" data-theme="e">

    <div data-role="header" data-theme="e">		
        <h1>Are you playing?</h1>
        <a href="logout.cfm" data-ajax="false" data-icon="minus">Logout</a>
	</div>
	<div data-role="content">
    
    	<div id="welcomeMsg"></div>		

        <!---<p>Hello <cfoutput>#playerDetail.firstname#</cfoutput>,
        <cfif rsLatest.RecordCount IS 0>
        there are curently no upcoming sessions scheduled.
        <cfelse>
        declare your avalability.</p>
        <p>The next session is on <cfoutput>#DateFormat(rsLatest.playtime, "full")# at #LSTimeFormat(rsLatest.playtime, "H:M tt")#.</cfoutput>
        </cfif>--->
        
        <!---<cfoutput query="rsLatest">
        <cfif rsLatest.id EQ rsAvail.playtimeid>
        	found a match, status is <cfoutput>#rsAvail.status#</cfoutput><br>
            <cfset status = rsAvail.status>
        </cfif>
        <fieldset id="canyouplay" data-role="controlgroup" data-type="horizontal">
            <legend>Can you play?</legend>
                <input type="radio" name="play" id="play_#id#" value="1" <cfif status IS 1>checked</cfif> />
                <label for="play_#id#">Yes</label>
        
                <input type="radio" name="play" id="playno_#id#" value="2" <cfif status IS 2>checked</cfif> />
                <label for="playno_#id#">No</label>
        
                <input type="radio" name="play" id="playmaybe_#id#" value="3" <cfif status IS 3>checked</cfif> />
                <label for="playmaybe_#id#">Maybe</label>
         </fieldset>
  		</cfoutput>--->

        <ul data-role="listview" data-inset="true">
		  <li><a href="#playtimes">Playtimes</a></li>
            <li><a href="#players">Players</a></li>
			<li><a href="#mydetails">My details</a></li>
		</ul>
	</div>
	
    <cfinclude template="includes/footer.cfm">
</div>



<div data-role="page" id="playtimes" data-theme="e">
	<div data-role="header" data-theme="e">
    	<a href="#home" data-rel="back" data-icon="back">Back</a>
		<h1>Playtimes</h1>
        <a href="logout.cfm" data-ajax="false" data-icon="minus">Logout</a>
	</div>

	<div data-role="content">
        
        <div id="playTimesResult">        
        </div>
    
        <!--<div data-role="collapsible-set">            
            <div data-role="collapsible" data-collapsed="true">
                <h3>#DateFormat(playtime, "full")#, #LSTimeFormat(playtime, "H:M tt")#</h3>  
                <fieldset id="fieldset#id#" data-role="controlgroup" data-type="horizontal">
                    <legend>Can you play?</legend>
                        <input type="radio" name="play" id="play_#id#" value="1" />
                        <label for="play_#id#">Yes</label>
                
                        <input type="radio" name="play" id="playno_#id#" value="2"  />
                        <label for="playno_#id#">No</label>
                
                        <input type="radio" name="play" id="playmaybe_#id#" value="3"  />
                        <label for="playmaybe_#id#">Maybe</label>
                 </fieldset>
            </div>	            
        </div>-->
        
    </div>
    
	<cfinclude template="includes/footer.cfm">
</div>


<div data-role="page" id="players" data-theme="e">

	<div data-role="header" data-theme="e">
    	<a href="#home" data-rel="back" data-icon="back">Back</a>
		<h1>Players</h1>
        <a href="logout.cfm" data-ajax="false" data-icon="minus">Logout</a>
	</div>
	<div data-role="content">            
        <cfinvoke 
            component="cfc.Players"
            method="getAllPlayers"
            returnvariable="playerList">
        </cfinvoke>    	 
    	<ul data-role="listview" data-inset="true">		
		<cfoutput query="playerList">
        	<li><a href="player.cfm?id=#id#" data-rel="dialog">#firstname# #lastname#</a></li>
        </cfoutput>		
        </ul>
	</div>
    
	<cfinclude template="includes/footer.cfm">
</div>



<div data-role="page" id="mydetails" data-theme="e">
	<div data-role="header" data-theme="e">
	    <a href="index.cfm" data-rel="back" data-icon="back">Back</a>
		<h1>My Details</h1>
        <a href="logout.cfm" data-ajax="false" data-icon="minus">Logout</a>
	</div>
	<div data-role="content">	
		Content		
	</div>
    
	<cfinclude template="includes/footer.cfm">
</div>


</body>
</html>
