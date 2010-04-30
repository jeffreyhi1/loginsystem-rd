<%
' $Id$
'*******************************************************************************************************************
'* Page Name 
'* Last Modification: 26 APR 2010 rdivilbiss
'* Version:  alpha 0.1b
'* On Entry: check if SSL is needed and redirect if needed.
'* Input   : UserID, Password, Name, Email, Website, Subscription
'* Output  : Register confirmation
'* On Exit : Register verification e-mail is sent.
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
'* Dimension all page variables and initialize default values
'*******************************************************************************************************************
Dim redirected, destination, password, confirm, passhash, userid, name, email, website, news, mailBody, debug, debugout
Dim ip, useragent, region, city, country, dateRegistered, locked, dateLocked, token, cmdTxt, message, objXMLHTTP, xmldoc

destination=""
password=""
confirm=""
passhash=""
userid=""
name=""
email=""
website=""
news=""
ip=""
useragent=""
region=""
city=""
country=""
dateRegistered=""
locked=""
dateLocked=""
token=""
cmdTxt=""
message= "<strong>"&lg_term_please_register&"</strong>"
debug = lg_debug
If debug Then
	debugout = "Debugging Enabled<br>"
End If

'*******************************************************************************************************************
'* Function to check is userid is available
'*******************************************************************************************************************
function isUser(pUserId)
	debugout = debugout & "entering isUser with pUserId = " &pUserID& "<br>"
	Dim cmdTxt
	If lg_database="access" Then
		cmdTxt = "SELECT [userid] FROM users WHERE ([userid]=?);"
	Else
		cmdTxt = "SELECT userid FROM users WHERE (userid=?);"
	End If		
	openCommand lg_term_command_string,"getUserid 1"

	addParam "@u",adVarChar,adParamInput,CLng(50),pUserid,"getUserid 2"

	getRS db_rs, cmdTxt, "getUserid 3"
	If (db_rs.bof AND db_rs.eof) Then ' No records
		isUser = false
		debugout = debugout & "in isUser with result isUser = false<br>"
	Else
		isUser = true
		debugout = debugout & "in isUser with result isUser = true<br>"
	End IF

	closeRS
	closeCommand
end function

If LCase(Request.ServerVariables("HTTP_METHOD")) = "get" Then
	'*******************************************************************************************************************
	'* Save destination if redirected from Login
	'*******************************************************************************************************************
	destination = getField("p,rXurlpath,get")
	debugout = debugout & "Is method GET, destination = "& destination &"<br>"
	'*******************************************************************************************************************
	'* If SSL required and not using SSL, redirect to https
	'*******************************************************************************************************************
	If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
		debugout = debugout & "useSSL is true and Session(redirected) = false.  Redirecting<br>"
		debugout = debugout & "Redirect path = https://" & lg_domain & lg_loginPath & lg_filename & "?r=1&p="& destination & "<br>"
		Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename & "?r=1&p="&destination)
	End If
