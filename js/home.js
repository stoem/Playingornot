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
				var user = res[0];
				var username = user.USERNAME;
				
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
});


$( '#home' ).live( 'pageshow',function(event){
	console.log("pageshow home");
});

$( '#playtimes' ).live( 'pageshow',function(event){
	console.log("pageshow playtimes");
	
	$.getJSON('cfc/PlayTimes.cfc?method=getUpcomingPlayTimes&returnformat=json', function(data) {
	  
	  var playtimes = [];
	
	  $.each(data, function(key, val) {
		playtimes.push('<li id="' + data[key].ID + '">' + data[key].PLAYTIME + '</li>');
		console.log('<li id="' + data[key].ID + '">' + data[key].PLAYTIME + '</li>');
	  });
	
	  /*$('<ul/>', {
		'class': 'my-new-list',
		html: items.join('')
	  }).appendTo('body');*/
	});
	
	/*$.post("cfc/PlayTimes.cfc?method=getUpcomingPlayTimes&returnformat=json",
			function(res) 
			{
				if(res) 
				{	
					console.log(res);	
					console.log(res[0]);				
					var s = "<h2>Results</h2><ul>";
					for(var i=0; i<res.length; i++) {
						s+= "<li>"+res[i]+"</li>";
					}
					s+="</ul>";
					$("#playTimesResult").html(s);
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
	);*/
});

$( '#players' ).live( 'pageshow',function(event){
  console.log("pageshow players");
});

$( '#mydetails' ).live( 'pageshow',function(event){
  console.log("pageshow mydetails");
});