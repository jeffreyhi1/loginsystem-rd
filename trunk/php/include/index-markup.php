<?php
// alpha 0.5 debug
// $Id: index-markup.php 322 2010-05-14 06:57:53Z rdivilbiss $
?>
if ((isset($_SESSION["name"])) && (isset($_SESSION["login"])) && ($_SESSION["login"]==true)) {

	echo "<h1>".lg_term_welcome.' '.$_SESSION["name"]."</h1><br />";
	echo '<p><a href="'. lg_logout_page .'" title="'. lg_term_log_out .'">'. lg_term_log_out .'</a>&nbsp;<a href="'. lg_change_password_page .'">'. lg_term_change_password .'</a>&nbsp;<a href="'. lg_cancel_account_page .'">'. lg_term_cancel_account .'</a></p>';
}else{
	echo '<h1>'.lg_term_welcome.' '.lg_term_guest.'</h1><p><a href="'. lg_loginPage .'" title="'.lg_term_login.'">'.lg_term_login.'</a></p>';
}
?>
<?php echo lg_phrase_default_body1 . ' ' . lg_term_project_home_link . lg_phrase_default_body2 . ' ' . lg_term_webloginproject_link . ' ' . lg_phrase_default_body3 ?>