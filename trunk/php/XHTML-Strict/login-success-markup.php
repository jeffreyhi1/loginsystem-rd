          <div id="login-system">
    		<h1><?PHP echo lg_term_login_success ?></h1>
   			<div id="loginSuccess"><p><?PHP echo htmlentities($_SESSION["name"]) ?>&nbsp;is logged in.</p>
   				<p><?PHP echo '<a href="'. lg_home .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue .'</a>' ?></p>
   			</div>
  		  </div>