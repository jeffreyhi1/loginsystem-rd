<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<!--#include virtual="/login-project/asp/include/hashSHA1.asp"-->
<!--#include virtual="/login-project/asp/include/form_token.asp"-->
<!--#include virtual="/login-project/asp/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/asp/include/paramSQL.asp"-->
<!--#include virtual="/login-project/asp/include/CDOMailInclude.asp"-->
<%
'*******************************************************************************************************************
'* Login Success
'* Last Modification: 19 FEB 2010
'* Version:  beta 1.2
'* On Entry: Verify need for SSL
'* Input:    N/A
'* Output:   Session("name") - the user's name
'* On Exit:  N/A
'******************************************************************************************************************

If NOT Session("login") Then
        Response.Redirect("http://"& lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME"))
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login Success</title>
</head>

<body>
<div id="login-system">
<h1><%=lg_term_login_success%></h1>
<div id="loginSuccess">
  <p><%=Server.HTMLEncode(Session("name"))%>&nbsp;is logged in.</p>
  <p><%="<a href="""& lg_home &""" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a>"%></p>
</div>
</div>
</body>

</html>
