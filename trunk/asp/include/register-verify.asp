<%
'*******************************************************************************************************************
'* Register Verify
'* Last Modification: 26 FEB 2010
'* Version:  beta 1.5
'* On Entry: N/A
'* Input:    token
'* Output:   message - string variable with results
'* On Exit:  Account Activated.
'******************************************************************************************************************

'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim token, cmdTxt, timePassed, id, userid, name, email, message, locked, dateLocked, ip
Dim region, city, country, useragent, objXMLHTTP, xmlDoc, destination

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


'*******************************************************************************************************************
'* If the token was posted in the form - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	token = getField("token,rXSafepq")
End if
'*******************************************************************************************************************
'* If the token was passed on the URL from a email link - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	token = getField("token,rXSafepq,get")
	destination = getField("p,rXurlpath,get")
End if
'*******************************************************************************************************************
'* If the token exists, process account activation
'*******************************************************************************************************************
If token<>"" then
	'*******************************************************************************************************************
	'* Get the dateLocked and verify it is within the lifetime of the token
	'*******************************************************************************************************************
	cmdTxt = "SELECT id, userid, email, locked, dateLocked, token FROM users WHERE (token=?);"
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	addParam "@token",adVarChar,adParamInput,CLng(40),token,lg_term_checkToken & " 3"
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If NOT(db_rs.bof AND db_rs.eof) Then
		timePassed = DateDiff("h",Now,db_rs("dateLocked"))
		if (timePassed <=24) Then
			'*******************************************************************************************************************
			'* The token is good, prepare to unlock the account
			'*******************************************************************************************************************
			id = db_rs("id")
			userid = db_rs("userid")
			email = db_rs("email")
			locked = db_rs("locked")
			dateLocked = db_rs("dateLocked")
			closeRS
			CloseCommand
			'*******************************************************************************************************************
			'* Geo-locate the user's IP
			'*******************************************************************************************************************
			ip = Request.ServerVariables("REMOTE_ADDR")
			useragent = Server.HTMLEncode(Trim(Left(Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT")),255)))
			Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
			objXMLHTTP.Open "GET", "http://ipinfodb.com/ip_query.php?ip="&ip, False
			objXMLHTTP.Send
			Set xmldoc = objXMLHTTP.responseXML
			on error resume next
			country = xmlDoc.documentElement.selectSingleNode("CountryName").text
			region = xmlDoc.documentElement.selectSingleNode("RegionName").text
			city = xmlDoc.documentElement.selectSingleNode("City").text
			set objXMLHTTP=nothing
			on error goto 0
			'*******************************************************************************************************************
			'* Unlock the account - set token->Null, dateLocked->Null, locked->0
			'*******************************************************************************************************************
			openCommand lg_term_command_string,"checkToken 4"
			cmdTxt = "UPDATE users SET token = ?, locked = ?, dateLocked = ? WHERE (id=?);"
			addParam "@token",adVarChar,adParamInput,CLng(40),Null,"checkToken 5"
			addParam "@locked",adVarChar,adParamInput,CLng(1),"0","checkToken 6"
			addParam "@dateLocked",adDate,adParamInput,CLng(8),Null,"checkToken 7"
			addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 8"
			execCmd cmdTxt
			message = "<h2>"&lg_phrase_verify_verified&"</h2><br><br>"
			message = message & lg_phrase_verify_login & "<br>"
			message = message & "<div id=""details"">" & LCase(lg_term_userid) & ": " & userid & "<br>"
			message = message & LCase(lg_term_email) & ": " & email & "<br>"
			message = message & LCase(lg_term_ip) & ": " & ip & "<br>"
			message = message & LCase(lg_term_region) & ": " & region & "<br>"
			message = message & LCase(lg_term_city) & ": " & city & "<br>"
			message = message & LCase(lg_term_country) & ": " & country & "<br>"
			message = message & LCase(lg_term_useragent) & ": " & useragent & "<br></div>"
			If destination&""<>"" Then
				message = message & "<p><a href="""& destination &""" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a></p>"
			End If
		Else
			'*******************************************************************************************************************
			'* The token has expired: show link to Issue Verification Token page
			'*******************************************************************************************************************
			message = "<h2>lg_phrase_verify_expired</h2><br><br>"
			message = message & "<a href=""lg_new_token_page"">lg_phrase_verify_newtoken</a>"
		End If
	Else
		message = lg_phrase_login_token_problem
	End IF
	closeCommand
End If
%>