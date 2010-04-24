<?PHP
/*******************************************************************************************************************
* Register Verify
* Last Modification: 19 APR 2010
* Version:  alpha 0.1 Debug
* On Entry: 1. verification token could be passed as a URL parameter
* Input:    2. verification token could be entered as form field value
* Output:   message - string variable with results
* On Exit:  Account activated if 
******************************************************************************************************************/
header("Pragma: No-cache");
header("Cache-control: No-cache");
/*******************************************************************************************************************
* Declare all page variables and initialize default values
*******************************************************************************************************************/
$token="";
$timePassed="";
$id="";
$userid="";
$name="";
$email="";
$message = lg_phrase_registration_email_verify_msg;
$locked="";
$dateLocked="";
$ip="";
$region="";
$city="";
$country="";
$useragent="";
$destination="";
$now = dbNow();
$timePassed="";
$dbMsg="";

if (lg_debug) {
	$dbMsg .= "Debugging Enabled<br>\n";
}

/*******************************************************************************************************************
* If the token was posted in the form - get the token
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg .= "METHOD POST, Check for token.<br>\n"; }
	if (isset($_POST["token"])) {
		$token = getField("token,safe");
		if (lg_debug) { $dbMsg .= "Token: ".$token."<br>\n"; }
	}	
}else{
	/*******************************************************************************************************************
	* If the token was passed on the URL from a email link - get the token
	*******************************************************************************************************************/
	if ($_SERVER["REQUEST_METHOD"]="GET") {
		if (lg_debug) { $dbMsg .= "METHOD GET, Check for token and destination.<br>\n"; }
		if (isset($_GET["token"])) {
			$token = getField("token,safe,get");
			if (lg_debug) { $dbMsg .= "Token: ".$token."<br>\n"; }
		}
		if (isset($_GET["p"])) {	
			$destination = getField("p,urlpath,get");
			if (lg_debug) { $dbMsg .= "Destination: ".$destination."<br>\n"; }
		}	
	}
}	
/*******************************************************************************************************************
* If the token exists, process account activation
*******************************************************************************************************************/
if ($token!="") {
	if (lg_debug) { $dbMsg .= "Token not empty, ".$token." get dateLocked<br>\n"; }
	/*******************************************************************************************************************
	* Get the dateLocked and verify it is within the lifetime of the token
	*******************************************************************************************************************/
	rv_getVerificationDetails($token, $dbResults);
	$dateLocked = $dbResults["dateLocked"];
	if (lg_debug) { $dbMsg .= "dateLocked from database = ".$dateLocked."<br>\n"; }
	if (($dateLocked=="") || ($dateLocked==NULL)) { // we got no results
		$message = lg_phrase_login_token_problem;
		if (lg_debug) { $dbMsg .= "message: ".$message."<br>\n"; }
	}else{
		if (lg_debug) { $dbMsg .= "dateLocked: ".$dateLocked."<br>\n"; }
		$timePassed = intval((strtotime($now)-strtotime($dateLocked))/3600); //hours
		if (lg_debug) { $dbMsg .= "timePassed: ".$timePassed."<br>\n"; }
		if ($timePassed <=24) {
			/*******************************************************************************************************************
			* The token is good, prepare to unlock the account
			*******************************************************************************************************************/
			$id = $dbResults["id"];
			$userid = $dbResults["userid"];
			$email = $dbResults["email"];
			$locked = 0;
			$token = NULL;
			$dateLocked = NULL;
			if (lg_debug) { $dbMsg .= "Token good: Prepare to unlock account.<br>\n"; }
			if (lg_debug) { $dbMsg .= "id: ".$id."<br>\n"; }
			if (lg_debug) { $dbMsg .= "userid: ".$userid."<br>\n"; }
			if (lg_debug) { $dbMsg .= "email: ".$email."<br>\n"; }
			if (lg_debug) { $dbMsg .= "locked: ".$locked."<br>\n"; }
			if (lg_debug) { $dbMsg .= "dateLocked: ".$dateLocked."<br>\n"; }
			/*******************************************************************************************************************
			* Unlock the account - set token->Null, dateLocked->Null, locked->0
			*******************************************************************************************************************/
			unlockAccount($token, $locked, $dateLocked, $id);
			if (lg_debug) { $dbMsg .= "Unlock account: numAffected ".$numAffected."<br>\n"; }
			
			$message = "<h2>".lg_phrase_verify_verified."</h2><br><br>";
			$message .=  lg_phrase_verify_login . "<br>";
			$message .=  '<div id="details">' . lg_term_userid . ": " . $userid . "<br>";
			$message .=  lg_term_email . ": " . $email . "<br>";
			//if (lg_debug) { $dbMsg .= "message: ".$message."<br>\n"; }
			if ($destination!="") {
				if (lg_debug) { $dbMsg .= "destination not empty: ".$destination."<br>\n"; }
				$message .=  '<p><a href="'. $destination .'" title="'. lg_phrase_logout_continue .'">'. lg_phrase_logout_continue ."</a></p>";
			}
		}else{
			/*******************************************************************************************************************
			* The token has expired: show link to Issue Verification Token page
			*******************************************************************************************************************/
			if (lg_debug) { $dbMsg .= "Time passed was greater than 24 hours<br>\n"; }
			$message = "<h2>".lg_phrase_verify_expired."</h2><br><br>";
			$message .= '<a href="'.lg_new_token_page.'">'.lg_phrase_verify_newtoken.'</a>';
			//if (lg_debug) { $dbMsg .= "message: ".$message."<br>\n"; }
		}	
	}
}	
?>