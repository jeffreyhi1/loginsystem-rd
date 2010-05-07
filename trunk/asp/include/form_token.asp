<%
'* alpha 0.2
'* $Id$
'*******************************************************************************************************************
'* Form Token
'* Version:  1.1
'* On Entry: none
'* Input:    CSRF token to verify
'* Output:   CSRF token writen as a hidden field
'* On Exit:  Nothing
'* 
'* Purpose: Write anti-CSRF one time use token to a form ft_page
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
	Dim ft_oldToken, ft_testToken, ft_tokenStr, ft_page
        If lg_useSSL Then
  	    	ft_page = Replace(Request.ServerVariables("HTTP_REFERER"),"https://"& lg_domain_secure,"")
        Else
	    	ft_page = Replace(Request.ServerVariables("HTTP_REFERER"),"http://"& lg_domain,"")
        End If
        If lg_debug Then dbMsg = dbMsg & "IN checkToken :: calculated ft_page = "& ft_page &"<br />" & vbLF End If
        if ft_page="" Then ' posted to self
		ft_page = Request.ServerVariables("SCRIPT_NAME")
		If lg_debug Then dbMsg = dbMsg & "IN checkToken :: ft_page from SCRIPT_NAME = "& ft_page &"<br />" & vbLF End If
	end if
	ft_oldToken=Request.Form("token")
	If lg_debug Then dbMsg = dbMsg & "IN checkToken :: ft_oldToken = "& ft_oldToken &"<br />" & vbLF End If
	ft_tokenStr = "IP:" & Session("ft_ip") & ",SESSIONID:" & Session.SessionID & ",GUID:" &Session("ft_guid")
	If lg_debug Then dbMsg = dbMsg & "IN checkToken :: ft_tokenStr = "& ft_tokenStr &"<br />" & vbLF End If
	ft_testToken=HashEncode(ft_tokenStr&Session("ft_salt"))&Session("ft_salt")
	If lg_debug Then dbMsg = dbMsg & "IN checkToken :: ft_testToken = "& ft_testToken &"<br />" & vbLF End If
	checkToken=false
	If ft_oldToken=ft_testToken Then
		If lg_debug Then dbMsg = dbMsg & "IN checkToken :: ft_testToken = ft_oldToken<br />" & vbLF End If
		If Request.Cookies("token")=ft_oldToken Then
			If lg_debug Then dbMsg = dbMsg & "IN checkToken :: cookies(token) = ft_oldToken<br />" & vbLF End If
			If DateDiff("s", Session("ft_time"), Time)<=300 Then ' Five minutes max
				If lg_debug Then dbMsg = dbMsg & "IN checkToken :: Time &lt; 300 Seconds - Good Time<br />" & vbLF End If
	  			checkToken=true
	  			Session("ft_salt")=""
	  			Session("ft_ip")=""
	  			Session("ft_token")=""
	  			Session("ft_time")=""
	  			Session("ft_guid")=""
	  			Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
	  			generateToken
	  		Else
	  			'*****************************************************************************
	  			'* Too much time taken, token expired
	  			'*****************************************************************************
	  			If lg_debug Then dbMsg = dbMsg & "IN checkToken :: Bad Time, more than 300 seconds.<br />" & vbLF End If
	  			Session("ft_token")=""
	  			Response.Cookies("user") = ""
				Response.Cookies("user").Expires = "January 1, 2009"
				Response.Cookies("login") = ""
				Response.Cookies("login").Expires = "January 1, 2009"
				Response.Cookies("token") = ""
				Response.Cookies("token").Expires = "January 1, 2009"
	  			Session.Abandon
				Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&ft_page&"&t=etime"
			End If
		Else
			'*****************************************************************************
			'* Cokkie error or cookies not enabled
			'*****************************************************************************
			If lg_debug Then dbMsg = dbMsg & "IN checkToken :: Cookie Error<br />" & vbLF End If
			Session("ft_token")=""
	  		Response.Cookies("user") = ""
			Response.Cookies("user").Expires = "January 1, 2009"
			Response.Cookies("login") = ""
			Response.Cookies("login").Expires = "January 1, 2009"
			Response.Cookies("token") = ""
			Response.Cookies("token").Expires = "January 1, 2009"
			Session.Abandon
			Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&ft_page&"&t=ecook"
		End If		
	Else
		'*****************************************************************************
		'* Bad token.
		'*****************************************************************************
		If lg_debug Then dbMsg = dbMsg & "IN checkToken :: Bad Token<br />" & vbLF End If
		Session("ft_token")=""
	  	Response.Cookies("user") = ""
		Response.Cookies("user").Expires = "January 1, 2009"
		Response.Cookies("login") = ""
		Response.Cookies("login").Expires = "January 1, 2009"
		Response.Cookies("token") = ""
		Response.Cookies("token").Expires = "January 1, 2009"
		Session.Abandon
		Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&ft_page&"&t=etok"  	
	End If
End Function

Function generateToken
	'*****************************************************************************************
	' Create and set a new token for CSRF protection
	'*****************************************************************************************
	If lg_debug Then dbMsg = dbMsg & "IN generateToken<br />" & vbLF End If
	Dim ft_salt, ft_tokenStr
	ft_salt = getsalt(10)
	Session("ft_salt")=ft_salt
	Session("ft_guid")=getGUID
	Session("ft_ip") = Request.ServerVariables("REMOTE_ADDR")
	Session("ft_time") = Time
	ft_tokenStr = "IP:" & Session("ft_ip") & ",SESSIONID:" & Session.SessionID & ",GUID:" &Session("ft_guid")
	Session("ft_token")=HashEncode(ft_tokenStr&Session("ft_salt"))&Session("ft_salt")
	Response.Cookies("token") = Session("ft_token")
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: ft_salt = "& ft_salt &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Session(ft_salt) = "& Session("ft_salt") &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Session(ft_guid) = "& Session("ft_guid") &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Session(ft_ip) = "& Session("ft_ip") &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Session(ft_time) = "& Session("ft_time") &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: ft_tokenStr = "& ft_tokenStr &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Session("ft_token") = "& Session("ft_token") &"<br />" & vbLF End If
	If lg_debug Then dbMsg = dbMsg & "IN generateToken :: Response.Cookies(token) = "& Session("ft_token") &"<br />" & vbLF End If
End Function
	
function writeToken
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("ft_token") & """ />")
End Function

function writeTokenH
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("ft_token") & """>")
End Function

If Request.ServerVariables("HTTP_METHOD")="GET" Then
	generateToken
End If
%>