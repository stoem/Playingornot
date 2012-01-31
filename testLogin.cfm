<cfinvoke 
    component="cfc.Players"
    method="getAllPlayers"
    returnvariable="playerList">
</cfinvoke>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Are you playing? Or not?</title>

<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1"> 

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
<script src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>

<script language="javascript">

$("#login").live("pageinit", function()
{
    console.log("Ready index");
	// submit saved avalability data to backend
	$("#submit").bind( "click", function(event, ui) 
	{
		event.preventDefault();
		console.log("submit clicked");
		
		var username = $.trim( $('#username').val() );
		var password = $.trim( $('#password').val() );
		
		$.mobile.showPageLoadingMsg();
		$.post("cfc/Auth.cfc?method=login&returnformat=json",
                    {username:username,password:password},
                    function(res) 
					{
                        if(res) 
						{
							if (res == 'true')
							{
                            	console.log(res);
								$.mobile.hidePageLoadingMsg();
								//$.mobile.changePage('home.cfm', {reloadPage:true});
								window.location.href = "home.cfm";
							}
							else
							{
								$.mobile.hidePageLoadingMsg();
							}
                        } 
						else
						{
                            //warn user of error
							$.mobile.hidePageLoadingMsg();
                        }
                    }
            );
		
		return false;
	});
	
});


</script>

</head>
    
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


</body>
</html>
