<?PHP
// $Id$
/*******************************************************************************************************************
* Page Name: Recover Password
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.1b debug Debug
* On Entry: check SSL state
* Input   : userid, email
* Output  : message
* On Exit : mail sent to account owner with password reset token
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

$userid="";
$name="";
$email="";
$id="";
$locked="";
$resettoken="";
$dateLocked="";
$mailBody="";
$message = lg_phrase_recover_password;

if (lg_debug) {
	$dbMsg .= "Debugging Enabled<br />\n";
}

/*******************************************************************************************************************
* If the form was posted, process the form
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	$message="";
	$userid = getField("userid,safepq");
	$email = getField("email,email");
	if ($userid=="") {
		$message = lg_phrase_userid_empty;
	}
	if ($email=="") {
		$message = lg_phrase_email_empty;
	}
	if (lg_debug) { $dbMsg .= "userid = ".$userid."<br />\n"; }
	if (lg_debug) { $dbMsg .= "email = ".$email."<br />\n"; }
	if (lg_debug) { $dbMsg .= "message = " .$message. "<br />\n"; }
	if ($message=="") {
		/*******************************************************************************************************************
		* If all required fields exist, verify there is a valid account and it is locked
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "message = ".$message.". All fields exist, verify account.<br />\n"; }
		rp_selectUserDetails($userid, $email, $dbResults);
		If (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
			if (lg_debug) { $dbMsg = "Returned Records<br />\n"; }
			$id = $dbResults["id"];
			$locked = $dbResults["locked"];
			$name = $dbResults["name"];
			if (lg_debug) { $dbMsg .= "id = " .$id. "<br />\n"; }
			if (lg_debug) { $dbMsg .= "locked = " .$locked. "<br />\n"; }
			if (lg_debug) { $dbMsg .= "name = " .$name. "<br />\n"; }
			if ($locked=="1") { // This account is locked; the user must contact the webmaster.
				$message = lg_phrase_recover_password_error & " 1";
				if (lg_debug) { $dbMsg .= "message = " .$message. "<br />\n"; }
			}
		}else{
			$message = lg_phrase_no_matching_registration;
			if (lg_debug) { $dbMsg .= "message = " .$message. "<br />\n"; }
		}
	}
	if ($message=="") {
		/*******************************************************************************************************************
		* We have a valid, locked account, issue a new token and update the user table
		*******************************************************************************************************************/
		$locked="1";
		$dateLocked = dbNow();
		$resettoken = sha1(getGUID());
		if (lg_debug) { $dbMsg .= "locked = " .$locked. "<br />\n"; }
		if (lg_debug) { $dbMsg .= "dateLocked = " .$dateLocked. "<br />\n"; }
		if (lg_debug) { $dbMsg .= "resettoken = " .$resettoken. "<br />\n"; }
			
		rp_issueToken($resettoken, $locked, $dateLocked, $id);
		if (lg_debug) { $dbMsg .= "numAffected = " .$numAffected. "<br />\n"; }
		if ($numAffected==1) {
			/*******************************************************************************************************************
			* Send verification email with new account unlock token to user
			******************************************************************************************************************/
			$message = lg_phrase_recover_password_success;
			if (lg_debug) { $dbMsg .= "message = " .$message. "<br />\n"; }
			
			$mailBody .= '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
			$mailBody .= '<HTML><HEAD><META http-equiv=Content-Type content="text/html; charset=UTF-8">';
			$mailBody .= '</HEAD><BODY><DIV><FONT face=Arial size=2>'. lg_phrase_recover_password .'<br><br>';
			$mailBody .= lg_term_to . $name . '<br><br>';
			$mailBody .= lg_phrase_request_password1 .' '. lg_domain .'. <br>';
			$mailBody .= lg_phrase_recover_password2 . '<br><br>';
			$mailBody .= '<a href="http://'. lg_domain . lg_loginPath . lg_set_new_password_page .'?resettoken='. $resettoken .'&id=1">'. lg_phrase_recover_password3 .'</a><br><br>';
			$mailBody .= lg_phrase_registration_mail5 . lg_domain . lg_loginPath . lg_set_new_password_page .'<br>';
			$mailBody .= lg_phrase_registration_mail6 . '<br><br>';
			$mailBody .= $resettoken . '<br><br>';
			$mailBody .= lg_phrase_recover_password4 .'<br>';
			$mailBody .= lg_phrase_recover_password5 . lg_webmaster_email_link .'<br><br>';
			$mailBody .= lg_copyright .'<br>';
			$mailBody .= '</FONT></DIV></BODY></HTML>';
			$subject = "=?UTF-8?B?" . base64_encode(lg_phrase_recover_password) . "?=";

			$headers  = "MIME-Version: 1.0\r\n";
			$headers .= "Content-type: text/html; charset=UTF-8\r\n";
			$headers .= "From: ". lg_webmaster_email ."\r\n";
			$headers .= "Reply-To: ". lg_webmaster_email ."\r\n";
			
			$result = mail($name ."<".$email.">", $subject, $mailBody, $headers);
			$result = mail(lg_webmaster_email, "WEBMASTER NOTICE: ".$subject, $mailBody, $headers);
		}else{
			$message = lg_phrase_recover_password_error . " 2";
			if (lg_debug) { $dbMsg .= "message = " .$message. "<br />\n"; }
		}
	}
}
?>