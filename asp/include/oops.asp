<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
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