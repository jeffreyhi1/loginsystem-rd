<?PHP
// $Id$
/*******************************************************************************************************************
* Page Name
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.1b debug Debug
* On Entry: User has just logged on
* Input   : None
* Output  : None
* On Exit : Redirected
******************************************************************************************************************/

/*******************************************************************************************************************
* On login success, provide link.
*******************************************************************************************************************/
if (!$_SESSION["login"]) {
        header("Location: http://". lg_domain . lg_loginPath . lg_loginPage . "?p=" . $_SERVER["SCRIPT_NAME"]);
}
?>