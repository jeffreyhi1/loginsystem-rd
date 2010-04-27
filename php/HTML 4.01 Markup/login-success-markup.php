			<!-- HTML 4.01 Strict -->
			<!-- 26 APR 2010 alpha 0.1b -->
			<div id="login-system">
			  <h1><?PHP echo lg_term_login_success; ?></h1>
			  <div id="loginSuccess"><p><?PHP echo htmlentities($_SESSION["name"]) . lg_phrase_is_logged_in; ?>.</p>
			  <p><?PHP echo '<a href="'. lg_home .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue .'</a>'; ?></p>
			  </div>
			</div>