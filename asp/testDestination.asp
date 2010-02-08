<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
If NOT Session("login") Then
	Response.Redirect "http://" & lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME")
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title>Test Destination</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="en">
<meta name="language" content="en-US">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2005-2010 Roderick Divilbiss">
<meta name=robots content="noindex, nofollow">
</head>

<body>
<p>Test Destination Page For Login-System</p>
<p>Login State: <%=Session("login")%><br>
<a href="login.asp?p=testDestination.asp" title="The login page">You Shoud Get Sent Back If Login State Is True</a><br>
<a href="logout.asp" title="Log Out">Log Out</a></p>
</body>
</html>