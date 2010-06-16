<?php
// alpha 0.5a debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
            <h1><?php echo lg_term_login; ?></h1>
            <?php 
            if ((!isset($_SESSION["login"])) || ($_SESSION["login"]!=true)) { 
			?>
            <div id="message"><?php echo $message; ?></div>
              <form id="frm" method="post" action="<?php echo $lg_filename; ?>" onsubmit="return validate(this);">
                <fieldset>
                <legend><?php echo lg_term_login; ?></legend>
                <label for="userid"><?php echo lg_term_userid; ?></label><br />
                <input id="userid" name="userid" title="<?php echo lg_phrase_userid_title; ?>" type="text" size="20" maxlength="50" autocomplete="off" value="<?php echo $useridValue; ?>" />
                <span class="field_normal"><?php echo lg_term_required; ?></span><br />
                <label for="password"><?php echo lg_term_password; ?></label><br />
                <input id="password" name="password" title="<?php echo lg_phrase_password_title; ?>" type="password" size="20" maxlength="255" autocomplete="off" />
                <span class="field_normal"><?php echo lg_term_required; ?></span><br />
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
                <input type="hidden" id="destination" name="destination" value="<?php echo $destination; ?>" /><br />
                <?php writeToken(); ?>
                <input type="submit" value="<?php echo lg_login_button_text; ?>" />
                </fieldset>
              </form>
                <p><a title="<?php echo lg_term_recover_password; ?>" href="<?php echo lg_recover_passsword_page; ?>"><?php echo lg_term_recover_password; ?></a>
                &nbsp;|&nbsp;<a href="<?php echo lg_register_page; ?>" title="<?php echo lg_term_register; ?>"><?php echo lg_term_register; ?></a></p>
            <?php 
            }else{ 
            ?>
                <div id="message"><?php echo $message; ?></div>
            <?php
            }
            ?>
            </div>