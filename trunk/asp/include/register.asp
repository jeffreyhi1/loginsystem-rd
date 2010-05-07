<%
'* alpha 0.2 debug
' $Id$
'*******************************************************************************************************************
'* Page Name: Register
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
Dim redirected, destination, password, confirm, passhash, userid, name, email, website, news, mailBody, dbMsg
Dim ip, useragent, region, city, country, dateRegistered, locked, dateLocked, token, cmdTxt, message, objXMLHTTP, xmldoc
Dim reChallengeField, reResponseField, publickey, privkey

redirected=""
destination=""
password=""
confirm=""
passhash=""
userid=""
name=""
email=""
website=""
news=""
mailBody=""
dbMsg=""
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
objXMLHTTP = ""
xmldoc=""
reChallengeField=""
reResponseField=""
'*******************************************************************************************************************
'* These keys only work only for www.webloginproject.com
'*******************************************************************************************************************
publickey = "6Lce3bkSAAAAAHHyw_BOFsIgrHh9TcPrQMQ1oLYU"
privkey = "6Lce3bkSAAAAADh2-3h0SS30KP5E8gHXBN0yV13j"
'*******************************************************************************************************************
'* Obtain free keys for your site at http://recaptcha.net/
'*******************************************************************************************************************

If lg_debug Then
	dbMsg = "DEBUG BEGIN<br />" & vbLF
End If

'*******************************************************************************************************************
'* Function to check is userid is available
'*******************************************************************************************************************
function isUser(pUserId)
	If lg_debug Then dbMsg = dbMsg & "Entering isUser with pUserId = " &pUserID& "<br>" & vbLF End If
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
		If lg_debug Then dbMsg = dbMsg & "in isUser with result isUser = false<br>" & vbLF End If
	Else
		isUser = true
		If lg_debug Then dbMsg = dbMsg & "in isUser with result isUser = true<br>" & vbLF End If
	End IF

	closeRS
	closeCommand
	If lg_debug Then dbMsg = dbMsg & "Exiting isUser.<br>" & vbLF End If
end function


'*******************************************************************************************************************
'* Function to write reCAPTCHA to form
'*******************************************************************************************************************
' returns string the can be written where you would like the reCAPTCHA challenged placed on your page
Function recaptcha_challenge_writer()
	If lg_debug Then dbMsg = dbMsg & "Entered recaptcha_challenge_writer function.<br>" & vbLF End If
	recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
		"var RecaptchaOptions = {" & _
		"   theme : 'white'," & _
		"   tabindex : 0" & _
		"};" & _
		"</script>" & _
		"<script type=""text/javascript"" src=""http://api.recaptcha.net/challenge?k=" & publickey & """></script>" & _
		"<noscript>" & _
		  "<iframe src=""http://api.recaptcha.net/noscript?k=" & publickey & """ frameborder=""1""></iframe><br>" & _
		    "<textarea name=""recaptcha_challenge_field"" rows=""3"" cols=""40""></textarea>" & _
		    "<input type=""hidden"" name=""recaptcha_response_field"" value=""manual_challenge"">" & _
		"</noscript>"
	If lg_debug Then dbMsg = dbMsg & "Exiting recaptcha_challenge_writer function.<br>" & vbLF End If	
End Function


'*******************************************************************************************************************
'* Function to verify reCAPTCHA field
'*******************************************************************************************************************
Function recaptcha_confirm(rechallenge,reresponse)
	If lg_debug Then dbMsg = dbMsg & "Entered recaptcha_confirm function.<br>" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "rechallenge = "& rechallenge &"<br>" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "reresponse = "& reresponse &"<br>" & vbLF End If
	
	Dim VarString
	VarString = _
        "privatekey=" & privkey & _
        "&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
        "&challenge=" & rechallenge & _
        "&response=" & reresponse

	Dim objXmlHttp
	Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
	objXmlHttp.open "POST", "http://api-verify.recaptcha.net/verify", False
	objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXmlHttp.send VarString

	Dim ResponseString
	ResponseString = split(objXmlHttp.responseText, vblf)
	If lg_debug Then "ResponseString = "& ResponseString &"<br>" & vbLF End If
	Set objXmlHttp = Nothing

	If ResponseString(0) = "true" Then
		'They answered correctly
		recaptcha_confirm = ""
	Else
		'They answered incorrectly
		recaptcha_confirm = ResponseString(1)
	End If
	
	If lg_debug Then "Exiting recaptcha_confirm<br>" & vbLF End If
