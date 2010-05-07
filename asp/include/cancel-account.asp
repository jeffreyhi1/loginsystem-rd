<%
'* alpha 0.2 debug
'* $Id$
'*******************************************************************************************************************
'* Cancel Account
'* On Entry: Verify need for SSL
'* Input:    userid, password
'* Output:   message - string variable with results
'* On Exit:  Account Deleted.
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
	Response.Redirect("https://" & lg_domain_secure & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim message, userid, password, passhash, dbPasshash, dbId, dateCancelled, cmdTxt, dbMsg

userid = ""
password = ""
message = lg_term_enter_information
passhash = ""
dbPasshash = ""
dbId = ""
dateCancelled = dbNow
cmdTxt = ""
If lg_debug Then
	dbMsg = "DEBUG BEGIN"
Else
	dbMsg = ""
End If

'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If lg_debug Then dbMsg = dbMsg & "METHOD=POST<br />" & vbLF
	checkToken
	If lg_debug Then dbMsg = dbMsg & "checkToken Okay.<br />" & vbLF
	message=""
	userid = Left(getField("userid,rXsafepq"),50)
	password = Left(getField("password,rXsafepq"),255)
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty
	End If
	If lg_debug Then dbMsg = dbMsg & "userid = "& userid &"<br />" & vbLF
	If lg_debug Then dbMsg = dbMsg & "password = "& password &"<br />" & vbLF
	If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF
	If message="" Then
	    '*******************************************************************************************************************
		'* If all required fields exist, begin process of deleting the account
		'*******************************************************************************************************************
		passhash = HashEncode(password & userid)
		If lg_debug Then dbMsg = dbMsg & "passhash calculated as = "& passhash &"<br />" & vbLF
		'*******************************************************************************************************************
		'* First, is this a valid userid and password?
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check if userid exists in users table.<br />" & vbLF
		If lg_database="access" Then
			cmdTxt = "SELECT [id], [password] FROM users WHERE ([userid]=?);"
		Else
			cmdTxt = "SELECT id, password FROM users WHERE (userid=?);"
		End If	
		openCommand lg_term_command_string,lg_term_cancel_account&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 2"
		getRS db_rs, cmdTxt, lg_term_get_name&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			dbPasshash = db_rs("password")
			dbId = db_rs("id")
			If lg_debug Then dbMsg = dbMsg & "db passhash = "& dbPasshash &"<br />" & vbLF
			If lg_debug Then dbMsg = dbMsg & "db ID = "& dbId &"<br />" & vbLF
			closeRS
			closeCommand
			If passhash = dbPasshash Then
				If lg_debug Then dbMsg = dbMsg & "calculated passhash = database passhash<br />" & vbLF
				'**********************************************************************************************************
				'* Valid used id and password, do cancel.
				'**********************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Valid credentials, do the account cancelation.<br />" & vbLF
				If lg_database="access" Then			
					cmdTxt = "UPDATE users SET [deleted]=1, [dateDeleted]=? WHERE ([userid]=?) AND ([password]=?);"
				Else
					cmdTxt = "UPDATE users SET deleted=1, dateDeleted=? WHERE (userid=?) AND (password=?);"
				End If	
				openCommand lg_term_command_string,lg_term_cancel_account&" 3"
				addParam "@dDeleted",adDate,adParamInput,CLng(8),dateCancelled,lg_term_cancel_account&" 4"
				addParam "@userid",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 5"
				addParam "@passhash",adVarChar,adParamInput,CLng(Len(passhash)),passhash,lg_term_cancel_account&" 6"
				execCmd cmdTxt
				If lg_debug Then dbMsg = dbMsg & "numAffected = "& nubAffected &"<br />" & vbLF
				If numAffected = 1 Then
					If lg_debug Then dbMsg = dbMsg & "Kill session and cookies<br />" & vbLF
					Response.Cookies("user") = ""
					Response.Cookies("user").Expires = "January 1, 2009"
					Response.Cookies("login") = ""
					Response.Cookies("login").Expires = "January 1, 2009"
					Response.Cookies("token") = ""
					Response.Cookies("token").Expires = "January 1, 2009"
					Session("userid")=""
					Session("name")=""
					Session("login")=false
					Session.Abandon
					Response.Redirect lg_logged_out_page & "?r=cancel"
				Else
					message = lg_phrase_cancel_account_error
				End If
				closeCommand
			Else
				'**********************************************************************************************************			
				'* ERROR: Invalid password, show generic error message
				'**********************************************************************************************************				
				message = lg_phrase_login_error
			End If
		Else
			'**********************************************************************************************************		
			'* ERROR: Invalid userid, show generic error message
			'**********************************************************************************************************			
			message = lg_phrase_login_error
		End If	
	End if ' if message="", nothing else needed...message already set.
End If ' if POST
%>