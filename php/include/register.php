<?PHP
// $Id$
/*******************************************************************************************************************
* Page Name: Register
* Last Modification: 27 APR 2010 rdivilbiss
* Version:  alpha 0.2 Debug
* On Entry: check for SSL state
* Input   : userid, password, confirm password, email, name, website address, remember me 
* Output  : message
* On Exit : new account created, locked, account unlock token emailed to account owner
******************************************************************************************************************/

/******************************************************************************************************************
* Diminsion all page variables and initialize default values
******************************************************************************************************************/
$redirected="";
$destination="";
$password="";
$confirm="";
$passhash="";
$userid="";
$name="";
$email="";
$website="";
$news="";
$mailBody="";
if (lg_debug) { $dbMsg="DEBUG BEGIN<br />\n"; }
$ip="";
$useragent="";
$region="";
$city="";
$country="";
$dateRegistered="";
$locked="";
$dateLocked="";
$token="";
$message= "<strong>".lg_term_please_register."</strong>";

/******************************************************************************************************************
* Obtain your own public and private reCAPTCHA keys for free at http://recaptcha.net/ and enter below.
******************************************************************************************************************/
$publickey = "";
$privatekey = "";
/*****************************************************************************************************************/

if (lg_debug) {
	$dbMsg .= "Debugging Enabled<br />\n";
}

