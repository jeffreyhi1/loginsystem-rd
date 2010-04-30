<%
'*  $Id:$
'*****************************************************************************************************
Dim reChallengeField, reResponseField, publickey, privkey
publickey = "6Lce3bkSAAAAAHHyw_BOFsIgrHh9TcPrQMQ1oLYU"
privkey = "6Lce3bkSAAAAADh2-3h0SS30KP5E8gHXBN0yV13j"

'*****************************************************************************************************
'* returns string the can be written where you would like the reCAPTCHA challenged placed on your page
'*****************************************************************************************************
Function recaptcha_challenge_writer()
recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
	"var RecaptchaOptions = {" & _
	"   theme : 'white'," & _
	"   tabindex : 0" & _
	"};" & _
	"</script>" & _
	"<script type=""text/javascript"" src=""http://api.recaptcha.net/challenge?k=" & publickey & """></script>" & _
	"<noscript>" & _
	  "<iframe src=""http://api.recaptcha.net/noscript?k=" & publickey & """ frameborder=""1""></iframe><br>" & _
	    "<textarea name=""recaptcha_challenge_field"" rows=""3"" cols=""40""></textarea>" & _
	    "<input type=""hidden"" name=""recaptcha_response_field"" value=""manual_challenge"">" & _
	"</noscript>"
End Function

'*****************************************************************************************************
'* Verifies the CAPTCHA for correctness
'*****************************************************************************************************
Function recaptcha_confirm(rechallenge,reresponse)
	' Test the captcha field

	Dim VarString
	VarString = _
        "privatekey=" & privkey & _
        "&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
        "&challenge=" & rechallenge & _
        "&response=" & reresponse

	Dim objXmlHttp
	Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
	objXmlHttp.open "POST", "http://api-verify.recaptcha.net/verify", False
	objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXmlHttp.send VarString

	Dim ResponseString
	ResponseString = split(objXmlHttp.responseText, vblf)
	Set objXmlHttp = Nothing

	If ResponseString(0) = "true" Then
		'They answered correctly
		recaptcha_confirm = ""
	Else
		'They answered incorrectly
		recaptcha_confirm = ResponseString(1) & vbLF
	End If
End Function
%> 