<cfinclude template="includes/restricted.cfm">
<cfset userid = ListLast(getauthUser(), "|")>

<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>playingornot.com</title>


<cfinvoke 
 component="cfc.Players"
 method="PlayerbyID"
 returnvariable="playerDetail">
	<cfinvokeargument name="id" value="#userid#"/>
</cfinvoke>

<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1"> 

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>

<script language="javascript">

$("#home").live("pageinit", function()
{
	console.log("Ready home");
});

$("#playtimes").live("pageinit", function()
{
    console.log("Ready playtimes");
	// submit saved avalability data to backend
	$("input[type='radio']").bind( "change", function(event, ui) 
	{
		var playtimeid = event.target.id.split('_')[1];
		var status = event.target.value;
		console.log("playtimeid: " + playtimeid + ": " + status);
		
		$.post("cfc/Players.cfc?method=storePlayAvailability&returnformat=json",
                    {playerid:1,playtimeid:playtimeid,status:status},
                    function(res) 
					{
                        if(res) 
						{
                            console.log(res);
                        } 
						else
						{
                            //warn user of error
                        }
                    }
            );
		
	});
	
});

</script>

</head>
    
<body>

<div data-role="page" id="home" data-title="Home" data-theme="e">

    <div data-role="header" data-theme="e">		
        <h1>Are you playing? Or not?</h1>
	</div>
	<div data-role="content">
<cfinvoke 
    component="cfc.PlayTimes"
    method="getLatestPlayTime"
    returnvariable="latestTime">
</cfinvoke>


        <p>Hello <cfoutput>#playerDetail.firstname#</cfoutput>, declare your avalability.</p>
        <p>The next session is on <cfoutput>#DateFormat(latestTime, "full")# at #LSTimeFormat(latestTime, "H:M tt")#. Can you play?</cfoutput>
  
  </p>
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
        <a href="logout.cfm" data-icon="minus">Logout</a>
	</div>

	<div data-role="content">
    <cfinvoke 
         component="cfc.PlayTimes"
         method="getNextPlayTimes"
         returnvariable="playTimes">
    </cfinvoke>
            <div data-role="collapsible-set">
                <cfoutput query="playTimes">
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
				</cfoutput>             
            </div>
    </div>
    
	<cfinclude template="includes/footer.cfm">
</div>


<div data-role="page" id="players" data-theme="e">

	<div data-role="header" data-theme="e">
    	<a href="#home" data-rel="back" data-icon="back">Back</a>
		<h1>Players</h1>
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
	</div>
	<div data-role="content">	
		Content		
	</div>
    
	<cfinclude template="includes/footer.cfm">
</div>

</body>
</html>
