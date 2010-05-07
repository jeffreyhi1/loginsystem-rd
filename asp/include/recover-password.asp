<%
'* alpha 0.2 debug
'* $Id$
'*******************************************************************************************************************
'* Page Name: Recover Password
'* On Entry: Check for SSL
'* Input   : userid, email
'* Output  : reset/recover password token emailed to email address of account owner
'* On Exit : message
'******************************************************************************************************************
' no browser caching of this page !! to be used on all pages
Response.Expires=-1
Response.ExpiresAbsolute = Now() - 1

' do not allow proxy servers to cache this page !! to be used on all pages
Response.AddHeader "pragma","no-cache"
Response.CacheControl="private"
Response.CacheControl="no-cache"
Response.CacheControl="no-store"

'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim userid, name, email, id, locked, token, dateLocked, mailBody, cmdTxt, message, dbMsg

userid=""
name=""
email=""
id=""
locked=""
token=""
dateLocked=""
mailBody=""
cmdTxt=""
message = lg_phrase_recover_password
dbMsg=""
If lg_debug Then dbMsg = "DEBUG BEGIN<br />" & vbLF End If
If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If

'*******************************************************************************************************************
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD")) = "post" Then
	If lg_debug Then dbMsg = dbMsg & "METHOD=POST<br />" & vbLF End If
	message=""
	userid = getField("userid,rXsafepq")
	email = getField("email,rXemail")
	If lg_debug Then dbMsg = dbMsg & "userid = "& userid &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "email = "& email &"<br />" & vbLF End If
	If userid="" Then
		message = lg_phrase_userid_empty
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	End If
	If email="" Then
		message = lg_phrase_email_empty
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, verify there is a valid account and it is locked
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "All fields present. Process field.<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT [id], [userid], [name], [email], [locked] FROM users WHERE ([userid]=?) AND ([email]=?);"
		Else
			cmdTxt = "SELECT id, userid, name, email, locked FROM users WHERE (userid=?) AND (email=?);"
		End If		
		openCommand lg_term_command_string,lg_phrase_recover_password&" 1"
		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_phrase_recover_password&" 2"
		addParam "@e",adVarChar,adParamInput,CLng(Len(email)),email,lg_phrase_recover_password&" 3"
		getRS db_rs, cmdTxt,lg_phrase_recover_password&" 4"
		If Not(db_rs.bof AND db_rs.eof) Then
			id = db_rs("id")
			locked = db_rs("locked")
			name = db_rs("name")
			If lg_debug Then dbMsg = dbMsg & "ID = "& id &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Locked = "& locked &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Name = "& name &"<br />" & vbLF End If
			If locked="1" Then ' This account is locked; the user must contact the webmaster.
				message = lg_phrase_recover_password_error & " 1"
				If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
			End If
		Else
			message = lg_phrase_no_matching_registration
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		End If
		closeRS
		closeCommand
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* We have a valid, locked account, issue a new token and update the user table
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Valid and locked account. Issue token. Update table.<br />" & vbLF End If
		locked="1"
		dateLocked = dbNow
		token = Left(HashEncode(getGUID),40)
		If lg_debug Then dbMsg = dbMsg & "Locked = "& locked &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "dateLocked = "& dateLocked &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "token = "& token &"<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "UPDATE users SET [token] = ?, [locked] = ?, [dateLocked] = ? WHERE ([id]=?);"
		Else
			cmdTxt = "UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE (id=?);"
		End If		
		openCommand lg_term_command_string,lg_phrase_recover_password&" 5"
		addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_phrase_recover_password&" 6"
		addParam "@locked",adVarChar,adParamInput,CLng(1),locked,lg_phrase_recover_password&" 7"
		addParam "@dateLocked",adDate,adParamInput,CLng(8),dateLocked,lg_phrase_recover_password&" 8"
		addParam "@id",adInteger,adParamInput,CLng(4),CInt(id),lg_phrase_recover_password&" 9"
		execCmd cmdTxt
		If lg_debug Then dbMsg = dbMsg & "numAffected = "& numAffected &"<br />" & vbLF End If
		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* Send verification email with new account unlock token to user
			'*******************************************************************************************************************
			message = lg_phrase_recover_password_success
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		
			mailBody = mailBody & "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
			mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
			mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_phrase_recover_password &"<br><br>"
			mailBody = mailBody & lg_term_to & name & "<br><br>"
			mailBody = mailBody & lg_phrase_request_password1 &" "& lg_domain &". <br>"
			mailBody = mailBody & lg_phrase_recover_password2 & "<br><br>"
			mailBody = mailBody & "<a href=""http://" & lg_domain & lg_loginPath & lg_set_new_password_page & "?resettoken=" & token & "&id=1"">"& lg_phrase_recover_password3 &"</a><br><br>"
			mailBody = mailBody & lg_phrase_registration_mail5 & lg_domain & lg_loginPath & lg_set_new_password_page & "<br>"
			mailBody = mailBody & lg_phrase_registration_mail6 & "<br><br>"
			mailBody = mailBody & token & "<br><br>"
			mailBody = mailBody & lg_phrase_recover_password4 & "<br>"
			mailBody = mailBody & lg_phrase_recover_password5 & lg_webmaster_email_link & "<br><br>"
			mailBody = mailBody & lg_copyright &"<br>"
			mailBody = mailBody & "</FONT></DIV></BODY></HTML>"
			If lg_debug Then dbMsg = dbMsg & "mailBody = "& mailBody &"<br />" & vbLF End If
			
			sendmail lg_webmaster_email, email, lg_phrase_recover_password, mailBody
			sendmail lg_webmaster_email, lg_webmaster_email, lg_phrase_attention_webmaster &" "& lg_phrase_recover_password, mailBody
			If lg_debug Then dbMsg = dbMsg & "Email notifications sent.<br />" & vbLF End If
		Else
			message = lg_phrase_recover_password_error & " 2"
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		End If
	End If
End If
%>