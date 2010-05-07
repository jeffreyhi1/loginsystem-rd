<?php
// alpha 0.2 debug
// $Id$
/*******************************************************************************************************************
* Page Name: Logout
* On Entry: N/A
* Input:    Session
* Output:   N/A
* On Exit:  Session Abandoned - Cookies Overwritten - Redirected to Logged Out
******************************************************************************************************************/
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/loginGlobals.php";

setcookie ("user", "", time() - 3600);
setcookie ("token", "", time() - 3600);

if (isset($_SESSION["user"])) {
	$_SESSION["user"]="";
}

if (isset($_SESSION["name"])) {
	$_SESSION["name"]="";
}
session_destroy();
header("Location: " . lg_logged_out_page);
exit();
?>