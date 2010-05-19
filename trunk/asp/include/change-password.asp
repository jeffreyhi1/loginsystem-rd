<%
'* alpha 0.5 debug
'* $Id$
'*******************************************************************************************************************
'* Change Password
'* On Entry: Verify need for SSL
'* Input:    oldpassword, password, confirm
'* Output:   message - string variable with results
'* On Exit:  Password Changed
'*           Email sent to account owner
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
Dim cmdTxt, name, email, oldpassword, password, confirm, oldpasshash, oldpasshashconfirm
Dim passhash, message, mailBody, dbMsg
Dim entropy, lowLetters, upLetters, symbols, digits, totalChars, lowLettersChars, upLettersChars, symbolChars, digitChars, otherChars

cmdTxt=""
name=""
email=""
oldpassword=""
password=""
confirm=""
oldpasshash=""
oldpasshashconfirm=""
passhash=""
message=lg_phrase_change_password
mailBody=""
If lg_debug Then dbMsg = dbMsg & "DEBUG BEGIN<br>" End If
If lg_debug Then dbMsg = dbMsg & "message: "&message&"<br>" End If
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

    If (Len(pPass) <= 0) Then
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
'* Must be logged in to change password. If not logged in redirect to login.asp
'*******************************************************************************************************************
If lg_debug Then dbMsg = dbMsg & "Check for Session(login)<br>" End If 
If NOT Session("login") AND lg_useSSL AND NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	If lg_debug Then dbMsg = dbMsg & "Not loggedin, useSSL=true, not secure port: redirecting to login<br>" End If
	Response.Redirect("https://" & lg_domain_secure & lg_loginPath & lg_loginPage &"?p=" & Request.ServerVariables("SCRIPT_NAME"))
Else
	If NOT Session("login") Then
		If lg_debug Then dbMsg = dbMsg & "not logged in, not using SSL, redirecting to login<br>" End If
		Response.Redirect("http://" & lg_domain & lg_loginPath & lg_loginPage &"?p=" & Request.ServerVariables("SCRIPT_NAME"))
	End If
End If


