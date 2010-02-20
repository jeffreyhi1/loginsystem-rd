<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'*******************************************************************************************************************
'* Logout
'* Last Modification: 19 FEB 2010
'* Version:  beta 1.2
'* On Entry: N/A
'* Input:    Session
'* Output:   N/A
'* On Exit:  Session Abandoned - Cookies Overwritten - Redirected to Logged Out
'******************************************************************************************************************
%>
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
Response.Cookies("user") = ""
Response.Cookies("user").Expires = "January 1, 2009"

Session.Abandon
Response.Redirect lg_logged_out_page
%>
