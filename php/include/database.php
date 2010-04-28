<?PHP
// $Id$
/**
* Login System Database Functions
* 27 APR 2010 Version alpha 0.1b debug
* MySql
*/

//error_reporting(0);

define("dbServer", "server");
define("dbUser", "user");
define("dbPassword", "password");
define("dbCatalog", "loginproject");

/* Globals */
$numAffected=0;
$debug = true;

/* Enable only for testing
function dbNow() {
	return date("Y-m-d H:i:s");
}


function getGUID(){
    if (function_exists('com_create_guid')){
        return com_create_guid();
    }else{
        mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $hyphen = chr(45);// "-"
        $uuid = chr(123)// "{"
            .substr($charid, 0, 8).$hyphen
            .substr($charid, 8, 4).$hyphen
            .substr($charid,12, 4).$hyphen
            .substr($charid,16, 4).$hyphen
            .substr($charid,20,12)
            .chr(125);// "}"
        return $uuid;
    }
}
*/

function getConnection() {
	global $debug;
	$dbConnection = new mysqli(dbServer, dbUser, dbPassword, dbCatalog);
	if (mysqli_connect_error()) {
		if ($debug) {
	    	die('Connect Error (' . mysqli_connect_errno() . ') '. mysqli_connect_error());
	    }else{
	    	die("There was a database connection error");
	    }
    }else{
    	return $dbConnection;
	}	
}

function closeConnection($dbConn) {
	$dbConn->close();
}

/* cancel account */
function ca_getUserDetails($pUserid, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, password FROM users WHERE userid=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pUserid);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id,$password);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["password"]=$password;
	
		$command->close();
	}
	closeConnection($dbConn);
}

function ca_cancelAccount($pDeleted,$pDateDeleted,$pUserid,$pPassword) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET deleted=?, dateDeleted=? WHERE userid=? AND password=?")) {
		/* bind parameters for markers */
	    $command->bind_param("ssss", $pDeleted, $pDateDeleted, $pUserid, $pPassword);

	    /* execute query */
	    $command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* change password */
function cp_getUserDetails($pUserid, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT name, email, password FROM users WHERE userid=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pUserid);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($name,$email,$password);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["name"]=$name;
	    $pResults["email"]=$email;
		$pResults["password"]=$password;

		$command->close();
	}
	closeConnection($dbConn);
}

function cp_changePassword($pPassword,$pUserid) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET password=? WHERE userid=?")) {
		/* bind parameters for markers */
	    $command->bind_param("ss", $pPassword, $pUserid);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* issue verification token */

function ivt_selectUser($pUserid,$pEmail,&$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, userid, name, email, locked FROM users WHERE userid=? AND email=?;")) {
		/* bind parameters for markers */
	    $command->bind_param("ss", $pUserid, $pEmail);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id, $userid, $name, $email, $locked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["userid"]=$userid;
	    $pResults["name"]=$name;
	    $pResults["email"]=$email;
	    $pResults["locked"]=$locked;

		$command->close();
	}
	closeConnection($dbConn);
}

