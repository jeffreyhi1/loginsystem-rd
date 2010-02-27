<%
'*******************************************************************************************************************
'* Logout
'* Last Modification: 19 FEB 2010
'* Version:  beta 1.2
'* On Entry: N/A
'* Input:    Session
'* Output:   N/A
'* On Exit:  Session Abandoned - Cookies Overwritten - Redirected to Logged Out
'******************************************************************************************************************

Response.Cookies("user") = ""
Response.Cookies("user").Expires = "January 1, 2009"

Session.Abandon
Response.Redirect lg_logged_out_page
%>