<%
' $Id$
'*******************************************************************************************************************
'* Page Name: Logout
'* Version:  alpha 0.1c debug
'* On Entry: N/A
'* Input:    Session
'* Output:   N/A
'* On Exit:  Session Abandoned - Cookies Overwritten - Redirected to Logged Out
'******************************************************************************************************************
' no browser caching of this page !! to be used on all pages
Response.Expires=-1
Response.ExpiresAbsolute = Now() - 1

' do not allow proxy servers to cache this page !! to be used on all pages
Response.AddHeader "pragma","no-cache"
Response.CacheControl="private"
Response.CacheControl="no-cache"
Response.CacheControl="no-store"

Response.Cookies("token") = ""
Response.Cookies("token").Expires = "January 1, 2009"

Response.Cookies("user") = ""
Response.Cookies("user").Expires = "January 1, 2009"

Session("userid")=""
Session("name")=""
Session("token")=""
Session("login")=false
Session.Abandon
Response.Redirect lg_logged_out_page
%>