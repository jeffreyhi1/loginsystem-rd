<%
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 19 APR 2010 rdivilbiss
'* Version:  alpha 1.0
'* On Entry: None
'* Input   : userid, email
'* Output  : new verification token emailed to account owner
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
message = lg_phrase_issue_new_token
name=""

'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD")) = "post" Then
	message=""
	userid = getField("userid,rXsafepq")
	email = getField("email,rXemail")
	'*****************************************************************************
	'* Check for required fields
	'*****************************************************************************
	If userid="" Then
		message = lg_phrase_userid_empty
	End If
	If email="" Then
		message = lg_phrase_email_empty
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, verify there is a valid account and it is locked
		'* The account is locked when a peron registers. The account must still be locked in order to
		'* receive a new verification token.
		'*******************************************************************************************************************
		If lg_database="access" Then
			cmdTxt = "SELECT [id], [userid], [name], [email], [locked] FROM users WHERE ([userid]=?) AND ([email]=?);"
		Else
			cmdTxt = "SELECT id, userid, name, email, locked FROM users WHERE (userid=?) AND (email=?);"
		End If		
		openCommand lg_term_command_string,lg_term_issue_verification_token&" 1"
		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_issue_verification_token&" 2"
		addParam "@e",adVarChar,adParamInput,CLng(Len(email)),email,lg_term_issue_verification_token&" 3"
		getRS db_rs, cmdTxt,lg_term_issue_verification_token&" 4"
		If Not(db_rs.bof AND db_rs.eof) Then
			id = db_rs("id")
			locked = db_rs("locked")
			name = db_rs("name")
			If locked<>"1" Then
				'*****************************************************************************
				'* The account was not locked. Can not issue a token.
				'*****************************************************************************
				message = lg_phrase_issue_new_token_error & " 1"
			End If
		Else
			'*****************************************************************************
			'* No account matching the posted information
			'*****************************************************************************
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
		openCommand lg_term_command_string,lg_term_issue_verification_token&" 5"
		addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_issue_verification_token&" 6"
		addParam "@locked",adVarChar,adParamInput,CLng(1),locked,lg_term_issue_verification_token&" 7"
		addParam "@dateLocked",adDate,adParamInput,CLng(8),dateLocked,lg_term_issue_verification_token&" 8"
		addParam "@id",adInteger,adParamInput,CLng(4),CInt(id),lg_term_issue_verification_token&" 9"
		execCmd cmdTxt
		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* We updated the record, so send verification email with new account unlock token to user
			'*******************************************************************************************************************
			message = lg_phrase_issue_new_token_success
		
			mailBody = mailBody & "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
			mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
			mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_phrase_registration_mail0 &"<br /><br />"
			mailBody = mailBody & lg_term_to & name & "<br /><br />"
			mailBody = mailBody & lg_phrase_registration_mail1 &" "& lg_domain &". " & lg_phrase_registration_mail2 & "<br />"
			mailBody = mailBody & lg_phrase_registration_mail3 & ".<br /><br />"
			mailBody = mailBody & "<a href=""http://" & lg_domain & lg_loginPath & lg_verify_page & "?token=" & token & "&id=1"">"& lg_phrase_registration_mail4 &"</a><br /><br />"
			mailBody = mailBody & lg_phrase_registration_mail5 & lg_domain & lg_loginPath & lg_verify_page & "<br />"
			mailBody = mailBody & lg_phrase_registration_mail6 & "<br /><br />"
			mailBody = mailBody & token & "<br /><br />"
			mailBody = mailBody & lg_phrase_registration_mail7 & "<br />"
			mailBody = mailBody & "this link: <a href=""http://" & lg_domain & lg_loginPath & lg_register_delete_page & "?email="& email &""">"& lg_term_remove_registration &"</a><br /><br />"
			mailBody = mailBody & lg_phrase_registration_mail9 & lg_domain & lg_contact_form & ">"& lg_phrase_contact_webmaster &"</a><br /><br />"
			mailBody = mailBody & lg_copyright &"<br />"
			mailBody = mailBody & "</FONT></DIV></BODY></HTML>"
			sendmail lg_webmaster_email, email, lg_term_registration_newtoken, mailBody
			sendmail lg_webmaster_email, "rod@rodsdot.com", "WEBMASTER NOTICE: "&lg_term_registration_newtoken, mailBody
		Else
			'*****************************************************************************
			'* There was an error updating the record and no new token was issued.
			'*****************************************************************************
			message = lg_phrase_issue_new_token_error & " 2"
		End If
	End If
End If
%>
