<?php
// alpha 0.5 debug
// $Id$
?>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">
				<h1><?php echo lg_phrase_delete_account; ?></h1>
				<?php if ($message==lg_term_register_delete_enter_email) { ?>
					<div id="message"><?php echo $message; ?></div>
					<div id="formDiv">
						<form id="frm" method="post" action="<?php echo $lg_filename; ?>">
						<fieldset>
						  <legend><?php echo lg_phrase_delete_account; ?></legend>
						  <p><lable for="email"><?php echo lg_term_email; ?></lable><br><input type="text" id="email" name="email" size="50" maxsize="100" value="<?php echo htmlentities($email); ?>"><br>
						  <input type="submit" value="<?php echo lg_term_submit; ?>"><?php writeTokenH();?></p>
						</fieldset>  
						</form>
				<?php }else{ ?>
					<div id="message"><?php echo $message; ?></div>
				<?php } ?>
			</div>