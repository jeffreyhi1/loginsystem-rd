<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Change Password
'* Last Modification: 26 JAN 2010
'* Version:  beta 1.1
'* On Entry: Verify need for SSL
'* Input:    oldpassword, newpassword, confirm
'* Output:   message - string variable with results
'* On Exit:  Password Changed
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
'* Must be logged in to change password. If not logged in redirect to login.asp
'*******************************************************************************************************************
Dim debugout
If lg_debug Then debugout = "DEBUG BEGIN<br>Check for Session(login)<br>" End If 
If NOT Session("login") AND lg_useSSL AND NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	If lg_debug Then debugout = debugout & "Not loggedin, useSSL=true, not secure port: redirecting to login<br>" End If
	Response.Redirect("https://" & lg_domain_secure & lg_loginPath & lg_loginPage &"?p=" & Request.ServerVariables("SCRIPT_NAME"))
Else
	If NOT Session("login") Then
		If lg_debug Then debugout = debugout & "not logged in, not using SSL, redirecting to login<br>" End If
		Response.Redirect("http://" & lg_domain & lg_loginPath & lg_loginPage &"?p=" & Request.ServerVariables("SCRIPT_NAME"))
	End If
End If


'*******************************************************************************************************************
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	If lg_debug Then debugout = debugout & "Logged in, but using SSL, recalling this page secure<br>" End If
	Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename)
End If

