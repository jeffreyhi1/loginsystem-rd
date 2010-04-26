<%
'*******************************************************************************************************************
'* Form Error
'* Last Modification: 26 APR 2010 rdivilbiss
'* Version:  alpha 0.1b
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
%>
<!--#include virtual="/login-project/aspdemo/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/aspdemo/include/loginGlobals.asp"-->
<%
Dim page, reason, message
page = getField("p,rXsafepq,get")
reason = getField("t,rXalpha,get")

Select Case reason
    Case "etime"
        message = "The form timed out before completion. Please complete the form in less than 5 minutes."
    Case "ecook"
    	message = "Cookies are required for login. Please ensure your browser accepts cookies from this site."
    Case "etok"
        message = "There was a form error. This can be caused by using your browser's back button to return to a previously completed form and re-submitting it."
End Select
%>