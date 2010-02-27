<%
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 26 FEB 2010 rdivilbiss
'* Version:  beta 1.5
'* On Entry: 
'* Input   : 
'* Output  : 
'* On Exit : 
'******************************************************************************************************************

'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim resettoken, cmdTxt, timePassed, id, userid, email, message, locked, dateLocked, mailBody
Dim newpassword, confirm, passhash, name, destination, changePassword, debug, debugout


resettoken=""
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
destination=""
changePassword=""
debug = false
debugout = ""


'*******************************************************************************************************************
'* If the resettoken was posted in the form - get the resettoken
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If debug Then debugout=debugout&"METHOD is POST<br>" & vbLF End If
	checkToken
	If debug Then debugout=debugout&"Check form token<br>" & vbLF End If
	resettoken = getField("resettoken")
	If debug Then debugout=debugout&"Reset token" & resettoken & "<br>" & vbLF End If
	If debug Then debugout=debugout&"Session(action)=" & Session("action") & "<br>" & vbLF End If
	If Session("action")="password" Then
		If debug Then debugout=debugout&"Session(action)=password<br>" & vbLF End If
		newpassword = getField("newpassword,rXsafepq")
		If debug Then debugout=debugout&"newpassword="&newpassword&"<br>" & vbLF End If
		confirm = getField("confirm,rXsafepq")
		If debug Then debugout=debugout&"confirm password="&confirm&"<br>" & vbLF End If
		changePassword=getField("changePassword,rXint")
		If debug Then debugout=debugout&"change password="&changePassword&"<br>" & vbLF End If
	Else
		Session("action") = "resettoken"
		If debug Then debugout=debugout&"Session(action)=resettoken in POST<br>" & vbLF End If	
	End if	
End if
'*******************************************************************************************************************
'* If the token was passed on the URL from a email link - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	If debug Then debugout=debugout&"METHOD GET<br>" & vbLF End If
	resettoken = getField("resettoken,rXSafe,get")
	If debug Then debugout=debugout&"reset token="&resettoken&"<br>" & vbLF End If
	destination = getField("p,rXurlpath,get")
	If debug Then debugout=debugout&"destination="&destination&"<br>" & vbLF End If
	Session("action") = "resettoken"
	If debug Then debugout=debugout&"Session(action)=resettoken in GET<br>" & vbLF End If
End if
'*******************************************************************************************************************
'* If the token exists, process account activation
'*******************************************************************************************************************
If resettoken<>"" AND Session("action")="resettoken" then
	If debug Then debugout=debugout&"resettoken not empty and Session(action)=resettoken<br>" & vbLF End If
	'*******************************************************************************************************************
	'* Get the dateLocked and verify it is within the lifetime of the token
	'*******************************************************************************************************************
	cmdTxt = "SELECT id, token, dateLocked FROM users WHERE (token=?);"
	If debug Then debugout=debugout&"cmdTxt = SELECT id, token, dateLocked FROM users WHERE (token=?);<br>" & vbLF End If
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	If debug Then debugout=debugout&"openCommand<br>" & vbLF End If
	addParam "@token",adVarChar,adParamInput,CLng(40),resettoken,lg_term_checkToken & " 3"
	If debug Then debugout=debugout&"addParam token="&resettoken&"<br>" & vbLF End If
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If debug Then debugout=debugout&"open Recordset<br>" & vbLF End If
	If NOT(db_rs.bof AND db_rs.eof) Then
		If debug Then debugout=debugout&"returned record(s)<br>" & vbLF End If
		timePassed = DateDiff("h",Now,db_rs("dateLocked"))
		If debug Then debugout=debugout&"timePassed"&timePassed&"<br>" & vbLF End If
		if (timePassed <=24) Then
			If debug Then debugout=debugout&"timePassed < 24 hours<br>" & vbLF End If
			'*******************************************************************************************************************
			'* The token is good, prepare to change password
			'*******************************************************************************************************************
			id = db_rs("id")
			If debug Then debugout=debugout&"record id="&id&"<br>" & vbLF End If
			closeRS
			CloseCommand
			If debug Then debugout=debugout&"closedCommand and closedRS<br>" & vbLF End If
			message = lg_phrase_set_new_password_good_token
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
			Session("action")="password"
			If debug Then debugout=debugout&"Session(action)=password<br>" & vbLF End If
		Else
			'*******************************************************************************************************************
			'* The token has expired: show link to Issue Verification Token page
			'*******************************************************************************************************************
			message = "<h2>lg_phrase_set_new_password_tken_expired</h2><br><br>"
			message = message & lg_phrase_contact_webmaster1 & " " & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
			If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
		End If
	Else
		message = lg_phrase_set_new_password_error & "Error 3A. "& lg_phrase_contact_webmaster1 & "<br>"
		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
		Session("action")="Error"
		If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
		If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
	End IF
	closeCommand
	If debug Then debugout=debugout&"closedCommand<br>" & vbLF End If
