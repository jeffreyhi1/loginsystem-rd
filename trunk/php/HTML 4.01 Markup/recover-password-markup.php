<?php
// alpha 0.5 debug
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">
			<h1><?php echo lg_phrase_recover_password; ?></h1>
			<?php if ($message != lg_phrase_recover_password_success) { ?>
			<div id="message"><?php echo $message; ?></div>	
			<div id="formDiv">
			<form id="frm" method="post" action="<?php echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?php echo lg_phrase_recover_password; ?></legend>
			  <p><label for="userid"><?php echo lg_term_userid; ?></label><br><input type="text" id="userid" name="userid" title="<?php echo lg_phrase_userid_title; ?>" size="50" maxlength="50"><br>
			  <label for="email"><?php echo lg_term_email; ?></label><br><input type="text" id="email" name="email" title="<?php echo lg_phrase_email_title; ?>" size="50" maxlength="255"><br>
			  <input type="submit" value="<?php echo lg_term_submit; ?>"><?php writeTokenH(); ?></p>
			</fieldset>
			</form>
			</div>
			<?php }else{ ?>
			<div id="message"><?php echo $message; ?></div>
			<p><a href="<?php echo lg_set_new_password_page?>" title="<?php echo lg_phrase_logout_continue?>"><?php echo lg_phrase_logout_continue?></a></p>
			<?php } ?>
			</div>