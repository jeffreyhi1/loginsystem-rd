<?php
// alpha 0.3 debug
// $Id$
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/generalPurpose.php";
include "include/form_token.php";
include "include/loginGlobals.php";
include "include/database.php";

/* You should add
* header("Pragma: No-cache");
* header("Cache-control: No-cache");
* after all PHP generated output
*/
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?php echo lg_term_xhtml_xmlns ?>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<?php echo lg_term_content_language ?>
<?php echo lg_term_language ?>
<title><?PHP echo lg_term_home; ?></title>
</head>

<body>
<?php
if ((isset($_SESSION["name"])) && (isset($_SESSION["login"])) && ($_SESSION["login"]==true)) {

	echo "<h1>".lg_term_welcome.' '.$_SESSION["name"]."</h1><br />";
	echo '<p><a href="logout.php" title="'. lg_term_log_out .'">'. lg_term_log_out .'</a></p>';
}else{
	echo '<h1>'.lg_term_welcome.' '.lg_term_guest.'</h1><p><a href="login.php" title="'.lg_term_login.'">'.lg_term_login.'</a></p>';
}
?>
<?php echo lg_phrase_default_body1 . ' ' . lg_term_project_home_link . lg_phrase_default_body2 . ' ' . lg_term_webloginproject_link . ' ' . lg_phrase_default_body3 ?>
</body>

</html>