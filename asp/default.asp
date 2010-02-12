<%
Option Explicit
Session.CodePage=65001
Response.Charset="UTF-8"
Dim articleName
articleName = "ASP SIDE: Login Project Home Page"
%>
<!--#include virtual="/login-project/asp/include/generalPurpose.asp"-->
<!--#include virtual="/login-project/asp/include/paramSQL.asp"-->
<!--#include virtual="/login-project/asp/include/CDOMailInclude.asp"-->
<!--#include virtual="/login-project/asp/include/loginGlobals.asp"-->
<%
' no browser caching of this page !! to be used on all pages
Response.Expires=-1
Response.ExpiresAbsolute = Now() - 1

' do not allow proxy servers to cache this page !! to be used on all pages
Response.CacheControl="private"
Response.CacheControl="no-cache"
Response.CacheControl="no-store"

Dim iaReadtime,iaRemoteIP,iaUserAgent,iaLanguage,iaConnection,iaCookie,iaHtmlBody
Dim objXMLHTTP, xmldoc, iaCountry, iaRegion, iaCity, iaPage, iaReferer, iaQuerystring
iaPage = Request.ServerVariables("SCRIPT_NAME")
iaReadtime = now
iaRemoteIP = Request.ServerVariables("REMOTE_ADDR")
iaUserAgent = Server.HTMLEncode(Request.ServerVariables("HTTP_USER_AGENT"))
iaLanguage = Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")
iaConnection = Request.ServerVariables("HTTP_CONNECTION")
iaCookie = Request.ServerVariables("HTTP_COOKIE")
iaReferer = Server.HTMLEncode(Request.ServerVariables("HTTP_REFERER"))
iaQuerystring = Server.HTMLEncode(Request.QueryString)
Set objXMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
objXMLHTTP.Open "GET", "http://ipinfodb.com/ip_query.php?ip="&iaRemoteIP, False
objXMLHTTP.Send
Set xmldoc = objXMLHTTP.responseXML
on error resume next
iaCountry = xmlDoc.documentElement.selectSingleNode("CountryName").text
iaRegion = xmlDoc.documentElement.selectSingleNode("RegionName").text
iaCity = xmlDoc.documentElement.selectSingleNode("City").text
set objXMLHTTP=nothing
on error goto 0

iaHtmlBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
iaHtmlBody = iaHtmlBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
iaHtmlBody = iaHtmlBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>"&articleName&" page was read at "&iaReadtime&"<br><br>"
iaHtmlBody = iaHtmlBody & "IP Address: <a href=""http://www.rodsdot.com/include/iploc.asp?ip="&iaRemoteIP&""">"& iaRemoteIP & "</a><br>"
iaHtmlBody = iaHtmlBody & "City: "& iaCity & "<br>"
iaHtmlBody = iaHtmlBody & "Region: "& iaRegion & "<br>"
iaHtmlBody = iaHtmlBody & "Country: "& iaCountry & "<br>"
iaHtmlBody = iaHtmlBody & "User Agent: "& iaUserAgent & "<br>"
iaHtmlBody = iaHtmlBody & "Language: "& iaLanguage & "<br>"
iaHtmlBody = iaHtmlBody & "Connection Type: "& iaConnection & "<br>"
iaHtmlBody = iaHtmlBody & "Cookie: "& iaCookie & "<br>"
iaHtmlBody = iaHtmlBody & "</FONT></DIV>"
iaHtmlBody = iaHtmlBody & "</div></BODY></HTML>"
sendmail "Article Read <webmaster@webloginproject.com>", "rod@rodsdot.com", articleName & " Accessed", iaHtmlBody
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">

<head>
<title><%=articleName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="en">
<meta name="language" content="en-US">
<meta name="author" content="Roderick Divilbiss">
<meta name="copyright" content="© 2010 EE Collaborative Login System">
<meta name=robots content="noindex, nofollow">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
</head>
<body>
<h1>ASP - MS Access Version Home Page</h1>
<p><a href="http://www.webloginproject.com/login-project/asp/testDestination.asp" title="A Protected Page Example">A Protected Page Example</a><br>
If you start at this link, you should be taken first to login.asp, from where you should follow the register link. After registration, you should get a confirmation message followed by a xxx link.  Follow the link and you should be taken to register_verify.asp.  Wait for your confirmation email.  Follow the verification link or cut and paste your token into register_verify.asp.  You should then be redirected to this original protected page example:BUT, you are not logged in, so you will go back to the login page.  Login and you should end up at this example protected page.  If the destination is not maintained through the entire process it is an error and should be reported in the issue tracker.  If it works, please let me know.  Moving the ASP starter pages to three different websites has helped me find a lot of hard coded stuff that should have pulled from the globals file.</p>
<p><a href="http://www.webloginproject.com/login-project/asp/login.asp" title="Login if you are registered">Login Page</a><br>Issues: does remember me work? Close your browser and come back to the example protected page. You should still be logged in, unless you are blocking cookies.</p>
<p><a href="http://www.webloginproject.com/login-project/asp/logout.asp" title="Log out page">Logout</a><br>Should kill session and cookies.</p>
<p><a href="http://www.webloginproject.com/login-project/asp/change_password.asp" title="Change password">Change Password</a></p>
<p><a href="http://www.webloginproject.com/login-project/asp/issue_verification_token.asp" title="Get a new registration email verification token">Get New EMail Verification Token</a></p>
<p><a href="http://www.webloginproject.com/login-project/asp/cancel_account.asp" title="cancel account">Cancel Your Account</a></p>
<p><a href="http://www.webloginproject.com/login-project/asp/register.asp" title="Register">Register</a></p>
<p><a href="http://www.webloginproject.com/login-project/asp/recover_password.asp" title="pending">Recover Password</a> added 11 FEB 2010</p>
<p><a href="http://www.webloginproject.com/login-project/asp/registration-succes.jpg" title="pending">Registration Success EMail</a></p>
</body>
</html>