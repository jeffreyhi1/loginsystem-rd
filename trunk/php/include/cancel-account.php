<?PHP
// $Id$
/*******************************************************************************************************************
* Cancel Account
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.2 Debug
* On Entry: Verify need for SSL
* Input:    userid, password
* Output:   message - string variable with results
* On Exit:  Account Deleted.
******************************************************************************************************************/

/*******************************************************************************************************************
* If SSL required and not using SSL, redirect to https
*******************************************************************************************************************/
if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
	header("Location: https://" . lg_domain . lg_loginPath . $lg_filename);
}


/*******************************************************************************************************************
* Declare all page variables and initialize default values
*******************************************************************************************************************/
$deleted = "1";
$userid = "";
$password = "";
$message = lg_term_enter_information;
$passhash = "";
$dbPasshash = "";
$dbId = "";
$dateDeleted = dbNow();

if (lg_debug) {
	$dbMsg = "DEBUG BEGIN<br />Check for Session(login)<br />";
}

/*******************************************************************************************************************
* If the form was posted, process the form
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg = "REQUEST METHO = POST, check form token<br />\n"; }
	checkToken();
	if (lg_debug) { $dbMsg = "check form token = OKAY<br />\n"; }
	$message="";
	$userid = getField("userid,safepq");
	$password = getField("password,safepq");
	if (lg_debug) { $dbMsg = "userid = ".$userid."<br />\n"; }
	if (lg_debug) { $dbMsg = "password = ".$password."<br />\n"; }
	if ($userid=="") {
		$message .= lg_phrase_userid_empty;
	}
	if ($password=="") {
		$message .= lg_phrase_password_empty;
	}
	if (lg_debug) { $dbMsg = "Should be empty: message = ".$message."<br />\n"; }
	if ($message=="") {
	    /*******************************************************************************************************************
		* If all required fields exist, begin process of deleting the account
		*******************************************************************************************************************/
		$passhash = sha1($password . $userid);
		if (lg_debug) { $dbMsg = "passhash = ".$passhash."<br />\n"; }
		/*******************************************************************************************************************
		* First, is this a valid userid and password?
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg = "Check that we have a valid userid and password<br />\n"; }
		ca_getUserDetails($userid, $dbResults);
		if (lg_debug) { $dbMsg = "ID from database = ".$dbResults["id"]."<br />\n"; }
		
		if (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
			$dbPasshash = $dbResults["password"];
			$dbId = $dbResults["id"];
			if (lg_debug) { $dbMsg = "pashhash from db = ".$dbPasshash."<br />\n"; }
			if (lg_debug) { $dbMsg = "ID from database = ".$dbId."<br />\n"; }
			
			if ($passhash==$dbPasshash) {
				/**********************************************************************************************************
				* Valid used id and password, do cancel.
				**********************************************************************************************************/
				if (lg_debug) { $dbMsg = "passhash matched database passhash: do Cancel<br />\n"; }
				ca_cancelAccount($deleted,$dateDeleted,$userid,$passhash);
				if (lg_debug) { $dbMsg = "numAffected = ".$numAffected."<br />\n"; }
				if ($numAffected==1) {
					$message .= lg_phrase_cancel_account_canceled;
					if (lg_debug) { $dbMsg = "message = ".$message."<br />\n"; }
				}else{
					$message .= lg_phrase_cancel_account_error;
					if (lg_debug) { $dbMsg = "message = ".$message."<br />\n"; }
				}
				// Eliminate any residual account information
				$_SESSION["login"]=false;
				$_SESSION["userid"]="";
				$_SESSION["name"]="";
				setcookie("token", "", time()-42000);
				setcookie("login", "", time()-42000);
			}else{
				/**********************************************************************************************************			
				* ERROR: Invalid password, show generic error message
				**********************************************************************************************************/
				$message .= lg_phrase_login_error;
				setcookie("token", "", time()-42000);
				if (lg_debug) { $dbMsg = "message = ".$message."<br />\n"; }
			}
		}else{
			/**********************************************************************************************************		
			* ERROR: Invalid userid, show generic error message
			**********************************************************************************************************/
			$message .= lg_phrase_login_error;
			setcookie("token", "", time()-42000);
			if (lg_debug) { $dbMsg = "message = ".$message."<br />\n"; }
		}
	} // if $message=="", nothing else needed...message already set.
} // if POST
?>