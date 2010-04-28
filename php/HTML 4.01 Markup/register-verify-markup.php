<?PHP
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<!-- 27 APR 2010 alpha 0.1b -->
			<div id="login-system">
			<h1><?PHP echo lg_phrase_registration_email_verify; ?></h1>
			<?PHP If ($message==lg_phrase_registration_email_verify_msg) { ?>
			<div id="message"><?PHP echo $message; ?></div>	
			<div id="formDiv">
			<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_registration_verification; ?></legend>
			  <p><label for="token"><?PHP echo lg_phrase_enter_unlock_code; ?></label><br><input type="text" id="token" name="token" size="50" maxlength="64"><br>
			  <input type="submit" value="<?PHP echo lg_term_submit; ?>"></p>
			</fieldset>
			</form>
			</div>
			<?PHP }else{ ?>
			<div id="message"><?PHP echo $message; ?></div>
			<?PHP } ?>
			</div>