Else
	If changePassword="1" Then
		If debug Then debugout=debugout&"changePassword=1<br>" & vbLF End If
		message = ""
		If newpassword = "" Then
			message = message & lg_phrase_newpassword_empty & "<br>"
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
		End If
		If confirm = "" Then
			message = message & lg_phrase_confirm_empty & "<br>"
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
		End If
		If newpassword<>confirm Then
			message = message & lg_phrase_password_nomatch_confirm
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
		End If		
		If resettoken = "" Then
			 message = lg_phrase_set_new_password_error & "Error 1. "& lg_phrase_contact_webmaster1 &"<br>"
			 message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			 Session("action")="Error"
			 If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
			 If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
		End If
		If message="" Then
			cmdTxt = "SELECT id, userid, email, name, locked, dateLocked, token FROM users WHERE (token=?);"
			If debug Then debugout=debugout&"cmdTxt=SELECT [id], userid, email, name, locked, dateLocked, token FROM users WHERE (token=?)<br>" & vbLF End If
			openCommand lg_term_command_string,lg_term_checkToken & " 1"
			If debug Then debugout=debugout&"openCommand<br>" & vbLF End If
			addParam "@token",adVarChar,adParamInput,CLng(40),resettoken,lg_term_checkToken & " 3"
			If debug Then debugout=debugout&"addParam token="&resettoken&"<br>" & vbLF End If
			getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
			If debug Then debugout=debugout&"open Recordset<br>" & vbLF End If
			If NOT(db_rs.bof AND db_rs.eof) Then
				If debug Then debugout=debugout&"returned record(s)<br>" & vbLF End If
				timePassed = DateDiff("h",Now,db_rs("dateLocked"))
				If debug Then debugout=debugout&"timePassed="&timePassed&"<br>" & vbLF End If
				if (timePassed <=24) Then
					If debug Then debugout=debugout&"timePassed < 24 hours<br>" & vbLF End If
					'*******************************************************************************************************************
					'* The token is good, change passord and unlock the account
					'*******************************************************************************************************************
					id = db_rs("id")
					If debug Then debugout=debugout&"id="&id&"<br>" & vbLF End If
					userid = db_rs("userid")
					If debug Then debugout=debugout&"userid="&userid&"<br>" & vbLF End If
					email = db_rs("email")
					If debug Then debugout=debugout&"email="&email&"<br>" & vbLF End If
					name = db_rs("name")
					If debug Then debugout=debugout&"name="&name&"<br>" & vbLF End If
					locked = db_rs("locked")
					If debug Then debugout=debugout&"locked="&locked&"<br>" & vbLF End If
					dateLocked = db_rs("dateLocked")
					If debug Then debugout=debugout&"dateLocked="&dateLocked&"<br>" & vbLF End If
					closeRS
					CloseCommand
					If debug Then debugout=debugout&"closedCommand and closedRS<br>" & vbLF End If
					'*******************************************************************************************************************
					'*
					'*******************************************************************************************************************
					passhash = HashEncode(newpassword & userid)
					If debug Then debugout=debugout&"passhash="&passhash&"<br>" & vbLF End If	
					cmdTxt = "UPDATE users SET users.password = ?, users.token = ?, users.locked = ?, users.dateLocked = ? WHERE (users.id=?);"
					If debug Then debugout=debugout&"cmdTxt=UPDATE users SET users.password = ?, users.token = ?, users.locked = ?, users.dateLocked = ? WHERE (users.id=?);<br>" & vbLF End If
					openCommand lg_term_command_string,"checkToken 4"
					If debug Then debugout=debugout&"openCommand<br>" & vbLF End If
					addParam "@pass",adVarChar,adParamInput,CLng(255),passhash,"checkToken 5"
					If debug Then debugout=debugout&"addParam =password"&passhash&"<br>" & vbLF End If
					addParam "@token",adVarChar,adParamInput,CLng(40),Null,"checkToken 5"
					If debug Then debugout=debugout&"addParam token=Null<br>" & vbLF End If
					addParam "@locked",adVarChar,adParamInput,CLng(1),"0","checkToken 6"
					If debug Then debugout=debugout&"addParam locked=0<br>" & vbLF End If
					addParam "@dateLocked",adDate,adParamInput,CLng(8),Null,"checkToken 7"
					If debug Then debugout=debugout&"addParam dateLocked=Null<br>" & vbLF End If
					addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 8"
					If debug Then debugout=debugout&"addParam id="&id&"<br>" & vbLF End If
					execCmd cmdTxt
					If debug Then debugout=debugout&"execute command<br>" & vbLF End If
					If numAffected = 1 Then
						If debug Then debugout=debugout&"numAffected="&numAffected&"<br>" & vbLF End If
						message = lg_phrase_set_new_password_success
						If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
						Session("action")="Success"
						If debug Then debugout=debugout&"Session(action)=Success<br>" & vbLF End If
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
						If debug Then debugout=debugout&"Sent Mail Notification<br>" & mailBody & "<br>" & vbLF End If
					Else
						message = lg_phrase_set_new_password_error & "Error 2. "& lg_phrase_contact_webmaster1 &"<br>"
				 		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
						Session("action")="Error"
						If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
						If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
					End If
				Else
					message = "<h2>lg_phrase_verify_expired</h2><br>"& lg_phrase_contact_webmaster1 &"<br>"
					message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
					Session("action")="Error"
					If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
					If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
				End If
			Else
				message = lg_phrase_set_new_password_error & "Error 3. "& lg_phrase_contact_webmaster1 &"<br>"
				message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
				Session("action")="Error"
				If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
				If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
			End If
		Else
			message = lg_phrase_set_new_password_error & "Error 4. "& lg_phrase_contact_webmaster1 &"<br>"
			message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
			If debug Then debugout=debugout&"message="&message&"<br>" & vbLF End If
			If debug Then debugout=debugout&"Session(action)=Error<br>" & vbLF End If
		End If		
	End If
End If
%>