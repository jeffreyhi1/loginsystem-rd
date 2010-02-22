<%
' Requires include/hashSHA1.asp
' Requires include/generalPurpose.asp
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
				Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etime"
			End If
		Else
			Session.Abandon
			Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=ecook"
		End If		
	Else
		Session.Abandon
		Response.Redirect "http://"& lg_domain & lg_form_error & "?p="&page&"&t=etok"  	
	End If
End Function
	
function writeToken
	'*****************************************************************************************
	' Create and set a new token for CSRF protection
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
	' Create and set a new token for CSRF protection
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

