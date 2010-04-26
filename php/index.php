<?PHP
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/generalPurpose.php";
include "include/form_token.php";
include "include/loginGlobals.php";
include "include/database.php";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?PHP echo lg_term_home; ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="content-language" content="en-US" />
<meta name="language" content="en-US" />
</head>

<body>
<?PHP
if (isset($_SESSION["name"])) {
	echo "<h1>".lg_term_welcome.' '.$_SESSION["name"]."</h1><br />";
	echo '<p><a href="logout.php" title="'. lg_term_log_out .'">'. lg_term_log_out .'</a></p>';
}else{
	echo '<h1>'.lg_term_welcome.' '.lg_term_guest.'</h1><p><a href="login.php" title="'.lg_term_login.'">'.lg_term_login.'</a></p>';
}
?>
<p>This PHP code is an alpha release. It is considered stable and suitable for use on a public website. It may contain errors or security vulnerabilities that were not found during testing. Report any problem or suggestion or security@webloginproject.com support@webloginproject.com translation.</p>
<p>This page, and the other pages in the login-system directory are meant only as examples of what you should include in your website&#39;s page template. For examples of the Login System incorporated into a production web site please see the example sites:</p>
<p><a title="ASP, XHTML &amp; MS SQL Server 2005 Demo Site" href="http://www.webloginproject.com/login-system/aspdemo/default.asp">ASP, XHTML &amp; MS SQL Server 2005</a><br />
<a title="ASP, XHTML &amp; MS Access Demo Site" href="http://www.webloginproject.com/login-system/aspmsa/">ASP, XHTML &amp; MS Access</a><br />
<a title="ASP, HTML 4.01 Strict &amp; MySql" href="https://www.webloginproject.com/login-system/aspmysql/">ASP, HTML 4.01 Strict &amp; MySql</a><br />
&nbsp;</p>
<p><a title="<?PHP echo lg_term_cancel_account; ?>" href="cancel_account.php"><?PHP echo lg_term_cancel_account; ?></a></p>
<p><a title="<?PHP echo lg_term_change_password; ?>" href="change_password.php"><?PHP echo lg_term_change_password; ?></a></p>
<p><a title="<?PHP echo lg_term_issue_verification_token; ?>" href="issue_verification_token.php"><?PHP echo lg_term_issue_verification_token; ?></a></p>
</body>

</html>