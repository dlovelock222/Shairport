<!DOCTYPE html>
<html>
<head>
 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta content="301645777112-2rlc9gth0f5d4reimjcm9bf0kj7ahec0.apps.googleusercontent.com"
          name="google-signin-client_id">
    <title>Login / Register</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin href="https://fonts.gstatic.com" rel="preconnect">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link
            href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
    <script crossorigin="anonymous"
            src="https://kit.fontawesome.com/3204349982.js"></script>
    <script async defer src="https://apis.google.com/js/platform.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto"
          rel="stylesheet" type="text/css"> 
    <script src="https://apis.google.com/js/api:client.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="414693959520-vaogaupc5phofnvp712flmqqr96ue9ai.apps.googleusercontent.com">
    <link href="register.css" rel="stylesheet">
    <link rel="stylesheet" href="aboutus.css">
	<link rel="shortcut icon" type="image/png" href="https://image.ibb.co/fOur3b/favicon.png"/>
    <script src="reg2.css"></script>

</head>
<body>

	<% String er = (String) request.getAttribute("error");
			if (er != null) out.println(er);
	 %>
		
		
	
		
<!--     <header class="header"> -->
        <nav class="navtopbar">
      <div class="topbar">
      	<div class="toplogo">
      		<div class="toplogo-container">
		        <a href="mellhome.jsp">
		        <img src="Shairportlogo.png" class="shairport_logo">
		        </a>
		    </div>
	    </div>
        

        <ul class="navbar_menu">
             <li class="navbar_item"> <a href="mellhome.jsp" class="links">Home</a> </li>
             <li class="navbar_item"> <a href="aboutus.jsp" class="links">About Us</a> </li>
        
        </ul>
      </div>
    </nav>
    
    
    
        <section>
		<div class="block"></div>
            <div class="login-wrap">
                <div class="login-html">
                    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
                    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
                    <div class="login-form">
                        <form action ="login" method ="POST">
                        <div class="sign-in-htm">
                            <div class="group">
                                <label for="email" class="label">Email</label>
                                <input id="email" name="email" type="text" class="input">
                            </div>
                            <div class="group">
                                <label for="password" class="label">Password</label>
                                <input id="password" name="password" type="password" class="input" data-type="password">
                            </div>
                            <div class="group">
                                <input id="check" type="checkbox" class="check" checked>
                                <label for="check"><span class="icon"></span> Keep me Signed in</label>
                            </div>
                            <div class="group">
                                <button class="button"> Sign In </button>
                            </div>
                            <div class="group">
                            	<div class="g-signin2" data-onsuccess="onSignIn" data-width="auto" data-height="40" data-longtitle="true" data-theme="dark"> </div>
                            </div>
                            <div class="hr"></div>
                            <div class="foot-lnk">
                                <a href="#forgot">Forgot Password?</a>
                            </div>
                        </div>
                        </form>
                        <form action="register" method="POST">
                        <div class="sign-up-htm">
                            <div class="group">
                                <label for="newName" class="label">Name</label>
                                <input id="newName" name="newName" type="text" class="input">
                            </div>
                            <div class="group">
                                <label for="newEmail" class="label">Email Address</label>
                                <input id="newEmail" name="newEmail" type="text" class="input">
                            </div>
                            <div class="group">
                                <label for="newPassword" class="label">Password</label>
                                <input id="newPassword" name="newPassword" type="password" class="input" data-type="password">
                            </div>
                            <div class="group">
                                <label for="newPasswordConfirmed" class="label">Repeat Password</label>
                                <input id="newPasswordConfirmed" name="newPasswordConfirmed" type="password" class="input" data-type="password">
                            </div>
                            <div class="group">
                                <button class="button"> Sign Up </button>
                            </div>
                            <div class="hr"></div>
                            <div class="foot-lnk">
                                <label for="tab-1">Already a Member?</label> <br> <br>
                            </div>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
		</section>




</body>

<script>
		function onSignIn(googleUser) {
	        // Useful data for your client-side scripts:
	        var profile = googleUser.getBasicProfile();
	        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
	        console.log('Full Name: ' + profile.getName());
	        console.log('Given Name: ' + profile.getGivenName());
	        console.log('Family Name: ' + profile.getFamilyName());
	        console.log("Image URL: " + profile.getImageUrl());
	        console.log("Email: " + profile.getEmail());
	        var name = profile.getName();
	        var email = profile.getEmail();
	        // The ID token you need to pass to your backend:
	        var id_token = googleUser.getAuthResponse().id_token;
	       
            if (email.includes("@usc.edu")) { 
            	document.cookie ="Email=" + email;
            	var cookieName = name.replace(" ","&");
	       		document.cookie = "Name=" + cookieName;
                window.location.href="http://localhost:8080/Shairport/googleServlet";
            } else {
                alert("Must sign in with a valid USC Email");
            }

	      }
		
			function onSuccess(googleUser) {
		      console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
		      onSignIn(googleUser);
		    }
			
		    function onFailure(error) {
		      console.log(error);
		    }
		 
		    
		     
		 
	    	function signOut() {
	    	    var auth2 = gapi.auth2.getAuthInstance();
	    	    auth2.signOut().then(function () {
	    	      console.log('User signed out.');
	    	      
	    	    });
	    	  }
		      
		    
		    
		      var CLIENT_ID = '414693959520-a8em47p4o4h9cjk9ca4vl383immov8i8.apps.googleusercontent.com';
		      var API_KEY = config.API_KEY;
		      
		   
		      var authorizeButton = document.getElementById('g-signin2');
		      
		      function handleClientLoad() {
		        gapi.load('client:auth2', initClient);
		      }
		      function initClient() {
		          gapi.client.init({
		          apiKey: API_KEY,
		          clientId: CLIENT_ID,
		          discoveryDocs: DISCOVERY_DOCS,
		          scope: SCOPES
		        }).then(function () {
		          // Listen for sign-in state changes.
		          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
		         
		          authorizeButton.onclick = handleAuthClick;
		        }, function(error) {
		          appendPre(JSON.stringify(error, null, 2));
		        });
		      }
		      function handleAuthClick(event) {
		        gapi.auth2.getAuthInstance().signIn();
		      }
		    
	</script>
	
	<script src="https://apis.google.com/js/platform.js?onload=renderButton" 
				onload="this.onload=function(){};handleClientLoad()"
      			onreadystatechange="if (this.readyState === 'complete') this.onload()" async defer></script>



</html>