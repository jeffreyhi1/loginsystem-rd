<%
' $Id$
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 26 APR 2010 rdivilbiss
'* Version:  alpha 1.0a
'* On Entry: None
'* Input   : email
'* Output  : None - account marked as deleted
'* On Exit : message
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
Dim token, cmdTxt, timePassed, id, userid, name, email, message, locked, dateLocked
Dim ip, region, city, country, useragent, objXMLHTTP, xmlDoc

token=""
cmdTxt=""
timePassed=""
id=""
userid=""
name=""
email=""
message=""
locked=""
dateLocked=""
ip=""
region=""
city=""
country=""


'*******************************************************************************************************************
'* If the form was posted, process the form which is just to get the email address
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	checkToken
	email = getField("email,rXemail")
End if
'*******************************************************************************************************************
'* If the email was passed on the URL via a link from the email get the email address
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="get" Then
	email = getField("email,rXemail,get")
End if

'*******************************************************************************************************************
'* If we have the email address, delete the account. First get the record matching the email
'*******************************************************************************************************************
If email<>"" then
	If lg_database="access" Then
		cmdTxt = "SELECT [id], [userid], [email], [locked], [dateLocked], [token] FROM users WHERE ([email]=?);"
	Else
		cmdTxt = "SELECT id, userid, email, locked, dateLocked, token FROM users WHERE (email=?);"
	End If		
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	addParam "@email",adVarChar,adParamInput,CLng(100),email,lg_term_checkToken & " 3"
	getRS db_rs, cmdTxt, lg_term_checkToken & " 3"
	If NOT(db_rs.bof AND db_rs.eof) Then
		id = db_rs("id")
		userid = db_rs("userid")
		token = db_rs("token")
		locked = db_rs("locked")
		dateLocked = db_rs("dateLocked")
		closeRS
		CloseCommand
		if token<>"" Then
			'*******************************************************************************************************************
			'* If the account was already activated, the token will be empty and the account 
			'* will not be deleted. If the token is not empty, delete the record
			'*******************************************************************************************************************
			openCommand lg_term_command_string,"checkToken 4"
			If lg_database="access" Then
				cmdTxt = "DELETE FROM users WHERE ([id]=?);"
			Else
				cmdTxt = "DELETE FROM users WHERE (id=?);"
			End If		
			addParam "@id",adInteger,adParamInput,CLng(4),id,"checkToken 5"
			execCmd cmdTxt
			message = "<h2>"&lg_phrase_delete_deleted&"</h2>"
		Else
			'*******************************************************************************************************************
			'* If the account was activated, notify the user the account will not be deleted
			'*******************************************************************************************************************
			message = "<h2>"&lg_phrase_delete_already_verified&"</h2><br /><br />"
			message = message & "If you wish to cancel the account use the account<br />"
			message = message & "cancellation page at <a href="""&lg_cancel_account_page&""">"&lg_term_cancel_account&"</a>"
		End If
	Else
		message = lg_phrase_register_delete_noemail
	End IF
	closeCommand
Else
	message = lg_term_register_delete_enter_email
End If
%>