'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim cmdTxt, name, email, oldpassword, password, newpassword, confirm, oldpasshash, oldpasshashconfirm, passhash, message, mailBody
cmdTxt=""
email=""
password=""
message=lg_phrase_change_password
If lg_debug Then debugout = debugout & "message: "&message&"<br>" End If
'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If lg_debug Then debugout = debugout & "POST: checkToken<br>" End If
	checkToken
	If lg_debug Then debugout = debugout & "checkToken okay<br>" End If
	message=""
	If lg_debug Then debugout = debugout & "message: "&message&"<br>" End If
	oldpassword = getField("oldpassword,rXsafepq")
	If lg_debug Then debugout = debugout & "oldpassword: "&oldpassword&"<br>" End If
	newpassword = getField("password,rXsafepq")
	If lg_debug Then debugout = debugout & "newpassword: "&newpassword&"<br>" End If
	confirm = getField("confirm,rXsafepq")
	If lg_debug Then debugout = debugout & "confirm password: "&confirm&"<br>" End If
	If oldpassword & ""="" Then
		If lg_debug Then debugout = debugout & "oldpassword empty<br>" End If
		message = message & lg_phrase_oldpassword_empty & "<br>"
	End If
	If newpassword & ""="" Then
		If lg_debug Then debugout = debugout & "newpassword empty<br>" End If
		message = message & lg_phrase_newpassword_empty & "<br>"
	End If
	If confirm & ""="" Then
		If lg_debug Then debugout = debugout & "confirm password empty<br>" End If
		message = message & lg_phrase_confirm_empty & "<br>"
	End If
	'*******************************************************************************************************************
	'* If all required fields exist, update database with new password hash
	'*******************************************************************************************************************
	If message="" Then
		If lg_debug Then debugout = debugout & "All required fields present: Process form<br>" End If
		cmdTxt = "SELECT name, email, password FROM users WHERE(userid=@u);"
		If lg_debug Then debugout = debugout & "cmdTxt = SELECT name, email, password FROM users WHERE(userid=@u);<br>" End If
		openCommand lg_term_command_string,lg_term_get_oldpassword&" 1"
		If lg_debug Then debugout = debugout & "opened command object<br>" End If
		addParam "@u",adVarChar,adParamInput,CLng(Len(Session("userid"))),Session("userid"),lg_term_get_oldpassword&" 2"
		If lg_debug Then debugout = debugout & "added parameter userid: "&Session("userid")&"<br>" End If
		getRS db_rs, cmdTxt, lg_term_get_oldpassword&" 3"
		If lg_debug Then debugout = debugout & "executed get recordset<br>" End If
		If Not(db_rs.bof AND db_rs.eof) Then
			If lg_debug Then debugout = debugout & "Recordset not empty<br>" End If
			oldpasshash = db_rs("password")
			If lg_debug Then debugout = debugout & "oldhash = "&oldpasshash&"<br>" End If
			name = db_rs("name")
			If lg_debug Then debugout = debugout & "name = "&name&"<br>" End If
			email = db_rs("email")
			If lg_debug Then debugout = debugout & "email = "&email&"<br>" End If
		End If
                closeCommand
		closeRS
		If newpassword=confirm Then
			If lg_debug Then debugout = debugout & "newpassword matches confirm password<br>" End If
			oldpasshashconfirm = HashEncode(oldpassword & Session("userid"))
			If lg_debug Then debugout = debugout & "verification hash computed as: "&oldpasshashconfirm&"<br>" End If
			if oldpasshashconfirm=oldpasshash Then
				If lg_debug Then debugout = debugout & "oldpassword hash matches stored password hash<br>" End If
				passhash = HashEncode(newpassword & Session("userid"))
                                openCommand lg_term_command_string,lg_term_set_newpassword&" 1"
				cmdTxt = "UPDATE users SET [password]=@p WHERE ([userid]=@u);"
				If lg_debug Then debugout = debugout & "cmdTxt = UPDATE users SET (password=@p) WHERE (userid=@u);<br>" End If
				addParam "@p",adVarChar,adParamInput,CLng(Len(passhash)),passhash,lg_term_set_newpassword&" 2"
				If lg_debug Then debugout = debugout & "parameter added passhash: "&passhash&"<br>" End If
				addParam "@u",adVarChar,adParamInput,CLng(Len(Session("userid"))),Session("userid"),lg_term_set_newpassword&" 3"
				If lg_debug Then debugout = debugout & "parameter added userid: "&Session("userid")&"<br>" End If
				execCmd cmdTxt
				If lg_debug Then debugout = debugout & "executed command<br>" End If
				If numAffected=1 Then
					If lg_debug Then debugout = debugout & "SUCCESS: numAffected=1<br>" End If
					'*******************************************************************************************************************
					'* Notify account holder of password change
					'*******************************************************************************************************************
					mailBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
					mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=UTF-8"">"
					mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_phrase_password_changed_pre & lg_domain & lg_phrase_password_changed_post &" "& Now &"<br><br>"
					mailBody = mailBody & lg_phrase_password_change_authorized
					mailBody = mailBody & lg_term_via_email & " " & lg_webmaster_email_link & " " & lg_term_immediately & "<br>"
					mailBody = mailBody & lg_term_or & " " & lg_term_at & "the <a href=""" & lg_contact_form & """>" & lg_term_contact_form & "</a><br>"
					mailBody = mailBody & "</FONT></DIV>"
					mailBody = mailBody & "</div></BODY></HTML>"
					If lg_debug Then debugout = debugout & "Send Mail To Owner<br>" & mailBody End If
					sendmail lg_webmaster_email, name & "<"&email&">", lg_phrase_password_changed, mailBody
					message = lg_phrase_password_changed
				Else
					message = lg_phrase_password_changed_error
					If lg_debug Then debugout = debugout & message & "<br>" End If
				End if
                                closeCommand
			Else
				message = lg_phrase_oldpassword_does_not_match
				If lg_debug Then debugout = debugout & message & "<br>" End If
			End If
		Else
			message = lg_phrase_password_nomatch_confirm
			If lg_debug Then debugout = debugout & message & "<br>" End If
		End If
	Else
		If lg_debug Then debugout = debugout & "NOT ALL REQUIRED FIELDS<br>" End If
	End If
Else
	If lg_debug Then debugout = debugout & "HTTP METHOD GET<br>" End If
End If					
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_change_password%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>
<div id="login-system">
<h1><%=lg_term_change_password%></h1>
<% If message <> lg_phrase_password_changed Then %>
<div id="message"><%=message%></div>
<form id="frm" name="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_change_password%></legend>
  <label for="oldpassword"><%=lg_term_current_password%>&nbsp;</label><br><input id="oldpassword" name="oldpassword" type="password" size="25" maxlength="255" title="<%=lg_phrase_oldpassword_title%>"><span class="field_normal"><%=lg_term_required%></span><br>
  <label for="newpassword"><%=lg_term_password%>&nbsp;</label><br><input id="password" name="password" type="password" size="25" maxlength="255" title="<%=lg_phrase_password_title%>"><span class="field_normal"><%=lg_term_required%></span><br>
  <label for="confirm"><%=lg_term_confirm%>&nbsp;</label><br><input id="confirm" name="confirm" type="password" size="25" maxlength="255" title="<%=lg_phrase_confirm_title%>"><span class="field_normal"><%=lg_term_required%></span><br>
  <%=writeToken%><input id="submit" name="submit" type="submit" value="<%=lg_term_change_password_button_text%>">
</fieldset>
</form>
<% Else %>
<div id="message"><%=message%></div>
<% End If %>
</div>
<%=debugout%>
</body>

</html>
