<%
' $Id$
'*******************************************************************************************************************
'* Page Name: Login
'* Version:  alpha 0.1c debug
'* On Entry: Check for need of SSL, check for Login cookie, check for account lockout
'* Input   : UserID, Password
'* Output  : message
'* On Exit : redirect to destination, login_success.asp, form_error, or forbidden depending on status
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
Dim redirected, destination, password, passhash, userid, useridValue, name, remember, cmdTxt, message
Dim ip, date, useragent, locked, laID, laUserID, laNumber, laIP, laDate, laLocked, laDeleted, tmpStr, dbMsg

destination=""
password=""
userid=""
useridValue=""
message= lg_term_please_login
ip = Request.ServerVariables("REMOTE_ADDR")
date = dbNow
useragent = Server.HTMLEncode(Left(Request.ServerVariables("HTTP_USER_AGENT"),255))
locked=""
If lg_debug Then
	dbMsg = "DEBUG BEGIN"
Else
	dbMsg = ""
End If

	
If LCase(Request.ServerVariables("HTTP_METHOD")) = "get" Then
	If lg_debug Then dbMsg = dbMsg & "METHOD=GET<br />" & vbLF End If
	'*******************************************************************************************************************
	'* On entry determine if we have a destination page
	'*******************************************************************************************************************
	destination = getField("p,rXurlpath,get")
	If destination = "" Then
		destination = lg_success_page
	End If
	If lg_debug Then dbMsg = dbMsg & "destination = "& destination &"<br />" & vbLF End If
	'*******************************************************************************************************************
	'* If already logged on, redirect - assuming if Session("login")=true then user is not locked out.
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "Session login = "& Session("login") &"<br />" & vbLF End If
	If Session("login") Then
		If lg_debug Then dbMsg = dbMsg & "Request.Cookies user = "& Request.Cookies("user") &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "Session antiFixation = "& Session("antiFixation") &"<br />" & vbLF End If
		'*******************************************************************************************************************
		'* Determine if we have deleted or locked user
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Session userid = "& Session("userid") &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "Check for deleted or locked user in users table<br />" & vbLF End If
		If lg_database="access" Then	
			cmdTxt = "SELECT [deleted], [locked] FROM users WHERE [userid]=?;"
		Else
			cmdTxt = "SELECT deleted, locked FROM users WHERE userid=?;"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 1"
		addParam "@u",adVarChar,adParamInput,CLng(50),Session("userid"),lg_term_error_string&" 2"
		getRS db_rs, cmdTxt,lg_term_error_string&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("locked")
			laDeleted = db_rs("deleted")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Deleted = "& laDeleted &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If locked or deleted the redirect to forbidden.
		'*******************************************************************************************************************		
		If (laLocked="1") OR (laDeleted="1") Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=1")		
		End If
		
		'*******************************************************************************************************************
		'* Determine if we have a valid anti-session fixation cookie, if not redirect to forbidden
		'*******************************************************************************************************************
		If Request.Cookies("user")=Session("antiFixation") Then 
			If (lg_useSSL) Then
				Response.Redirect("https://". lg_domain_secure & lg_loginPath & destination)
			Else
				Response.Redirect("http://". lg_domain_secure & lg_loginPath & destination)
			End If	
		Else
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=2")
		End If	
	End If
	
	'*******************************************************************************************************************
	'* Determine if we have Cookie Login
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "Request.Cookies login= "& Session("login") &"<br />" & vbLF End If
	If Request.Cookies("login") = "" Then
		'*******************************************************************************************************************
		'* There is no login cookie. Make sure IP is not locked out by loginAttempts
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check for IP ban by loginAttempts<br />" & vbLF End If
		If lg_database="access" Then	
			cmdTxt = "SELECT MAX([loginLocked]) as loginLocked FROM loginAttempts WHERE [loginAttemptIP] = ?);"
		Else
			cmdTxt = "SELECT MAX(loginLocked) as loginLocked FROM loginAttempts WHERE loginAttemptIP = ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 4"
		addParam "@i",adVarChar,adParamInput,CLng(Len(ip)),ip,lg_term_error_string&" 5"
		getRS db_rs, cmdTxt,lg_term_error_string&" 6"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("loginLocked")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************
		If laLocked="1" Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon		
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=3")
		End If
		
		'*******************************************************************************************************************
		'* No Cookie Login and IP Not Locked Setup Login Attempts Record for POST
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Setup Login Attempts Record<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "INSERT INTO loginAttempts ([loginAttemptDate], [loginAttemptIP]) VALUES (?, ?);"
		Else	
			cmdTxt = "INSERT INTO loginAttempts (loginAttemptDate, loginAttemptIP) VALUES (?, ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 7"
		addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 8"
		addParam "@i",adVarChar,adParamInput,CLng(Len(ip)),ip,lg_term_error_string&" 9"	
		execCmd cmdTxt
		If lg_debug Then dbMsg = dbMsg & "Number of Records Affected = "& numAffected &"<br />" & vbLF End If
		closeCommand
		
		'*******************************************************************************************************************
		'* NOT LOGGED IN: If SSL required and not using SSL, redirect to https
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "lg_useSSL = "& lg_useSSL &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "SERVER PORT SECURE = "& Request.ServerVariables("SERVER_PORT_SECURE") &"<br />" & vbLF End If
		If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
			Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename &"?p="&destination)
		End If	
	Else
		'*******************************************************************************************************************
		'* User Login Is Saved In Login Cookie.
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Request.Cookies login = "& Request.Cookies("login") &"<br />" & vbLF End If
		userid = Request.Cookies("login")
		'*******************************************************************************************************************
		'* Cookie or no cookie the userid could be deleted or locked.
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check for deleted or locked user in users table<br />" & vbLF End If
		If lg_database="access" Then	
			cmdTxt = "SELECT [deleted], [locked] FROM users WHERE [userid]=?;"
		Else
			cmdTxt = "SELECT deleted, locked FROM users WHERE userid=?;"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 10"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 11"
		getRS db_rs, cmdTxt,lg_term_error_string&" 12"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("locked")
			laDeleted = db_rs("deleted")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Deleted = "& laDeleted &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************		
		If (laLocked="1") OR (laDeleted="1") Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=4")		
		End If
		
		'*******************************************************************************************************************
		'* Userid was not deleted or locked in users
		'*******************************************************************************************************************
		Session("userid")=Request.Cookies("login")
		destination = lg_success_page
		If lg_debug Then dbMsg = dbMsg & "UserID = "& userid &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "Session userid = "& Session("userid") &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "destination = "& destination &"<br />" & vbLF End If
		
		'*******************************************************************************************************************
		'* Cookie or not the UserID and/or IP could be locked out by loginAttempts
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check if userid or IP is locked out by loginAttempts<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT MAX([loginLocked]) as loginLocked FROM loginAttempts WHERE [loginAttemptIP] = ? OR [loginAttemptUserID] = ?);"
		Else
			cmdTxt = "SELECT MAX(loginLocked) as loginLocked FROM loginAttempts WHERE loginAttemptIP = ? OR loginAttemptUserID = ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 13"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 14"
		addParam "@i",adVarChar,adParamInput,CLng(32),ip,lg_term_error_string&" 15"
		getRS db_rs, cmdTxt,lg_term_error_string&" 16"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("loginLocked")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************
		If laLocked="1" Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=5")
		End If
	
		'*******************************************************************************************************************
		'* Lookup user's name and locked from user's table
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Lookup username<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT [name], [locked] FROM users WHERE ([userid]=?);"
		Else
			cmdTxt = "SELECT name, locked FROM users WHERE (userid=?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 17"
		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_error_string&" 18"
		getRS db_rs, cmdTxt,lg_term_error_string&" 19"
		If Not(db_rs.bof AND db_rs.eof) Then
			name = db_rs("name")
			laLocked = db_rs("locked")
			If lg_debug Then dbMsg = dbMsg & "name = "& name &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "locked = "& locked &"<br />" & vbLF End If
		End If
		closeRS
		closeCommand
		
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************
		If laLocked="1" Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=6")
		End If
			'*******************************************************************************************************************
			'* Not locked out, login via cookie
			'*******************************************************************************************************************		
			Session("login")=True
			Session("name")=name
			Session("userid")=userid
			If lg_debug Then dbMsg = dbMsg & "Session login = "& Session("login") &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Session name = "& Session("name") &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Session userid = "& Session("userid") &"<br />" & vbLF End If
			
			'*******************************************************************************************************************
			'* Credentials are valid, issue a anti Session Fixation cookie
			'*******************************************************************************************************************
			If lg_debug Then dbMsg = dbMsg & "Credentials are valid - issue anti Session Fixation cookie.<br />" & vbLF End If
			tmpStr = getGUID
			If lg_debug Then dbMsg = dbMsg & "GUID = "& tmpStr &"<br />" & vbLF End If
			tmpStr = HashEncode(Session.SessionID & Request.ServerVariables("REMOTE_ADDR") & tmpStr)
			If lg_debug Then dbMsg = dbMsg & "anti Session Fixation Token = "& tmpStr &"<br />" & vbLF End If
			Response.Cookies("user") = tmpStr
			Response.Cookies("user").Expires = Dateadd("s", 1200, Now()) ' 20 minutes
			Session("antiFixation") = tmpStr
			If lg_debug Then dbMsg = dbMsg & "Session antiFixation = "& Session("antiFixation") &"<br />" & vbLF End If

			'*******************************************************************************************************************
			'* If we are logging user authentications, write to the logins table
			'*******************************************************************************************************************
			If lg_log_logins Then
				If lg_debug Then dbMsg = dbMsg & "log_logins = "& log_logins &"<br />" & vbLF End If
				If lg_database="access" Then
					cmdTxt = "INSERT INTO logins ([date], [userid], [ip], [useragent]) VALUES (?, ?, ?, ?);"
				Else
					cmdTxt = "INSERT INTO logins (date, userid, ip, useragent) VALUES (?, ?, ?, ?);"
				End If
				openCommand lg_term_command_string,lg_term_log_string&" 20"
				addParam "@sate",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 21"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 22"
				addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 23"
				addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 24"
				execCmd cmdTxt
				If lg_debug Then dbMsg = dbMsg & "Log Login Number Affected = "& numAffected &"<br />" & vbLF End If
				closeCommand	
			End If
			If Session("login")=True Then
				Response.Redirect(destination)
			End If
		End If
	End If
