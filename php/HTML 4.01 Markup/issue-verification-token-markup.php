			<!-- HTML 4.01 Strict -->
			<!-- 27 APR 2010 alpha 0.1b -->
			<div id="login-system">
				<h1><?PHP echo lg_term_issue_verification_token; ?></h1>
				<?PHP if ($message==lg_phrase_issue_new_token) { ?>
				<div id="message"><?PHP echo $message; ?></div>	
				<div id="formDiv">
					<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
						<fieldset>
						  <legend><?PHP echo lg_term_issue_verification_token; ?></legend>
						  <p><label for="userid"><?PHP echo lg_term_userid; ?></label><br><input type="text" id="userid" name="userid" title="<?PHP echo lg_phrase_userid_title; ?>" size="50" maxlength="50"><br>
						  <label for="email"><?PHP echo lg_term_email; ?></label><br><input type="text" id="email" name="email" title="<?PHP echo lg_phrase_email_title; ?>" size="50" maxlength="255"><br>
						  <input type="submit" value="<?PHP echo lg_term_submit; ?>"><?PHP writeTokenH(); ?></p>
						</fieldset>
					</form>
				</div>
				<?PHP }else{ ?>
				<div id="message"><?PHP echo $message; ?></div>
				<?PHP } ?>
			</div>