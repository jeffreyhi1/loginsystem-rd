<?php
// alpha 0.5 debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
			  <h1><?php echo lg_term_login_success; ?></h1>
			  <div id="loginSuccess"><p><?php echo htmlentities($_SESSION["name"]) . lg_phrase_is_logged_in; ?>.</p>
			  <p><?php echo '<a href="'. lg_home .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue .'</a>'; ?></p>
			  </div>
			</div>