Else
	'*******************************************************************************************************************
	'* The form was posted, process the form
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "METHOD=POST, checkToken<br />" & vbLF End If
	checkToken
	If lg_debug Then dbMsg = dbMsg & "checkToken Okay<br />" & vbLF End If
	message = ""
	password = Trim(Left(getField("password,rXsafepq"),255))
	userid = Trim(Left(getField("userid,rXsafepq"),50))
	remember = Trim(Left(getField("remember,rXalpha"),3)) ' Yes or empty
	destination = getField("destination,rXurlpath")       ' saved final destination
	If lg_debug Then dbMsg = dbMsg & "POSTED password = "& password &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "POSTED userid = "& userid &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "POSTED remember = "& remember &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "POSTED destination = "& destination &"<br />" & vbLF End If
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty & "<br>" & vbLF
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	Else
		useridValue = Server.HTMLEncode(userid)
		If lg_debug Then dbMsg = dbMsg & "useridValue = "& useridValue &"<br />" & vbLF	 End If
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty & "<br>" & vbLF
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* Userid could be deleted or locked.
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check for deleted or locked user in users table<br />" & vbLF End If
		If lg_database="access" Then	
			cmdTxt = "SELECT [deleted], [locked] FROM users WHERE [userid]=?;"
		Else
			cmdTxt = "SELECT deleted, locked FROM users WHERE userid=?;"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 25"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 26"
		getRS db_rs, cmdTxt,lg_term_error_string&" 27"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("locked")
			laDeleted = db_rs("deleted")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Deleted = "& laDeleted &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************		
		If (laLocked="1") OR (laDeleted="1") Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=7")		
		End If
		
		'*******************************************************************************************************************
		'* Check for lock out on loginAttempts
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check if userid or IP is locked out by loginAttempts<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT MAX([loginLocked]) as loginLocked FROM loginAttempts WHERE [loginAttemptIP] = ? OR [loginAttemptUserID] = ?);"
		Else
			cmdTxt = "SELECT MAX(loginLocked) as loginLocked FROM loginAttempts WHERE loginAttemptIP = ? OR loginAttemptUserID = ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 28"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 29"
		addParam "@i",adVarChar,adParamInput,CLng(32),ip,lg_term_error_string&" 30"
		getRS db_rs, cmdTxt,lg_term_error_string&" 31"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("loginLocked")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If locked then, redirect to forbidden.
		'*******************************************************************************************************************
		If laLocked="1" Then
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=8")
		End If
		
		'*******************************************************************************************************************
		'* If all required fields exist, attempt to autenticate the credentials
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "All required fields exist, attempt to authenticate.<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT [name], [password], [locked] FROM users WHERE ([userid]=?);"
		Else
			cmdTxt = "SELECT name, password, locked FROM users WHERE (userid=?);"
		End If
		openCommand lg_term_command_string,lg_term_get_name&" 32"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_get_name&" 33"
		getRS db_rs, cmdTxt, lg_term_get_name&" 34"
		If Not(db_rs.bof AND db_rs.eof) Then
			passhash = db_rs("password")
			name = db_rs("name")
			locked = CStr(db_rs("locked"))
			If lg_debug Then dbMsg = dbMsg & "db passhash = "& passhash &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "db name = "& name &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "db locked = "& locked &"<br />" & vbLF End If
		End If
		closeRS
		closeCommand
		If locked<>"1" Then
			If lg_debug Then dbMsg = dbMsg & "Calculated passhash = "& HashEncode(password & userid) &"<br />" & vbLF End If
			If passhash=HashEncode(password & userid) AND NOT(locked="1") Then
				'*******************************************************************************************************************
				'* Credentials are valid, issue a anti Session Fixation cookie
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Credentials are valid - issue anti Session Fixation cookie.<br />" & vbLF End If
				tmpStr = getGUID
				If lg_debug Then dbMsg = dbMsg & "GUID = "& tmpStr &"<br />" & vbLF End If
				tmpStr = HashEncode(Session.SessionID & Request.ServerVariables("REMOTE_ADDR") & tmpStr)
				If lg_debug Then dbMsg = dbMsg & "anti Session Fixation Token = "& tmpStr &"<br />" & vbLF End If
				Response.Cookies("user") = tmpStr
				Response.Cookies("user").Expires = Dateadd("s", 1200, Now()) ' 20 minutes
				Session("antiFixation") = tmpStr
				If lg_debug Then dbMsg = dbMsg & "Session antiFixation = "& Session("antiFixation") &"<br />" & vbLF End If
								
				'*******************************************************************************************************************
				'* If credential are valid log the user in
				'*******************************************************************************************************************
				Session("login")=True
				Session("userid")=userid
				Session("name")=name
				If lg_debug Then dbMsg = dbMsg & "Session login = "& Session("login") &"<br />" & vbLF End If
				If lg_debug Then dbMsg = dbMsg & "Session userid = "& Session("userid") &"<br />" & vbLF End If
				If lg_debug Then dbMsg = dbMsg & "Session name = "& Session("name") &"<br />" & vbLF End If
							
				'*******************************************************************************************************************
				'* If the user wishes to have authentication remembered, write the permanent cookies
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "term_remember = "& lg_term_remember &"<br />" & vbLF End If
				If lg_debug Then dbMsg = dbMsg & "user wishes to remember login = "& remember &"<br />" & vbLF End If
				If lg_term_remember AND getField("remember")="Yes" Then
					Response.Cookies("login") = userid
					Response.Cookies("login").Expires = Dateadd("yyyy",5, Now())
				End If
				If lg_debug Then dbMsg = dbMsg & "Login Cookie Expires: "& Dateadd("yyyy",5,Now()) &"<br />" & vbLF End If

				'*******************************************************************************************************************
				'* If we are logging user authentications, write to the logins table
				'*******************************************************************************************************************
				If lg_log_logins Then
					If lg_debug Then dbMsg = dbMsg & "log_logins = "& log_logins &"<br />" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "INSERT INTO logins ([date], [userid], [ip], [useragent]) VALUES (?, ?, ?, ?);"
					Else
						cmdTxt = "INSERT INTO logins (date, userid, ip, useragent) VALUES (?, ?, ?, ?);"
					End If		
					openCommand lg_term_command_string,lg_term_log_string&" 35"
					addParam "@date",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 36"
					addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 37"
					addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 38"
					addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 39"
					execCmd cmdTxt
					If lg_debug Then dbMsg = dbMsg & "Log Login Number Affected = "& numAffected &"<br />" & vbLF End If
					closeCommand
				End If
				
				'*******************************************************************************************************************
				'* Clear the attemptedLogins table
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Clear the Login from attemptedLogins table<br />" & vbLF End If
				If lg_database="access" Then
					cmdTxt = "DELETE FROM loginAttempts WHERE ([loginAttemptUserID]=?) OR ([loginAttemptIP]=?);"
				Else
					cmdTxt = "DELETE FROM loginAttempts WHERE (loginAttemptUserID=?) OR (loginAttemptIP=?);"
				End If		
				openCommand lg_term_command_string,lg_term_log_string&" 40"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 41"
				addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 42"
				execCmd cmdTxt
				If lg_debug Then dbMsg = dbMsg & "Clear loginAttempts Number Affected = "& numAffected &"<br />" & vbLF End If
				closeCommand
				
				'*******************************************************************************************************************
				'* Clear the form token
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Clear the form token cookie.<br />" & vbLF End If
				Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
				
				'*******************************************************************************************************************
				'* Logged in, redirect
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Valid login, redirect<br />" & vbLF End If
				Response.Redirect(destination)
			Else
				'*******************************************************************************************************************
				'* Bad Login - get the login attempts record
				'*******************************************************************************************************************
				If lg_debug Then dbMsg = dbMsg & "Bad Login: increment attemptedLogins record.<br />" & vbLF End If
				'Bad Login attempt - log it and count
				If lg_database="access" Then
					cmdTxt = "SELECT [id], [loginAttemptNumber] FROM loginAttempts WHERE ([loginAttemptUserID] = ?) OR ([loginAttemptIP] = ?);"
				Else	
					cmdTxt = "SELECT id, loginAttemptNumber FROM loginAttempts WHERE (loginAttemptUserID = ?) OR (loginAttemptIP = ?);"
				End If
				If lg_debug Then dbMsg = dbMsg & "First look-up the attemptedLogin record<br />" & vbLF End If
				openCommand lg_term_command_string,lg_term_error_string&" 33"
				addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 43"
				addParam "@i",adVarChar,adParamInput,CLng(32),ip,lg_term_error_string&" 44"
				getRS db_rs, cmdTxt,lg_term_error_string&" 45"
				If Not(db_rs.bof AND db_rs.eof) Then
					laID = db_rs("id")
					laNumber = db_rs("loginAttemptNumber")
					If lg_debug Then dbMsg = dbMsg & "db ID = "& laID &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db Number = "& laNumber &"<br />" & vbLF End If
				End If
				closeRS
				closeCommand
				laNumber = laNumber + 1
				If lg_debug Then dbMsg = dbMsg & "Number incremented to: "& laNumber &"<br />" & vbLF End If
				If lg_debug Then dbMsg = dbMsg & "Max Logins = "& lg_login_attempts &"<br />" & vbLF End If
				If (laNumber >= lg_login_attempts) Then
					'*******************************************************************************************************************
					'* Lock the account and redirect to forbidden
					'*******************************************************************************************************************
					If lg_debug Then dbMsg = dbMsg & "Exceeded max logins, lock the account and ban the IP<br />" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "UPDATE loginAttempts SET [loginAttemptNumber] = ?, [loginAttemptDate] = ?, [loginAttemptLocked] = ? WHERE [id] = ?"
					Else	
						cmdTxt = "UPDATE loginAttempts SET loginAttemptNumber = ?, loginAttemptDate = ?, loginAttemptLocked = ? WHERE id = ?"
					End If
					openCommand lg_term_command_string,lg_term_error_string&" 46"
					addParam "@n",adInteger,adParamInput,CLng(Len(laNumber)),laNumber,lg_term_error_string&" 47"
					addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 48"
					addParam "@l",adVarChar,adParamInput,CLng(1),"1",lg_term_error_string&" 49"
					addParam "@i",adVarChar,adParamInput,CLng(Len(laID)),laID,lg_term_error_string&" 50"
					execCmd cmdTxt
					If lg_debug Then dbMsg = dbMsg & "Lock loginAttempts recordsAffected = "& numAffected &"<br />" & vbLF End If
					closeCommand
					Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=9")
				Else
					'*******************************************************************************************************************
					'* Update the record with the UserID and number of login attempts
					'*******************************************************************************************************************
					If lg_debug Then dbMsg = dbMsg & "Have not exceeded max login attempts. Update record.<br />" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "UPDATE loginAttempts SET [loginAttemptUserID] = ?, [loginAttemptNumber] = ?, [loginAttemptDate] = ? WHERE [id] = ?"
					Else	
						cmdTxt = "UPDATE loginAttempts SET loginAttemptUserID = ?, loginAttemptNumber = ?, loginAttemptDate = ? WHERE id = ?"
					End If
					openCommand lg_term_command_string,lg_term_error_string&" 51"
					addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 52"
					addParam "@n",adInteger,adParamInput,CLng(Len(laNumber)),laNumber,lg_term_error_string&" 53"
					addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 54"
					addParam "@i",adVarChar,adParamInput,CLng(Len(laID)),laID,lg_term_error_string&" 55"
					execCmd cmdTxt
					If lg_debug Then dbMsg = dbMsg & "Updated loginAttempts. numAffected = "& numAffected &"<br />" & vbLF End If
					closeCommand				
				End If	
				message = lg_phrase_login_error
				If lg_debug Then dbMsg = dbMsg & "message = "& message &" 1 <br />" & vbLF End If
			End if
		Else
			'*******************************************************************************************************************
			'* Userid is locked, redirect to forbidden
			'*******************************************************************************************************************
			Session("userid") = ""
			Session("login") = false
			Session("name") = ""
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "December 31, 2000"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "December 31, 2000"
			Session.Abandon
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=10")
			If lg_debug Then dbMsg = dbMsg & "Userid is locked, redirect to forbidden<br />" & vbLF End If
		End if
		message = lg_phrase_login_error;
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	End If
End if
%>