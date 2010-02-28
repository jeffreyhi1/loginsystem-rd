<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
%>
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
If NOT Session("login") Then
    Response.Redirect "http://" & lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME")
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>A Protected Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="language" content="en-US" />
<meta name="author" content="Roderick Divilbiss" />
<meta name="copyright" content="© 2010 EE Collaborative Login Project http://www.webloginproject.com" />
<style type="text/css">
#details { font-family:Courier New; font-size:10pt; border:1px solid #000000; padding:10px; background-color:#FFE2C6; }
#message { font-size:10pt; padding:10px; background-color:#FFFFCC; border:1px solid #000000; }
#warning { font-size:10pt; font-weight:bold; padding:10px; background-color:#FFFFCC; color:#FF0000; border:1px solid #FF0000; }
</style>
</head>

<body>

<h1>Protected Page</h1>
<h2>Welcome <%=Session("name")%>!</h2>
<p>You have successfully registered, verified your registration, and logged in, if you can see this page.</p>
<p>Page Protection Code:</p>
<p><code>&lt;%<br>
			Option Explicit<br>
			Session.CodePage=65001<br>
			Response.Charset=&quot;UTF-8&quot;<br>
			%&gt;<br>
			&lt;!--#include virtual=&quot;/login-system/asp/include/loginGlobals.asp&quot;--&gt;<br>
			&lt;%<br>
			If NOT Session(&quot;login&quot;) Then<br>
&nbsp;&nbsp;&nbsp; Response.Redirect &quot;http://&quot; &amp; lg_domain &amp; lg_loginPath &amp; lg_loginPage &amp;_<br>
&nbsp;&nbsp;&nbsp; &quot;?p=&quot; &amp; Request.ServerVariables(&quot;SCRIPT_NAME&quot;)<br>
			End If<br>
			<br>
			' Your page code here<br>
			%&gt;</code></p>
<p>&copy; 2010 EE Collaborative Login Project</p>
<p>Demo Sites:<br>
<a title="ASP, MS SQL Server 2005, XHTML 1.1 Strict" href="https://www.webloginproject.com/login-project/aspdemo/">ASP, MS SQL Server 2005, XHTML 1.1 Strict</a><br>
<a title="ASP, MS Access, XHTML 1.1 Transitional" href="https://www.webloginproject.com/login-project/aspmsa/">ASP, MS Access, XHTML 1.1 Transitional</a><br>
<a title="ASP, MySql, HTML 4.01 Strict" href="https://www.webloginproject.com/login-project/aspmysql/">ASP, MySql, HTML 4.01 Strict</a></p>
<p>Project Home</p>
</body>
</html>