End Function



If LCase(Request.ServerVariables("HTTP_METHOD")) = "get" Then
	'*******************************************************************************************************************
	'* Save destination if redirected from Login
	'*******************************************************************************************************************
	destination = getField("p,rXurlpath,get")
	If lg_debug Then dbMsg = dbMsg & "Is method GET, destination = "& destination &"<br>" & vbLF End If
	'*******************************************************************************************************************
	'* If SSL required and not using SSL, redirect to https
	'*******************************************************************************************************************
	If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
		If lg_debug Then dbMsg = dbMsg & "useSSL is true and Session(redirected) = false.  Redirecting<br>" & vbLF End If
		If lg_debug Then dbMsg = dbMsg & "Redirect path = https://" & lg_domain & lg_loginPath & lg_filename & "?r=1&p="& destination & "<br>" & vbLF End If
		Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename & "?r=1&p="&destination)
	End If
Else
	'*******************************************************************************************************************
	'* The form was posted, process the form
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "Form POST checkToken<br>" & vbLF End If
	checkToken
	If lg_debug Then dbMsg = dbMsg & "checkToken true. Processing form<br>" & vbLF End If
	message = ""
	userid = Trim(Left(getField("userid,rXsafepq"),50))
	If lg_debug Then dbMsg = dbMsg & "userid = " & Server.HTMLEncode(userid) & "<br>" & vbLF End If
	password = Trim(Left(getField("password,rXsafepq"),255))
	If lg_debug Then dbMsg = dbMsg & "password = " & Server.HTMLEncode(password) & "<br>" & vbLF End If
	confirm = Trim(Left(getField("confirm,rXsafepq"),255))
	If lg_debug Then dbMsg = dbMsg & "confirm = " & Server.HTMLEncode(confirm) & "<br>" & vbLF End If
	email = Trim(Left(getField("email,rXemail"),100))
	If lg_debug Then dbMsg = dbMsg & "email = " & Server.HTMLEncode(email) & "<br>" & vbLF End If
	name = Trim(Left(getField("name,rXname"),100))
	If lg_debug Then dbMsg = dbMsg & "name = " & Server.HTMLEncode(name) & "<br>" & vbLF End If
	website = Trim(Left(getField("website,rXsafe"),100))
	If lg_debug Then dbMsg = dbMsg & "website = " & Server.HTMLEncode(website) & "<br>" & vbLF End If
	news = Trim(Left(getField("news,rXalpha"),3))
	If news="" Then
		news = "No"
		If lg_debug Then dbMsg = dbMsg & "news = NO (empty)<br>" & vbLF End If
	Else
		If lg_debug Then dbMsg = dbMsg & "news = YES<br>" & vbLF End If
	End if
	destination = getField("destination,rXurlpath")
	If lg_debug Then dbMsg = dbMsg & "destination = " & Server.HTMLEncode(destination) & "<br>" & vbLF End If
	reChallengeField = getField("recaptcha_challenge_field,rXsafe")
	reResponseField = getField("recaptcha_response_field,rXsafe")
	If lg_debug Then dbMsg = dbMsg & "reCAPTCHA Challenge = " & Server.HTMLEncode(reChallengeField) & "<br>" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "reCAPTCHA Response = " & Server.HTMLEncode(reResponseField) & "<br>" & vbLF End If
	message = recaptcha_confirm(reChallengeField, reResponseField)
	If lg_debug Then dbMsg = dbMsg & "message = " & Server.HTMLEncode(message) & "<br>" & vbLF End If
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
	If lg_debug Then dbMsg = dbMsg & "pashash = " & Server.HTMLEncode(passhash) & "<br>" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "message = " & message & "<br>" & vbLF End If
	If message="" Then
		'*******************************************************************************************************************
		'* If all required fields exist, create account, first initialize dateRegistered the geo-locate the user's IP
		'*******************************************************************************************************************
		If lg_debug Then dbMsg = dbMsg & "All required fields exist. Prepare to insert record.<br>" & vbLF End If
		dateRegistered = dbNow
		If lg_debug Then dbMsg = dbMsg & "dateRegistered = "& dateRegistered &"<br>" & vbLF End If
		ip = Request.ServerVariables("REMOTE_ADDR")
		If lg_debug Then dbMsg = dbMsg & "Remote Address = "& ip &"<br>" & vbLF End If
		useragent = Server.HTMLEncode(Trim(Left(Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT")),255)))
		If lg_debug Then dbMsg = dbMsg & "useragent = "& useragent &"<br>" & vbLF End If
		
		on error resume next
		Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
		If err and debug Then
			If lg_debug Then dbMsg = dbMsg & err.number & " " & err.description & " " & err.source & "<br>" & vbLF End If
		End If	
		objXMLHTTP.Open "GET", "http://ipinfodb.com/ip_query.php?ip="&ip, False
		If err and debug Then
			If lg_debug Then dbMsg = dbMsg & err.number & " " & err.description & " " & err.source & "<br>" & vbLF End If
		End If
		objXMLHTTP.Send
		If err and debug Then
			If lg_debug Then dbMsg = dbMsg & err.number & " " & err.description & " " & err.source & "<br>" & vbLF End If
		End If
		Set xmldoc = objXMLHTTP.responseXML
		If err and debug Then
			If lg_debug Then dbMsg = dbMsg & err.number & " " & err.description & " " & err.source & "<br>" & vbLF End If
		End If
		
		country = xmlDoc.documentElement.selectSingleNode("CountryName").text
		If lg_debug Then dbMsg = dbMsg & "country = "& country &"<br>" & vbLF End If
		region = xmlDoc.documentElement.selectSingleNode("RegionName").text
		If lg_debug Then dbMsg = dbMsg & "region = "& region &"<br>" & vbLF End If
		city = xmlDoc.documentElement.selectSingleNode("City").text
		If lg_debug Then dbMsg = dbMsg & "city = "& city &"<br>" & vbLF End If
		set objXMLHTTP=nothing
		on error goto 0
		'*******************************************************************************************************************
		'* Set locked, dateLocked and unlock token
		'*******************************************************************************************************************
		locked="1"
		If lg_debug Then dbMsg = dbMsg & "locked = 1<br>" & vbLF End If
		dateLocked = dbNow
		If lg_debug Then dbMsg = dbMsg & "dateLocked = "& dateLocked &"<br>" & vbLF End If
		token = Left(HashEncode(getGUID),40)
		If lg_debug Then dbMsg = dbMsg & "token = "& token &"<br>" & vbLF End If
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
		If lg_debug Then dbMsg = dbMsg & "Database insert occurred. Result = "& numAffected &"<br>" & vbLF End If

		If numAffected = 1 Then
			'*******************************************************************************************************************
			'* On success, email user the unlock token. Copy the webmaster
			'*******************************************************************************************************************
			If lg_debug Then dbMsg = dbMsg & "Database Insert Success: Prepare e-mail.<br>" & vbLF End If
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
			If lg_debug Then dbMsg = dbMsg & "mailbody = "& mailbody &"<br>" & vbLF End If
			
			sendmail lg_webmaster_email, email, "User Registration", mailBody
			sendmail lg_webmaster_email, "rod@rodsdot.com", "ATTN:Webmaster User Registration", mailBody
			If lg_debug Then dbMsg = dbMsg & "mail sent = "& CDOMailIncludeResults &"<br>" & vbLF End If
		Else
			message = lg_phrase_registration_error & " " & lg_term_via_email & " " & lg_webmaster_email & " " & lg_term_or & " " & lg_term_at & "<a href=""" & lg_contact_form & """>" & lg_term_contact_form & "</a>"
			If lg_debug Then dbMsg = dbMsg & "Database Insert Failed: "& message &"<br>" & vbLF End If
		End If
		closeRS
		closeCommand
	End If
End if
%>