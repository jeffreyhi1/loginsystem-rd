<?php
// alpha 0.5 debug
// $Id$
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/generalPurpose.php";
include "include/loginGlobals.php";
include "include/database.php";
include "include/form_token.php";
include "include/recover-password.php";

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
<title><?PHP echo lg_term_recover_password; ?></title>
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="© 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>
<?PHP include "include/recover-password-markup.php"; ?>
<?PHP if (lg_debug) { echo "<p>". $dbMsg . "</p>"; } ?>
</body>
</html>