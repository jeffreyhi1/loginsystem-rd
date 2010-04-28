			<!-- XHTML 1.1 Strict -->
			<!-- 27 APR 2010 alpha 0.1b -->
			<div id="login-system">
    		<?PHP if ($numAffected!=1) { ?>
    		<div id="message"><?PHP echo $message; ?></div>
    		<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
    		  <fieldset>
    		    <legend><?PHP echo lg_term_registration; ?></legend>
    		    <label for="userid"><?PHP echo lg_term_userid; ?></label><br />
    		    <input id="userid" name="userid" title="<?PHP echo lg_phrase_userid_new_title; ?>" type="text" size="20" maxlength="32" />
    		    <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
    		    <label for="password"><?PHP echo lg_term_password; ?></label><br />
    		    <input id="password" name="password" title="<?PHP echo lg_phrase_password_new_title; ?>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
    		    <label for="confirm"><?PHP echo lg_term_confirm; ?></label><br />
    		    <input id="confirm" name="confirm" title="<?PHP echo lg_phrase_confirm_title; ?>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
    		    <label for="email"><?PHP echo lg_term_email; ?></label><br />
    		    <input id="email" name="email" title="<?PHP echo lg_phrase_email_title; ?>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
    		    <label for="name"><?PHP echo lg_term_name; ?></label><br />
    		    <input id="name" name="name" title="<?PHP echo lg_phrase_name_title; ?>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
    		    <label for="website"><?PHP echo lg_term_website_address; ?></label><br />
    		    <input id="website" title="<?PHP echo lg_phrase_website_title; ?>" name="website" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_optional; ?></span><br />
    		    <label for="news"><?PHP echo lg_phrase_news; ?></label>
    		    <input id="news" name="news" type="checkbox" value="Yes" />
    		    <input type="hidden" id="destination" name="destination" value="<?PHP echo $destination; ?>" /><br />
    		    <?PHP writeToken(); ?><input type="submit" value="<?PHP echo lg_register_button_text; ?>" />
    		  </fieldset>
    		</form>
    		<?PHP }else{ ?>
    		<div id="registered"><p><?PHP echo lg_term_registration_thankyou; ?><br /><br />
    		  <strong><?PHP echo lg_term_userid; ?></strong>: <?PHP echo htmlentities($userid); ?><br />
    		  <strong><?PHP echo lg_term_email; ?></strong>: <?PHP echo htmlentities($email); ?><br />
    		  <strong><?PHP echo lg_term_name; ?></strong>: <?PHP echo htmlentities($name); ?><br />
    		  <strong><?PHP echo lg_term_website; ?></strong>: <?PHP echo htmlentities($website); ?><br />
    		  <strong><?PHP echo lg_term_ip; ?></strong>: <?PHP echo htmlentities($ip); ?><br />
    		  <strong><?PHP echo lg_term_region; ?></strong>: <?PHP echo htmlentities($region); ?><br />
    		  <strong><?PHP echo lg_term_city; ?></strong>: <?PHP echo htmlentities($city); ?><br />
    		  <strong><?PHP echo lg_term_country; ?></strong>: <?PHP echo htmlentities($country); ?><br />
    		  <strong><?PHP echo lg_term_useragent; ?></strong>: <?PHP echo htmlentities($useragent); ?><br />
    		  <?PHP If ($destination!="") { ?></p>
    		  	<p><a href="<?PHP echo lg_verify_page; ?>" title="<?PHP echo lg_phrase_logout_continue; ?>"><?PHP echo lg_phrase_logout_continue; ?></a></p>
    		  	<?PHP }else{ ?>
    		  	<p><a href="<?PHP echo lg_verify_page; ?>"><?PHP echo lg_phrase_logout_continue; ?></a></p>
  	  		  	<?PHP } ?>
  		  		</div>
    		<?PHP } ?>
  			</div>