<?PHP
// alpha 0.5 debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<!-- 27 APR 2010 alpha 0.3 debug -->
			<div id="login-system">
			  <h1><?PHP echo lg_term_login_success; ?></h1>
			  <div id="loginSuccess"><p><?PHP echo htmlentities($_SESSION["name"]) . lg_phrase_is_logged_in; ?>.</p>
			  <p><?PHP echo '<a href="'. lg_home .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue .'</a>'; ?></p>
			  </div>
			</div>