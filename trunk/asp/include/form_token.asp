<%
' $Id$
'*******************************************************************************************************************
'* Form Token
'* Version:  1.1
'* On Entry: none
'* Input:    CSRF token to verify
'* Output:   CSRF token writen as a hidden field
'* On Exit:  Nothing
'* 
'* Purpose: Write anti-CSRF one time use token to a form page
'*          Verify on POST the token exists and was not tampered with.
'*
'* NOTE: Person browsing the site who use the back button to return to a form will get an error
'*       because the token is no longer valid.  Similaryly a fouble post will return an error due
'*       to an invalid token.
'*       Persons who take too long (default 5 minutes) to complete a form will throw a form error.
'*       Persons who do not accept cookies will have an error.
'*
'* Requires include/hashSHA1.asp
'* Requires include/generalPurpose.asp
'*******************************************************************************************************************
 
function checkToken
	'*****************************************************************************************
	' Check the posted token for correctness
	'*****************************************************************************************
	Dim oldToken, testToken, tokenStr, page
        If lg_useSSL Then
  	    	page = Replace(Request.ServerVariables("HTTP_REFERER"),"https://"& lg_domain_secure,"")
        Else
	    	page = Replace(Request.ServerVariables("HTTP_REFERER"),"http://"& lg_domain,"")
        End If
        if page="" Then ' posted to self
		page = Request.ServerVariables("SCRIPT_NAME")
	end if
	oldToken=request.form("token")
	tokenStr = "IP:" & Session("ip") & ",SESSIONID:" & Session.SessionID & ",GUID:" &Session("guid")
	testToken=HashEncode(tokenStr&Session("salt"))&Session("salt")
	checkToken=false
	If oldToken=testToken Then
		If Request.Cookies("token")=oldToken Then 
			If DateDiff("s", Session("time"), Time)<=300 Then ' Five minutes max
	  			checkToken=true
	  			Session("token")=""
	  			Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
	  			generateToken
	  		Else
	  			'*****************************************************************************
	  			'* Too much time taken, token expired
	  			'*****************************************************************************
	  			Session("token")=""
	  			Session("userid")=""
	  			Session("name")=""
	  			Session("login")=false
	  			Response.Cookies("user") = ""
				Response.Cookies("user").Expires = "January 1, 2009"
				Response.Cookies("login") = ""
				Response.Cookies("login").Expires = "January 1, 2009"
				Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
	  			Session.Abandon
				Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etime"
			End If
		Else
			'*****************************************************************************
			'* Cokkie error or cookies not enabled
			'*****************************************************************************
			Session("token")=""
			Session("userid")=""
	  		Session("name")=""
	  		Session("login")=false
	  		Response.Cookies("user") = ""
			Response.Cookies("user").Expires = "January 1, 2009"
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "January 1, 2009"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "January 1, 2009"
			Session.Abandon
			Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=ecook"
		End If		
	Else
		'*****************************************************************************
		'* Bad token.
		'*****************************************************************************
		Session("token")=""
		Session("userid")=""
	  	Session("name")=""
	  	Session("login")=false
	  	Response.Cookies("user") = ""
		Response.Cookies("user").Expires = "January 1, 2009"
		Response.Cookies("login") = ""
		Response.Cookies("login").Expires = "January 1, 2009"
		Response.Cookies("token") = ""
		Response.Cookies("token").Expires = "January 1, 2009"
		Session.Abandon
		Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etok"  	
	End If
End Function

Function generateToken
	'*****************************************************************************************
	' Create and set a new token for CSRF protection
	'*****************************************************************************************
	Dim salt, tokenStr
	salt = getSalt(10)
	Session("salt")=salt
	Session("guid")=getGUID
	Session("ip") = Request.ServerVariables("REMOTE_ADDR")
	Session("time") = Time
	tokenStr = "IP:" & Session("ip") & ",SESSIONID:" & Session.SessionID & ",GUID:" &Session("guid")
	Session("token")=HashEncode(tokenStr&Session("salt"))&Session("salt")
	Response.Cookies("token") = Session("token")
End Function
	
function writeToken
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("token") & """ />")
End Function

function writeTokenH
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("token") & """>")
End Function
%>