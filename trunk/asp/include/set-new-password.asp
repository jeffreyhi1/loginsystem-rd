<%
'* alpha 0.5a debug
'* $Id$
'*******************************************************************************************************************
'* Page Name: Set New Password
'* On Entry: reset token
'* Input   : current password, new password, confirmation password
'* Output  : message
'* On Exit : password changed
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
Dim resettoken, cmdTxt, timePassed, id, userid, email, message, locked, dateLocked, mailBody
Dim password, confirm, passhash, name, destination, changePassword, dbMsg
Dim entropy, lowLetters, upLetters, symbols, digits, totalChars, lowLettersChars, upLettersChars, symbolChars, digitChars, otherChars


resettoken=""
cmdTxt=""
timePassed=""
id=""
userid=""
email=""
message = "Enter your password reset token in the field provided and press the Submit button."
locked=""
dateLocked=""
mailBody=""
password = ""
confirm = ""
passhash = ""
name=""
destination=""
changePassword=""
dbMsg = ""
entropy =0
lowLetters = "abcdefghijklmnopqrstuvwxyz"
upLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
symbols = "~`!@#$%^&*()-_+="
digits = "1234567890"

totalChars = 95
lowLettersChars = Len(lowLetters)
upLettersChars = Len(upLetters)
symbolChars = Len(symbols)
digitChars = Len(digits)
otherChars = totalChars - (lowLettersChars + upLettersChars + symbolChars + digitChars)

Function getEntropy(pPass)
	Dim hasLower, hasUpper, hasSymbol, hasDigit
	Dim hasOther, idx, char, bits, match, domain

    If (Len(pPass) < 0) Then
        getEntropy = 0
    Else
    	hasLower = False
    	hasUpper = False
    	hasSymbol = False
    	hasDigit = False
    	hasOther = False
    	domain = 0
		
    	For idx = 1 to Len(pPass)
        	char = Mid(pPass,idx,1)
			match = ""
			
        	If InStr(lowLetters,char) > 0 Then
            	hasLower = True
            	match = True
            End If	
            If InStr(upLetters,char) > 0 Then
            	hasUpper = True
            	match = True
            End If
            If InStr(digits,char) > 0 Then
            	hasDigit = True
            	match = True
            End If
            If InStr(symbols,char) > 0 Then
            	hasSymbol = True
            	match = True
            End If
            If match="" Then
            	hasOther = True
            End If            
		Next
		   
	    If (hasLower) Then
        	domain = domain + lowLettersChars
        End If
    	If (hasUpper) Then
        	domain = domain + upLettersChars
    	End If
    	If (hasDigit) Then
        	domain = domain + digitChars
    	End If
    	If (hasSymbol) Then
        	domain = domain + symbolChars
    	End If
    	If (hasOther) Then
        	domain = domain + otherChars
        End If
        
        bits = Log(domain) * (Len(pPass) / Log(2))	
    	getEntropy = Int(bits)
    End If
End Function


'*******************************************************************************************************************
'* If the resettoken was posted in the form - get the resettoken
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If lg_debug Then dbMsg=dbMsg&"METHOD is POST<br>" & vbLF End If
	If lg_debug Then dbMsg=dbMsg&"Check form token<br>" & vbLF End If
	resettoken = getField("resettoken")
	If lg_debug Then dbMsg=dbMsg&"Reset token" & resettoken & "<br>" & vbLF End If
	If lg_debug Then dbMsg=dbMsg&"Session(action)=" & Session("action") & "<br>" & vbLF End If
	If Session("action")="password" Then
		If lg_debug Then dbMsg=dbMsg&"Session(action)=password<br>" & vbLF End If
		password = Left(Request.Form("password"),255)
		If lg_debug Then dbMsg=dbMsg&"password="& Server.HTMLEncode(password) &"<br>" & vbLF End If
		confirm = Left(Request.Form("confirm"),255)
		If lg_debug Then dbMsg=dbMsg&"confirm password="& Server.HTMLEncode(confirm) &"<br>" & vbLF End If
		changePassword=getField("changePassword,rXint")
		If lg_debug Then dbMsg=dbMsg&"change password="& changePassword &"<br>" & vbLF End If
	Else
		If resettoken="" Then
			Session("action") = "token"
		Else	
			Session("action") = "resettoken"
		End If	
		If lg_debug Then dbMsg=dbMsg&"Session(action)="& Session("action") &" in POST<br>" & vbLF End If	
	End if	
