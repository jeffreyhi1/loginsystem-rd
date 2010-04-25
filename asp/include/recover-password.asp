<%
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 25 APR 2010 rdivilbiss
'* Version:  alpha 0.1a
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
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim userid, name, email, id, locked, token, dateLocked, mailBody, cmdTxt, message

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


'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD")) = "post" Then
	message=""
	userid = getField("userid")
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
			If locked="1" Then ' This account is locked; the user must contact the webmaster.
				message = lg_phrase_recover_password_error & " 1"
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
		dateLocked = dbNow
		token = Left(HashEncode(getGUID),40)
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
		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* Send verification email with new account unlock token to user
			'*******************************************************************************************************************
			message = lg_phrase_recover_password_success
		
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
			sendmail lg_webmaster_email, email, lg_phrase_recover_password, mailBody
			sendmail lg_webmaster_email, lg_webmaster_email, "ATTN:Webmaster " & lg_phrase_recover_password, mailBody
		Else
			message = lg_phrase_recover_password_error & " 2"
		End If
	End If
End If
%>