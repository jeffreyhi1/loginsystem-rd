<?PHP
// alpha 0.5 debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
            <h1><?PHP echo lg_term_login; ?></h1>
            <?PHP 
            if ((!isset($_SESSION["login"])) || ($_SESSION["login"]!=true)) { 
			?>
            <div id="message"><?PHP echo $message; ?></div>
              <form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
                <fieldset>
                <legend><?PHP echo lg_term_login; ?></legend>
                <label for="userid"><?PHP echo lg_term_userid; ?></label><br />
                <input id="userid" name="userid" title="<?PHP echo lg_phrase_userid_title; ?>" type="text" size="20" maxlength="50" value="<?PHP echo $useridValue; ?>" />
                <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
                <label for="password"><?PHP echo lg_term_password; ?></label><br />
                <input id="password" name="password" title="<?PHP echo lg_phrase_password_title; ?>" type="password" size="20" maxlength="255" />
                <span class="field_normal"><?PHP echo lg_term_required; ?></span><br />
				<?php 
				if (lg_term_remember) {
                	echo '<label for="remember">' . lg_term_rememberme . '</label>';
                	echo '<input id="remember" name="remember" type="checkbox" value="Yes"';
                	if ($remember=="Yes") {
                		echo " checked";
                	}
                	echo " /><br />";
                	echo '<div id="remember_me_warning">' . lg_phrase_remember_me_warning . '</div>';
                }
                ?>
                <input type="hidden" id="destination" name="destination" value="<?PHP echo $destination; ?>" /><br />
                <?PHP writeToken(); ?>
                <input type="submit" value="<?PHP echo lg_login_button_text; ?>" />
                </fieldset>
              </form>
                <p><a title="<?PHP echo lg_term_recover_password; ?>" href="<?PHP echo lg_recover_passsword_page; ?>"><?PHP echo lg_term_recover_password; ?></a>
                &nbsp;|&nbsp;<a href="<?PHP echo lg_register_page; ?>" title="<?PHP echo lg_term_register; ?>"><?PHP echo lg_term_register; ?></a></p>
            <?PHP 
            }else{ 
            ?>
                <div id="message"><?PHP echo $message; ?></div>
            <?PHP
            }
            ?>
            </div>