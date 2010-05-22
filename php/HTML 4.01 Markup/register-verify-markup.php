<?php
// alpha 0.5 debug
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">
			<h1><?php echo lg_phrase_registration_email_verify; ?></h1>
			<?php If ($message==lg_phrase_registration_email_verify_msg) { ?>
			<div id="message"><?php echo $message; ?></div>	
			<div id="formDiv">
			<form id="frm" method="post" action="<?php echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?php echo lg_term_registration_verification; ?></legend>
			  <p><label for="token"><?php echo lg_phrase_enter_unlock_code; ?></label><br><input type="text" id="token" name="token" size="50" maxlength="64"><br>
			  <input type="submit" value="<?php echo lg_term_submit; ?>"></p>
			</fieldset>
			</form>
			</div>
			<?php }else{ ?>
			<div id="message"><?php echo $message; ?></div>
			<?php } ?>
			</div>