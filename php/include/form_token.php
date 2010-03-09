<?PHP
session_start();

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
	$testToken=sha1(($tokenStr.$_SESSION["salt"]).$_SESSION["salt"]);
	$checkToken=False;
	If ($oldToken===$testToken) {
	    $diff = time() - $_SESSION["time"];
		If ($diff<=300) { // Five minutes max
	    	If ($_SESSION["usecookie"]) {
			    If ($_COOKIE["token"]===$oldToken) {
					return true;
				}else{
					$_SESSION = array();
		  			if (isset($_COOKIE[session_name()])) {
	    				setcookie(session_name(), '', time()-42000, '/');
					}
					session_destroy();
					header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=ec");
				}
				if (isset($_COOKIE["token"])) {
					setcookie("token", '', time()-42000);
				}
				if (isset($_SESSION["usecookie"])) {
					unset($_SESSION["usecookie"]);
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
			header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=et");
		}
	}else{
		$_SESSION = array();
		if (isset($_COOKIE[session_name()])) {
    		setcookie(session_name(), '', time()-42000, '/');
		}
		session_destroy();
		header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=e");
	}
}


function writeToken($type = "X") {
	/*****************************************************************************************
	* Create and set a new token for CSRF protection
	* Default output is an XHTML compatible input field. If $type = "H" then an HTML field
	* on initial entry or after form errors and we are going to redisplay the form.
	******************************************************************************************/
	$salt="";
	$tokenStr="";
	$salt = $salt = substr(md5(uniqid(rand(), true)), 0, 16);
	setcookie("token", "", time()-42000);
	$_SESSION["salt"]=$salt;
	$_SESSION["guid"] = getGUID();
	$_SESSION["ip"] = $_SERVER["REMOTE_ADDR"];
	$_SESSION["time"] = time();
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$_SESSION["token"]=sha1(($tokenStr.$_SESSION["salt"]).$_SESSION["salt"]);
	if (setcookie("token", $_SESSION["token"], time()+500)) {
		$_SESSION["usecookie"]=True;
	}
	if (($type=="H") || ($type=="h")) {
		return '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '">';
	}else{	
		return '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '" />';
	}	
}
?>