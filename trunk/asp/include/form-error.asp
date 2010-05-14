<%
'* alpha 0.3
'* $Id$
'*******************************************************************************************************************
'* Form Error
'* On Entry: URL parameters
'* Input:    p (page) and t (reason for error)
'* Output:   message - reason for error and link to page
'* On Exit:  None
'******************************************************************************************************************
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"

' no browser caching of this page !! to be used on all pages
Response.Expires=-1
Response.ExpiresAbsolute = Now() - 1

' do not allow proxy servers to cache this page !! to be used on all pages
Response.AddHeader "pragma","no-cache"
Response.CacheControl="private"
Response.CacheControl="no-cache"
Response.CacheControl="no-store"


Dim page, reason, message
page = getField("p,rXsafepq,get")
reason = getField("t,rXalpha,get")

Select Case reason
    Case "etime"
        message = lg_phrase_form_error_time
    Case "ecook"
    	message = lg_phrase_form_error_cookie
    Case "etok"
        message = lg_phrase_form_error_token
End Select
%>