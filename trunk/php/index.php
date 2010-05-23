<?php
// alpha 0.5a debug
// $Id$
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/generalPurpose.php";
include "include/loginGlobals.php";
include "include/database.php";
include "include/form_token.php";

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
<title><?php echo lg_term_home; ?></title>
</head>

<body>
<?php include "include/index-markup.php"; ?>
</body>

</html>