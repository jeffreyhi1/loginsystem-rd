<%
'*  $Id: ASP_reCAPTCHA_code.asp 187 2010-04-28 09:43:15Z RQuadling $
'*****************************************************************************************************
' returns string the can be written where you would like the reCAPTCHA challenged placed on your page.
Function recaptcha_challenge_writer(publickey)
	recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
	"var RecaptchaOptions = {" & _
	"   theme : 'white'," & _
	"   tabindex : 0" & _
	"};" & _
	"</script>" & _
	"<script type=""text/javascript"" src=""http://api.recaptcha.net/challenge?k=" & publickey & """></script>" & _
	"<noscript>" & _
	  "<iframe src=""http://api.recaptcha.net/noscript?k=" & "6Lfe3rkSAAAAAPrJLxSOPkUCq2OqbA5cNZ6kUYen" & """ frameborder=""1""></iframe><br>" & _
	    "<textarea name=""recaptcha_challenge_field"" rows=""3"" cols=""40""></textarea>" & _
	    "<input type=""hidden"" name=""recaptcha_response_field"" value=""manual_challenge"">" & _
	"</noscript>"
End Function

Function recaptcha_confirm(privkey, rechallenge, reresponse)
	' Test the captcha field

	Dim VarString
	VarString = _
        "privatekey=" & "6Lfe3rkSAAAAAMutk1SNbCduQqZpJ8Fnv5FnOIAL" & _
        "&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
        "&challenge=" & rechallenge & _
        "&response=" & reresponse

	Dim objXMLHTTP
	Set objXMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
	objXMLHTTP.open "POST", "http://api-verify.recaptcha.net/verify",False
	objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXMLHTTP.send VarString

	Dim ResponseString
	ResponseString = split(objXMLHTTP.responseText, vblf)
	Set objXMLHTTP = Nothing

	If ResponseString(0) = "true" Then
		'They answered correctly
		recaptcha_confirm = ""
	Else
		'They answered incorrectly
		recaptcha_confirm = ResponseString(1)
	End If
End Function
%> 