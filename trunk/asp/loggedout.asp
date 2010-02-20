<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/aspmsa/include/loginGlobals.asp"-->
<%
'*******************************************************************************************************************
'* Logged Out
'* Last Modification: 19 FEB 2010
'* Version:  beta 1.2
'* On Entry: N/A
'* Input:    N/A
'* Output:   lg_phrase_logged_out displayed
'* On Exit:  If no link clicked, user will be redirected to the home page in 30 seconds
'******************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_logged_out%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="en">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2005-2010 Roderick Divilbiss">
<meta name=robots content="noindex, nofollow">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="refresh" content="30;URL=http://<%=lg_domain%><%=lg_home%>">
</head>
<body>
<h1><%=lg_phrase_logged_out%></h1>
<p><a href="<%=lg_home%>" title="<%=lg_phrase_logout_continue%>"><%=lg_phrase_logout_continue%></a></p>
</body>
</html>