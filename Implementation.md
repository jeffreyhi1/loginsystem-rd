Implementation Guide

# Introduction #

How to Install The Login System On You Site

# Implementation #

The Login System has been released as alpha code in ASP and PHP. Cold Fusion and ASP.NET versions are still in development. While it has been tested thoroughly, it is not guaranteed bug-free. It has been successfully deployed on many servers.

The Login System is meant to be integrated into your site so it has your site's "look and feel." If you will create one template page which contains all the normal content of a page on your site, then implementation is simply a matter of including the server-side code for a given page, along with the necessary library files at the top of the page. The HTML or XHTML markup for a given page is included in the "main content area" of the page.  From one template page, you create as many of the Login System pages as needed for your site.

Please send an e-mail to webmaster@webloginproject.com with the URL of the website where you will implement the login system and with contact details so you may be notified of any enhancements or security problems discovered.

## Prerequisites ##

There are certain pages your site is expected to have prior to implementing the Login System. To avoid multiple, potentially conflicting versions, you can learn about the prerequisites at the Google Code Project wiki: http://code.google.com/p/loginsystem-rd/wiki/Prerequisites.

## Obtaining the code ##

Obtaining the code will require two downloads.  You'll need the one of the:
  * ASP or PHP code, in the world language of your choice (Danish, German, etc.), and
  * a database creation script or the MS Access database file.

All packages are currently delivered with XHTML 1.1 Strict markup. If you want HTML 4.01 Strict markup you need an additional download/

All packages are available under the downloads tab on this site.


## The database ##

The ASP code supports MS Access, MS SQL Server (tested on SQL Server 2005) and MySql databases.  An empty MS Access database is be provided at the downloads page.  MS SQL SQL and MySql SQL scripts are also be available on the downloads page.  The PHP code initially supports just the MySql database.

It is assumed you know how to create databases from SQL scripts, and/or know how to implement an MS Access site on your web site securely.  The user account for web access should be separate from the database admin role.  It needs SELECT, INSERT, DELETE, and UPDATE permissions only.  If you are unsure, or just want assistance or assurance you have implemented your database properly, please post a question at the Miscellaneous Web Development and appropriate database topic areas at [Experts Exchange](http://www.experts-exchange.com/).

  * [MS Access Topic Area](http://www.experts-exchange.com/Database/MS_Access/)
  * [MS SQL Server Topic Area](http://www.experts-exchange.com/Database/MS-SQL-Server/)
  * [MySql Topic Area](http://www.experts-exchange.com/Database/MySQL/)

## Folder Structure ##

It is suggested your Login System pages be placed in a separate folder, (we will assume that folder is named "login-system",) under you web site's root folder.  That folder should have a folder underneath it called "include."  Your Login System pages created from your web site page template with the included code and markup will go into the "login-system" folder.  The included code, library files, and markup files will go into the "include" folder. You will need to modify the loginGlobals library file to have the correct folder paths and file names for your configuration.  You will also place your database connection string into this file.

For ASP users, it is suggested for security reasons, your actual database connection string be created as an Application variable in global.asa in your web root, and you simply include the Application variable in the loginGlobals file.
A page skeleton

An example ASP page skeleton would look like this (a login page):

```
<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/include/loginGlobals.asp"-->
<!--#include virtual="/login-project/include/hashSHA1.asp"-->
<!--#include virtual="/login-project/include/form_token.asp"-->
<!--#include virtual="/login-project/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/include/paramSQL.asp"-->
<!--#include virtual="/login-project/include/CDOMailInclude.asp"-->
<!--#include virtual="/login-project/include/login.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_login%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="language" content="en-US">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2010 EE Collaborative Login Project http://www.webloginproject.com">
</head>

<body>
<!--#include virtual="/login-project/include/login-markup.asp"-->
</body>
</html>
```

You have the library files at the top of the page (above the DOCTYPE) including the server-side code for the login page. The login form and other markup is included in the body of the page, (in your main content area.)

An example PHP page skeleton would look like this (a login page):

```
<?PHP
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/generalPurpose.php";
include "include/form_token.php";
include "include/loginGlobals.php";
include "include/database.php";
include "include/login.php";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<title><?PHP echo lg_term_login?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="language" content="en-US" />
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="&copy; 2010 EE Collaborative Login Project http://www.webloginproject.com" />
</head>

<body>
<?PHP include "include/login-markup.php"; ?>
<?PHP echo "<p>". $dbMsg . "</p>"; ?>
</body>
</html>
```

As with the ASP skeleton page above, you have the library files at the top of the page (above the DOCTYPE) including the server-side code for the login page. The login form and other markup is included in the body of the page, (in your main content area.)


## Protected Pages ##

All protected pages must be .asp or .php pages.  The top of any protected ASP page should include the following code.

```
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-system/asp/include/loginGlobals.asp"-->
<%
If NOT Session("login") Then
    Response.Redirect "http://" & lg_domain & lg_loginPath & lg_loginPage &_
    "?p=" & Request.ServerVariables("SCRIPT_NAME")
End If

' Your page code here
%>
```

The top of any protected PHP page should include the following code.

```
<?PHP
setlocale(LC_ALL, 'English_United States.65001');
if (!isset($_SESSION)) {
	session_start();
}

include "include/loginGlobals.php";

if ((!isset($_SESSION["login"])) || ($_SESSION["login"]==False)) {
	header("Location: http://" . lg_domain . lg_loginPath . lg_loginPage ."?p=". $_SERVER["SCRIPT_NAME"]);
}
?>
```


You may not normally set the Codepage and Charset at the top of your ASP pages, or use the setlocale with your PHP pages, but for security purposes it is assumed you will do so for pages in the Login System and for those protected by the Login System.  UTF-8 is being used to facilitate the internationalized versions of the Login System. You'll note your protected page needs access to the domain, path, and login page constants maintained in the loginGlobals library file.

## Bugs or Feature Enhancement Requests ##

The Login System is a living breathing project. This is a companion demonstration and test site.  This is the project home.  Any bugs, security vulnerabilities, or feature enhancements should be made at the Issues tracker.  This is a project consisting of volunteers who are well experienced, seasoned web developers.  Most are consultants or are employed full time.  Security vulnerabilities will receive the most attention.  From beta, alpha and through release 1.0, you should consistently monitor the project home for any bug or security patches made available.  Due to the design of the Login System, those will simply be replacement pages for existing pages you have already implemented.

Feature enhancements will be evaluated based on their general applicability to a wide audience and if accepted will be implemented when time is available.  If you have a special or pressing need, you may check the project contributors to see who is available to be hired for custom programming.
I Just need help implementing the Login System on my site
Post you assistance requests and questions at Experts Exchange in one or all of the [Miscellaneous Web Development](http://www.experts-exchange.com/Web_Development/Miscellaneous/), [ASP](http://www.experts-exchange.com/Web_Development/Web_Languages-Standards/ASP/) and/or [PHP](http://www.experts-exchange.com/Web_Development/Web_Languages-Standards/PHP/) topic areas.  If you don't have an account; sign-up, it is free. The authors of this system are frequent contributors and regular participants of that site.  Many other experts at the site are quite capable of assisting you as well.

## Demo Site ##

The demo sites are featured on the project's home page: [HOME](http://code.google.com/p/loginsystem-rd/).