End if
'*******************************************************************************************************************
'* If the token was passed on the URL from a email link - get the token
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	If lg_debug Then dbMsg=dbMsg&"METHOD GET<br>" & vbLF End If
	resettoken = getField("resettoken,rXSafe,get")
	If lg_debug Then dbMsg=dbMsg&"reset token="&resettoken&"<br>" & vbLF End If
	destination = getField("p,rXurlpath,get")
	If lg_debug Then dbMsg=dbMsg&"destination="&destination&"<br>" & vbLF End If
	If Request.Querystring = "" OR resettoken="" Then
		Session("action") = "token"
	Else
		Session("action") = "resettoken"
	End If
	If lg_debug Then dbMsg=dbMsg&"Session(action)="& Session("action") &" in GET<br>" & vbLF End If
End if
'*******************************************************************************************************************
'* If the token exists, process account activation
'*******************************************************************************************************************
If resettoken<>"" AND Session("action")="resettoken" then
	If lg_debug Then dbMsg=dbMsg&"resettoken not empty and Session(action)=resettoken<br>" & vbLF End If
	'*******************************************************************************************************************
	'* Get the dateLocked and verify it is within the lifetime of the token
	'*******************************************************************************************************************
	If lg_database="access" Then
		cmdTxt = "SELECT [id], [token], [dateLocked] FROM users WHERE ([token]=?);"
	Else
		cmdTxt = "SELECT id, token, dateLocked FROM users WHERE (token=?);"
	End If		
	If lg_debug Then dbMsg=dbMsg&"cmdTxt = SELECT id, token, dateLocked FROM users WHERE (token=?);<br>" & vbLF End If
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	If lg_debug Then dbMsg=dbMsg&"openCommand<br>" & vbLF End If
	addParam "@token",adVarChar,adParamInput,CLng(40),resettoken,lg_term_checkToken & " 3"
	If lg_debug Then dbMsg=dbMsg&"addParam token="&resettoken&"<br>" & vbLF End If
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If lg_debug Then dbMsg=dbMsg&"open Recordset<br>" & vbLF End If
	If NOT(db_rs.bof AND db_rs.eof) Then
		If lg_debug Then dbMsg=dbMsg&"returned record(s)<br>" & vbLF End If
		timePassed = DateDiff("h",Now,db_rs("dateLocked"))
		If lg_debug Then dbMsg=dbMsg&"timePassed"&timePassed&"<br>" & vbLF End If
		if (timePassed <=24) Then
			If lg_debug Then dbMsg=dbMsg&"timePassed < 24 hours<br>" & vbLF End If
			'*******************************************************************************************************************
			'* The token is good, prepare to change password
			'*******************************************************************************************************************
			id = db_rs("id")
			If lg_debug Then dbMsg=dbMsg&"record id="&id&"<br>" & vbLF End If
			closeRS
			CloseCommand
			If lg_debug Then dbMsg=dbMsg&"closedCommand and closedRS<br>" & vbLF End If
			message = lg_phrase_set_new_password_good_token
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
			Session("action")="password"
			If lg_debug Then dbMsg=dbMsg&"Session(action)=password<br>" & vbLF End If
		Else
			'*******************************************************************************************************************
			'* The token has expired: show link to Issue Verification Token page
			'*******************************************************************************************************************
			message = "<h2>lg_phrase_set_new_password_token_expired</h2><br><br>"
			message = message & lg_phrase_contact_webmaster1 & " " & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
			If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
		End If
	Else
		message = lg_phrase_set_new_password_error & "Error 3A. "& lg_phrase_contact_webmaster1 & "<br>"
		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
		Session("action")="Error"
		If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
		If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
	End IF
	closeCommand
	If lg_debug Then dbMsg=dbMsg&"closedCommand<br>" & vbLF End If
