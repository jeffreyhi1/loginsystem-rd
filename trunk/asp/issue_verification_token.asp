<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Issue Verification Token
'* Last Modification: 19 FEB 2010
'* Version:  beta 1.2
'* On Entry: Verify need for SSL
'* Input:    userid, email
'* Output:   message - string variable with results
'* On Exit:  New token, locked, and dateLocked written to user table
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
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim userid, name, email, id, locked, token, dateLocked, mailBody, cmdTxt, message, name

userid=""
name=""
email=""
id=""
locked=""
token=""
dateLocked=""
mailBody=""
cmdTxt=""
message = lg_phrase_issue_new_token
name=""

'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD")) = "post" Then
	message=""
	userid = getField("userid,rXsafepq")
	email = getField("email,rXemail")
	If userid="" Then
		message = lg_phrase_userid_empty
	End If
	If email="" Then
		message = lg_phrase_email_empty
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, verify there is a valid account and it is locked
		'*******************************************************************************************************************
		cmdTxt = "SELECT id, userid, name, email, locked FROM users WHERE (userid=?) AND (email=?);"
		openCommand lg_term_command_string,lg_term_issue_verification_token&" 1"
		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_issue_verification_token&" 2"
		addParam "@e",adVarChar,adParamInput,CLng(Len(email)),email,lg_term_issue_verification_token&" 3"
		getRS db_rs, cmdTxt,lg_term_issue_verification_token&" 4"
		If Not(db_rs.bof AND db_rs.eof) Then
			id = db_rs("id")
			locked = db_rs("locked")
			name = db_rs("name")
			If locked<>"1" Then
				message = lg_phrase_issue_new_token_error & " 1"
			End If
		Else
			message = lg_phrase_no_matching_registration
		End If
		closeRS
		closeCommand
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* We have a valid, locked account, issue a new token and update the user table
		'*******************************************************************************************************************
		locked="1"
		dateLocked = now
		token = Left(HashEncode(getGUID),40)
		cmdTxt = "UPDATE users SET users.token = ?, users.locked = ?, users.dateLocked = ? WHERE (users.id=?);"
		openCommand lg_term_command_string,lg_term_issue_verification_token&" 5"
		addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_issue_verification_token&" 6"
		addParam "@locked",adVarChar,adParamInput,CLng(1),locked,lg_term_issue_verification_token&" 7"
		addParam "@dateLocked",adDate,adParamInput,CLng(8),dateLocked,lg_term_issue_verification_token&" 8"
		addParam "@id",adInteger,adParamInput,CLng(4),CInt(id),lg_term_issue_verification_token&" 9"
		execCmd cmdTxt
		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* Send verification email with new account unlock token to user
			'*******************************************************************************************************************
			message = lg_phrase_issue_new_token_success
		
			mailBody = mailBody & "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
			mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
			mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_phrase_registration_mail0 &"<br><br>"
			mailBody = mailBody & lg_term_to & name & "<br><br>"
			mailBody = mailBody & lg_phrase_registration_mail1 &" "& lg_domain &". " & lg_phrase_registration_mail2 & "<br>"
			mailBody = mailBody & lg_phrase_registration_mail3 & ".<br><br>"
			mailBody = mailBody & "<a href=""http://" & lg_domain & lg_loginPath & lg_verify_page & "?token=" & token & "&id=1"">"& lg_phrase_registration_mail4 &"</a><br><br>"
			mailBody = mailBody & lg_phrase_registration_mail5 & lg_domain & lg_loginPath & lg_verify_page & "<br>"
			mailBody = mailBody & lg_phrase_registration_mail6 & "<br><br>"
			mailBody = mailBody & token & "<br><br>"
			mailBody = mailBody & lg_phrase_registration_mail7 & "<br>"
			mailBody = mailBody & "this link: <a href=""http://" & lg_domain & lg_loginPath & lg_register_delete_page & "?email="& email &""">"& lg_term_remove_registration &"</a><br><br>"
			mailBody = mailBody & lg_phrase_registration_mail9 & lg_domain & lg_contact_form & ">"& lg_phrase_contact_webmaster &"</a><br><br>"
			mailBody = mailBody & lg_copyright &"<br>"
			mailBody = mailBody & "</FONT></DIV></BODY></HTML>"
			sendmail lg_webmaster_email, email, "New Registration Token", mailBody
			sendmail lg_webmaster_email, "rod@rodsdot.com", "ATTN:Webmaster New Registration Token", mailBody
		Else
			message = lg_phrase_issue_new_token_error & " 2"
		End If
	End If
End If
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=lg_term_issue_verification_token%></title>
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>
<div id="login-system">
<h1><%=lg_term_issue_verification_token%></h1>
<% If (message = lg_phrase_issue_new_token) Then %>
<div id="message"><%=message%></div>	
<div id="formDiv">
<form name="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_issue_verification_token%></legend>
  <p><lable for="userid"><%=lg_term_userid%></lable><br><input type="text" id="userid" name="userid" title="<%=lg_phrase_userid_title%>" size="50" maxsize="50"><br>
  <p><lable for="email"><%=lg_term_email%></lable><br><input type="text" id="email" name="email" title="<%=lg_phrase_email_title%>" size="50" maxsize="255"><br>
  <input type="submit" value="<%=lg_term_submit%>"><%=writeToken%></p>
</fieldset>
</form>
</div>
<% Else %>
<div id="message"><%=message%></div>
<% End If %>
</div>

</body>

</html>
