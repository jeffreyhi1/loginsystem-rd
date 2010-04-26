<%
'*******************************************************************************************************************
'* Login.asp
'* Last Modification: 26 APR 2010 rdivilbiss - added anti Session Fixation cookie and
'*                                             corrected a flaw where any properly named cookie would
'*                                             bypass authentication.
'* Version:  alpha 0.1b
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
Dim ip, date, useragent, locked, laID, laUserID, laNumber, laIP, laDate, laLocked, tmpStr

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
	'* Determine if we have Session Login
	'*******************************************************************************************************************
	If Session("login") Then
		If Request.Cookies("user")=Session("antiFixation") Then 
			Response.Redirect(destination)
		Else
			Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=1")
		End If	
	End If
	
	'*******************************************************************************************************************
	'* Determine if we have Cookie Login
	'*******************************************************************************************************************
	If Request.Cookies("login") = "" Then
		'*******************************************************************************************************************
		'* There is no login cookie. Make sure IP is not locked out by loginAttempts
		'*******************************************************************************************************************
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
		If lg_database="access" Then
			cmdTxt = "INSERT INTO loginAttempts ([loginAttemptDate], [loginAttemptIP]) VALUES (?, ?);"
		Else	
			cmdTxt = "INSERT INTO loginAttempts (loginAttemptDate, loginAttemptIP) VALUES (?, ?);"
		End If
		openCommand lg_term_command_string,lg_term_error_string&" 7"
		addParam "@d",adDate,adParamInput,CLng(8),date,lg_term_error_string&" 9"
		addParam "@i",adVarChar,adParamInput,CLng(Len(ip)),ip,lg_term_error_string&" 10"	
		execCmd cmdTxt
		closeCommand
		
		'*******************************************************************************************************************
		'* NOT LOGGED IN: If SSL required and not using SSL, redirect to https
		'*******************************************************************************************************************
		If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
			Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename &"?p="&destination)
		End If	
	Else
		'*******************************************************************************************************************
		'* User Login Is Saved In Login Cookie.
		'*******************************************************************************************************************
		userid = Request.Cookies("login")
		Session("userid")=Request.Cookies("login")
		destination = lg_success_page
		
		'*******************************************************************************************************************
		'* Make sure userid and/or IP are not locked out by loginAttempts
		'*******************************************************************************************************************
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
			
			'*******************************************************************************************************************
			'* Credentials are valid, issue a anti Session Fixation cookie
			'*******************************************************************************************************************
			tmpStr = getGUID
			tmpStr = HashEncode(Session.SessionID & Request.ServerVariables("REMOTE_ADDR") & tmpStr)
			Response.Cookies("user") = tmpStr
			Response.Cookies("user").Expires = Dateadd("s", 1200, Now()) ' 20 minutes
			Session("antiFixation") = tmpStr

			'*******************************************************************************************************************
			'* If we are logging user authentications, write to the logins table
			'*******************************************************************************************************************
			If lg_log_logins Then
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
	checkToken
	message = ""
	password = Trim(Left(getField("password,rXsafepq"),255))
	userid = Trim(Left(getField("userid,rXsafepq"),32))
	remember = Trim(Left(getField("remember,rXalpha"),3)) ' Yes or empty
	destination = getField("destination,rXurlpath")       ' saved final destination
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty & "<br>" & vbLF
	Else
		useridValue = Server.HTMLEncode(userid)	
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty & "<br>" & vbLF
	End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, attempt to autenticate the credentials
		'*******************************************************************************************************************
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
		End If
		closeRS
		closeCommand
		If locked<>"1" Then
			If passhash=HashEncode(password & userid) AND NOT(locked="1") Then
				'*******************************************************************************************************************
				'* Credentials are valid, issue a anti Session Fixation cookie
				'*******************************************************************************************************************
				tmpStr = getGUID
				tmpStr = HashEncode(Session.SessionID & Request.ServerVariables("REMOTE_ADDR") & tmpStr)
				Response.Cookies("user") = tmpStr
				Response.Cookies("user").Expires = Dateadd("s", 1200, Now()) ' 20 minutes
				Session("antiFixation") = tmpStr
								
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
					Response.Cookies("login") = userid
					Response.Cookies("login").Expires = Dateadd("yyyy",5, Now())
				End If
			
				'*******************************************************************************************************************
				'* If we are logging user authentications, write to the logins table
				'*******************************************************************************************************************
				If lg_log_logins Then
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
					closeCommand
				End If
				
				'*******************************************************************************************************************
				'* Clear the attemptedLogins table
				'*******************************************************************************************************************
				If lg_database="access" Then
					cmdTxt = "DELETE FROM loginAttempts WHERE ([loginAttemptUserID]=?) OR ([loginAttemptIP]=?);"
				Else
					cmdTxt = "DELETE FROM loginAttempts WHERE (loginAttemptUserID=?) OR (loginAttemptIP=?);"
				End If		
				openCommand lg_term_command_string,lg_term_log_string&" 30"
				addParam "@user",adVarChar,adParamInput,CLng(Len(userid)),Session("userid"),lg_term_log_string&" 31"
				addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_log_string&" 32"
				execCmd cmdTxt
				closeCommand
				
				'*******************************************************************************************************************
				'* Clear the form token
				'*******************************************************************************************************************
				Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
				
				'*******************************************************************************************************************
				'* Logged in, redirect
				'*******************************************************************************************************************
				Response.Redirect(destination)
			Else
				'Bad Login attempt - log it and count
				If lg_database="access" Then
					cmdTxt = "SELECT [id], [loginAttemptUserID], [loginAttemptNumber], [loginAttemptDate], [loginAttemptIP], [loginAttemptLocked] FROM loginAttempts WHERE ([loginAttemptUserID] = ?) OR ([loginAttemptIP] = ?);"
				Else	
					cmdTxt = "SELECT id, loginAttemptUserID, loginAttemptNumber, loginAttemptDate, loginAttemptIP, loginAttemptLocked FROM loginAttempts WHERE (loginAttemptUserID = ?) OR (loginAttemptIP = ?);"
				End If
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
				End If
				closeRS
				closeCommand
				laNumber = laNumber + 1
				If (laNumber >= lg_login_attempts) Then
					' Lock the account and redirect to forbidden
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
					closeCommand
					Response.Redirect("http://" & lg_domain & lg_forbidden &"?r=5")
				Else
					' Update the record with the UserID and number of login attempts
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
					closeCommand				
				End If	
				message = lg_phrase_login_error
			End if
		Else
			message = lg_phrase_login_error
		End if	
	End If
End if
%>