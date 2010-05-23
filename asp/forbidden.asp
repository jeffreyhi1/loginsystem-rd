<%
'* alpha 0.5a debug
'* $Id$
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%=lg_term_xhtml_xmlns%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=lg_term_content_language%>
<%=lg_term_language%>
<title><%=lg_term_forbidden%></title>
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="&copy; 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>
<body>
<%=lg_phrase_forbidden_body & " " & lg_webmaster_email_link & "</p>" %>
</body>
</html>