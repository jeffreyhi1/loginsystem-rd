			<!-- XHTML 1.1 Strict -->
			<!-- 19 APR 2010 alpha 0.1a -->
			<div id="login-system">
			<h1><?PHP echo lg_term_cancel_account; ?></h1>
			<?PHP If ($message != lg_phrase_cancel_account_cancelled) { ?>
			<div id="message"><?PHP echo $message; ?></div>
			<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_cancel_account; ?></legend>
			  <div id="warning"><?PHP echo lg_phrase_cancel_account_warning; ?></div>
			  <label for="userid"><?PHP echo lg_term_userid; ?></label><br /><input id="userid" name="userid" title="<?PHP echo lg_phrase_userid_title; ?>" type="text" size="20" maxlength="32" />&nbsp;<span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
			  <label for="password"><?PHP echo lg_term_password; ?></label><br /><input id="password" name="password" title="<?PHP echo lg_phrase_password_title; ?>" type="password" size="20" maxlength="255" />&nbsp;<span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
			  <input type="submit" value="<?PHP echo lg_term_cancel; ?>" /><?PHP writeToken(); ?>
			</fieldset>
			<p><a title="<?PHP echo lg_term_recover_password; ?>" href="<?PHP echo lg_recover_passsword_page; ?>"><?PHP echo lg_term_recover_password; ?></a></p>
			</form>
			<?PHP }else{ ?>
			<div id="message"><?PHP echo $message; ?></div>
			<?PHP } ?>
			</div>