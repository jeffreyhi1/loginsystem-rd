<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
'* alpha 0.2
'* $Id$
%>
<!--#include file="include/loginGlobals.asp"-->
<!--#include file="include/hashSHA1.asp"-->
<!--#include file="include/form_token.asp"-->
<!--#include file="include/generalPurpose.asp"-->
<!--#include file="include/paramSQL.asp"-->
<!--#include file="include/CDOMailInclude.asp"-->
<!--#include file="include/register.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%=lg_term_xhtml_xmlns%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=lg_term_content_language%>
<%=lg_term_language%>
<title><%=lg_term_register%></title>
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="&copy; 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>

</head>
<body>
<!--#include file="include/register-markup.asp"-->
<% If lg_debug Then Response.Write dbMsg End If %>
</body>
</html>