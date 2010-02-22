			<div id="login-system">
			<h1><?PHP echo lg_term_reset_password ?></h1>
			<?PHP if ($_SESSION["action"]=="token") { ?>
			<div id="message"><?PHP echo $message ?></div>	
			<div id="formDiv">
			<form name="frm1" method="post" action="<?PHP echo $lg_filename ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_registration_verification ?></legend>
			  <p><lable for="resettoken"><?PHP echo lg_phrase_enter_unlock_code ?></lable><br><input type="text" id="resettoken" name="resettoken" size="50" maxsize="64"><br>
			  <input type="submit" value="<?PHP echo lg_term_submit ?>"><?PHP echo writeToken() ?><input name="changePassword" type="hidden" value=""></p>
			</fieldset>
			</form>
			</div>
			<?PHP 
			}else{
				if ($_SESSION["action"]=="password") {
			 ?>
			<div id="message"><?PHP echo $message ?></div>	
			<div id="formDiv">
			<form name="frm2" method="post" action="<?PHP echo $lg_filename ?>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><?PHP echo lg_term_set_new_password ?></legend>
			  <p><lable for="newpassword"><?PHP echo lg_term_new_password ?></lable><br><input id="newpassword" name="newpassword" type="password" size="50" maxsize="255"><br>
			  <lable for="newpassword"><?PHP echo lg_term_confirm ?></lable><br><input id="confirm" name="confirm" type="password" size="50" maxsize="255"><br>
			  <input type="submit" value="<?PHP echo lg_term_submit ?>"><?PHP echo writeToken() ?><input name="changePassword" type="hidden" value="1"><input type="hidden" name="resettoken" value="<?PHP echo $resettoken ?>"></p>
			</fieldset>
			</form>
			</div>
			<?PHP
				}else{  // must be success or error, in either case we just show a message.
			 ?>
			<div id="message"><?PHP echo $message ?></div>
			<?PHP 
				}
			} 
			?>
			</div>