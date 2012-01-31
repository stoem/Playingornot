// home.js


<!-- pageinit only fires every first time the page loads (init is the clue...) -->
$("#home").live("pageinit", function()
{
	console.log("Ready home");
	
	$.post("cfc/Players.cfc?method=getPlayerInfo&returnformat=json",
			function(res) 
			{
				if(res) 
				{	
					console.log(res);
					var user = jQuery.parseJSON(res); 
					var username = user[0]["USERNAME"];
					
					$("#welcomeMsg").html( "Welcome " + username );
				} 
			}
		);
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
		

	$.post("cfc/PlayTimes.cfc?method=getUpcomingPlayTimes&returnformat=json",
				function(res) 
				{
					if(res) 
					{	
						console.log(res);
						$("#fullresponse").html( res );
						//$.mobile.hidePageLoadingMsg();
						//$.mobile.changePage('home.cfm');
						//window.location.href = "home.cfm";	
					} 
					else
					{
						//warn user of error
						$.mobile.hidePageLoadingMsg();
					}
				}
		);	

});



$( '#home' ).live( 'pageshow',function(event){
	console.log("pageshow home");
});

$( '#playtimes' ).live( 'pageshow',function(event){
	console.log("pageshow playtimes");
});

$( '#players' ).live( 'pageshow',function(event){
  console.log("pageshow players");
});

$( '#mydetails' ).live( 'pageshow',function(event){
  console.log("pageshow mydetails");
});