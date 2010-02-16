<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Login
'* Last Modification: 26 JAN 2010
'* Version:  beta 1.1
'* On Entry: Verify need for SSL
'*			 Determine final redirect path; destination page or login success page
'* Input:    userid, password, remember
'* Output:   message - string variable with results
'* On Exit:  User logged in
'*           User redirected to final redirect path
'******************************************************************************************************************
%>
<!--#include virtual="/login-project/asp/include/hashSHA1.asp"-->
<!--#include virtual="/login-project/asp/include/form_token.asp"-->
<!--#include virtual="/login-project/asp/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/asp/include/paramSQL.asp"-->
<!--#include virtual="/login-project/asp/include/CDOMailInclude.asp"-->
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim redirected, destination, password, passhash, userid, name, remember, cmdTxt, message

destination=""
password=""
userid=""
message= lg_term_please_login

If LCase(Request.ServerVariables("HTTP_METHOD")) = "get" Then
	'*******************************************************************************************************************
	'* On entry determin if we have a destination page
	'*******************************************************************************************************************
	destination = getField("p,rXurlpath,get")
	If destination = "" Then
		destination = lg_success_page
	End If
	
	
	'*******************************************************************************************************************
	'* If already logged on, redirect
	'*******************************************************************************************************************
	If Session("login") AND destination<>"" Then
		Response.Redirect(destination)
	End If
	
	'*******************************************************************************************************************
	'* Is login state save in the user's cookies? If so log user in
	'*******************************************************************************************************************
	If Request.Cookies("user") & ""<>"" Then
		Session("login")=True
		Session("userid")=userid
		
		'*******************************************************************************************************************
		'* Lookup user's name
		'*******************************************************************************************************************
		cmdTxt = "SELECT name FROM users WHERE (userid=?);"
		openCommand lg_term_command_string,lg_term_error_string&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_error_string&" 2"
		getRS db_rs, cmdTxt,lg_term_error_string&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			name = db_rs("name")
			Session("name")=name
		End If
		
		'*******************************************************************************************************************
		'* If we are logging user authentications, write to the logins table
		'*******************************************************************************************************************
		If lg_log_logins Then
			cmdTxt = "INSERT INTO logins ([Date], userid, ip, useragent) VALUES (?, ?, ?, ?);"
			addParam "@sate",adDate,adParamInput,CLng(8),(now),lg_term_log_string&" 1"
			addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_log_string&" 2"
			addParam "@ip",adVarChar,adParamInput,CLng(32),Request.ServerVariables("REMOTE_ADDR"),lg_term_log_string&" 3"
			addParam "@ua",adVarChar,adParamInput,CLng(255),Server.HTMLEncode(Trim(Left(Request.ServerVariables("HTTP_USER_AGENT"),255))),lg_term_log_string&" 4"
			execCmd cmdTxt
		End If
		closeRS
		closeCommand

		'*******************************************************************************************************************
		'* Logged in, redirect
		'*******************************************************************************************************************
		Response.Redirect("destination")
	End If
	'*******************************************************************************************************************
	'* NOT LOGGED IN: If SSL required and not using SSL, redirect to https
	'*******************************************************************************************************************
	If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
		Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename &"?p="&destination)
	End If
Else
	'*******************************************************************************************************************
	'* The form was posted, process the form
	'*******************************************************************************************************************
	checkToken
	message = ""
	password = Trim(Left(getField("password,rXsafepq"),255))
	userid = Trim(Left(getField("userid,rXsafepq"),32))
	remember = Trim(Left(getField("remember,rXalpha"),3)) ' Yes or empty
	destination = getField("destination,rXurlpath")       ' saved final destination
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty & "<br>" & vbLF
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty & "<br>" & vbLF
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, attempt to autenticate the credentials
		'*******************************************************************************************************************
		cmdTxt = "SELECT name, password FROM users WHERE (userid=?);"
		openCommand lg_term_command_string,lg_term_get_name&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_get_name&" 2"
		getRS db_rs, cmdTxt, lg_term_get_name&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			passhash = db_rs("password")
			name = db_rs("name")
		End If
		
		If passhash=HashEncode(password & userid) Then
			'*******************************************************************************************************************
			'* If credential are valid log the user in
			'*******************************************************************************************************************
			Session("login")=True
			Session("userid")=userid
			Session("name")=name
			
			'*******************************************************************************************************************
			'* If the user wishes to have authentication remembered, write the permanent cookies
			'*******************************************************************************************************************
			If lg_term_remember AND getField("remember")="Yes" Then
				Response.Cookies("user") = userid
				Response.Cookies("login").Expires = "January 1, 2015"
			End If
			
			'*******************************************************************************************************************
			'* If we are logging user authentications, write to the logins table
			'*******************************************************************************************************************
			If lg_log_logins Then
				cmdTxt = "INSERT INTO logins ([Date], userid, ip, useragent) VALUES (?, ?, ?, ?);"
				addParam "@date",adDate,adParamInput,CLng(8),(now),lg_term_log_string&" 1"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_log_string&" 2"
				addParam "@ip",adVarChar,adParamInput,CLng(32),Request.ServerVariables("REMOTE_ADDR"),lg_term_log_string&" 3"
				addParam "@ua",adVarChar,adParamInput,CLng(255),Server.HTMLEncode(Trim(Left(Request.ServerVariables("HTTP_USER_AGENT"),255))),lg_term_log_string&" 4"
				execCmd cmdTxt
			End If
			closeRS
			closeCommand
			
			'*******************************************************************************************************************
			'* Logged in, redirect
			'*******************************************************************************************************************
			Response.Redirect(destination)
                Else
                       message = lg_phrase_login_error
		End If
	End If
End if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=lg_term_login%></title>
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
#remember_me_warning { border:1px solid #FF0000; padding:2px; background-color:#FFFFCC; color:#FF0000; font-weight:bold; margin-bottom:5px; }
</style>
</head>

<body>
<div id="login-system">
<h1><%=lg_term_login%></h1>
<% If Session("login")<>True Then %>
<div id="message"><%=message%></div>
<form id="frm" name="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_login%></legend>
  <label for="userid"><%=lg_term_userid %></label><br><input id="userid" name="userid" title="lg_phrase_userid_title" type="text" size="20" maxlength="32"><span class="field_normal"><%=lg_term_required%></span><br>
  <label for="password"><%=lg_term_password %></label><br><input id="password" name="password" title="lg_phrase_password_title" type="password" size="20" maxlength="255"><span class="field_normal"><%=lg_term_required%></span><br>
  <label for="remember"><%=lg_term_rememberme %></label><input id="remember" name="remember" type="checkbox" value="Yes"><input type="hidden" id="destination" name="destination" value="<%=destination%>"><br>
  <div id="remember_me_warning"><%=lg_phrase_remember_me_warning%></div><% writeToken %>
  <input type="submit" value="<%=lg_login_button_text %>">
</fieldset>
</form>
<p><a title="<%=lg_term_recover_password%>" href="<%=lg_recover_passsword_page%>"><%=lg_term_recover_password%></a>&nbsp;|&nbsp;<a href="<%=lg_register_page&"?p="&destination%>" title="<%=lg_term_register%>"><%=lg_term_register%></a></p>
<% Else %>
<div id="message"><%=message%></div>
<% End If %>
</div>
<body>

</body>

</html>