<?PHP
// alpha 0.5 debug
// $Id$
/*******************************************************************************************************************
* Page Name
* Last Modification: 27 APR 2010 rdivilbiss
* On Entry: email passed as URL parameter
* Input   : email address
* Output  : message
* On Exit : account marked as deleted in users table
******************************************************************************************************************/

/*******************************************************************************************************************
* Diminsion all page variables and initialize default values
*******************************************************************************************************************/

$token="";
$cmdTxt="";
$timePassed="";
$id="";
$userid="";
$name="";
$email="";
$message="";
$locked="";
$dateLocked="";
$ip="";
$region="";
$city="";
$country="";
$dbMsg="";

if (lg_debug) {
	$dbMsg .= "Debugging Enabled<br>\n";
}

/*******************************************************************************************************************
* If the form was posted, process the form which is just to get the email address
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg .= "METHOD POST, checkToken<br>\n"; }
	checkToken();
	if (lg_debug) { $dbMsg .= "checkToken OKAY<br>\n"; }
	$email = getField("email,email");
	if (lg_debug) { $dbMsg .= "email = ".$email."<br>\n"; }
}else{
	/*******************************************************************************************************************
	* If the email was passed on the URL via a link from the email get the email address
	*******************************************************************************************************************/
	if ($_SERVER["REQUEST_METHOD"]=="GET") {
		$email = getField("email,email,get");
		if (lg_debug) { $dbMsg .= "email = ".$email."<br>\n"; }
	}
}
/*******************************************************************************************************************
* If we have the email address, delete the account. First get the record matching the email
*******************************************************************************************************************/
If ($email!="") {
	if (lg_debug) { $dbMsg .= "email is not empty, get info to delete the account<br>\n"; }
	rd_selectUserDetails($email, $dbResults);
	if (lg_debug) { $dbMsg .= "id from database = -".$dbResults["id"]."-<br>\n"; }
	if (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
		$id = $dbResults["id"];
		$token = $dbResults["token"];
		if (lg_debug) { $dbMsg .= "token from database = -".$dbResults["token"]."-<br>\n"; }
		if ($token!="") {
			/*******************************************************************************************************************
			* If the account was already activated, the token will be empty and the account 
			* will not be deleted. If the token is not empty, delete the record
			*******************************************************************************************************************/
			if (lg_debug) { $dbMsg .= "Token was empty: delete record.<br>\n"; }
			rd_deleteUser($id);
			// none of these should be set
			if (isset($_SESSION["login"])) {
				$_SESSION["login"]=false;
			}
			if (isset($_SESSION["userid"])) {	
				$_SESSION["userid"]="";
			}
			if (isset($_SESSION["name"])) {
				$_SESSION["name"]="";
			}
			setcookie("token", "", time()-42000);
			setcookie("login", "", time()-42000);
			$message = "<h2>".lg_phrase_delete_deleted."</h2>";
		}else{
			/*******************************************************************************************************************
			* If the account was activated, notify the user the account will not be deleted
			*******************************************************************************************************************/
			$message = "<h2>".lg_phrase_delete_already_verified."</h2><br /><br />";
			$message .= "If you wish to cancel the account use the account<br />";
			$message .= 'cancellation page at <a href="'.lg_cancel_account_page.'">'.lg_term_cancel_account.'</a>';
			if (lg_debug) { $dbMsg .= "Message = ".$message."<br>\n"; }
			setcookie("token", "", time()-42000);
		}
	}else{
		$message = lg_phrase_register_delete_noemail;
		if (lg_debug) { $dbMsg .= "Message = ".$message."<br>\n"; }
		setcookie("token", "", time()-42000);
	}
}else{
	$message = lg_term_register_delete_enter_email;
	if (lg_debug) { $dbMsg .= "Message = ".$message."<br>\n"; }
	setcookie("token", "", time()-42000);
}
?>