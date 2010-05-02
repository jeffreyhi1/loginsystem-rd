<?PHP
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<!-- alpha 0.1c debug -->
			<div id="login-system">
			<h1><?PHP echo lg_term_reset_password; ?></h1>
			<?PHP if ($_SESSION["action"]=="token") { ?>
			<div id="message"><?PHP echo $message; ?></div>	
			<div id="formDiv">
			<form id="frm1" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_registration_verification; ?></legend>
			  <p><label for="resettoken"><?PHP echo lg_phrase_enter_unlock_code; ?></label><br /><input type="text" id="resettoken" name="resettoken" size="50" maxlength="64" /><br />
			  <input type="submit" value="<?PHP echo lg_term_submit; ?>" /><?PHP writeToken(); ?><input name="changePassword" type="hidden" value="" /></p>
			</fieldset>
			</form>
			</div>
			<?PHP 
			}else{
				if ($_SESSION["action"]=="password") {
			 ?>
			<div id="message"><?PHP echo $message; ?></div>	
			<div id="formDiv">
			<form id="frm2" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_set_new_password; ?></legend>
			  <p><label for="newpassword"><?PHP echo lg_term_new_password; ?></label><br /><input id="newpassword" name="newpassword" type="password" size="50" maxlength="255" autocomplete="off" /><br />
			  <label for="newpassword"><?PHP echo lg_term_confirm; ?></label><br /><input id="confirm" name="confirm" type="password" size="50" maxlength="255" autocomplete="off" /><br />
			  <input type="submit" value="<?PHP echo lg_term_submit; ?>" /><?PHP writeToken(); ?><input name="changePassword" type="hidden" value="1" /><input type="hidden" name="resettoken" value="<?PHP echo $resettoken; ?>" /></p>
			</fieldset>
			</form>
			</div>
			<?PHP
				}else{  // must be success or error, in either case we just show a message.
			 ?>
			<div id="message"><?PHP echo $message; ?></div>
			<?PHP 
				}
			} 
			?>
			</div>