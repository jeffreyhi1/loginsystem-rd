<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Set New Password
'* Last Modification: 13 FEB 2010
'* Version:  beta 1.1
'* On Entry: Verify need for SSL
'* Input:    reset token
'* 			 If token good, newpassword, confirm (password)
'* Output:   message - string variable with results
'* On Exit:  New Password Set
'*           Email sent to account owner
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
Dim token, cmdTxt, timePassed, id, userid, email, message, locked, dateLocked, mailBody
Dim newpassword, confirm, passhash, name


token=""
cmdTxt=""
timePassed=""
id=""
userid=""
email=""
message = "Enter you password reset token in the field provided and press the Submit button."
locked=""
dateLocked=""
mailBody=""
newpassword = ""
confirm = ""
passhash = ""
name=""
Session("action") = "token"

'*******************************************************************************************************************
'* If the token was posted in the form - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	checkToken
	token = getField("token")
	If Session("action")="password" Then
		newpassword = getField("newpassword,rXsafepq")
		confirm = getField("confirm,rXsafepq")
		changePassword=getField("changePassword,rXint")
	End if	
End if
'*******************************************************************************************************************
'* If the token was passed on the URL from a email link - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	token = getField("token,rXSafe,get")
	destination = getField("p,rXurlpath,get")
End if
'*******************************************************************************************************************
'* If the token exists, process account activation
'*******************************************************************************************************************
If token<>"" AND Session("action")="token" then
	'*******************************************************************************************************************
	'* Get the dateLocked and verify it is within the lifetime of the token
	'*******************************************************************************************************************
	cmdTxt = "SELECT [id], token, dateLocked FROM users WHERE (token=?);"
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_checkToken & " 3"
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If NOT(db_rs.bof AND db_rs.eof) Then
		timePassed = DateDiff("h",Now,db_rs("dateLocked"))
		if (timePassed <=24) Then
			'*******************************************************************************************************************
			'* The token is good, prepare to change password
			'*******************************************************************************************************************
			id = db_rs("id")
			closeRS
			CloseCommand
			message = lg_phrase_set_new_password_good_token
			Session("action")="password"
		Else
			'*******************************************************************************************************************
			'* The token has expired: show link to Issue Verification Token page
			'*******************************************************************************************************************
			message = "<h2>lg_phrase_set_new_password_tken_expired</h2><br><br>"
			message = message & lg_phrase_contact_webmaster1 & " " & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
		End If
	Else
		message = lg_phrase_set_new_password_error" & "Error 3A. "& lg_phrase_contact_webmaster1 & "<br>"
		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
		Session("action")="Error"
	End IF
	closeCommand
