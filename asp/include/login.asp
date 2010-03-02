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
Dim redirected, destination, password, passhash, userid, useridValue, name, remember, cmdTxt, message
Dim ip, date, useragent, locked

destination=""
password=""
userid=""
useridValue=""
message= lg_term_please_login
ip = Request.ServerVariables("REMOTE_ADDR")
date = dbNow
useragent = Server.HTMLEncode(Left(Request.ServerVariables("HTTP_USER_AGENT"),255))
locked=""

If LCase(Request.ServerVariables("HTTP_METHOD")) = "get" Then
	'*******************************************************************************************************************
	'* On entry determine if we have a destination page
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
		Session("userid")=Request.Cookies("user")
		
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
		closeRS
		closeCommand
		
		'*******************************************************************************************************************
		'* If we are logging user authentications, write to the logins table
		'*******************************************************************************************************************
		If lg_log_logins Then
			cmdTxt = "INSERT INTO logins (date, userid, ip, useragent) VALUES (?, ?, ?, ?);"
			openCommand lg_term_command_string,lg_term_log_string&" 0"
			addParam "@sate",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 1"
			addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 2"
			addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 3"
			addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 4"
			execCmd cmdTxt
			closeCommand	
		End If

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
		useridValue = Server.HTMLEncode("userid")
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, attempt to autenticate the credentials
		'*******************************************************************************************************************
		cmdTxt = "SELECT name, password, locked FROM users WHERE (userid=?);"
		openCommand lg_term_command_string,lg_term_get_name&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_get_name&" 2"
		getRS db_rs, cmdTxt, lg_term_get_name&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			passhash = db_rs("password")
			name = db_rs("name")
			locked = CStr(db_rs("locked"))
		End If
		closeRS
		closeCommand
		If locked<>"1" Then
			If passhash=HashEncode(password & userid) AND NOT(locked="1") Then
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
					Response.Cookies("user").Expires = "January 1, 2015"
				End If
			
				'*******************************************************************************************************************
				'* If we are logging user authentications, write to the logins table
				'*******************************************************************************************************************
				If lg_log_logins Then
					cmdTxt = "INSERT INTO logins (date, userid, ip, useragent) VALUES (?, ?, ?, ?);"
					openCommand lg_term_command_string,lg_term_log_string&" 0"
					addParam "@date",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 1"
					addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 2"
					addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 3"
					addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 4"
					execCmd cmdTxt
					closeCommand
				End If
			
				
				'*******************************************************************************************************************
				'* Logged in, redirect
				'*******************************************************************************************************************
				Response.Redirect(destination)
			Else
				message = lg_phrase_login_error
			End if
		Else
			message = lg_phrase_login_error_token
		End if	
	End If
End if
%>