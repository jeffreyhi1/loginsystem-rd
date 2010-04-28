<?PHP
// $Id$
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}
setcookie ("user", "", time() - 3600);

if (isset($_SESSION["user"])) {
	$_SESSION["user"]="";
}
if (isset($_SESSION["login"])) {
	$_SESSION["login"]="";
}
if (isset($_SESSION["name"])) {
	$_SESSION["name"]="";
}
session_destroy();

// alpha 0.1b debug - 27 APR 2010

/* You should add
* header("Pragma: No-cache");
* header("Cache-control: No-cache");
* after all PHP generated output
*/
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="content-language" content="en-US" />
<meta name="language" content="en-US" />
<title>Forbidden</title>
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="© 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>
<h1>Forbidden</h1>
<p>The maximum number of login attempts have occurred. Please contact webmaster.</p>
</body>
</html>