Else
	If changePassword="1" Then
		message = ""
		If newpassword = "" Then
			message = message & lg_phrase_newpassword_empty & "<br>"
		End If
		If confirm = "" Then
			message = message & lg_phrase_confirm_empty & "<br>"
		End If
		If newpassword<>confirm Then
			message = message & lg_phrase_password_nomatch_confirm
		End If		
		If token = "" Then
			 message = lg_phrase_set_new_password_error" & "Error 1. "& lg_phrase_contact_webmaster1 &"<br>"
			 message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			 Session("action")="Error"
		End If
		If message="" Then
		cmdTxt = "SELECT [id], userid, email, name, locked, dateLocked, token FROM users WHERE (token=?);"
		openCommand lg_term_command_string,lg_term_checkToken & " 1"
		addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_checkToken & " 3"
		getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
		If NOT(db_rs.bof AND db_rs.eof) Then
			timePassed = DateDiff("h",Now,db_rs("dateLocked"))
			if (timePassed <=24) Then
				'*******************************************************************************************************************
				'* The token is good, change passord and unlock the account
				'*******************************************************************************************************************
				id = db_rs("id")
				userid = db_rs("userid")
				email = db_rs("email")
				name = db_rs("name")
				locked = db_rs("locked")
				dateLocked = db_rs("dateLocked")
				closeRS
				CloseCommand
				'*******************************************************************************************************************
				'*
				'*******************************************************************************************************************
				passhash = HashEncode(newpassword & userid)
				openCommand lg_term_command_string,"checkToken 4"	
				cmdTxt = "UPDATE users SET users.password = ?, users.token = ?, users.locked = ?, users.dateLocked = ? WHERE (users.id=?);"
				addParam "@pass",adVarChar,adParamInput,CLng(255),passhash,"checkToken 5"
				addParam "@token",adVarChar,adParamInput,CLng(40),Null,"checkToken 5"
				addParam "@locked",adVarChar,adParamInput,CLng(1),"0","checkToken 6"
				addParam "@dateLocked",adDate,adParamInput,CLng(8),Null,"checkToken 7"
				addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 8"
				execCmd cmdTxt
				If numberAffected = 1 Then
					message = lg_phrase_set_new_password_success
					Session("action")="Success"
					'*******************************************************************************************************************
					'* Notify account holder of password change
					'*******************************************************************************************************************
					mailBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
					mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=UTF-8"">"
					mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_phrase_password_changed_pre & lg_domain & lg_phrase_password_changed_post &" "& Now &"<br><br>"
					mailBody = mailBody & lg_phrase_password_change_authorized
					mailBody = mailBody & lg_term_via_email & " " & lg_webmaster_email_link & " " & lg_term_immediately & "<br>"
					mailBody = mailBody & lg_term_or & " " & lg_term_at & "&nbsp;the <a href=""" & lg_contact_form & """>" & lg_term_contact_form & "</a><br>"
					mailBody = mailBody & "</FONT></DIV>"
					mailBody = mailBody & "</div></BODY></HTML>"
					sendmail lg_webmaster_email, name & "<"&email&">", lg_phrase_password_changed, mailBody
					sendmail lg_webmaster_email, lg_webmaster_email, "ATTN:Webmaster " & lg_phrase_password_changed, mailBody
				Else
					message = lg_phrase_set_new_password_error" & "Error 2. "& lg_phrase_contact_webmaster1 &"<br>"
			 		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
					Session("action")="Error"
				End If
			Else
				message = "<h2>lg_phrase_verify_expired</h2><br>"& lg_phrase_contact_webmaster1 &"<br>"
				message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
				Session("action")="Error"
			End If
		Else
			message = lg_phrase_set_new_password_error" & "Error 3. "& lg_phrase_contact_webmaster1 &"<br>"
			message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
		End If	
	End If
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_reset_password%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2005-2010 Roderick Divilbiss">
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>

</head>

<body>
<div id="login-system">
<h1><%=lg_term_reset_password%></h1>
<% If Session("action")="token" Then %>
<div id="message"><%=message%></div>	
<div id="formDiv">
<form name="frm1" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_registration_verification%></legend>
  <p><lable for="token"><%=lg_phrase_enter_unlock_code%></lable><br><input type="text" id="token" name="token" size="50" maxsize="64"><br>
  <input type="submit" value="<%=lg_term_submit%>"><%=writeToken%><input name="changePassword" type="hidden" value=""></p>
</fieldset>
</form>
</div>
<% 
Else
	If Session("action")="password" Then
%>
<div id="message"><%=message%></div>	
<div id="formDiv">
<form name="frm2" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_set_new_password%></legend>
  <p><lable for="newpassword"><%=lg_term_new_password%></lable><br><input id="newpassword" name="newpassword" type="password" size="50" maxsize="255"><br>
  <lable for="newpassword"><%=lg_term_confirm%></lable><br><input id="confirm" name="confirm" type="password" size="50" maxsize="255"><br>
  <input type="submit" value="<%=lg_term_submit%>"><%=writeToken%><input name="changePassword" type="hidden" value="1"><input type="hidden" name="token" value="<%=token%>"></p>
</fieldset>
</form>
</div>
<%
	Else
	' must be success or error, in either case we just show a message.
%>
<div id="message"><%=message%></div>
<% 
	End If
End If 
%>
</div>
</body>
</html>