function ivt_issueToken($pToken,$pLocked,$pDateLocked,$pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE id=?")) {
		/* bind parameters for markers */
	    $command->bind_param("sssi", $pToken, $pLocked, $pDateLocked, $pId);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* login */

function li_checkForLocked($pIp,$pUserid=NULL,&$pResults=array()) {
	$dbConn = getConnection();
	if ($pUserid==NULL) {
		if ($command = $dbConn->prepare("SELECT loginAttemptLocked FROM loginAttempts WHERE loginAttemptIP = ?")) {
			/* bind parameters for markers */
			$command->bind_param("s", $pIp);
		
	    	/* execute query */
	    	$command->execute();
	    
	    	/* bind result variables */
    		$command->bind_result($locked);

	    	/* fetch value */
	    	$command->fetch();

	    	/* assign results */
			$pResults["locked"]=$locked;
			
			$command->close();
		}else{
			if ($command = $dbConn->prepare("SELECT loginAttemptLocked FROM loginAttempts WHERE loginAttemptUserID = ? OR loginAttemptIP = ?")) {
				$command->bind_param("ss", $pIp, $pUserid);
			
				/* execute query */
		    	$command->execute();
	    
		    	/* bind result variables */
	    		$command->bind_result($locked);

		    	/* fetch value */
		    	$command->fetch();

		    	/* assign results */
				$pResults["locked"]=$locked;
			
				$command->close();
			}
		}
	}
	if ($pResults["locked"]==NULL && $pResults["locked"]=="") {
		$pResults["locked"]=0;
	}
	closeConnection($dbConn);
}


function li_createLoginAttempt($pDate, $pIp) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("INSERT INTO loginAttempts (loginAttemptDate, loginAttemptIP) VALUES (?, ?)")) {
		/* bind parameters for markers */
	    $command->bind_param("ss", $pDate, $pIp);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


function li_getLoginAttemptRecord($pIp, $pUserid, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, loginAttemptNumber FROM loginAttempts WHERE loginAttemptUserID = ? OR loginAttemptIP = ?")) {
	
		/* bind parameters for markers */
		$command->bind_param("ss", $pUserid, $pIp);
			
		/* execute query */
		$command->execute();
	    
	   	/* bind result variables */
    	$command->bind_result($id, $number);

	   	/* fetch value */
	   	$command->fetch();

	   	/* assign results */
		$pResults["id"]=$id;
		$pResults["number"]=$number;
			
		$command->close();
	}
	closeConnection($dbConn);
}


function li_lockLoginAttemtpt($pLocked, $pNumber, $pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE loginAttempts SET loginLocked = ?, loginAttemptNumber = ? WHERE id = ?")) {
	
		/* bind parameters for markers */
		$command->bind_param("sii", $pLocked, $pNumber, $pId);
		
		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


function li_updateLoginAttempt($pUserid, $pNumber, $pDate, $pId) {
	global $numAffected;

	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE loginAttempts SET loginAttemptUserID = ?, loginAttemptNumber = ?, loginAttemptDate = ? WHERE id = ?")) {

		/* bind parameters for markers */
		$command->bind_param("sisi", $pUserid, $pNumber, $pDate, $pId);
		
		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);

}


function li_deleteLoginAttempt($pIp, $pUserid) {
	global $numAffected;

	$dbConn = getConnection();
	if ($command = $dbConn->prepare("DELETE FROM loginAttempts WHERE loginAttemptIP = ? OR loginAttemptUserID = ?")) {

		/* bind parameters for markers */
		$command->bind_param("ss", $pIp, $pUserid);
		
		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


function li_getName($pUserid,&$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT name, locked FROM users WHERE userid=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pUserid);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($name,$locked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["name"]=$name;
	    $pResults["locked"]=$locked;

		$command->close();
	}
	closeConnection($dbConn);
}

function li_logLogin($pDate,$pUserid,$pIp,$pUseragent) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("INSERT INTO logins (date, userid, ip, useragent) VALUES (?, ?, ?, ?)")) {
		/* bind parameters for markers */
	    $command->bind_param("ssss", $pDate, $pUserid, $pIp, $pUseragent);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}

function li_getLoginDetails($pUserid,&$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT name, password, locked FROM users WHERE userid=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pUserid);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($name, $password, $locked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["name"]=$name;
	    $pResults["password"]=$password;
	    $pResults["locked"]=$locked;

		$command->close();
	}
	closeConnection($dbConn);
}


/* recover password */

function rp_selectUserDetails($pUserid,$pEmail,&$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, name, locked FROM users WHERE userid=? AND email=?")) {
		/* bind parameters for markers */
	    $command->bind_param("ss", $pUserid, $pEmail);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id,$name,$locked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["name"]=$name;
	    $pResults["locked"]=$locked;

		$command->close();
	}
	closeConnection($dbConn);
}

function rp_issueToken($pToken,$pLocked,$pDateLocked,$pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE id=?")) {
		/* bind parameters for markers */
	    $command->bind_param("sssi", $pToken, $pLocked, $pDateLocked, $pId);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* register delete */

function rd_selectUserDetails($pEmail, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, userid, locked, dateLocked, token FROM users WHERE email=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pEmail);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id, $userid, $locked, $dateLocked, $token);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["userid"]=$userid;
	    $pResults["locked"]=$locked;
	    $pResults["dateLocked"]=$dateLocked;
	    $pResults["token"]=$token;

		$command->close();
	}
	closeConnection($dbConn);
}

