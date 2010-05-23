<?php
// alpha 0.5a debug
// $Id$
/*******************************************************************************************************************
* Page Name: Login
* Last Modification: 01 MAY 2010 rdivilbiss Version
* On Entry: check for destination, $_SESSION["login"], and for SSL state
* Input   : userid, password
* Output  : message, possible logging of login
* On Exit : continuation link
******************************************************************************************************************/

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

if ($_SERVER["REQUEST_METHOD"]=="GET") {
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
	* If already logged on, redirect - assuming if $_SESSION["login"]==true then user is not locked out.
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "Checking for session login <br />\n"; }
	if (isset($_SESSION["login"])) {
		if ($_SESSION["login"]==true) {
			if (lg_debug) { $dbMsg .= "Session login = ".$_SESSION["login"]." <br />\n"; }
			li_checkForDeletedOrLockedUserid($_SESSION["userid"],$dbResults);
			if (($dbResults["deleted"]=="1") || ($dbResults["locked"]=="1")) {
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
				header("Location: http://". lg_domain . lg_forbidden);
				exit();
			}
			if (lg_useSSL) {
				if (lg_debug) { $dbMsg .= "Use SSL is True <br />\n"; }
				header("Location: https://". lg_domain_secure . lg_loginPath . $destination);
				exit();
			}else{
				if (lg_debug) { $dbMsg .= "Use SSL is False <br />\n"; }
				header("Location: http://". lg_domain . lg_loginPath . $destination);
				exit();
			}
		}
	}
	
	/*******************************************************************************************************************
	* Determine if we have Cookie Login
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "Checking for cookie <br />\n"; }
	if (!isset($_COOKIE["login"])) {
		/*******************************************************************************************************************
		* No cookie but IP could be locked out.
		*******************************************************************************************************************/
		li_checkForLockedIP($ip,$dbResults);
		if (lg_debug) { $dbMsg .= "dbResults locked = " .$dbResults["locked"]. "<br />\n"; } 
		if ($dbResults["locked"]=="1") {
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}
		
		/*******************************************************************************************************************
		* No Cookie Login and IP Not Locked Setup Login Attempts Record for POST
		*******************************************************************************************************************/
		li_createLoginAttempt($date, $ip);
		
		/*******************************************************************************************************************
		* NOT LOGGED IN: If SSL required and not using SSL, redirect to https
		*******************************************************************************************************************/
		if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
			if (lg_debug) { $dbMsg .= "Not logged in: redirected to https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination." <br />\n"; }
			header("Location: https://" . lg_domain . lg_loginPath . $lg_filename ."?p=". $destination);
			exit();
		}	
	}else{
		/*******************************************************************************************************************
		* User Login Is Saved In Login Cookie.
		*******************************************************************************************************************/
		$userid = $_COOKIE["login"];
		/*******************************************************************************************************************
		* Cookie or no cookie the userid could be deleted or locked.
		*******************************************************************************************************************/
		li_checkForDeletedOrLockedUserid($userid,$dbResults);
		if (($dbResults["deleted"]=="1") || ($dbResults["locked"]=="1")) {
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}
		
		/*******************************************************************************************************************
		* Userid was not deleted or locked in users
		*******************************************************************************************************************/
		$_SESSION["userid"]=$userid;
		$destination = lg_success_page;
		if (lg_debug) { $dbMsg .= "UserID = ". $userid . "<br />\n"; }
		if (lg_debug) { $dbMsg .= "Session userid = ". $_SESSION["userid"] . "<br />\n"; }
		if (lg_debug) { $dbMsg .= "destination = " . $destination . "<br />\n"; }
		
		/*******************************************************************************************************************
		* Cookie or not the UserID and/or IP could be locked out by loginAttempts
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Has cookie but checking for loginAttempt lock out <br />\n"; }
		li_checkForLocked($ip,$pUserid, $dbResults);
		if ($dbResults["locked"]=="1") {
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}
		if (lg_debug) { $dbMsg .= "Has Cookie and not locked out <br />\n"; }
	
		/*******************************************************************************************************************
		* Lookup user's name and locked from user's table
		*******************************************************************************************************************/
		if (lg_debug) { $dbMsg .= "Looking up name in database <br />\n"; }
		li_getName($userid,$dbResults);
		
		$name = $dbResults["name"];
		if ($dbResults["locked"]=="1") {
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}
		
		/*******************************************************************************************************************
		* Not locked out, login via cookie
		*******************************************************************************************************************/
		session_regenerate_id(true); // anti-session fixation
		$_SESSION["name"]=$name;
		$_SESSION["login"]=true;
		if (lg_debug) { $dbMsg .= "Name = ".$name." <br />\n"; }
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
		if (lg_useSSL) {
			if (lg_debug) { $dbMsg .= "Logged in redirecting to https://". lg_domain . lg_loginPath . $destination." <br />\n"; }
			header("Location: https://" . lg_domain . lg_loginPath . $destination);
			exit();
		}else{
			if (lg_debug) { $dbMsg .= "Logged in redirecting to https://". lg_domain . lg_loginPath . $destination." <br />\n"; }
			header("Location: http://" . lg_domain . lg_loginPath . $destination);
			exit();
		}	
	}
}else{
	/*******************************************************************************************************************
	* The form was posted, process the form
	*******************************************************************************************************************/
	if (lg_debug) { $dbMsg .= "POST - Process fields <br />\n"; }
	checkToken();
	$message = "";
	if (isset($_POST["password"])) {
		$password = $_POST["password"];
	}	
	$userid = getField("userid,safepq");
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
		* Userid could be deleted or locked.
		*******************************************************************************************************************/
		li_checkForDeletedOrLockedUserid($userid,$dbResults);
		if (($dbResults["deleted"]=="1") || ($dbResults["locked"]=="1")) {
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}	
	
		/*******************************************************************************************************************
		* Check for lock out on loginAttempts
		*******************************************************************************************************************/
		li_checkForLocked($ip, $userid, $dbResults);
		if ($dbResults["locked"]=="1") {
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}          

		/*******************************************************************************************************************
		* If all required fields exist, attempt to authenticate the credentials
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
				* If credentials are valid log the user in
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
					setcookie("login", $userid, time()+157788000); // 5 Years
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
				li_deleteLoginAttempt($ip, $userid);
				
				/*******************************************************************************************************************
				* Clear the form token
				*******************************************************************************************************************/
				setcookie("token", "", time()-42000);
				
				/*******************************************************************************************************************
				* Logged in, redirect
				*******************************************************************************************************************/
				if (lg_debug) { $dbMsg .= "Logged In::Redirect <br />\n"; }
				if (lg_debug) { $dbMsg .= "Use SSL = ".lg_useSSL." <br />\n"; }
				if (lg_debug) { $dbMsg .= "Server Port Secure = ".$_SERVER["SERVER_PORT_SECURE"]." <br />\n"; }
				if ((lg_useSSL) && ($_SERVER["SERVER_PORT_SECURE"]=="0")) {
					if (lg_debug) { $dbMsg .= "REDIRECTING TO: https://" . lg_domain . lg_loginPath . $destination." <br />\n"; }
					header("Location: https://" . lg_domain . lg_loginPath . $destination);
					exit();
				}else{
					if (lg_debug) { $dbMsg .= "REDIRECTING TO: http://" . lg_domain . lg_loginPath . $destination." <br />\n"; }
					header("Location: http://" . lg_domain . lg_loginPath . $destination);
					exit();
				}
			}else{
				/*******************************************************************************************************************
				* Bad Login - get the login attempts record
				*******************************************************************************************************************/
  				if (lg_debug) { $dbMsg .= "getLoginAttemptRecord: IP = ".$ip." UserId = ".$userid." <br />\n"; }
				li_getLoginAttemptRecord($ip, $userid, $dbResults);
				$id = $dbResults["id"];
				$laNumber = $dbResults["number"]+1;
		
				if (lg_debug) { $dbMsg .= "ID = ".$id."<br />\n"; }
				if (lg_debug) { $dbMsg .= "laNumber = ". $laNumber ."<br />\n"; }
				if (lg_debug) { $dbMsg .= "lg_login_attempts = ". lg_login_attempts ."<br />\n"; }
				if ($laNumber >= lg_login_attempts) {
					/*******************************************************************************************************************
					* Lock the account and redirect to forbidden
					*******************************************************************************************************************/
					$locked = "1";
					li_lockLoginAttemtpt($locked,$laNumber,$id);
					header("Location: http://". lg_domain . lg_forbidden);
					exit();
				}else{
					/*******************************************************************************************************************
					* Update the login attempt record
					*******************************************************************************************************************/
					li_updateLoginAttempt($userid, $laNumber, $date, $ip, $id);
					if (lg_debug) { $dbMsg .= "Updated Login Attempt: ID = " . $id ." Number = ". $laNumber . " numAffected = ".$numAffected ."<br />\n"; }
				}
				$message = lg_phrase_login_error;
			}
		}else{
			// UserID is locked
			/*******************************************************************************************************************
			* Cookie or no cookie the userid could be deleted or locked.
			*******************************************************************************************************************/
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
			header("Location: http://". lg_domain . lg_forbidden);
			exit();
		}			
		$message = lg_phrase_login_error;	
	}
}
?>