<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'* alpha 0.1c
'* $Id$
%>
<!--#include file="include/generalPurpose.asp"-->
<!--#include file="include/loginGlobals.asp"-->
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Form Error</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="content-language" content="en-US" />
<meta name="language" content="en-US" />
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="&copy; 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>

</head>
<body>
<!--#include file="include/form-error-markup.asp"-->
</body>
</html>