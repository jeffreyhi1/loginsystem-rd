<?PHP
// alpha 0.5 debug
// $Id$
?>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
				<h1><?PHP echo lg_phrase_delete_account; ?></h1>
				<?PHP if ($message==lg_term_register_delete_enter_email) { ?>
					<div id="message"><?PHP echo $message; ?></div>
					<div id="formDiv">
						<form id="frm" method="post" action="<?PHP echo $lg_filename; ?>">
						<fieldset>
						  <legend><?PHP echo lg_phrase_delete_account; ?></legend>
						  <p><lable for="email"><?PHP echo lg_term_email; ?></lable><br><input type="text" id="email" name="email" size="50" maxsize="100" value="<?php echo htmlentities($email); ?>" /><br />
						  <input type="submit" value="<?PHP echo lg_term_submit; ?>" /><?PHP writeToken();?></p>
						</fieldset>  
						</form>
				<?PHP }else{ ?>
					<div id="message"><?PHP echo $message; ?></div>
				<?PHP } ?>
			</div>