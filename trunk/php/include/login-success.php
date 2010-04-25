<?PHP
/*******************************************************************************************************************
* Page Name
* Last Modification: 19 APR 2010 rdivilbiss
* Version:  alpha 0.1a Debug
* On Entry: User has just logged on
* Input   : None
* Output  : None
* On Exit : Redirected
******************************************************************************************************************/
header("Pragma: No-cache");
header("Cache-control: No-cache");
/*******************************************************************************************************************
* On login success, provide link.
*******************************************************************************************************************/
if (!$_SESSION["login"]) {
        header("Location: http://". lg_domain . lg_loginPath . lg_loginPage . "?p=" . $_SERVER["SCRIPT_NAME"]);
}
?>