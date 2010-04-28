<?PHP
/*******************************************************************************************************************
* Change Password
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.1b debug version
* On Entry: Verify need for SSL
* Input:    oldpassword, newpassword, confirm
* Output:   message - string variable with results
* On Exit:  Password Changed
*           Email sent to account owner
******************************************************************************************************************/

/*******************************************************************************************************************
* Must be logged in to change password. If not logged in redirect to login.asp
*******************************************************************************************************************/
$dbMsg = "";
if (lg_debug) {
	$dbMsg = "DEBUG BEGIN<br />Check for Session(login)<br />";
}
 
if ((!$_SESSION["login"]) && (lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
	if (lg_debug) { $dbMsg .= "Not loggedin, useSSL=true, not secure port: redirecting to login<br />"; }
	header("Location: https://" . lg_domain_secure . lg_loginPath . lg_loginPage ."?p=" . $_SERVER["SCRIPT_NAME"]);
}else{
	if (!$_SESSION["login"]) {
		if (lg_debug) { $dbMsg .= "Not logged in, not using SSL, redirecting to login<br />"; }
		header("Location: http://" . lg_domain . lg_loginPath . lg_loginPage ."?p=" . $_SERVER["SCRIPT_NAME"]);
	}
}

/*******************************************************************************************************************
* If SSL required and not using SSL, redirect to https
*******************************************************************************************************************/
if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
	if (lg_debug) { $dbMsg .= "Logged in, but using SSL, recalling this page secure<br />\n"; }
	if (lg_debug) { $dbMsg .= "Redirecting to: https://". lg_domain . lg_loginPath . $lg_filename."<br />\n"; }
	header("Location: https://" . lg_domain . lg_loginPath . $lg_filename);
}

