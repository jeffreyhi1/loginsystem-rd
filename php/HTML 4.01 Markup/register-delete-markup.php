			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
				<h1><?PHP echo lg_phrase_delete_account?></h1>
				<?PHP if ($message==lg_term_register_delete_enter_email) { ?>
					<div id="message"><?PHP echo $message?></div>
					<div id="formDiv">
						<form id="frm" method="post" action="<?PHP echo $lg_filename?>">
						<fieldset>
						  <legend><?PHP echo lg_phrase_delete_account?></legend>
						  <p><lable for="email"><?PHP echo lg_term_email?></lable><br><input type="text" id="email" name="email" size="50" maxsize="100"><br>
						  <input type="submit" value="<?PHP echo lg_term_submit?>"><?PHP echo writeTokenH();?></p>
						</fieldset>  
						</form>
				<?PHP }else{ ?>
					<div id="message"><?PHP echo $message?></div>
				<?PHP } ?>
			</div>