function rd_deleteUser($pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("DELETE FROM users WHERE id=?")) {
		/* bind parameters for markers */
	    $command->bind_param("i", $pId);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* register verify */

function rv_getVerificationDetails($pToken, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, userid, email, locked, dateLocked FROM users WHERE token=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pToken);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id, $userid, $email, $locked, $dateLocked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["userid"]=$userid;
	    $pResults["email"]=$email;
	    $pResults["locked"]=$locked;
	    $pResults["dateLocked"]=$dateLocked;

		$command->close();
	}
	closeConnection($dbConn);
}

function unlockAccount($pToken, $pLocked, $pDateLocked, $pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE id=?")) {
		/* bind parameters for markers */
	    $command->bind_param("sssi", $pToken, $pLocked, $pDateLocked, $pId);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}


/* register */

function isUser($pUserid) {
	/**
	* isUser($pUserid)
	*
	* If $pUserid exists in table users returns true,
	* otherwise returns false
	*/
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT userid FROM users WHERE userid=?")) {
	    /* bind parameters for markers */
	    $command->bind_param("s", $pUserid);

	    /* execute query */
	    $command->execute();
		
		/* store result */
		$command->store_result();
		
		/* Number of Rows */
		if ($command->num_rows==0) {
			return false;
		}else{
			return true;
		}
		$command->close();
	}
	closeConnection($dbConn);
}


function addUser($pDateRegistered, $pUserid, $pPassword, $pName, $pEmail, $pIp, $pRegion, $pCity, $pCountry, $pUseragent, $pWebsite, $pNews, $pLocked, $pDateLocked, $pToken) {
	global $numAffected;	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("INSERT INTO users (dateRegistered, userid, password, name, email, ip, region, city, country, useragent, website, news, locked, dateLocked, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
	    /* bind parameters for markers */
	    $command->bind_param("sssssssssssssss", $pDateRegistered, $pUserid, $pPassword, $pName, $pEmail, $pIp, $pRegion, $pCity, $pCountry, $pUseragent, $pWebsite, $pNews, $pLocked, $pDateLocked, $pToken);

	    /* execute query */
	    $command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;
		
		$command->close();
	}
	closeConnection($dbConn);
}


/* set new password */

function snp_selectTokenDetails($pToken, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, dateLocked FROM users WHERE token=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pToken);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id, $dateLocked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["dateLocked"]=$dateLocked;

		$command->close();
	}
	closeConnection($dbConn);
}


function snp_selectUserDetails($pToken, &$pResults=array()) {
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("SELECT id, userid, email, name, locked, dateLocked FROM users WHERE token=?")) {
		/* bind parameters for markers */
	    $command->bind_param("s", $pToken);

	    /* execute query */
	    $command->execute();
	    
	    /* bind result variables */
    	$command->bind_result($id, $userid, $email, $name, $locked, $dateLocked);

	    /* fetch value */
	    $command->fetch();
	    
	    /* assign results */
	    $pResults["id"]=$id;
	    $pResults["userid"]=$userid;
	    $pResults["email"]=$email;
	    $pResults["name"]=$name;
	    $pResults["locked"]=$locked;
	    $pResults["dateLocked"]=$dateLocked;

		$command->close();
	}
	closeConnection($dbConn);
}


function snp_setNewPassword($pPassword,$pToken,$pLocked,$pDateLocked,$pId) {
	global $numAffected;
	
	$dbConn = getConnection();
	if ($command = $dbConn->prepare("UPDATE users SET password = ?, token = ?, locked = ?, dateLocked = ? WHERE id=?")) {
		/* bind parameters for markers */
	    $command->bind_param("ssssi", $pPassword, $pToken, $pLocked, $pDateLocked, $pId);

		/* execute query */
		$command->execute();

		/* affected rows */
		$numAffected = $command->affected_rows;

		$command->close();
	}
	closeConnection($dbConn);
}

?>