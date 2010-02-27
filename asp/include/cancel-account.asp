<%
'*******************************************************************************************************************
'* Cancel Account
'* Last Modification: 25 FEB 2010 rdivilbiss
'* Version:  beta 1.5
'* On Entry: Verify need for SSL
'* Input:    userid, password
'* Output:   message - string variable with results
'* On Exit:  Account Deleted.
'******************************************************************************************************************

'*******************************************************************************************************************
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	Response.Redirect("https://" & lg_domain_secure & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim message, userid, password, passhash, dbPasshash, dbId, dateCancelled, cmdTxt

userid = ""
password = ""
message = lg_term_enter_information
passhash = ""
dbPasshash = ""
dbId = ""
dateCancelled = dbNow
cmdTxt = ""

'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	checkToken
	message=""
	userid = Left(getField("userid,rXsafepq"),32)
	password = Left(getField("password,rXsafepq"),255)
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty
	End If
	If message="" Then
	    '*******************************************************************************************************************
		'* If all required fields exist, begin process of deleting the account
		'*******************************************************************************************************************
		passhash = HashEncode(password & userid)
		'*******************************************************************************************************************
		'* First, is this a valid userid and password?
		'*******************************************************************************************************************
		cmdTxt = "SELECT id, password FROM users WHERE (userid=?);"
		openCommand lg_term_command_string,lg_term_cancel_account&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 2"
		getRS db_rs, cmdTxt, lg_term_get_name&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			dbPasshash = db_rs("password")
			dbId = db_rs("id")
			closeRS
			closeCommand
			If passhash = dbPasshash Then
				'**********************************************************************************************************
				'* Valid used id and password, do cancel.
				'**********************************************************************************************************				
				cmdTxt = "UPDATE users SET deleted=1, dateDeleted=? WHERE (userid=?) AND (password=?);"
				openCommand lg_term_command_string,lg_term_cancel_account&" 3"
				addParam "@dDeleted",adDate,adParamInput,CLng(8),dateCancelled,lg_term_cancel_account&" 4"
				addParam "@userid",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 5"
				addParam "@passhash",adVarChar,adParamInput,CLng(Len(passhash)),passhash,lg_term_cancel_account&" 6"
				execCmd cmdTxt
				If numAffected = 1 Then
					message = lg_phrase_cancel_account_cacelled
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