Else
	If changePassword="1" Then
		If lg_debug Then dbMsg=dbMsg&"changePassword=1<br>" & vbLF End If
		message = ""
		If password = "" Then
			message = message & lg_phrase_newpassword_empty & "<br>"
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
		End If
		entropy = getEntropy(password)
		If lg_debug Then dbMsg = dbMsg & "ENTROPY = "& entropy &"<br />" & vbLF End If
		If (lg_password_min_bits > 0) AND (entropy < lg_password_min_bits) Then
			message = message & lg_phrase_password_too_simple & "<br>" & vbLF
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		ElseIf (lg_password_min_length > 0) AND (Len(password) < lg_password_min_length) AND (lg_password_min_bits < 1) Then
			message = message & lg_phrase_password_too_short_pre & " " & lg_password_min_length & " " & lg_phrase_password_too_short_post & "<br>" & vbLF
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		End If
		If confirm = "" Then
			message = message & lg_phrase_confirm_empty & "<br>"
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
		End If
		If password<>confirm Then
			message = message & lg_phrase_password_nomatch_confirm
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
		End If		
		If resettoken = "" Then
			 message = lg_phrase_set_new_password_error & "Error 1. "& lg_phrase_contact_webmaster1 &"<br>"
			 message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			 Session("action")="Error"
			 If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
			 If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
		End If
		If message="" Then
			If lg_database="access" Then
				cmdTxt = "SELECT [id], [userid], [email], [name], [locked], [dateLocked], [token] FROM users WHERE ([token]=?);"
			Else
				cmdTxt = "SELECT id, userid, email, name, locked, dateLocked, token FROM users WHERE (token=?);"
			End If		
			If lg_debug Then dbMsg=dbMsg&"cmdTxt=SELECT [id], userid, email, name, locked, dateLocked, token FROM users WHERE (token=?)<br>" & vbLF End If
			openCommand lg_term_command_string,lg_term_checkToken & " 1"
			If lg_debug Then dbMsg=dbMsg&"openCommand<br>" & vbLF End If
			addParam "@token",adVarChar,adParamInput,CLng(40),resettoken,lg_term_checkToken & " 3"
			If lg_debug Then dbMsg=dbMsg&"addParam token="&resettoken&"<br>" & vbLF End If
			getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
			If lg_debug Then dbMsg=dbMsg&"open Recordset<br>" & vbLF End If
			If NOT(db_rs.bof AND db_rs.eof) Then
				If lg_debug Then dbMsg=dbMsg&"returned record(s)<br>" & vbLF End If
				timePassed = DateDiff("h",Now,db_rs("dateLocked"))
				If lg_debug Then dbMsg=dbMsg&"timePassed="&timePassed&"<br>" & vbLF End If
				if (timePassed <=24) Then
					If lg_debug Then dbMsg=dbMsg&"timePassed < 24 hours<br>" & vbLF End If
					'*******************************************************************************************************************
					'* The token is good, change passord and unlock the account
					'*******************************************************************************************************************
					id = db_rs("id")
					If lg_debug Then dbMsg=dbMsg&"id="&id&"<br>" & vbLF End If
					userid = db_rs("userid")
					If lg_debug Then dbMsg=dbMsg&"userid="&userid&"<br>" & vbLF End If
					email = db_rs("email")
					If lg_debug Then dbMsg=dbMsg&"email="&email&"<br>" & vbLF End If
					name = db_rs("name")
					If lg_debug Then dbMsg=dbMsg&"name="&name&"<br>" & vbLF End If
					locked = db_rs("locked")
					If lg_debug Then dbMsg=dbMsg&"locked="&locked&"<br>" & vbLF End If
					dateLocked = db_rs("dateLocked")
					If lg_debug Then dbMsg=dbMsg&"dateLocked="&dateLocked&"<br>" & vbLF End If
					closeRS
					CloseCommand
					If lg_debug Then dbMsg=dbMsg&"closedCommand and closedRS<br>" & vbLF End If
					'*******************************************************************************************************************
					'*
					'*******************************************************************************************************************
					passhash = HashEncode(password & userid)
					If lg_debug Then dbMsg=dbMsg&"passhash="&passhash&"<br>" & vbLF End If
					If lg_database="access" Then
						cmdTxt = "UPDATE users SET [password] = ?, [token] = ?, [locked] = ?, [dateLocked] = ? WHERE ([id]=?);"
					Else
						cmdTxt = "UPDATE users SET password = ?, token = ?, locked = ?, dateLocked = ? WHERE (id=?);"
					End If		
					If lg_debug Then dbMsg=dbMsg&"cmdTxt=UPDATE users SET users.password = ?, users.token = ?, users.locked = ?, users.dateLocked = ? WHERE (users.id=?);<br>" & vbLF End If
					openCommand lg_term_command_string,"checkToken 4"
					If lg_debug Then dbMsg=dbMsg&"openCommand<br>" & vbLF End If
					addParam "@pass",adVarChar,adParamInput,CLng(255),passhash,"checkToken 5"
					If lg_debug Then dbMsg=dbMsg&"addParam =password"&passhash&"<br>" & vbLF End If
					addParam "@token",adVarChar,adParamInput,CLng(40),Null,"checkToken 5"
					If lg_debug Then dbMsg=dbMsg&"addParam token=Null<br>" & vbLF End If
					addParam "@locked",adVarChar,adParamInput,CLng(1),"0","checkToken 6"
					If lg_debug Then dbMsg=dbMsg&"addParam locked=0<br>" & vbLF End If
					addParam "@dateLocked",adDate,adParamInput,CLng(8),Null,"checkToken 7"
					If lg_debug Then dbMsg=dbMsg&"addParam dateLocked=Null<br>" & vbLF End If
					addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 8"
					If lg_debug Then dbMsg=dbMsg&"addParam id="&id&"<br>" & vbLF End If
					execCmd cmdTxt
					If lg_debug Then dbMsg=dbMsg&"execute command<br>" & vbLF End If
					If numAffected = 1 Then
						If lg_debug Then dbMsg=dbMsg&"numAffected="&numAffected&"<br>" & vbLF End If
						message = lg_phrase_set_new_password_success
						If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
						Session("action")="Success"
						If lg_debug Then dbMsg=dbMsg&"Session(action)=Success<br>" & vbLF End If
						Response.Cookies("token")=""
						Response.Cookies("token").Expires = "December 31, 2000"
						'*******************************************************************************************************************
						'* Notify account holder of password change
						'*******************************************************************************************************************
						mailBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
						mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=UTF-8"">"
						mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"
						mailBody = mailBody & lg_term_to & " " & name & "<br><br>" 
						mailBody = mailBody & lg_phrase_password_changed_pre & lg_domain & lg_phrase_password_changed_post &" "& Now &"<br><br>"
						mailBody = mailBody & lg_phrase_password_change_authorized
						mailBody = mailBody & lg_term_via_email & " " & lg_webmaster_email_link & " " & lg_term_immediately & "<br>"
						mailBody = mailBody & lg_term_or & " " & lg_term_at & "&nbsp;the <a href=""" & lg_contact_form & """>" & lg_term_contact_form & "</a><br>"
						mailBody = mailBody & "</FONT></DIV>"
						mailBody = mailBody & "</div></BODY></HTML>"
						sendmail lg_webmaster_email, name & "<"&email&">", lg_phrase_password_changed, mailBody
						sendmail lg_webmaster_email, lg_webmaster_email, "ATTN:Webmaster " & lg_phrase_password_changed, mailBody
						If lg_debug Then dbMsg=dbMsg&"Sent Mail Notification<br>" & mailBody & "<br>" & vbLF End If
					Else
						message = lg_phrase_set_new_password_error & "Error 2. "& lg_phrase_contact_webmaster1 &"<br>"
				 		message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
						Session("action")="Error"
						Response.Cookies("token")=""
						Response.Cookies("token").Expires = "December 31, 2000"
						If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
						If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
					End If
				Else
					message = "<h2>lg_phrase_verify_expired</h2><br>"& lg_phrase_contact_webmaster1 &"<br>"
					message = message & lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
					Session("action")="Error"
					Response.Cookies("token")=""
					Response.Cookies("token").Expires = "December 31, 2000"
					If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
					If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
				End If
			Else
				message = lg_phrase_set_new_password_error & "Error 3. "& lg_phrase_contact_webmaster1 &"<br>"
				message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
				Session("action")="Error"
				Response.Cookies("token")=""
				Response.Cookies("token").Expires = "December 31, 2000"
				If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
				If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
			End If
		Else
			message = lg_phrase_set_new_password_error & "Error 4. "& lg_phrase_contact_webmaster1 &"<br>"
			message = lg_phrase_webmaster_may_be_contacted & lg_webmaster_email_link
			Session("action")="Error"
			Response.Cookies("token")=""
			Response.Cookies("token").Expires = "December 31, 2000"
			If lg_debug Then dbMsg=dbMsg&"message="&message&"<br>" & vbLF End If
			If lg_debug Then dbMsg=dbMsg&"Session(action)=Error<br>" & vbLF End If
		End If		
	End If
End If
%>