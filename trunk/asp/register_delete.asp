<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Register Delete
'* Last Modification: 26 JAN 2010
'* Version:  beta 1.1
'* On Entry: N/A
'* Input:    email
'* Output:   message - string variable with results
'* On Exit:  Account Deleted.
'******************************************************************************************************************
%>
<!--#include virtual="/login-project/asp/include/hashSHA1.asp"-->
<!--#include virtual="/login-project/asp/include/form_token.asp"-->
<!--#include virtual="/login-project/asp/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/asp/include/paramSQL.asp"-->
<!--#include virtual="/login-project/asp/include/CDOMailInclude.asp"-->
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
'*******************************************************************************************************************
'* Diminsion all page variables and initialize default values
'*******************************************************************************************************************
Dim token, cmdTxt, timePassed, id, userid, email, message, locked, dateLocked, ip, region, city, country, useragent, objXMLHTTP, xmlDoc

token=""
cmdTxt=""
timePassed=""
id=""
userid=""
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
	cmdTxt = "SELECT [id], userid, email, locked, dateLocked, token FROM users WHERE (email=?);"
	openCommand lg_term_command_string,lg_term_checkToken & " 1"
	addParam "@email",adVarChar,adParamInput,CLng(40),email,lg_term_checkToken & " 3"
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
			'* If the account was already activated it will not be deleted, if still locked it will be deleted
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
			'* If the account was not activated, delete the record from the user's table
			'*******************************************************************************************************************
			openCommand lg_term_command_string,"checkToken 4"
			cmdTxt = "DELETE * FROM users WHERE (users.id=?);"
			addParam "@id",adInteger,adParamInput,CLng(8),id,"checkToken 5"
			execCmd cmdTxt
			message = "<h2>"&lg_phrase_delete_deleted&"</h2>"
		Else
			'*******************************************************************************************************************
			'* If the account was activated, notify the user the account will not be deleted
			'*******************************************************************************************************************
			message = "<h2>"&lg_phrase_delete_already_verified&"</h2><br><br>"
			message = message & "If you wish to cancel the account use the account<br>"
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=lg_term_delete_account%></title>
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
<h1><%=lg_phrase_delete_account%></h1>
<% If message = lg_term_register_delete_enter_email Then %>
<div id="message"><%=message%></div>
<div id="formDiv">
<form name="frm" method="post" action="<%=lg_filename%>">
<fieldset>
  <legend><%=lg_phrase_delete_account%></legend>
  <p><lable for="email"><%=lg_term_email%></lable><br><input type="text" id="email" name="email" size="50" maxsize="100"><br>
  <input type="submit" value="<%=lg_term_submit%>"><%=writeToken%></p>
</fieldset>  
</form>
<% Else %>
<div id="message"><%=message%></div>
<% End If %>
</div>

</body>
</html>