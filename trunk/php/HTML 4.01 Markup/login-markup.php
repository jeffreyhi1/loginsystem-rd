<?PHP
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<!-- 27 APR 2010 alpha 0.1b -->
			<div id="login-system">
            <h1><?PHP echo lg_term_login; ?></h1>
            <?PHP 
            if ((!isset($_SESSION["login"])) || ($_SESSION["login"]!=true)) { 
			?>
            <div id="message"><?PHP echo $message; ?></div>
              <form id="frm" method="post" action="<?PHP echo $lg_filename; ?>" onsubmit="return validate(this);">
                <fieldset>
                <legend><?PHP echo lg_term_login; ?></legend>
                <label for="userid"><?PHP echo lg_term_userid; ?></label><br>
                <input id="userid" name="userid" title="<?PHP echo lg_phrase_userid_title; ?>" type="text" size="20" maxlength="32" value="<?PHP echo $useridValue; ?>">
                <span class="field_normal"><?PHP echo lg_term_required; ?></span><br>
                <label for="password"><?PHP echo lg_term_password; ?></label><br>
                <input id="password" name="password" title="<?PHP echo lg_phrase_password_title; ?>" type="password" size="20" maxlength="255">
                <span class="field_normal"><?PHP echo lg_term_required; ?></span><br>
                <label for="remember"><?PHP echo lg_term_rememberme; ?></label>
                <input id="remember" name="remember" type="checkbox" value="Yes">
                <input type="hidden" id="destination" name="destination" value="<?PHP echo $destination; ?>"><br>
                <div id="remember_me_warning"><?PHP echo lg_phrase_remember_me_warning; ?></div>
                <?PHP writeTokenH(); ?>
                <input type="submit" value="<?PHP echo lg_login_button_text; ?>">
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