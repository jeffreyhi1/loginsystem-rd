<?PHP
/**
* Login System Form Token (anti-CSRF) Functions
* 19 APR 2010 Version alpha 0.1a
*/
if (!isset($_SESSION)) {
	session_start();
}

function checkToken() {
	/*****************************************************************************************
	* Check the posted token for correctness
	******************************************************************************************/
	$oldToken="";
	$testToken="";
	$tokenStr="";
	$page=$_SERVER["SCRIPT_NAME"];
	$oldToken=$_POST["token"];
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$testToken=sha1(($tokenStr&$_SESSION["salt"]).$_SESSION["salt"]);
	$checkToken=False;
	If ($oldToken===$testToken) {
	    $diff = time() - $_SESSION["time"]; 
		If ($diff<=300) { // Five minutes max
	    	If ($_SESSION["usecookie"]) {
			    If ($_COOKIE["token"]===$oldToken) {
			    	setcookie("token", '', time()-42000);
					return true;
				}else{
					$_SESSION = array();
		  			if (isset($_COOKIE[session_name()])) {
	    				setcookie(session_name(), '', time()-42000, '/');
					}
					session_destroy();
					header("Location: http://". lg_domain . lg_loginPath . lg_form_error ."?p=" . $page . "&t=ec");
				}
			}else{	
	  			return True;
	  		}	
	  	}else{
	  		$_SESSION = array();
	  		if (isset($_COOKIE[session_name()])) {
    			setcookie(session_name(), '', time()-42000, '/');
			}
			session_destroy();
			header("Location: http://". lg_domain . lg_loginPath . lg_form_error ."?p=" . $page . "&t=et");
		}
	}else{
		$_SESSION = array();
		if (isset($_COOKIE[session_name()])) {
    		setcookie(session_name(), '', time()-42000, '/');
		}
		session_destroy();
		header("Location: http://". lg_domain . lg_loginPath . lg_form_error ."?p=" . $page . "&t=e");
	}
}
	
function writeToken() {
	/*****************************************************************************************
	* Create and set a new token for CSRF protection
	* on initial entry or after form errors and we are going to redisplay the form.
	******************************************************************************************/
	$salt="";
	$tokenStr="";
	$salt = sha1("rodsdot.com");
	setcookie("token", "", time()-42000);
	$_SESSION["salt"]=$salt;
	$_SESSION["guid"] = com_create_guid();
	$_SESSION["ip"] = $_SERVER["REMOTE_ADDR"];
	$_SESSION["time"] = time();
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$_SESSION["token"]=sha1(($tokenStr&$_SESSION["salt"]).$_SESSION["salt"]);
	if (setcookie("token", $_SESSION["token"], time()+500)) {
		$_SESSION["usecookie"]=True;
	}
	echo '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '" />';
}

function writeTokenH() {
	/*****************************************************************************************
	* Create and set a new token for CSRF protection
	* on initial entry or after form errors and we are going to redisplay the form.
	******************************************************************************************/
	$salt="";
	$tokenStr="";
	$salt = sha1("rodsdot.com");
	setcookie("token", "", time()-42000);
	$_SESSION["salt"]=$salt;
	$_SESSION["guid"] = com_create_guid();
	$_SESSION["ip"] = $_SERVER["REMOTE_ADDR"];
	$_SESSION["time"] = time();
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$_SESSION["token"]=sha1(($tokenStr&$_SESSION["salt"]).$_SESSION["salt"]);
	if (setcookie("token", $_SESSION["token"], time()+500)) {
		$_SESSION["usecookie"]=True;
	}
	echo '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '">';
}
?>