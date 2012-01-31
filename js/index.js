// index.js

var POST_LOGIN_PAGE = "#home";
var AUTH_URL = "cfc/Auth.cfc?method=login&returnformat=json";

$("#login").live("pageinit", function()
{
    console.log("Ready index");
	
	// we catch timeout/not logged in errors caused by AJAX requests here
	// see http://bit.ly/yHKVq3
    $.ajaxSetup({
        error:function(x,e)
		{
            if(x.status == 500 && x.statusText == "SessionTimeout") {
                alert("Your session has timed out.");
                //location.href = 'login.cfm';
            }
        }
    });	
	
	// submit saved avalability data to backend
	$("#submit").bind( "click", function(event, ui) 
	{
		event.preventDefault();	
		var username = $.trim( $('#username').val() );
		var password = $.trim( $('#password').val() );
		
		$.mobile.showPageLoadingMsg();
		$.post( AUTH_URL,
                    {username:username,password:password},
                    function(res) 
					{
                        if(res) 
						{
							if (res == 'true')
							{
                            	console.log(res);
								$.mobile.changePage( POST_LOGIN_PAGE );
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