'*******************************************************************************************************************
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	If lg_debug Then dbMsg = dbMsg & "Logged in, but using SSL, recalling this page secure<br>" End If
	Response.Redirect("https://" & lg_domain & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	If lg_debug Then dbMsg = dbMsg & "POST: checkToken<br>" End If
	checkToken
	If lg_debug Then dbMsg = dbMsg & "checkToken okay<br>" End If
	message=""
	If lg_debug Then dbMsg = dbMsg & "message: "&message&"<br>" End If
	oldpassword = Left(Request.Form("oldpassword"),255)
	If lg_debug Then dbMsg = dbMsg & "oldpassword: "& Server.HTMLEncode(oldpassword) &"<br>" End If
	password = Left(Request.Form("password"),255)
	If lg_debug Then dbMsg = dbMsg & "new password: "& Server.HTMLEncode(password) &"<br>" End If
	confirm = Left(Request.Form("confirm"),255)
	If lg_debug Then dbMsg = dbMsg & "confirm password: "& Server.HTMLEncode(confirm) &"<br>" End If
	If oldpassword & ""="" Then
		If lg_debug Then dbMsg = dbMsg & "oldpassword empty<br>" End If
		message = message & lg_phrase_oldpassword_empty & "<br>"
	End If
	If password & ""="" Then
		If lg_debug Then dbMsg = dbMsg & "new password empty<br>" End If
		message = message & lg_phrase_newpassword_empty & "<br>"
	End If
	If password<>"" Then
		entropy = getEntropy(password)
		If lg_debug Then dbMsg = dbMsg & "ENTROPY = "& entropy &"<br />" & vbLF End If
		If (lg_password_min_bits > 0) AND (entropy < lg_password_min_bits) Then
			message = message & lg_phrase_password_too_simple & "<br>" & vbLF
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		ElseIf (lg_password_min_length > 0) AND (Len(password) < lg_password_min_length) AND (lg_password_min_bits < 1) Then
			message = message & lg_phrase_password_too_short_pre & " " & lg_password_min_length & " " & lg_phrase_password_too_short_post & "<br>" & vbLF
			If lg_debug Then dbMsg = dbMsg & "message = "& message &"<br />" & vbLF End If
		End If
	End If	
	If confirm & ""="" Then
		If lg_debug Then dbMsg = dbMsg & "confirm password empty<br>" End If
		message = message & lg_phrase_confirm_empty & "<br>"
	End If
	'*******************************************************************************************************************
	'* If all required fields exist, update database with new password hash
	'*******************************************************************************************************************
	If message="" Then
		If lg_debug Then dbMsg = dbMsg & "All required fields present: Process form<br>" End If
		If lg_database="access" Then
			cmdTxt = "SELECT [name], [email], [password] FROM users WHERE([userid]=?);"
		Else
			cmdTxt = "SELECT name, email, password FROM users WHERE(userid=?);"
		End If		
		If lg_debug Then dbMsg = dbMsg & "cmdTxt = SELECT name, email, password FROM users WHERE(userid=?);<br>" End If
		openCommand lg_term_command_string,lg_term_get_oldpassword&" 1"
		If lg_debug Then dbMsg = dbMsg & "opened command object<br>" End If
		addParam "@u",adVarChar,adParamInput,CLng(Len(Session("userid"))),Session("userid"),lg_term_get_oldpassword&" 2"
		If lg_debug Then dbMsg = dbMsg & "added parameter userid: "&Session("userid")&"<br>" End If
		getRS db_rs, cmdTxt, lg_term_get_oldpassword&" 3"
		If lg_debug Then dbMsg = dbMsg & "executed get recordset<br>" End If
		If Not(db_rs.bof AND db_rs.eof) Then
			If lg_debug Then dbMsg = dbMsg & "Recordset not empty<br>" End If
			oldpasshash = db_rs("password")
			If lg_debug Then dbMsg = dbMsg & "oldhash = "&oldpasshash&"<br>" End If
			name = db_rs("name")
			If lg_debug Then dbMsg = dbMsg & "name = "&name&"<br>" End If
			email = db_rs("email")
			If lg_debug Then dbMsg = dbMsg & "email = "&email&"<br>" End If
		End If
		closeCommand
		closeRS
		If password=confirm Then
			If lg_debug Then dbMsg = dbMsg & "new password matches confirm password<br>" End If
			oldpasshashconfirm = HashEncode(oldpassword & Session("userid"))
			If lg_debug Then dbMsg = dbMsg & "verification hash computed as: "&oldpasshashconfirm&"<br>" End If
			if oldpasshashconfirm=oldpasshash Then
				If lg_debug Then dbMsg = dbMsg & "oldpassword hash matches stored password hash<br>" End If
				passhash = HashEncode(password & Session("userid"))
				openCommand lg_term_command_string,lg_term_change_password&" 2"
				If lg_database="access" Then
					cmdTxt = "UPDATE users SET [password]=? WHERE ([userid]=?);"
				Else
					cmdTxt = "UPDATE users SET password=? WHERE (userid=?);"
				End If	
				If lg_debug Then dbMsg = dbMsg & "cmdTxt = UPDATE users SET (password=?) WHERE (userid=?);<br>" End If
				addParam "@p",adVarChar,adParamInput,CLng(Len(passhash)),passhash,lg_term_change_password&" 3"
				If lg_debug Then dbMsg = dbMsg & "parameter added passhash: "&passhash&"<br>" End If
				addParam "@u",adVarChar,adParamInput,CLng(Len(Session("userid"))),Session("userid"),lg_term_change_password&" 4"
				If lg_debug Then dbMsg = dbMsg & "parameter added userid: "&Session("userid")&"<br>" End If
				execCmd cmdTxt
				If lg_debug Then dbMsg = dbMsg & "executed command<br>" End If
				If numAffected=1 Then
					If lg_debug Then dbMsg = dbMsg & "SUCCESS: numAffected=1<br>" End If
					'*******************************************************************************************************************
					'* Notify account holder of password change
					'*******************************************************************************************************************
					mailBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
					mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=UTF-8"">"
					mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>" & lg_term_to &" "& name & "<br><br>"
					mailBody = mailBody & lg_phrase_password_changed_pre & " " & lg_domain & " " & lg_phrase_password_changed_post &" "& Now &"<br><br>"
					mailBody = mailBody & lg_phrase_password_change_authorized & " "
					mailBody = mailBody & lg_term_via_email & " " & lg_webmaster_email_link & " " & lg_term_immediately & "<br>"
					mailBody = mailBody & lg_term_or & " " & lg_term_at & "&nbsp;the <a href=""" & "http://" & lg_domain &  lg_contact_form & """>" & lg_term_contact_form & "</a><br>"
					mailBody = mailBody & "</FONT></DIV>"
					mailBody = mailBody & "</div></BODY></HTML>"
					If lg_debug Then dbMsg = dbMsg & "Send Mail To Owner<br>" & mailBody End If
					sendmail lg_webmaster_email, name & "<"&email&">", lg_phrase_password_changed, mailBody
					sendmail lg_webmaster_email, lg_webmaster_email, lg_phrase_password_changed, mailBody
					message = lg_phrase_password_changed
				Else
					message = lg_phrase_password_changed_error
					If lg_debug Then dbMsg = dbMsg & message & "<br>" End If
				End if
				closeCommand
			Else
				message = lg_phrase_oldpassword_does_not_match
				If lg_debug Then dbMsg = dbMsg & message & "<br>" End If
			End If
		Else
			message = lg_phrase_password_nomatch_confirm
			If lg_debug Then dbMsg = dbMsg & message & "<br>" End If
		End If
	Else
		If lg_debug Then dbMsg = dbMsg & "NOT ALL REQUIRED FIELDS<br>" End If
	End If
Else
	If lg_debug Then dbMsg = dbMsg & "HTTP METHOD GET<br>" End If
End If					
%>