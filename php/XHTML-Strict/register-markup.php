			<div id="login-system">
    		<?PHP (if numAffected!=1) { ?>
    		<div id="message"><?PHP echo $message ?></div>
    		<form id="frm" method="post" action="<?PHP echo $lg_filename ?>" onsubmit="return validate(this);">
    		  <fieldset>
    		    <legend><?PHP echo lg_term_registration ?></legend>
    		    <label for="userid"><?PHP echo lg_term_userid  ?></label><br />
    		    <input id="userid" name="userid" title="<?PHP echo lg_phrase_userid_new_title ?>" type="text" size="20" maxlength="32" />
    		    <span class="field_normal"><?PHP echo lg_term_required ?></span><br />
    		    <label for="password"><?PHP echo lg_term_password  ?></label><br />
    		    <input id="password" name="password" title="<?PHP echo lg_phrase_password_new_title ?>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><?PHP echo lg_term_required ?></span><br />
    		    <label for="confirm"><?PHP echo lg_term_confirm  ?></label><br />
    		    <input id="confirm" name="confirm" title="<?PHP echo lg_phrase_confirm_title ?>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><?PHP echo lg_term_required ?></span><br />
    		    <label for="email"><?PHP echo lg_term_email  ?></label><br />
    		    <input id="email" name="email" title="<?PHP echo lg_phrase_email_title ?>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_required ?></span><br />
    		    <label for="name"><?PHP echo lg_term_name  ?></label><br />
    		    <input id="name" name="name" title="<?PHP echo lg_phrase_name_title ?>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_required ?></span><br />
    		    <label for="website"><?PHP echo lg_term_website_address  ?></label><br />
    		    <input id="website" title="<?PHP echo lg_phrase_website_title ?>" name="website" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><?PHP echo lg_term_optional ?></span><br />
    		    <label for="news"><?PHP echo lg_phrase_news  ?></label>
    		    <input id="news" name="news" type="checkbox" value="Yes" />
    		    <input type="hidden" id="destination" name="destination" value="<?PHP echo destination ?>" /><br />
    		    <?PHP writeToken() ?> <input type="submit" value="<?PHP echo lg_register_button_text  ?>" />
    		  </fieldset>
    		</form>
    		<?PHP }else{ ?>
    		<div id="registered"><p><?PHP echo lg_term_registration_thankyou ?><br /><br />
    		  <strong>User ID</strong>: <?PHP echo $userid ?><br />
    		  <strong>EMail</strong>: <?PHP echo $email ?><br />
    		  <strong>Name</strong>: <?PHP echo $name ?><br />
    		  <strong>Website</strong>: <?PHP echo $website ?><br />
    		  <strong>IP</strong>: <?PHP echo $ip ?><br />
    		  <strong>Region</strong>: <?PHP echo $region ?><br />
    		  <strong>City</strong>: <?PHP echo $city ?><br />
    		  <strong>Country</strong>: <?PHP echo $country ?><br />
    		  <strong>UserAgent</strong>: <?PHP echo $useragent ?><br />
    		  <?PHP if ($destination!="") { ?></p>
    		  	<p><a href="<?PHP echo lg_verify_page ?>" title="<?PHP echo lg_phrase_logout_continue ?>"><?PHP echo lg_phrase_logout_continue ?></a></p>
    		  	<?PHP }else{ ?>
    		  	<p><a href="<?PHP echo lg_verify_page ?>"><?PHP echo lg_phrase_logout_continue ?></a></p>
  	  		  	<?PHP } ?>
  		  		</div>
    		<?PHP } ?>
  			</div>