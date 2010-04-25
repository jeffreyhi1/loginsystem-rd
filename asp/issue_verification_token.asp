<!--METADATA TYPE="typelib" uuid="00000205-0000-0010-8000-00AA006D2EA4" -->
<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--file="include/loginGlobals.asp"-->
<!--file="include/hashSHA1.asp"-->
<!--file="include/form_token.asp"-->
<!--file="include/generalPurpose.asp"-->
<!--file="include/paramSQL.asp"-->
<!--file="include/CDOMailInclude.asp"-->
<!--file="include/issue-verification-token.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><%=lg_term_issue_verification_token%></title>
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
<!--file="include/issue-verification-token-markup.asp"-->
</body>
</html>