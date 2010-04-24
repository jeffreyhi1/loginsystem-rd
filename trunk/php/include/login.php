<?PHP
/*******************************************************************************************************************
* Page Name: Login
* Last Modification: 19 APR 2010 rdivilbiss
* Version:  alpha 0.1 Debug Version
* On Entry: check for destination, $_SESSION["login"], and for SSL state
* Input   : userid, password
* Output  : message, possible logging of login
* On Exit : continuation link
******************************************************************************************************************/
header("Pragma: No-cache");
header("Cache-control: No-cache");
/*******************************************************************************************************************
* Declare all page variables and initialize their default values
*******************************************************************************************************************/

$dbMsg="";
$redirected="";
$destination="";
$password="";
$passhash="";
$userid="";
$useridValue="";
$name="";
$remember="";
$message= lg_term_please_login;
$ip = $_SERVER["REMOTE_ADDR"];
$date = dbNow();
$useragent = htmlentities(substr($_SERVER["HTTP_USER_AGENT"],1,255));
$locked="";

if ($_SERVER["REQUEST_METHOD"]!="POST") {
	if (lg_debug) { $dbMsg .= "METHOD GET<br />\n"; }
	/*******************************************************************************************************************
	* On entry determine if we have a destination page
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "Checking for destination parameter <br />\n"; }
	$destination = getField("p,urlpath,get");
	if ($destination=="") {
		$destination = lg_success_page;
		if (lg_debug) { $dbMsg .= "Destination = ".$destination." <br />\n"; }
	}
	
	
	/*******************************************************************************************************************
	* If already logged on, redirect
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "Checking for session login <br />\n"; }
	if (isset($_SESSION["login"])) {
		if ($_SESSION["login"]) {
			if (lg_debug) { $dbMsg .= "Session login = ".$_SESSION["login"]." <br />\n"; }
			if (lg_useSSL) {
				if (lg_debug) { $dbMsg .= "Use SSL is True <br />\n"; }
				header("Location: https://". lg_domain_secure . lg_loginPath . $destination);
			}else{
				if (lg_debug) { $dbMsg .= "Use SSL is False <br />\n"; }
				header("Location: http://". lg_domain . lg_loginPath . $destination);
			}
		}
	}
	
	/*******************************************************************************************************************
	* Is login state saved in the user's cookies? If so log user in
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "Checking for cookie <br />\n"; }
	if (isset($_COOKIE["user"])) {
		/*******************************************************************************************************************
		* Is the userid or IP locked out?
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Has cookie but checking for loginAttempt lock out <br />\n"; }
		li_checkForLocked($ip,$_COOKIE["user"],$dbResults);
		if ($dbResults["locked"]==1) {
			header("Location: http://". lg_domain . lg_forbidden);
		}
		if (lg_debug) { $dbMsg .= "Has Cookie and not locked out <br />\n"; }
			
		/*******************************************************************************************************************
		* Lookup user's name and locked from users table
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Looking up name in database <br />\n"; }
		li_getName($_SESSION["userid"],$dbResults);
		
		$name = $dbResults["name"];
		if ($dbResults["locked"]==1) {
			header("Location: http://". lg_domain . lg_forbidden);
		}
		session_regenerate_id(true); // anti-session fixation
		$_SESSION["name"]=name;
		if (lg_debug) { $dbMsg .= "Name = ".$name." <br />\n"; }

		/*******************************************************************************************************************
		* Not locked out, login via cookie
		*******************************************************************************************************************/
		$_SESSION["login"]=true;
		$_SESSION["userid"]=$_COOKIE["user"];
		if (lg_debug) { $dbMsg .= "Session login set to True <br />\n"; }
		if (lg_debug) { $dbMsg .= "Session userid = ".$_SESSION["userid"]." <br />\n"; }
					
		/*******************************************************************************************************************
		* If we are logging user authentications, write to the logins table
		*******************************************************************************************************************/
		if (lg_log_logins) {
			if (lg_debug) { $dbMsg .= "Logging the Login <br />\n"; }
			if (lg_debug) { $dbMsg .= "date = ".$date." <br />\n"; }
			if (lg_debug) { $dbMsg .= "userid = ".$userid." <br />\n"; }
			if (lg_debug) { $dbMsg .= "ip = ".$ip." <br />\n"; }
			if (lg_debug) { $dbMsg .= "useragent = ".$useragent." <br />\n"; }
			li_logLogin($date,$userid,$ip,$useragent);
		}
		
		/*******************************************************************************************************************
		* Logged in, redirect
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Logged in redirecting to https://". lg_domain . lg_loginPath . $destination." <br />\n"; }
		header("Location: https://" . lg_domain . lg_loginPath . $destination);
	}else{
		/*******************************************************************************************************************
		* No cookie but IP could be locked out.
		*******************************************************************************************************************/
		li_checkForLocked($ip,'',$dbResults);
		if ($dbResults["locked"]==1) {
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}
		/*******************************************************************************************************************
		* Not locked out but need to create loginAttempt record
		*******************************************************************************************************************/
		li_createLoginAttempt($date, $ip);
	
		/*******************************************************************************************************************
		* NOT LOGGED IN: If SSL required and not using SSL, redirect to https
		*******************************************************************************************************************/
		if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
			if (lg_debug) { $dbMsg .= "Not logged in: redirected to https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination." <br />\n"; }
			header("Location: https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination);
		}
	}	
}else{
	/*******************************************************************************************************************
	* The form was posted, process the form
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "POST - Process fields <br />\n"; }
	//checkToken();
	$message = "";
	$password = getField("password,safe");
	$userid = getField("userid,safe");
	$remember = getField("remember,alpha"); // Yes or empty
	$destination = getField("destination,urlpath");       // saved final destination
	if (lg_debug) { $dbMsg .= "POSTED password = ".$password." <br />\n"; }
	if (lg_debug) { $dbMsg .= "POSTED userid = ".$userid." <br />\n"; }
	if (lg_debug) { $dbMsg .= "POSTED remember = ".$remember." <br />\n"; }
	if ($userid=="") {
		$message .= lg_phrase_userid_empty . "<br />\n";
	}else{
		$useridValue = htmlentities($userid);
		if (lg_debug) { $dbMsg .= "htmlentities userid = ".$useridValue." <br />\n"; }
	}
	if ($password=="") {
		$message .= lg_phrase_password_empty . "<br />\n";
	}
	if (lg_debug) { $dbMsg .= "Message = ".$message." <br />\n"; }
	if ($message=="") {
		/*******************************************************************************************************************
		* If all required fields exist, attempt to autenticate the credentials
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Looking up login details from database <br />\n"; }
		li_getLoginDetails($userid, $dbResults);
		$passhash = $dbResults["password"];
		$name = $dbResults["name"];
		$locked = (string) $dbResults["locked"];
		if (lg_debug) { $dbMsg .= "Calculated Passhash = ".sha1($password . $userid)."<br />\n"; }
		if (lg_debug) { $dbMsg .= "Database Passhash   = ".$passhash." <br />\n"; }
		if (lg_debug) { $dbMsg .= "Name = ".$name." <br />\n"; }
		if (lg_debug) { $dbMsg .= "Locked = ".$locked." <br />\n"; }
		if ($locked!="1") {
			if (lg_debug) { $dbMsg .= "Account Not Locked <br />\n"; }
			if ($passhash==sha1($password . $userid)) {
				if (lg_debug) { $dbMsg .= "Passhash matches password <br />\n"; }
				/*******************************************************************************************************************
				* If credential are valid log the user in
				*******************************************************************************************************************/
				session_regenerate_id(true); // anti-session fixation
				$_SESSION["login"]=true;
				$_SESSION["userid"]=$userid;
				$_SESSION["name"]=$name;
				if (lg_debug) { $dbMsg .= "Session login set to True <br />\n"; }
				if (lg_debug) { $dbMsg .= "Session userid set to ".$userid." <br />\n"; }
				if (lg_debug) { $dbMsg .= "Session name set to ".$name." <br />\n"; }
				
				/*******************************************************************************************************************
				* If the user wishes to have authentication remembered, write the permanent cookies
				*******************************************************************************************************************/
				if (lg_debug) { $dbMsg .= "lg_term_remember = ".lg_term_remember." <br />\n"; }
				if (lg_debug) { $dbMsg .= "getField remember = ".getField("remember")." <br />\n"; }
				if ((lg_term_remember) AND (getField("remember")=="Yes")) {
					if (lg_debug) { $dbMsg .= "Setting cookie user <br />\n"; }
					setcookie("user", $value, time()+31536000); // 1 Year
				}
			
				/*******************************************************************************************************************
				* If we are logging user authentications, write to the logins table
				*******************************************************************************************************************/
				if (lg_log_logins) {
					if (lg_debug) { $dbMsg .= "Logging the Login <br />\n"; }
					if (lg_debug) { $dbMsg .= "date = ".$date." <br />\n"; }
					if (lg_debug) { $dbMsg .= "userid = ".$userid." <br />\n"; }
					if (lg_debug) { $dbMsg .= "ip = ".$ip." <br />\n"; }
					if (lg_debug) { $dbMsg .= "useragent = ".$useragent." <br />\n"; }
					li_logLogin($date,$userid,$ip,$useragent);
				}
				
				/*******************************************************************************************************************
				* Delete the login attempt record
				*******************************************************************************************************************/
				li_deleteLoginAttempt($pIp, $pUserid);
				
				/*******************************************************************************************************************
				* Logged in, redirect
				*******************************************************************************************************************/
				if (lg_debug) { $dbMsg .= "Logged In::Redirect <br />\n"; }
				if (lg_debug) { $dbMsg .= "Use SSL = ".lg_useSSL." <br />\n"; }
				if (lg_debug) { $dbMsg .= "Server Port Secure = ".$_SERVER["SERVER_PORT_SECURE"]." <br />\n"; }
				if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
					if (lg_debug) { $dbMsg .= "REDIRECTING TO: https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination." <br />\n"; }
					header("Location: https://" . lg_domain . lg_loginPath . $destination);
				}else{
					if (lg_debug) { $dbMsg .= "REDIRECTING TO: http://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination." <br />\n"; }
					header("Location: http://" . lg_domain . lg_loginPath . $destination);
				}
			}else{
				$message = lg_phrase_login_error;
				if (lg_debug) { $dbMsg .= "Message = ".$message." <br />\n"; }
			}
		}else{
			$message = lg_phrase_login_error_token;
			if (lg_debug) { $dbMsg .= "Message = ".$message." <br />\n"; }
		}		
		
	}
	if ($message!="") { // failed login attempt for one of several reasons.
  		if (lg_debug) { $dbMsg .= "getLoginAttemptRecord: IP = ".$ip." UserId = ".$userid." <br />\n"; }
		li_getLoginAttemptRecord($ip, $userid, $dbResults);
		$id = $dbResults["id"];
		$laNumber = $dbResults["number"]+1;
		
		if (lg_debug) { $dbMsg .= "ID = ".$id."<br />\n"; }
		//if (lg_debug) { $dbMsg .= "db Number = ".$dbResults["number"]."<br />\n"; }
		if (lg_debug) { $dbMsg .= "iaNumber = ". $laNumber ."<br />\n"; }
		if ($laNumber >= lg_login_attempts) {
			/*******************************************************************************************************************
			* Lock the account and redirect to forbidden
			*******************************************************************************************************************/
			$locked = "1";
			li_lockLoginAttemtpt($locked,$laNumber,$id);
			if (lg_debug) { $dbMsg .= "Lock Login Attempt: ID = " . $id ." Number = ". $laNumber. " numAffected = ". $numAffected ."<br />\n"; }
			if (!lg_debug) { 
				header("Location: http://". lg_domain . lg_forbidden);
				exit();
			}	
		}else{	
		/*******************************************************************************************************************
		* Update the login attempt record
		*******************************************************************************************************************/
			li_updateLoginAttempt($userid, $laNumber, $date, $id);
			if (lg_debug) { $dbMsg .= "Updated Login Attempt: ID = " . $id ." Number = ". $laNumber . " numAffected = ".$numAffected ."<br />\n"; }
			//exit();
		}
	}	
}
?>