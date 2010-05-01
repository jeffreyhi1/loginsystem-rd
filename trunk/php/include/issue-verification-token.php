<?PHP
// $Id$
/*******************************************************************************************************************
* Page Name: Issue Verification Token
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.1c debug Debug
* On Entry: Check SSL State
* Input   : userid, email
* Output  : message
* On Exit : email sent to account owner with password reset token, account locked
'******************************************************************************************************************

/*******************************************************************************************************************
* If SSL required and not using SSL, redirect to https
*******************************************************************************************************************/
if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]==0)) {
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
$token="";
$dateLocked="";
$mailBody="";
$message = lg_phrase_issue_new_token;
$name="";

if (lg_debug) {
	$dbMsg .= "Debugging Enabled<br />\n";
}


/*******************************************************************************************************************
* If the form was posted, process the form
*******************************************************************************************************************/
if ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg .= "METHOD POST<br />\n"; }
	$message="";
	$userid = getField("userid,safepq");
	$email = getField("email,email");
	if (lg_debug) { $dbMsg .= "Userid = ".$userid."<br />\n"; }
	if (lg_debug) { $dbMsg .= "Email = ".$email."<br />\n"; }
	
	/*****************************************************************************
	* Check for required fields
	*****************************************************************************/
	if ($userid=="") {
		$message = lg_phrase_userid_empty;
	}
	if ($email=="") {
		$message = lg_phrase_email_empty;
	}
	if ($message=="") {
		/*******************************************************************************************************************
		* If all required fields exist, verify there is a valid account and it is locked
		* The account is locked when a peron registers. The account must still be locked in order to
		* receive a new verification token.
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "All fields present: Process form<br />\n"; }
		ivt_selectUser($userid,$email,$dbResults);
		if (lg_debug) { $dbMsg .= "ID from database: (did we get records) -".$dbResults["id"]."-<br />\n"; }
		if (($dbResults["id"]!="") && ($dbResults["id"]!=NULL)) {
			$id = $dbResults["id"];
			$locked = $dbResults["locked"];
			$name = $dbResults["name"];
			if (lg_debug) { $dbMsg .= "ID = ".$id."<br />\n"; }
			if (lg_debug) { $dbMsg .= "Locked = ".$locked."<br />\n"; }
			if (lg_debug) { $dbMsg .= "Name = ".$name."<br />\n"; }
			
			if ($locked!="1") {
				/*****************************************************************************
				* The account was not locked. Can not issue a token.
				*****************************************************************************/
				$message = lg_phrase_issue_new_token_error . " 1";
				if (lg_debug) { $dbMsg .= "Message: ".$message."<br />\n"; }
			}
		}else{
			/*****************************************************************************
			* No account matching the posted information
			*****************************************************************************/
			$message = lg_phrase_no_matching_registration;
			if (lg_debug) { $dbMsg .= "Message: ".$message."<br />\n"; }
		}
	}
	if ($message=="") {
		/*******************************************************************************************************************
		* We have a valid, locked account, issue a new token and update the user table
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Valid, locked account: Issue Token<br />\n"; }
		$locked="1";
		$dateLocked = dbNow();
		$token = sha1(getGUID());
		if (lg_debug) { $dbMsg .= "Locked = ".$locked."<br />\n"; }
		if (lg_debug) { $dbMsg .= "dateLocked = ".$dateLocked."<br />\n"; }
		if (lg_debug) { $dbMsg .= "Token = ".$token."<br />\n"; }
		
		ivt_issueToken($token,$locked,$dateLocked,$id);
		if (lg_debug) { $dbMsg = "numAffected = ".$numAffected."<br />\n"; }
		if ($numAffected==1) {
			/*******************************************************************************************************************
			* We updated the record, so send verification email with new account unlock token to user
			*******************************************************************************************************************/
			$message = lg_phrase_issue_new_token_success;
			if (lg_debug) { $dbMsg .= "Message: ".$message."<br />\n"; }
			
			$mailBody .= '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
			$mailBody .= '<HTML><HEAD><META http-equiv=Content-Type content="text/html; charset=UTF-8">';
			$mailBody .= '</HEAD><BODY><DIV><FONT face=Arial size=2>'. lg_phrase_registration_mail0 .'<br><br>';
			$mailBody .= lg_term_to . ' ' . $name . '<br><br>';
			$mailBody .= lg_phrase_registration_mail1 .' '. lg_domain .'. '. lg_phrase_registration_mail2 . '<br>';
			$mailBody .= lg_phrase_registration_mail3 . '.<br><br>';
			$mailBody .= '<a href="http://'. lg_domain . lg_loginPath . lg_verify_page .'?token='. $token .'&id=1">'. lg_phrase_registration_mail4 .'</a><br><br>';
			$mailBody .= lg_phrase_registration_mail5 . lg_domain . lg_loginPath . lg_verify_page .'<br>';
			$mailBody .= lg_phrase_registration_mail6 . '<br><br>';
			$mailBody .= $token . '<br><br>';
			$mailBody .= lg_phrase_registration_mail7 . '<br>';
			$mailBody .= 'this link: <a href="http://' . lg_domain . lg_loginPath . lg_register_delete_page . '?email='. $email .'">'. lg_term_remove_registration .'</a><br><br>';
			$mailBody .= lg_phrase_registration_mail9 . lg_domain . lg_loginPath . lg_contact_form . '">'. lg_phrase_contact_webmaster .'</a><br><br>';
			$mailBody .= lg_copyright .'<br>';
			$mailBody .= '</FONT></DIV></BODY></HTML>';
			if (lg_debug) { $dbMsg .= "MailBody = ".$mailBody."<br />\n"; }
			$subject = "=?UTF-8?B?" . base64_encode(lg_term_registration_newtoken) . "?=";

			$headers  = "MIME-Version: 1.0\r\n";
			$headers .= "Content-type: text/html; charset=UTF-8\r\n";
			$headers .= "From: ". lg_webmaster_email ."\r\n";
			$headers .= "Reply-To: ". lg_webmaster_email ."\r\n";
			
			$result = mail($name ."<".$email.">", $subject, $mailBody, $headers);
			$result = mail(lg_webmaster_email, "WEBMASTER NOTICE: ".$subject, $mailBody, $headers);
		}else{
			/*****************************************************************************
			* There was an error updating the record and no new token was issued.
			*****************************************************************************/
			$message = lg_phrase_issue_new_token_error . " 2";
			if (lg_debug) { $dbMsg .= "Message: ".$message."<br />\n"; }
		}
	}
}
?>