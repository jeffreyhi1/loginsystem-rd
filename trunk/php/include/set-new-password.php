<?PHP
// alpha 0.5 debug
// $Id$
/*******************************************************************************************************************
* Page Name: Set New Password
* Last Modification: 27 APR 2010 rdivilbiss
* On Entry: Expecting reset token, account is locked
* Input   : current password, new password, confirm new password
* Output  : message
* On Exit : password changed and account unlocked
******************************************************************************************************************/

/*******************************************************************************************************************
* Declare all page variables and initialize default values
*******************************************************************************************************************/

$resettoken="";
$timePassed="";
$id="";
$userid="";
$email="";
$message = "Enter you password reset token in the field provided and press the Submit button.";
$locked="";
$dateLocked="";
$mailBody="";
$password = "";
$confirm = "";
$passhash = "";
$name="";
$now = dbNow();
$destination="";
$changePassword="";

if (lg_debug) {
	$dbMsg = "Debugging Enabled<br />\n";
}
$entropy="";
$lowLetters="";
$upLetters="";
$symbols="";
$digits="";
$totalChars="";
$lowLettersChars="";
$upLettersChars="";
$symbolChars="";
$digitChars="";
$otherChars="";


$lowLetters = "abcdefghijklmnopqrstuvwxyz";
$upLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
$symbols = "~`!@#$%^&*()-_+=";
$digits = "1234567890";

$totalChars = 95;
$lowLettersChars = strlen($lowLetters);
$upLettersChars = strlen($upLetters);
$symbolChars = strlen($symbols);
$digitChars = strlen($digits);
$otherChars = $totalChars - ($lowLettersChars + $upLettersChars + $symbolChars + $digitChars);

function getEntropy($pPass) {
	global $lowLetters;
	global $upLetters;
	global $symbols;
	global $digits;
	global $totalChars;
	global $lowLettersChars;
	global $upLettersChars;
	global $symbolChars;
	global $digitChars;
	global $otherChars;
	$hasLower="";
	$hasUpper="";
	$hasSymbol="";
	$hasDigit="";
	$hasOther="";
	$idx="";
	$char="";
	$bits="";
	$match="";
	$domain="";

    if (strlen($pPass) < 0) {
        return 0;
    }else{
    	$hasLower = false;
    	$hasUpper = false;
    	$hasSymbol = false;
    	$hasDigit = false;
    	$hasOther = false;
    	$domain = 0;
		
    	for ($idx=0; $idx < strlen($pPass); $idx++) {
        	$char = substr($pPass,$idx,1);
			$match = "";

        	if (strpos($lowLetters,$char)!==false) {
            	$hasLower = true;
            	$match = true;
            }	
            if (strpos($upLetters,$char)!==false) {
            	$hasUpper = true;
            	$match = true;
            }
            if (strpos($digits,$char)!==false) {
            	$hasDigit = true;
            	$match = true;
            }
            if (strpos($symbols,$char)!==false) {
            	$hasSymbol = true;
            	$match = true;
            }
            if ($match=="") {
            	$hasOther = true;
            }            
		}
		   
	    if ($hasLower) {
        	$domain += $lowLettersChars;
        }
    	if ($hasUpper) {
        	$domain += $upLettersChars;
    	}
    	if ($hasDigit) {
        	$domain += $digitChars;
    	}
    	if ($hasSymbol) {
        	$domain += $symbolChars;
    	}
    	if ($hasOther) {
        	$domain += $otherChars;
        }
        
        $bits = floor(log($domain) * (strlen($pPass))/log(2));	
    	return $bits;
    }
}

