<%
'*******************************************************************************************************************
'* Form Token
'* Last Modification: 19 FEB 2010 rdivilbiss
'* Version:  1.0
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
	  		Else
	  			Session.Abandon
	  			'*****************************************************************************
	  			'* Too much time taken, token expired
	  			'*****************************************************************************
				Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etime"
			End If
		Else
			'*****************************************************************************
			'* Cokkie error or cookies not enabled
			'*****************************************************************************
			Session.Abandon
			Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=ecook"
		End If		
	Else
		'*****************************************************************************
		'* Bad token.
		'*****************************************************************************
		Session.Abandon
		Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etok"  	
	End If
End Function
	
function writeToken
	'*****************************************************************************************
	' Create and set a new XHTML token for CSRF protection
	' on initial entry or after form errors and we are going to redisplay the form.
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
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("token") & """ />")
End Function

function writeTokenH
	'*****************************************************************************************
	' Create and set a new HTML token for CSRF protection
	' on initial entry or after form errors and we are going to redisplay the form.
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
	Response.Write("<input id=""token"" name=""token"" type=""hidden"" accesskey=""u"" tabindex=""999"" value=""" & Session("token") & """>")
End Function
%>