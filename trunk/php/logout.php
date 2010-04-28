<?PHP
/*******************************************************************************************************************
* Logout
* Last Modification: 27 APR 2010
* Version:  alpha 0.1b Debug
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

if (isset($_SESSION["user"])) {
	$_SESSION["user"]="";
}
if (isset($_SESSION["login"])) {
	$_SESSION["login"]="";
}
if (isset($_SESSION["name"])) {
	$_SESSION["name"]="";
}
session_destroy();
header("Location: " . lg_logged_out_page);
exit();
?>