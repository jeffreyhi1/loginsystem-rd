<%
' $Id$
'*******************************************************************************************************************
'* Login.asp
'* Last Modification: rdivilbiss - added anti Session Fixation cookie and
'*                                 corrected a flaw where any properly named cookie would
'*                                 bypass authentication.
'* Version:  alpha 0.1b debug
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
Dim ip, date, useragent, locked, laID, laUserID, laNumber, laIP, laDate, laLocked, tmpStr, dbMsg

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
	'* Determine if we have Session Login
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "Session login = "& Session("login") &"<br />" & vbLF End If
	If Session("login") Then
		If lg_debug Then dbMsg = dbMsg & "Request.Cookies user = "& Request.Cookies("user") &"<br />" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "Session antiFixation = "& Session("antiFixation") &"<br />" & vbLF End If
		If Request.Cookies("user")=Session("antiFixation") Then 
			Response.Redirect(destination)
		Else
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=1")
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
			cmdTxt = "SELECT [loginAttemptLocked] FROM loginAttempts WHERE ([loginAttemptIP] = ?);"
		Else
			cmdTxt = "SELECT loginAttemptLocked FROM loginAttempts WHERE (loginAttemptIP = ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 4"
		addParam "@i",adVarChar,adParamInput,CLng(Len(ip)),ip,lg_term_error_string&" 5"
		getRS db_rs, cmdTxt,lg_term_error_string&" 6"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("loginAttemptLocked")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		'*******************************************************************************************************************
		'* If already locked then, redirect
		'*******************************************************************************************************************
		If laLocked="1" Then
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=2")
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
		addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 9"
		addParam "@i",adVarChar,adParamInput,CLng(Len(ip)),ip,lg_term_error_string&" 10"	
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
		Session("userid")=Request.Cookies("login")
		destination = lg_success_page
		
		'*******************************************************************************************************************
		'* Make sure userid and/or IP are not locked out by loginAttempts
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "Check if userid or IP is locked out by loginAttempts<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT [loginAttemptLocked] FROM loginAttempts WHERE ([loginAttemptUserID] = ?) OR ([loginAttemptIP] = ?);"
		Else
			cmdTxt = "SELECT loginAttemptLocked FROM loginAttempts WHERE (loginAttemptUserID = ?) OR (loginAttemptIP = ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 1"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 2"
		addParam "@i",adVarChar,adParamInput,CLng(32),ip,lg_term_error_string&" 3"
		getRS db_rs, cmdTxt,lg_term_error_string&" 6"
		If Not(db_rs.bof AND db_rs.eof) Then
			laLocked = db_rs("loginAttemptLocked")
			If lg_debug Then dbMsg = dbMsg & "Locked = "& laLocked &"<br />" & vbLF End If
			closeRS
			closeCommand
		End If
		
		'*******************************************************************************************************************
		'* If already locked then, redirect
		'*******************************************************************************************************************
		If laLocked="1" Then
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=3")
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
		openCommand lg_term_command_string,lg_term_error_string&" 14"
		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_error_string&" 15"
		getRS db_rs, cmdTxt,lg_term_error_string&" 16"
		If Not(db_rs.bof AND db_rs.eof) Then
			name = db_rs("name")
			locked = db_rs("locked")
			If lg_debug Then dbMsg = dbMsg & "name = "& name &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "locked = "& locked &"<br />" & vbLF End If
		End If
		closeRS
		closeCommand
		
		'*******************************************************************************************************************
		'* If already locked then, redirect
		'*******************************************************************************************************************
		If locked="1" Then
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=4")
		Else
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
				openCommand lg_term_command_string,lg_term_log_string&" 17"
				addParam "@sate",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 18"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 19"
				addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 20"
				addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 21"
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
		'* If all required fields exist, attempt to autenticate the credentials
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "All required fields exist, attempt to authenticate.<br />" & vbLF End If
		If lg_database="access" Then
			cmdTxt = "SELECT [name], [password], [locked] FROM users WHERE ([userid]=?);"
		Else
			cmdTxt = "SELECT name, password, locked FROM users WHERE (userid=?);"
		End If
		openCommand lg_term_command_string,lg_term_get_name&" 22"
		addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_get_name&" 23"
		getRS db_rs, cmdTxt, lg_term_get_name&" 24"
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
					openCommand lg_term_command_string,lg_term_log_string&" 25"
					addParam "@date",adDate,adParamInput,CLng(8),date,lg_term_log_string&" 26"
					addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 27"
					addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 28"
					addParam "@ua",adVarChar,adParamInput,CLng(255),useragent,lg_term_log_string&" 29"
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
				openCommand lg_term_command_string,lg_term_log_string&" 30"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 31"
				addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 32"
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
				If lg_debug Then dbMsg = dbMsg & "Bad Login: increment attemptedLogins record.<br />" & vbLF End If
				'Bad Login attempt - log it and count
				If lg_database="access" Then
					cmdTxt = "SELECT [id], [loginAttemptUserID], [loginAttemptNumber], [loginAttemptDate], [loginAttemptIP], [loginAttemptLocked] FROM loginAttempts WHERE ([loginAttemptUserID] = ?) OR ([loginAttemptIP] = ?);"
				Else	
					cmdTxt = "SELECT id, loginAttemptUserID, loginAttemptNumber, loginAttemptDate, loginAttemptIP, loginAttemptLocked FROM loginAttempts WHERE (loginAttemptUserID = ?) OR (loginAttemptIP = ?);"
				End If
				If lg_debug Then dbMsg = dbMsg & "First look-up the attemptedLogin record<br />" & vbLF End If
				openCommand lg_term_command_string,lg_term_error_string&" 33"
				addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 34"
				addParam "@i",adVarChar,adParamInput,CLng(32),ip,lg_term_error_string&" 35"
				getRS db_rs, cmdTxt,lg_term_error_string&" 36"
				If Not(db_rs.bof AND db_rs.eof) Then
					laID = db_rs("id")
					laUserID = db_rs("loginAttemptUserID")
					laNumber = db_rs("loginAttemptNumber")
					laDate = db_rs("loginAttemptDate")
					laIP = db_rs("loginAttemptIP")
					laLocked = db_rs("loginAttemptLocked")
					If lg_debug Then dbMsg = dbMsg & "db ID = "& laID &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db UserID = "& laUserID &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db Number = "& laNumber &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db Date = "& laDate &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db IP = "& laIP &"<br />" & vbLF End If
					If lg_debug Then dbMsg = dbMsg & "db Locked = "& laLocked &"<br />" & vbLF End If
				End If
				closeRS
				closeCommand
				laNumber = laNumber + 1
				If lg_debug Then dbMsg = dbMsg & "Number incremented to: "& laNumber &"<br />" & vbLF End If
				If lg_debug Then dbMsg = dbMsg & "Max Logins = "& lg_login_attempts &"<br />" & vbLF End If
				If (laNumber >= lg_login_attempts) Then
					' Lock the account and redirect to forbidden
					If lg_debug Then dbMsg = dbMsg & "Exceeded max logins, lock the account and ban the IP<br />" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "UPDATE loginAttempts SET [loginAttemptNumber] = ?, [loginAttemptDate] = ?, [loginAttemptLocked] = ? WHERE [id] = ?"
					Else	
						cmdTxt = "UPDATE loginAttempts SET loginAttemptNumber = ?, loginAttemptDate = ?, loginAttemptLocked = ? WHERE id = ?"
					End If
					openCommand lg_term_command_string,lg_term_error_string&" 37"
					addParam "@n",adInteger,adParamInput,CLng(Len(laNumber)),laNumber,lg_term_error_string&" 38"
					addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 39"
					addParam "@l",adVarChar,adParamInput,CLng(1),"1",lg_term_error_string&" 40"
					addParam "@i",adVarChar,adParamInput,CLng(Len(laID)),laID,lg_term_error_string&" 41"
					execCmd cmdTxt
					If lg_debug Then dbMsg = dbMsg & "Lock loginAttempts recordsAffected = "& numAffected &"<br />" & vbLF End If
					closeCommand
					Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=5")
				Else
					' Update the record with the UserID and number of login attempts
					If lg_debug Then dbMsg = dbMsg & "Have not exceeded max login attempts. Update record.<br />" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "UPDATE loginAttempts SET loginAttemptUserID = ?, loginAttemptNumber = ?, loginAttemptDate = ? WHERE id = ?"
					Else	
						cmdTxt = "UPDATE loginAttempts SET loginAttemptUserID = ?, loginAttemptNumber = ?, loginAttemptDate = ? WHERE id = ?"
					End If
					openCommand lg_term_command_string,lg_term_error_string&" 42"
					addParam "@u",adVarChar,adParamInput,CLng(50),userid,lg_term_error_string&" 43"
					addParam "@n",adInteger,adParamInput,CLng(Len(laNumber)),laNumber,lg_term_error_string&" 44"
					addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 45"
					addParam "@i",adVarChar,adParamInput,CLng(Len(laID)),laID,lg_term_error_string&" 46"
					execCmd cmdTxt
					If lg_debug Then dbMsg = dbMsg & "Updated loginAttempts. numAffected = "& numAffected &"<br />" & vbLF End If
					closeCommand				
				End If	
				message = lg_phrase_login_error
				If lg_debug Then dbMsg = dbMsg & "message = "& message &" 1 <br />" & vbLF End If
			End if
		Else
			message = lg_phrase_login_error
			If lg_debug Then dbMsg = dbMsg & "message = "& message &" 2 <br />" & vbLF End If
		End if	
	End If
End if
%>