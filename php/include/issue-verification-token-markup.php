<?php
// alpha 0.5a debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
				<h1><?php echo lg_term_issue_verification_token; ?></h1>
				<?php if ($message==lg_phrase_issue_new_token) { ?>
				<div id="message"><?php echo $message; ?></div>	
				<div id="formDiv">
					<form id="frm" method="post" action="<?php echo $lg_filename; ?>" onsubmit="return validate(this);">
						<fieldset>
						  <legend><?php echo lg_term_issue_verification_token; ?></legend>
						  <p><label for="userid"><?php echo lg_term_userid; ?></label><br /><input type="text" id="userid" name="userid" title="<?php echo lg_phrase_userid_title; ?>" size="50" maxlength="50" value="<?php echo htmlentities($userid)?>" /><br />
						  <label for="email"><?php echo lg_term_email; ?></label><br /><input type="text" id="email" name="email" title="<?php echo lg_phrase_email_title; ?>" size="50" maxlength="255" value="<?php echo htmlentities($email)?>" /><br />
						  <input type="submit" value="<?php echo lg_term_submit; ?>" /><?php writeToken(); ?></p>
						</fieldset>
					</form>
				</div>
				<?php }else{ ?>
				<div id="message"><?php echo $message; ?></div>
				<p><a href="<?php echo lg_verify_page?>" title="<?php echo lg_phrase_logout_continue?>"><?php echo lg_phrase_logout_continue?></a></p>
				<?php } ?>
			</div>