/*******************************************************************************************************************
* Diminsion all page variables and initialize default values
*******************************************************************************************************************/
$name="";
$email="";
$oldpassword="";
$password="";
$newpassword="";
$confirm="";
$oldpasshash="";
$oldpasshashconfirm="";
$passhash="";
$mailBody="";
$message = lg_phrase_change_password;
if (lg_debug) { $dbMsg .= "message: ". $message ."<br />\n"; }
/*******************************************************************************************************************
* If the form was posted, process the form
*******************************************************************************************************************/
If ($_SERVER["REQUEST_METHOD"]=="POST") {
	if (lg_debug) { $dbMsg .= "METHOD POST: checkToken<br />\n"; }
	checkToken();
	if (lg_debug) { $dbMsg .= "checkToken OKAY<br />\n"; }
	$message="";
	if (lg_debug) { $dbMsg .= "message: ".$message."<br />\n"; }
	$oldpassword = getField("oldpassword,safepq");
	$newpassword = getField("password,safepq");
	$confirm = getField("confirm,safepq");
	if (lg_debug) { $dbMsg .= "Old Password: ".$oldpassword."<br />\n"; }
	if (lg_debug) { $dbMsg .= "New Password: ".$newpassword."<br />\n"; }
	if (lg_debug) { $dbMsg .= "Confirm Password: ".$confirm."<br />\n"; }
	
	if ($oldpassword=="") {
		$message .= lg_phrase_oldpassword_empty . "<br />\n";
	}
	if ($newpassword=="") {
		$message .= lg_phrase_newpassword_empty . "<br />\n";
	}
	if ($confirm=="") {
		$message .= lg_phrase_confirm_empty & "<br />\n";
	}
	if (lg_debug) { $dbMsg .= "message: " . $message . "<br />\n"; }
	/*******************************************************************************************************************
	* If all required fields exist, update database with new password hash
	*******************************************************************************************************************/
	if ($message=="") {
		if (lg_debug) { $dbMsg .= "All required fields present: Process form: Lookup old password.<br />\n"; }
		cp_getUserDetails($_SESSION["userid"], $dbResults);
		
		if (($dbResults["password"]!="") && ($dbResults["password"]!=NULL)) {
			if (lg_debug) { $dbMsg .= "Recordset not empty<br />\n"; }
			$oldpasshash = $dbResults["password"];
			$name = $dbResults["name"];
			$email = $dbResults["email"];
			if (lg_debug) { $dbMsg .= "old password = ".$oldpassword."<br />\n"; }
			if (lg_debug) { $dbMsg .= "name = ".$name."<br />\n"; }
			if (lg_debug) { $dbMsg .= "email = ".$email."<br />\n"; }
		}
		if ($newpassword==$confirm) {
			if (lg_debug) { $dbMsg .= "newpassword matches confirm password<br />\n"; }
			$oldpasshashconfirm = sha1($oldpassword . $_SESSION["userid"]);
			if (lg_debug) { $dbMsg .= "verification hash computed as: ".oldpasshashconfirm."<br />\n"; }
			if ($oldpasshashconfirm==$oldpasshash) {
				if (lg_debug) { $dbMsg .= "oldpassword hash matches stored password hash<br />\n"; }
				$passhash = sha1($newpassword . $_SESSION["userid"]);
				
				cp_changePassword($passhash, $_SESSION["userid"]);
				if (lg_debug) { $dbMsg .= "Executed change password command: numAffected = ".$numAffected."<br />"; }
				if ($numAffected==1) {
					/*******************************************************************************************************************
					* Notify account holder of password change
					*******************************************************************************************************************/
					$mailBody .= '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
					$mailBody .= '<HTML><HEAD><META http-equiv=Content-Type content="text/html; charset=UTF-8">';
					$mailBody .= '</HEAD><BODY><DIV><FONT face=Arial size=2>' . lg_term_to . ' ' . $name . '<br><br>';
					$mailBody .= lg_phrase_password_changed_pre . lg_domain . lg_phrase_password_changed_post .' '. dbNow() .'<br><br>';
					$mailBody .= lg_phrase_password_change_authorized;
					$mailBody .= lg_term_via_email .' '. lg_webmaster_email_link .' '. lg_term_immediately .'<br>';
					$mailBody .= lg_term_or .' '. lg_term_at .'&nbsp;the <a href="'. 'hhttp://'. lg_domain . lg_contact_form . '">'. lg_term_contact_form .'</a><br>';
					$mailBody .= '</FONT></DIV>';
					$mailBody .= '</div></BODY></HTML>';
					if (lg_debug) { $dbMsg .= "Sending Notification Mail To Owner<br>" . $mailBody ."<br>\n"; }
					
					$headers  = "MIME-Version: 1.0\r\n";
					$headers .= "Content-type: text/html; charset=UTF-8\r\n";
					$headers .= "From: ". lg_webmaster_email ."\r\n";
					$headers .= "Reply-To: ". lg_webmaster_email ."\r\n";
			                $subject = "=?UTF-8?B?" . base64_encode(lg_phrase_password_changed) . "?=";
                                        $subject1 = "=?UTF-8?B?" . base64_encode(lg_phrase_attention_webmaster . ' ' . lg_phrase_password_changed) . "?=";
					$result = mail($name ."<".$email.">", $subject, $mailBody, $headers);
					$result = mail(lg_webmaster_email, $subject1, $mailBody, $headers);
			
					$message = lg_phrase_password_changed;
					if (lg_debug) { $dbMsg .= "message: ".$message."<br />\n"; }
				}else{
					$message = lg_phrase_password_changed_error;
					if (lg_debug) { $dbMsg .= "message: ".$message."<br />\n"; }
				}
			}else{
				$message = lg_phrase_oldpassword_does_not_match;
				if (lg_debug) { $dbMsg .= "message: ".$message."<br />\n"; }
			}
		}else{
			$message = lg_phrase_password_nomatch_confirm;
			if (lg_debug) { $dbMsg .= "message: ".$message."<br />\n"; }
		}
	}else{
		if (lg_debug) { $dbMsg .= "NOT ALL REQUIRED FIELDS<br />\n"; }
	}
}else{
	if (lg_debug) { $dbMsg .= "REQUEST METHOD GET<br />\n"; }
}
?>