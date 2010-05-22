<?php
// alpha 0.5 debug
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">			
			<h1><?php echo lg_term_cancel_account; ?></h1>
			<?php If ($message != lg_phrase_cancel_account_canceled) { ?>
			<div id="message"><?php echo $message; ?></div>
			<form id="frm" method="post" action="<?php echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?php echo lg_term_cancel_account; ?></legend>
			  <div id="warning"><?php echo lg_phrase_cancel_account_warning; ?></div>
			  <label for="userid"><?php echo lg_term_userid; ?></label><br><input id="userid" name="userid" title="<?php echo lg_phrase_userid_title; ?>" type="text" size="20" maxlength="50" value="<?php echo htmlentities($userid); ?>">&nbsp;<span class="field_normal"><?php echo lg_term_required; ?></span><br>
			  <label for="password"><?php echo lg_term_password; ?></label><br><input id="password" name="password" title="<?php echo lg_phrase_password_title; ?>" type="password" size="20" maxlength="255" autocomplete="off">&nbsp;<span class="field_normal"><?php echo lg_term_required; ?></span><br>
			  <input type="submit" value="<?php echo lg_term_cancel; ?>"><?php writeTokenH(); ?>
			</fieldset>
			<p><a title="<?php echo lg_term_recover_password; ?>" href="<?php echo lg_recover_passsword_page; ?>"><?php echo lg_term_recover_password; ?></a></p>
			</form>
			<?php }else{ ?>
			<div id="message"><?php echo $message; ?></div>
			<?php
				echo '<p><a href="'. lg_loginPage .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue .'</a></p>'; 
				} ?>
			</div>