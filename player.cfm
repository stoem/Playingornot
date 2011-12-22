<cfinvoke 
 component="cfc.Players"
 method="PlayerbyID"
 returnvariable="playerDetail">
	<cfinvokeargument name="id" value="#URL.id#"/>
</cfinvoke>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<title>playingornot.com</title> 
	<link rel="stylesheet" href="//code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script src="//code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
</head> 

<body> 

<div data-role="page" data-theme="e">

	<div data-role="header" data-theme="e">
		<cfoutput query="playerDetail"><h1>#firstname# #lastname#</h1></cfoutput>
	</div><!-- /header -->

	<div data-role="content">	
		<p>
        Phone: 000000000<br>
        Email: some@fake.com
        
        </p>
	</div><!-- /content -->
	
	<cfinclude template="includes/footer.cfm">
	
</div><!-- /page -->

</body>
</html>