<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<!--#include virtual="/login-project/asp/include/hashSHA1.asp"-->
<!--#include virtual="/login-project/asp/include/form_token.asp"-->
<!--#include virtual="/login-project/asp/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/asp/include/paramSQL.asp"-->
<!--#include virtual="/login-project/asp/include/CDOMailInclude.asp"-->
<%
'*******************************************************************************************************************
'* Cancel Account
'* Last Modification: 19 FEB 2010 rdivilbiss
'* Version:  beta 1.2
'* On Entry: Verify need for SSL
'* Input:    userid, password
'* Output:   message - string variable with results
'* On Exit:  Account Deleted.
'******************************************************************************************************************

'*******************************************************************************************************************
'* If SSL required and not using SSL, redirect to https
'*******************************************************************************************************************
If lg_useSSL and NOT Request.ServerVariables("SERVER_PORT_SECURE")="1" Then
	Response.Redirect("https://" & lg_domain_secure & lg_loginPath & lg_filename)
End If


'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim message, userid, password, passhash, dbPasshash, dbId, dateCancelled, cmdTxt

userid = ""
password = ""
message = lg_term_enter_information
passhash = ""
dbPasshash = ""
dbId = ""
dateCancelled = now
cmdTxt = ""

'*******************************************************************************************************************
'* If the form was posted, process the form
'*******************************************************************************************************************
If LCase(Request.ServerVariables("HTTP_METHOD"))="post" Then
	checkToken
	message=""
	userid = Left(getField("userid,rXsafepq"),32)
	password = Left(getField("password,rXsafepq"),255)
	If userid & ""="" Then
		message = message & lg_phrase_userid_empty
	End If
	If password & ""="" Then
		message = message & lg_phrase_password_empty
	End If
	If message="" Then
	    '*******************************************************************************************************************
		'* If all required fields exist, begin process of deleting the account
		'*******************************************************************************************************************
		passhash = HashEncode(password & userid)
		'*******************************************************************************************************************
		'* First, is this a valid userid and password?
		'*******************************************************************************************************************
		cmdTxt = "SELECT id, password FROM users WHERE (userid=?);"
		openCommand lg_term_command_string,lg_term_cancel_account&" 1"

		addParam "@u",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 2"
		getRS db_rs, cmdTxt, lg_term_get_name&" 3"
		If Not(db_rs.bof AND db_rs.eof) Then
			dbPasshash = db_rs("password")
			dbId = db_rs("id")
			closeRS
			closeCommand
			If passhash = dbPasshash Then
				' valid used id and password, do cancel.
				cmdTxt = "UPDATE users SET [deleted]=1, [dateDeleted]=? WHERE (userid=?) AND (password=?);"
				openCommand lg_term_command_string,lg_term_cancel_account&" 3"
				addParam "@dDeleted",adDate,adParamInput,CLng(8),dateCancelled,lg_term_cancel_account&" 4"
				addParam "@userid",adVarChar,adParamInput,CLng(Len(userid)),userid,lg_term_cancel_account&" 5"
				addParam "@passhash",adVarChar,adParamInput,CLng(Len(passhash)),passhash,lg_term_cancel_account&" 6"
				execCmd cmdTxt
				If numAffected = 1 Then
					message = lg_phrase_cancel_account_cacelled
				Else
					message = lg_phrase_cancel_account_error
				End If
				closeCommand
			Else
				'ERROR: Invalid password
				message = lg_phrase_login_error
			End If	
		Else
			' ERROR: Invalid userid
			message = lg_phrase_login_error
		End If	
	End if ' if message="", no else needed...message already set.
End If ' if POST
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_cancel_account%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2005-2010 Roderick Divilbiss">
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>
<div id="login-system">
<h1><%=lg_term_cancel_account%></h1>
<% If message <> lg_phrase_cancel_account_cacelled Then %>
<div id="message"><%=message%></div>
<form id="frm" name="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
<fieldset>
  <legend><%=lg_term_cancel_account%></legend>
  <div id="warning"><%=lg_phrase_cancel_account_warning%></div>
  <label for="userid"><%=lg_term_userid %></label><br><input id="userid" name="userid" title="lg_phrase_userid_title" type="text" size="20" maxlength="32"><span class="field_normal"><%=lg_term_required%></span><br>
  <label for="password"><%=lg_term_password %></label><br><input id="password" name="password" title="lg_phrase_password_title" type="password" size="20" maxlength="255"><span class="field_normal"><%=lg_term_required%></span><br>
  <input type="submit" value="<%=lg_term_cancel%>"><% writeToken %>
</fieldset>
<p><a title="<%=lg_term_recover_password%>" href="<%=lg_recover_passsword_page%>"><%=lg_term_recover_password%></a></p>
</form>
<% Else %>
<div id="message"><%=message%></div>
<% End If %>
</div>
</body>

</html>