if ($_SERVER["REQUEST_METHOD"]=="GET") {
	/******************************************************************************************************************
	* Save $destination if $redirected from Login
	******************************************************************************************************************/
	$destination = getField("p,urlpath,get");
	if (lg_debug) { $dbMsg .= "METHOD GET, destination = ". $destination ."<br />\n"; }
	/******************************************************************************************************************
	* if SSL required and not using SSL, redirect to https
	******************************************************************************************************************/
	if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
		if (lg_debug) { $dbMsg .= "useSSL is true and not secure port.  Redirecting<br />\n"; }
		if (lg_debug) { $dbMsg .= "Redirect path = https://" . lg_domain . lg_loginPath . $lg_filename . "?p=". $destination . "<br />\n"; }
		header("Location: https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination);
	}
}else{
	/******************************************************************************************************************
	* The form was posted, process the form
	******************************************************************************************************************/
	if (lg_debug) { $dbMsg .=  "Form POST checktoken<br />\n"; }
	checkToken();
	if (lg_debug) { $dbMsg .=  "checktoken true. Processing form<br />\n"; }
	$message = "";
	$userid = getField("userid,safepq");
	if (lg_debug) { $dbMsg .= "userid = " . htmlentities($userid) . "<br />\n"; }
	$password = getField("password,safepq");
	if (lg_debug) { $dbMsg .= "password = " . htmlentities($password) . "<br />\n"; }
	$confirm = getField("confirm,safepq");
	if (lg_debug) { $dbMsg .= "confirm = " . htmlentities($confirm) . "<br />\n"; }
	$email = getField("email,email");
	if (lg_debug) { $dbMsg .= "email = " . htmlentities($email) . "<br />\n"; }
	$name = getField("name,name");
	if (lg_debug) { $dbMsg .= "name = " . htmlentities($name) . "<br />\n"; }
	$website = getField("website,safe");
	if (lg_debug) { $dbMsg .= "website = " . htmlentities($website) . "<br />\n"; }
	$news = getField("news,alpha");
	if ($news=="") {
		$news = "No";
		if (lg_debug) { $dbMsg .= "news = NO (empty)<br />\n"; }
	}else{
		if (lg_debug) { $dbMsg .= "news = YES<br />\n"; }
	}
	$destination = getField("destination,urlpath");
	if (lg_debug) { $dbMsg .= "destination  ". htmlentities($destination) ."<br />\n"; }
	$recaptcha_challenge_field = $_POST["recaptcha_challenge_field"];
	if (lg_debug) { $dbMsg .= "recaptcha_challenge_field  ". htmlentities($recaptcha_challenge_field) ."<br />\n"; }
	$recaptcha_response_field = getField("recaptcha_response_field,safe");
	if (lg_debug) { $dbMsg .= "recaptcha_response_field  ". htmlentities($recaptcha_response_field) ."<br />\n"; }
	$resp = recaptcha_check_answer ($privatekey,$_SERVER["REMOTE_ADDR"],$recaptcha_challenge_field,$recaptcha_response_field);
	if (!$resp->is_valid) {
		$message = lg_phrase_recaptcha_error . htmlentities($resp->error) . "<br />\n";
	}
	if ($userid=="") {
		$message .=  lg_phrase_userid_empty ."<br />\n";
	}
	if (isUser($userid) && ($userid!="")) {
		$message .= lg_phrase_userid_inuse ."<br />\n";
	}
	if ($password=="") {
		$message .=  lg_phrase_password_empty ."<br />\n";
	}
	if ($confirm=="") {
		$message .=  lg_phrase_confirm_empty . "<br />\n";
	}
	if ($email=="") {
		$message .=  lg_phrase_email_empty . "<br />\n";
	}
	if ($name=="") {
		$message .=  lg_phrase_name_empty . "<br />\n";
	}
	if (($password!="") && ($confirm!="") && ($password!=$confirm)) {
		$message .=  lg_phrase_password_nomatch_confirm . "<br />\n";
	}
	$passhash = sha1($password . $userid);
	if (lg_debug) { $dbMsg .= "pashash = " . htmlentities($passhash) . "<br />\n"; }
	if (lg_debug) { $dbMsg .= "message = " . $message; }
	if ($message=="") {
		/******************************************************************************************************************
		* if all required fields exist, create account, first initialize $dateRegistered the geo-locate the user's $ip
		******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "All required fields exist. Prepare to insert record.<br />\n"; }
		$dateRegistered = dbNow();
		if (lg_debug) { $dbMsg .= "dateRegistered = ". $dateRegistered ."<br />\n"; }
		$ip = $_SERVER["REMOTE_ADDR"];
		if (lg_debug) { $dbMsg .= "Remote Address = ". $ip ."<br />\n"; }
		$useragent = htmlentities($_SERVER["HTTP_USER_AGENT"]);
		if (lg_debug) { $dbMsg .= "useragent = ". $useragent ."<br />\n"; }
		
		
		$d = file_get_contents("http://www.ipinfodb.com/ip_query.php?ip=$ip&output=xml");
 
		//Use backup server if cannot make a connection
		if (!$d){
			$backup = file_get_contents("http://backup.ipinfodb.com/ip_query.php?ip=$ip&output=xml");
			$answer = new SimpleXMLElement($backup);
		}else{
			$answer = new SimpleXMLElement($d);
		}
 
		$country = $answer->CountryName;
		$region = $answer->RegionName;
		$city = $answer->City;
		if (lg_debug) { $dbMsg .= "country = ". $country ."<br />\n"; }
		if (lg_debug) { $dbMsg .= "region = ". $region ."<br />\n"; }
		if (lg_debug) { $dbMsg .= "city = ". $city ."<br />\n"; }

		/******************************************************************************************************************
		* Set $locked, $dateLocked and unlock $token
		******************************************************************************************************************/
		$locked="1";
		if (lg_debug) { $dbMsg .= "locked = 1<br />\n"; }
		$dateLocked = dbNow();
		if (lg_debug) { $dbMsg .= "dateLocked = ". $dateLocked ."<br />\n"; }
		$token = strtoupper(sha1(getGUID()));
		if (lg_debug) { $dbMsg .= "token = ". $token ."<br />\n"; }
		/******************************************************************************************************************
		* Write new account to user's table in database
		******************************************************************************************************************/
		addUser($dateRegistered, $userid, $passhash, $name, $email, $ip, $region, $city, $country, $useragent, $website, $news, $locked, $dateLocked, $token);
		if (lg_debug) { $dbMsg .= "Database insert occurred. Result = ". $numAffected ."<br />\n"; }

		if ($numAffected == 1) {
			/******************************************************************************************************************
			* On success, $email user the unlock $token. Copy the webmaster
			******************************************************************************************************************/
			if (lg_debug) { $dbMsg .= "Database Insert Success: Prepare e-mail.<br />\n"; }
			$message = lg_phrase_registration_success;
			
			$mailBody .= '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
			$mailBody .= '<HTML><HEAD><META http-equiv=Content-Type content="text/html; charset=us-ascii">';
			$mailBody .= '</HEAD><BODY><DIV><FONT face=Arial size=2>'. lg_term_register_confirmation .'<br><br>';
			$mailBody .= lg_term_to .' '. $name .'<br><br>';
			$mailBody .= lg_phrase_registration_mail1 .' '. lg_domain .'. '.lg_phrase_registration_mail2;
			$mailBody .= lg_phrase_registration_mail3. '.<br><br>';
			$mailBody .= '<a href="http://' . lg_domain . lg_loginPath . lg_verify_page .'?token='. $token .'&p='. $destination .'">'. lg_phrase_registration_mail4 .'</a><br><br>';
			$mailBody .= lg_phrase_registration_mail5 .lg_domain . lg_loginPath . lg_verify_page .'<br>';
			$mailBody .= lg_phrase_registration_mail6 .'.<br><br>';
			$mailBody .= $token .'<br><br>';
			$mailBody .= lg_phrase_registration_mail7 .'<br>';
			$mailBody .= lg_phrase_registration_mail8 . lg_domain . lg_loginPath . lg_register_delete_page .'?email='. $email .'">'. lg_term_remove_registration .'</a>.<br><br>';
			$mailBody .= lg_phrase_registration_mail9 . lg_domain . lg_contact_form .'">'. lg_phrase_contact_webmaster .'</a>.<br><br>';
			$mailBody .= lg_copyright .'<br>';
			$mailBody .= '</FONT></DIV></BODY></HTML>';
			if (lg_debug) { $dbMsg .= "mailBody = ". $mailBody ."<br />\n"; }
			$subject = "=?UTF-8?B?" . base64_encode(lg_phrase_user_registration) . "?=";
                        $subject1 = "=?UTF-8?B?" . base64_encode(lg_phrase_attention_webmaster .' '. lg_phrase_user_registration) . "?=";

			$headers  = "MIME-Version: 1.0\r\n";
			$headers .= "Content-type: text/html; charset=UTF-8\r\n";
			$headers .= "From: ". lg_webmaster_email ."\r\n";
			$headers .= "Reply-To: ". lg_webmaster_email ."\r\n";
			
			$result = mail($name ."<".$email.">", $subject, $mailBody, $headers);
			$result = mail(lg_webmaster_email, $subject1, $mailBody, $headers);

			if (lg_debug) { $dbMsg .= "mail sent = "& $result &"<br />\n"; }
		}else{
			$message = lg_phrase_registration_error ." ". lg_term_via_email ." ". lg_webmaster_email ." ". lg_term_or ." ". lg_term_at .'<a href="'. lg_contact_form .'">'. lg_term_contact_form .'</a>';
			if (lg_debug) { $dbMsg .= "Database Insert Failed: ". $message ."<br />\n"; }
		}
	}
}
?>