Else
	'*******************************************************************************************************************
	'* The form was posted, process the form
	'*******************************************************************************************************************
	debugout = debugout & "Form POST checkToken<br>"
	checkToken
	debugout = debugout & "checkToken true. Processing form<br>"
	message = ""
	userid = Trim(Left(getField("userid,rXsafepq"),32))
	debugout = debugout & "userid = " & Server.HTMLEncode(userid) & "<br>"
	password = Trim(Left(getField("password,rXsafepq"),255))
	debugout = debugout & "password = " & Server.HTMLEncode(password) & "<br>"
	confirm = Trim(Left(getField("confirm,rXsafepq"),255))
	debugout = debugout & "confirm = " & Server.HTMLEncode(confirm) & "<br>"
	email = Trim(Left(getField("email,rXemail"),100))
	debugout = debugout & "email = " & Server.HTMLEncode(email) & "<br>"
	name = Trim(Left(getField("name,rXname"),100))
	debugout = debugout & "name = " & Server.HTMLEncode(name) & "<br>"
	website = Trim(Left(getField("website,rXsafe"),100))
	debugout = debugout & "website = " & Server.HTMLEncode(website) & "<br>"
	news = Trim(Left(getField("news,rXalpha"),3))
	If news="" Then
		news = "No"
		debugout = debugout & "news = NO (empty)<br>"
	Else
		debugout = debugout & "news = YES<br>"
	End if
	destination = getField("destination,rXurlpath")
	debugout = debugout & "destination = " & Server.HTMLEncode(destination) & "<br>"
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty & "<br>" & vbLF
	End If
	If isUser(userid) AND userid<>"" then
		message = message & lg_phrase_userid_inuse & "<br>" & vbLF
		userid=""
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty & "<br>" & vbLF
	End If
	If confirm & ""="" Then
		message = message & lg_phrase_confirm_empty & "<br>" & vbLF
	End If
	If email & ""="" Then
		message = message & lg_phrase_email_empty & "<br>" & vbLF
	End If
	If name & ""="" Then
		message = message & lg_phrase_name_empty & "<br>" & vbLF
	End If
	If password & ""<>"" AND confirm & ""<>"" AND password<>confirm Then
		message = message & lg_phrase_password_nomatch_confirm & "<br>" & vbLF
	End If
	passhash = HashEncode(password & userid)
	debugout = debugout & "pashash = " & Server.HTMLEncode(passhash) & "<br>"
	debugout = debugout & "message = " & message
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, create account, first initialize dateRegistered the geo-locate the user's IP
		'*******************************************************************************************************************
		debugout = debugout & "All required fields exist. Prepare to insert record.<br>"
		dateRegistered = dbNow
		debugout = debugout & "dateRegistered = "& dateRegistered &"<br>"
		ip = Request.ServerVariables("REMOTE_ADDR")
		debugout = debugout & "Remote Address = "& ip &"<br>"
		useragent = Server.HTMLEncode(Trim(Left(Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT")),255)))
		debugout = debugout & "useragent = "& useragent &"<br>"
		
		on error resume next
		Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
		If err and debug Then
			debugout = debugout & err.number & " " & err.description & " " & err.source & "<br>"
		End If	
		objXMLHTTP.Open "GET", "http://ipinfodb.com/ip_query.php?ip="&ip, False
		If err and debug Then
			debugout = debugout & err.number & " " & err.description & " " & err.source & "<br>"
		End If
		objXMLHTTP.Send
		If err and debug Then
			debugout = debugout & err.number & " " & err.description & " " & err.source & "<br>"
		End If
		Set xmldoc = objXMLHTTP.responseXML
		If err and debug Then
			debugout = debugout & err.number & " " & err.description & " " & err.source & "<br>"
		End If
		
		country = xmlDoc.documentElement.selectSingleNode("CountryName").text
		debugout = debugout & "country = "& country &"<br>"
		region = xmlDoc.documentElement.selectSingleNode("RegionName").text
		debugout = debugout & "region = "& region &"<br>"
		city = xmlDoc.documentElement.selectSingleNode("City").text
		debugout = debugout & "city = "& city &"<br>"
		set objXMLHTTP=nothing
		on error goto 0
		'*******************************************************************************************************************
		'* Set locked, dateLocked and unlock token
		'*******************************************************************************************************************
		locked="1"
		debugout = debugout & "locked = 1<br>"
		dateLocked = dbNow
		debugout = debugout & "dateLocked = "& dateLocked &"<br>"
		token = Left(HashEncode(getGUID),40)
		debugout = debugout & "token = "& token &"<br>"
		'*******************************************************************************************************************
		'* Write new account to user's table in database
		'*******************************************************************************************************************
		If lg_database="access" Then
			cmdTxt = "INSERT INTO users ([dateRegistered], [userid], [password], [name], [email], [ip], [region], [city], [country], [useragent], [website], [news], [locked], [dateLocked], [token]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
		Else	
			cmdTxt = "INSERT INTO users (dateRegistered, userid, password, name, email, ip, region, city, country, useragent, website, news, locked, dateLocked, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
		End If	
		openCommand lg_term_command_string, lg_term_do_registration &" 1"
		addParam "@dRegistered",adDBTimeStamp,adParamInput,CLng(8),dateRegistered,lg_term_do_registration&" 2"
		addParam "@userid",adVarChar,adParamInput,CLng(50),userid,lg_term_do_registration&" 3"
		addParam "@password",adVarChar,adParamInput,CLng(64),passhash,lg_term_do_registration&" 4"
		addParam "@name",adVarChar,adParamInput,CLng(100),name,lg_term_do_registration&" 5"
		addParam "@email",adVarChar,adParamInput,CLng(100),email,lg_term_do_registration&" 6"
		addParam "@ip",adVarChar,adParamInput,CLng(32),ip,lg_term_do_registration&" 7"
		If region="" Then
			addParam "@region",adVarChar,adParamInput,CLng(50),Null,lg_term_do_registration&" 8"
		Else
			addParam "@region",adVarChar,adParamInput,CLng(50),region,lg_term_do_registration&" 8"
		End If
		If city="" Then
			addParam "@city",adVarChar,adParamInput,CLng(50),Null,lg_term_do_registration&" 9"
		Else	
			addParam "@city",adVarChar,adParamInput,CLng(50),city,lg_term_do_registration&" 9"
		End If
		If country="" Then
			addParam "@country",adVarChar,adParamInput,CLng(50),Null,lg_term_do_registration&" 10"
		Else
			addParam "@country",adVarChar,adParamInput,CLng(50),country,lg_term_do_registration&" 10"
		End If	
		addParam "@useragent",adVarChar,adParamInput,CLng(255),useragent,lg_term_do_registration&" 11"
		If website="" Then
			addParam "@website",adVarChar,adParamInput,CLng(100),Null,lg_term_do_registration&" 12a"
		Else	
			addParam "@website",adVarChar,adParamInput,CLng(100),website,lg_term_do_registration&" 12b"
		End If	
		addParam "@news",adVarChar,adParamInput,CLng(3),news,lg_term_do_registration&" 13"
		addParam "@locked",adVarChar,adParamInput,CLng(1),locked,lg_term_do_registration&" 14"
		addParam "@dLocked",adDBTimeStamp,adParamInput,CLng(8),dateLocked,lg_term_do_registration&" 15"
		addParam "@token",adVarChar,adParamInput,CLng(64),token,lg_term_do_registration&" 16"
		execCmd cmdTxt
		debugout = debugout & "Database insert occurred. Result = "& numAffected &"<br>"

		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* On success, email user the unlock token. Copy the webmaster
			'*******************************************************************************************************************
			debugout = debugout & "Database Insert Success: Prepare e-mail.<br>"
			message = lg_phrase_registration_success
			
			mailBody = mailBody & "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
			mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
			mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"& lg_term_register_confirmation &"<br><br>"
			mailBody = mailBody & lg_term_to & name & "<br><br>"
			mailBody = mailBody & lg_phrase_registration_mail1 &" "& lg_domain &". " & lg_phrase_registration_mail2 & "<br>"
			mailBody = mailBody & lg_phrase_registration_mail3 & "<br><br>"
			mailBody = mailBody & "<a href=""http://" & lg_domain & lg_loginPath & lg_verify_page & "?token=" & token & "&p="&destination&""">"& lg_phrase_registration_mail4 &"</a><br><br>"
			mailBody = mailBody & lg_phrase_registration_mail5
                        mailBody = mailBody & lg_domain & lg_loginPath & lg_verify_page & "</p>"
			mailBody = mailBody & lg_phrase_registration_mail6 & ".<br><br>"
			mailBody = mailBody & token & "<br><br>"
			mailBody = mailBody & lg_phrase_registration_mail7 & " "
			mailBody = mailBody & lg_phrase_registration_mail8 & lg_domain & lg_loginPath & lg_register_delete_page & "?email="& email &""">"& lg_term_remove_registration &"</a>.<br><br>"
			mailBody = mailBody & lg_phrase_registration_mail9 & lg_domain & lg_contact_form & """>"& lg_phrase_contact_webmaster &"</a>.<br><br>"
			mailBody = mailBody & lg_copyright &"<br>"
			mailBody = mailBody & "</FONT></DIV></BODY></HTML>"
			debugout = debugout & "mailbody = "& mailbody &"<br>"
			
			sendmail lg_webmaster_email, email, "User Registration", mailBody
			sendmail lg_webmaster_email, "rod@rodsdot.com", "ATTN:Webmaster User Registration", mailBody
			debugout = debugout & "mail sent = "& CDOMailIncludeResults &"<br>"
		Else
			message = lg_phrase_registration_error & " " & lg_term_via_email & " " & lg_webmaster_email & " " & lg_term_or & " " & lg_term_at & "<a href=""" & lg_contact_form & """>" & lg_term_contact_form & "</a>"
			debugout = debugout & "Database Insert Failed: "& message &"<br>"
		End If
		closeRS
		closeCommand
	End If
End if
%>