/*******************************************************************************************************************
* If the resettoken was posted in the form - get the resettoken
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg .= "METHOD POST: checking form token.<br />\n"; }
	checkToken();
	if (lg_debug) { $dbMsg .= "Form token checked OKAY<br />\n"; }
	$resettoken = getField("resettoken,safepq");
	if (lg_debug) { $dbMsg .= "Reset token = " . htmlentities($resettoken) . "<br />\n"; }
	if (lg_debug) { $dbMsg .= "Session action = " . htmlentities($_SESSION["action"]) . "<br />\n"; }
	if ($_SESSION["action"]=="password") {
		if (lg_debug) { $dbMsg .= "Session action = " . htmlentities($_SESSION["action"]) . "<br />\n"; }
		if (isset($_POST["password"])) {
			$password = substr($_POST["password"],0,255);
		}
		if (isset($_POST["confirm"])) {
			$confirm = substr($_POST["confirm"],0,255);
		}	
		$changePassword = getField("changePassword,rXint");
		if (lg_debug) { $dbMsg .= "New password = " . htmlentities($password) . "<br />\n"; }
		if (lg_debug) { $dbMsg .= "Confirm password = " . htmlentities($confirm) . "<br />\n"; }
		if (lg_debug) { $dbMsg .= "Change password = " . htmlentities($changePassword) . "<br />\n"; }
	}else{
		if ($resettoken=="") {
			$_SESSION["action"] = "token";
		}else{	
			$_SESSION["action"] = "resettoken";
		}	
		if (lg_debug) { $dbMsg .= "Session action = " . htmlentities($_SESSION["action"]) . "<br />\n"; }
	}
}
/*******************************************************************************************************************
* If the token was passed on the URL from a email link - get the token
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="GET") {
	if (lg_debug) { $dbMsg .= "REQUEST METHOD = GET<br />\n"; }
	$resettoken = getField("resettoken,safepg,get");
	$destination = getField("p,urlpath,get");
	$_SESSION["action"] = "resettoken";
	if (lg_debug) { $dbMsg .= "Reset token = " . htmlentities($resettoken) . "<br />\n"; }
	if (lg_debug) { $dbMsg .= "Destination = " . htmlentities($destination) . "<br />\n"; }
	if (lg_debug) { $dbMsg .= "Session action = " . htmlentities($_SESSION["action"]) . "<br />\n"; }
	if (($resettoken=="") OR (!isset($_GET["resettoken"]))) {
		$_SESSION["action"] = "token";
	}else{
		$_SESSION["action"] = "resettoken";
	}
}

/*******************************************************************************************************************
* If the token exists, process account activation
*******************************************************************************************************************/
if (($resettoken!="") && ($_SESSION["action"]=="resettoken")) {
	if (lg_debug) { $dbMsg .= "Reset Token not empty and $_SESSION action=resettoken<br />\n"; }
	/*******************************************************************************************************************
	* Get the dateLocked and verify it is within the lifetime of the token
	*******************************************************************************************************************/
	snp_selectTokenDetails($resettoken, $dbResults);
	if (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
		if (lg_debug) { $dbMsg .= "Returned record(s)<br />\n"; }
		$id = $dbResults["id"];
		$dateLocked = $dbResults["dateLocked"];
		if (lg_debug) { $dbMsg .= "dateLocked = ". htmlentities($dateLocked) ."<br />\n"; }
		$timePassed = intval((strtotime($now)-strtotime($dateLocked))/3600); //hours
		if (lg_debug) { $dbMsg .= "timePassed: ".$timePassed."<br />\n"; }

		if ($timePassed <=24) {
			/*******************************************************************************************************************
			* The token is good, prepare to change password
			*******************************************************************************************************************/
			if (lg_debug) { $dbMsg .= "TimePassed &lt; 24 hours: Prepare to change password.<br />\n"; }
			$message = lg_phrase_set_new_password_good_token;
			if (lg_debug) { $dbMsg .= "message = ". $message ."<br />\n"; }
			$_SESSION["action"]="password";
			if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
		}else{
			/*******************************************************************************************************************
			* The token has expired: show link to Issue Verification Token page
			*******************************************************************************************************************/
			$message = "<h2>" . lg_phrase_set_new_password_token_expired . "</h2><br /><br />";
			$message .= lg_phrase_contact_webmaster1 . " " . lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
			$_SESSION["action"]="Error";
			if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
			if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
		}
	}else{
		$message = lg_phrase_set_new_password_error . "Error 3A. " . lg_phrase_contact_webmaster1 . "<br />\n";
		$message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
		$_SESSION["action"]="Error";
		if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
		if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
	}
}else{
	if ($changePassword=="1") {
		if (lg_debug) { $dbMsg .= "Change Password = 1<br />\n"; }
		$message = "";
		if ($password=="") {
			$message .= lg_phrase_newpassword_empty . "<br />\n";
			if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
		}
		if ($confirm=="") {
			$message .= lg_phrase_confirm_empty . "<br />\n";
			if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
		}
		if ($password!=$confirm) {
			$message .= lg_phrase_password_nomatch_confirm;
			if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
		}
		if ($password!="") {
			$entropy = getEntropy($password);
			if (lg_debug) { $dbMsg .= "ENTROPY = ". $entropy ."<br />\n"; }
			if ((lg_password_min_bits > 0) AND ($entropy < lg_password_min_bits}) {
				$message .= lg_phrase_password_too_simple . "<br>\n";
				if (lg_debug) { $dbMsg .= "message = ". $message ."<br />\n"; }
			}elseif{ ((lg_password_min_length > 0) AND (strlen($password) < lg_password_min_length) AND (lg_password_min_bits < 1)) {
				$message .= lg_phrase_password_too_short_pre . " " . lg_password_min_length . " " . lg_phrase_password_too_short_post . "<br>\n";
				if (lg_debug) { $dbMsg .= "message = ". $message ."<br />\n"; }
			}
		}		
		if ($resettoken=="") {
			 $message .= lg_phrase_set_new_password_error . "Error 1. " . lg_phrase_contact_webmaster1 ."<br />";
			 $message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
			 $_SESSION["action"]="Error";
			 if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
			 if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
		}
		if (lg_debug) { $dbMsg .= "Should be empty: message = " . $message . "<br />\n"; }
		if ($message=="") {
			snp_selectUserDetails($resettoken, $dbResults);
			if (lg_debug) { $dbMsg .= "ID from database".$dbResults["id"]."<br />\n"; }
			
			if (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
				if (lg_debug) { $dbMsg .= "Returned record(s)<br />\n"; }
				$dateLocked = $dbResults["dateLocked"];
				if (lg_debug) { $dbMsg .= "dateLocked = ". htmlentities($dateLocked) ."<br />\n"; }
				$timePassed = intval((strtotime($now)-strtotime($dateLocked))/3600); //hours
				if (lg_debug) { $dbMsg .= "timePassed = ".$timePassed."<br />\n"; }

				if ($timePassed <=24) {
					/*******************************************************************************************************************
					* The token is good, change passord and unlock the account
					*******************************************************************************************************************/
					if (lg_debug) { $dbMsg .= "Time passed &lt; 24 Hours::Token Good, Change Password & Unlock The Account<br />\n"; }
					$id = $dbResults["id"];
					$userid = $dbResults["userid"];
					$email = $dbResults["email"];
					$name = $dbResults["name"];
					$locked = $dbResults["locked"];
					if (lg_debug) { $dbMsg = "id = ". htmlentities($id) ."<br />\n"; }
					if (lg_debug) { $dbMsg = "userid = ". htmlentities($userid) ."<br />\n"; }
					if (lg_debug) { $dbMsg = "email = ". htmlentities($email) ."<br />\n"; }
					if (lg_debug) { $dbMsg = "name = ". htmlentities($name) ."<br />\n"; }
					if (lg_debug) { $dbMsg = "locked = ". htmlentities($locked) ."<br />\n"; }

					$passhash = sha1($password . $userid);
					if (lg_debug) { $dbMsg = "Passhash = ". $passhash ."<br />\n"; }
					$resettoken = NULL;
					$locked = "0";
					$dateLocked = NULL;
					
					snp_setNewPassword($passhash, $resettoken, $locked, $dateLocked, $id);
					if (lg_debug) { $dbMsg = "numAffected = ". htmlentities($numAffected) ."<br />\n"; }
					
					if ($numAffected==1) {
						$message = lg_phrase_set_new_password_success;
						if (lg_debug) { $dbMsg .= "message = ". $message . "<br />\n"; }
						$_SESSION["action"]="Success";
						if (lg_debug) { $dbMsg .= "Session action = ".$_SESSION["action"]."<br />\n"; }
						/*******************************************************************************************************************
						* Notify account holder of password change
						*******************************************************************************************************************/
						$mailBody .= '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
						$mailBody .= '<HTML><HEAD><META http-equiv=Content-Type content="text/html; charset=UTF-8">';
						$mailBody .= '</HEAD><BODY><DIV><FONT face=Arial size=2>'. lg_phrase_password_changed_pre . lg_domain . lg_phrase_password_changed_post .' '. $now .'<br><br>';
						$mailBody .= lg_phrase_password_change_authorized;
						$mailBody .= lg_term_via_email .' '. lg_webmaster_email_link .' '. lg_term_immediately . '<br>';
						$mailBody .= lg_term_or .' '. lg_term_at .'&nbsp;the <a href="'. lg_contact_form .'">' . lg_term_contact_form . '</a><br>';
						$mailBody .= '</FONT></DIV>';
						$mailBody .= '</div></BODY></HTML>';
						
						$headers  = "MIME-Version: 1.0\r\n";
						$headers .= "Content-type: text/html; charset=UTF-8\r\n";
						$headers .= "From: ". lg_webmaster_email ."\r\n";
						$headers .= "Reply-To: ". lg_webmaster_email ."\r\n";
			
						$result = mail($name ."<".$email.">", lg_phrase_password_changed, $mailBody, $headers);
						$result = mail(lg_webmaster_email, "WEBMASTER NOTICE: ".lg_phrase_password_changed, $mailBody, $headers);
						
						if (lg_debug) { $dbMsg ."Sent Mail Notification<br />" . $mailBody . "<br />\n"; }
					}else{
						$message = lg_phrase_set_new_password_error . "Error 2. " . lg_phrase_contact_webmaster1 ."<br />";
				 		$message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
						$_SESSION["action"]="Error";
						if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
			 			if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
					}
				}else{
					$message .= "<h2>". lg_phrase_verify_expired ."</h2><br />". lg_phrase_contact_webmaster1 ."<br />";
					$message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
					$_SESSION["action"]="Error";
					if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
			 		if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
				}
			}else{
				$message = lg_phrase_set_new_password_error . "Error 3. " . lg_phrase_contact_webmaster1 ."<br />";
				$message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
				$_SESSION["action"]="Error";
				if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
			 	if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
			}
		}else{
			$message = lg_phrase_set_new_password_error . "Error 4. " . lg_phrase_contact_webmaster1 ."<br />";
			$message .= lg_phrase_webmaster_may_be_contacted . lg_webmaster_email_link;
			$_SESSION["action"]="Error";
			if (lg_debug) { $dbMsg .= "message = " . $message . "<br />\n"; }
			if (lg_debug) { $dbMsg .= "Session action = " . $_SESSION["action"] . "<br />\n"; }
		}
	}else{
		$_SESSION["action"]="token";
	}
}
?>