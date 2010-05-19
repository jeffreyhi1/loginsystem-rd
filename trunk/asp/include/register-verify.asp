<%
'* alpha 0.5 debug
'* $Id$
'*******************************************************************************************************************
'* Page Name: Register Verify
'* On Entry: N/A
'* Input:    token
'* Output:   message - string variable with results
'* On Exit:  Account Activated.
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
Dim token, cmdTxt, timePassed, id, userid, name, email, message, locked, dateLocked, ip
Dim region, city, country, useragent, objXMLHTTP, xmlDoc, destination, dbMsg

token=""
cmdTxt=""
timePassed=""
id=""
userid=""
name=""
email=""
message = lg_phrase_registration_email_verify_msg
locked=""
dateLocked=""
ip=""
region=""
city=""
country=""
useragent=""
objXMLHTTP=""
xmlDoc=""
destination=""
dbMsg=""

If lg_debug Then dbMsg = "DEBUG BEGIN<br />" & vbLF End If

'*******************************************************************************************************************
'* If the token was posted in the form - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If lg_debug Then dbMsg = dbMsg & "METHOD=POST<br />" & vbLF End If
	token = getField("token,rXSafepq")
	If lg_debug Then dbMsg = dbMsg & "Posted token = "& token &"<br />" & vbLF End If
End if
'*******************************************************************************************************************
'* If the token was passed on the URL from a email link - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	If lg_debug Then dbMsg = dbMsg & "METHOD=GET<br />" & vbLF End If
	token = getField("token,rXSafepq,get")
	If lg_debug Then dbMsg = dbMsg & "URL token = "& token &"<br />" & vbLF End If
	destination = getField("p,rXurlpath,get")
	If lg_debug Then dbMsg = dbMsg & "destination = "& destination &"<br />" & vbLF End If
End if
'*******************************************************************************************************************
'* If the token exists, process account activation
'*******************************************************************************************************************
If token<>"" then
	'*******************************************************************************************************************
	'* Get the dateLocked and verify it is within the lifetime of the token
	'*******************************************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "Token not empty. Get account details.<br />" & vbLF End If
	If lg_database="access" Then
		cmdTxt = "SELECT [id], [userid], [email], [locked], [dateLocked], [token] FROM users WHERE ([token]=?);"
	Else
		cmdTxt = "SELECT id, userid, email, locked, dateLocked, token FROM users WHERE (token=?);"
	End If		
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_checkToken & " 3"
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If NOT(db_rs.bof AND db_rs.eof) Then
		If lg_debug Then dbMsg = dbMsg & "dateLocked = "& dateLocked &"<br />" & vbLF End If
		timePassed = DateDiff("h",Now,db_rs("dateLocked"))
		If lg_debug Then dbMsg = dbMsg & "timePassed = "& timePassed &"<br />" & vbLF End If
		if (timePassed <=24) Then
			'*******************************************************************************************************************
			'* The token is good, prepare to unlock the account
			'*******************************************************************************************************************
			If lg_debug Then dbMsg = dbMsg & "Token is good, prepare to unlock the account. Get account details.<br />" & vbLF End If
			id = db_rs("id")
			userid = db_rs("userid")
			email = db_rs("email")
			locked = db_rs("locked")
			dateLocked = db_rs("dateLocked")
			If lg_debug Then dbMsg = dbMsg & "ID = "& id &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "UserID = "& userid &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Email = "& email &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Locked = "& locked &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "dateLocked = "& dateLocked &"<br />" & vbLF End If
			closeRS
			CloseCommand
			'*******************************************************************************************************************
			'* Geo-locate the user's IP
			'*******************************************************************************************************************
			If lg_debug Then dbMsg = dbMsg & "Geo-locate the user IP<br />" & vbLF End If
			ip = Request.ServerVariables("REMOTE_ADDR")
			useragent = Server.HTMLEncode(Trim(Left(Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT")),255)))
			If lg_debug Then dbMsg = dbMsg & "IP = "& ip &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Useragent = "& useragent &"<br />" & vbLF End If
			Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
			objXMLHTTP.Open "GET", "http://ipinfodb.com/ip_query.php?ip="&ip, False
			objXMLHTTP.Send
			Set xmldoc = objXMLHTTP.responseXML
			on error resume next
			country = xmlDoc.documentElement.selectSingleNode("CountryName").text
			region = xmlDoc.documentElement.selectSingleNode("RegionName").text
			city = xmlDoc.documentElement.selectSingleNode("City").text
			If lg_debug Then dbMsg = dbMsg & "City = "& city &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Region = "& Region &"<br />" & vbLF End If
			If lg_debug Then dbMsg = dbMsg & "Country = "& country &"<br />" & vbLF End If
			set objXMLHTTP=nothing
			on error goto 0
			'*******************************************************************************************************************
			'* Unlock the account - set token->Null, dateLocked->Null, locked->0
			'*******************************************************************************************************************
			If lg_debug Then dbMsg = dbMsg & "Unlock the account<br />" & vbLF End If
			openCommand lg_term_command_string,"checkToken 4"
			If lg_database="access" Then
				cmdTxt = "UPDATE users SET [token] = ?, [locked] = ?, [dateLocked] = ? WHERE ([id]=?);"
			Else
				cmdTxt = "UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE (id=?);"
			End If		
			addParam "@token",adVarChar,adParamInput,CLng(40),Null,"checkToken 5"
			addParam "@locked",adVarChar,adParamInput,CLng(1),"0","checkToken 6"
			addParam "@dateLocked",adDate,adParamInput,CLng(8),Null,"checkToken 7"
			addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 8"
			execCmd cmdTxt
			
			message = "<h2>"&lg_phrase_verify_verified&"</h2><br><br>"
			message = message & lg_phrase_verify_login & "<br>"
			message = message & "<div id=""details"">" & LCase(lg_term_userid) & ": " & Server.HTMLEncode(userid) & "<br>"
			message = message & LCase(lg_term_email) & ": " & Server.HTMLEncode(email) & "<br>"
			message = message & LCase(lg_term_ip) & ": " & Server.HTMLEncode(ip) & "<br>"
			message = message & LCase(lg_term_region) & ": " & Server.HTMLEncode(region) & "<br>"
			message = message & LCase(lg_term_city) & ": " & Server.HTMLEncode(city) & "<br>"
			message = message & LCase(lg_term_country) & ": " & Server.HTMLEncode(country) & "<br>"
			message = message & LCase(lg_term_useragent) & ": " & Server.HTMLEncode(useragent) & "<br></div>"
			If destination&""<>"" Then
				message = message & "<p><a href="""& lg_loginPage &"?p="& destination &" "" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a></p>"
			Else
				message = message & "<p><a href="""& lg_loginPage &" "" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a></p>"
			End If
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		Else
			'*******************************************************************************************************************
			'* The token has expired: show link to Issue Verification Token page
			'*******************************************************************************************************************
			message = "<h2>lg_phrase_verify_expired</h2><br><br>"
			message = message & "<a href=""lg_new_token_page"">lg_phrase_verify_newtoken</a>"
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		End If
	Else
		message = lg_phrase_login_token_problem
		If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
	End IF
	closeCommand
End If
%>