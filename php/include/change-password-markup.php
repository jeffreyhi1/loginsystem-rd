<?PHP
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<!-- 27 APR 2010 alpha 0.1b debug -->
			<div id="login-system">
			<h1><?PHP echo lg_term_change_password; ?></h1>
			<h2><?PHP echo $_SESSION["name"] ?></h2>
			<?PHP if ($message != lg_phrase_password_changed) { ?>
				<div id="message"><?PHP echo $message; ?></div>
				<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
				<fieldset>
				  <legend><?PHP echo lg_term_change_password; ?></legend>
				  <label for="oldpassword"><?PHP echo lg_term_current_password; ?>&nbsp;</label><br /><input id="oldpassword" name="oldpassword" type="password" size="25" maxlength="255" title="<?PHP echo lg_phrase_oldpassword_title; ?>" />&nbsp;<span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
				  <label for="newpassword"><?PHP echo lg_term_new_password; ?>&nbsp;</label><br /><input id="password" name="password" type="password" size="25" maxlength="255" title="<?PHP echo lg_phrase_password_title; ?>" />&nbsp;<span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
				  <label for="confirm"><?PHP echo lg_term_confirm; ?>&nbsp;</label><br /><input id="confirm" name="confirm" type="password" size="25" maxlength="255" title="<?PHP echo lg_phrase_confirm_title; ?>" />&nbsp;<span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
				  <?PHP writeToken(); ?><input id="submit" name="submit" type="submit" value="<?PHP echo lg_term_change_password_button_text; ?>" />
				</fieldset>
				</form>
			<?PHP }else{ ?>
				<div id="message"><?PHP echo $message; ?><br />
					<a href="<?PHP echo lg_home; ?>"><?PHP echo lg_phrase_logout_continue; ?></a>
				</div>
			<?PHP } ?>
			</div>