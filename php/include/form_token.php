<?php
// alpha 0.5a debug
// $Id$
/**
* Login System Form Token (anti-CSRF) Functions
* 27 APR 2010 Version alpha 0.3 debug
*/
if (!isset($_SESSION)) {
	session_start();
}
	

function generateToken(){
	/*****************************************************************************************
	* Create and set a new token for CSRF protection
	* on initial entry or after form errors and we are going to redisplay the form.
	******************************************************************************************/
	$salt="";
	$tokenStr="";
	$salt = sha1($_SERVER["HTTP_HOST"]);
	setcookie("token", "", time()-42000);
	$_SESSION["salt"]=$salt;
	$_SESSION["guid"] = getGUID();
	$_SESSION["ip"] = $_SERVER["REMOTE_ADDR"];
	$_SESSION["time"] = time();
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$_SESSION["token"]=sha1(($tokenStr.$_SESSION["salt"]).$_SESSION["salt"]);
	if (setcookie("token", $_SESSION["token"], time()+86400)) {
		$_SESSION["usecookie"]=True;
	}
}


function checkToken() {
	/*****************************************************************************************
	* Check the posted token for correctness
	******************************************************************************************/
	$oldToken="";
	$testToken="";
	$tokenStr="";
	$page=basename($_SERVER['PHP_SELF']);
	$oldToken=$_POST["token"];
	$tokenStr = "IP:" . $_SESSION["ip"] . ",SESSIONID:" . session_id() . ",GUID:" . $_SESSION["guid"];
	$testToken=sha1(($tokenStr.$_SESSION["salt"]).$_SESSION["salt"]);
	$checkToken=False;
	If ($oldToken===$testToken) {
	    $diff = time() - $_SESSION["time"]; 
		If ($diff<=300) { // Five minutes max
	    	If ($_SESSION["usecookie"]) {
			    If ($_COOKIE["token"]===$oldToken) {
			    	/*****************************************************************************************
					* Destroy the old form token, then
					* generate a new token for the form, which may or may not be needed. We want to do this
					* before headers are written. When writeToken() or writeTokenH() is called we are only 
					* writing the pre-generated token to the form. The cookie will have already been written.
					******************************************************************************************/
					setcookie("token", '', time()-42000);
					generateToken();
					return true;
				}else{
					$_SESSION = array();
		  			if (isset($_COOKIE[session_name()])) {
	    				setcookie(session_name(), '', time()-42000);
					}
					session_destroy();
					header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=ec");
				}
			}else{	
	  			return True;
	  		}	
	  	}else{
	  		$_SESSION = array();
	  		if (isset($_COOKIE[session_name()])) {
    			setcookie(session_name(), '', time()-42000);
			}
			session_destroy();
			header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=et");
		}
	}else{
		$_SESSION = array();
		if (isset($_COOKIE[session_name()])) {
    		setcookie(session_name(), '', time()-42000);
		}
		session_destroy();
		header("Location: http://". lg_domain . lg_form_error ."?p=" . $page . "&t=e");
	}
}


if ($_SERVER["REQUEST_METHOD"]=="GET") {
	/*****************************************************************************************
	* We need to generate the token (writing a cookie) before headers are written. When
	* writeToken() or writeTokenH() is called we are only writing the pre-generated token to
	* the form. The cookie has already been sent.
	******************************************************************************************/
	generateToken();
}

function writeToken() {	
	echo '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '" />';
}

function writeTokenH() {
	echo '<input id="token" name="token" type="hidden" accesskey="u" tabindex="999" value="' .$_SESSION['token']. '">';
}
?>