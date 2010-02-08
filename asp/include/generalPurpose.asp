<%
'****************************************************************
'* generalPurpose.asp           �2005 - 2009 Roderick Divilbiss *
'*                                       http://www.rodsdot.com *
'****************************************************************
'* TERMS OF USE                                                 *
'*--------------------------------------------------------------*
'* Except where otherwise noted, this source code and markup is *
'* licensed under a Creative Commons License Creative Commons   *
'* License.  http://creativecommons.org/licenses/by-nc/2.0/     *
'*                                                              *
'* Complete Terms of Use my be found at:                        *
'* http://www.rodsdot.com/termsofuse.asp                        *
'*                                                              *
'* No part of this application code may be used for commercial  *
'* purposes without prior written permission from the author,   *
'* Roderick W. Divilbiss of Overland Park, Kansas, United States*
'* of America.                                                  *
'*                                                              *
'* Non-commercial use of this application code requires this    *
'* notice be kept intact.                                       *
'*                                                              *
'* � 2000-2009, Roderick W. Divilbiss, All Rights Reserved      *
'* Used by permission.                                          *
'* Original source code may be found at www.rodsdot.com.        *
'*                                                              *
'* The following notice and hyperlink must be included on one   *
'* page on the web site accessible to the public and linked     *
'* directly to the website's home page.                         *
'*                                                              *
'* This site contains code used by permission of Rod Divilbiss, *
'* http://www.rodsdot.com.                                      *
'* **************************************************************
Const rXaccounting = "^([1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?)$"
Const rXaddress = "^[a-zA-Z0-9\#\s\.\-;:,]{1,}$"
Const rXalpha = "^[a-zA-Z]+$"
Const rXalphanumeric = "^[a-zA-Z0-9]+$"
Const rXalphaSpace = "^[a-zA-Z ]+$"
Const rXbinary = "^[0-1]+$"
Const rXcreditcard = "^((4\d{3}|5[1-5]\d{2}|6011)[ -]*(\d{4}[ -]*\d{4}[ -]*\d{4}))|((34\d{2}|37\d{2})[ -]*(\d{6}[ -]*\d{5}))$"
Const rXcurrency = "^(\$*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?)|(\({1}\$*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?\))$"
Const rXdate = "^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$"
Const rXdecimal = "^([1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{1,16})?)$"
Const rXemail = "^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
Const rXhex = "^[0-9A-F]+[0-9AF]*$"
Const rXimgpath = "^[a-zA-Z0-9\/\%\_]+\.(gif|jpg|gif|png)$"
Const rXint = "^([-]*[1-9]+[0-9]*)|([0])$"
Const rXip = "^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$"
Const rXmmddyyyy = "^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$"
Const rXmmyyyyy = "(([0]*[1-9]{1})|([1]{1}[0-2]{1}))(\/{1})((19[0-9]{2})|([2-9]{1}[0-9]{3}))$"
Const rXmoney = "^(\${1}[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{2})?)$"
Const rXname = "^[a-zA-Z \.\-\']+$"
Const rXnumber = "^([-+]*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]*[1-9]+)?)|([-+]*[1-9]+[0-9]*(\.[0-9]*[1-9]+)?)$"
Const rXnumberpositive = "^([+]*[1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]*[1-9]+)?)$"
Const rXnumeric = "^[0-9]+$"
Const rXpassword8to16an = "^(?=[a-zA-Z]*\d)(?=[0-9A-Z]*[a-z])(?=[0-9a-z]*[A-Z])(?!.*\s).{8,16}$"
Const rXpassword8to16ans = "^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*[\s'<>]).{8,16}$"
Const rXpassword8to32an = "^(?=[a-zA-Z]*\d)(?=[0-9A-Z]*[a-z])(?=[0-9a-z]*[A-Z])(?!.*\s).{8,32}$"
Const rXpassword8to32ans = "^(?=.*\d|\S)(?=.*[a-z])(?=.*[A-Z]).{8,32}$"
Const rXphoneany7 = "^\d{3}.*\d{4}$"
Const rXphoneeu10 = "^\d{3}\.*\d{3}\.*\d{4}$"
Const rXphoneeu7 = "^\d{3}\.*\d{4}$"
Const rXphoneus10 = "^(\(*\d{3}\)*\s*\-*\d{3}\s*\-*\d{4}\s*)|(\d{3}\.*\d{3}\.*\d{4}\s*)$"
Const rXsafe = "^[a-zA-Z0-9 -\.\,\;\:\/\?\&\=\_]+$"
Const rXsafepq = "^[a-zA-Z0-9 -\.\,\~\!\@\#\%\^\&\*\(\);\:\/\?\&\=\_]+$"
Const rXssn = "^(?!000)(?!666)([0-6]\d{2}|7(?:[0-6]\d|7[012]))[ -]?(?!00)(\d\d){1}[ -]?(?!0000)(\d{4})$"
Const rXstate = "^((?:A[LKSZRAP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])|(?:A[lkszrap]|C[aot]|D[ec]|F[lm]|G[au]|Hi|I[adln]|K[sy]|La|M[adehinopst]|N[cdehjmvy]|O[hkr]|P[arw]|Ri|S[cd]|T[nx]|Ut|V[ait]|W[aivy])|(?:a[lkszrap]|c[aot]|d[ec]|f[lm]|g[au]|hi|i[adln]|k[sy]|la|m[adehinopst]|n[cdehjmvy]|o[hkr]|p[arw]|ri|s[cd]|t[nx]|ut|v[ait]|w[aivy]))\.?$"
Const rXtextarea = "^[a-zA-Z0-9 -\.\,\n\r\;\:\/\?\&\=]+$"
Const rXurlpath = "^[a-zA-Z0-9\/\-\%\_]+\.(php|asp|htm|html)$"
Const rXzip5 = "^\d{5}?$"
Const rXzipcode = "^\d{5}(-\d{4})?$"

Function getGUID
	Dim TypeLib, tg
	on error resume next
	Set TypeLib = Server.CreateObject("Scriptlet.TypeLib")
	if err then
		Response.Write "GP ERROR 1"
		Response.Write err.number & " " & err.description & " " & err.source
		response.end
	else
		tg = TypeLib.Guid
		getGUID = CStr(left(tg, len(tg)-2))
		Set TypeLib = Nothing
	end if
End Function

function getField(pParams) ' fieldname, pattern, method
	'**********************************************
	'* PURPOSE: Retrieves a form field and
	'*   ensures it contains only safe characters
	'*   as defined by a regular expression.
	'* INPUT: The field name
	'* OUTPUT: The field value if it contains only
	'*   allowed characters, otherwise an empty
	'*   string.
	'**********************************************
	Dim param, fldName, regEx, tmp, strIn, matches, match
	Set regEx = New RegExp
	
	param = Split(Replace(pParams," ",""),",")
	fldName = LCase(param(0))
	
	' Assume no pattern and default to safe characters
	regEx.pattern = rXsafe
	if UBound(param)>0 then
		if param(1)<>"" then
			regEx.pattern=Eval(param(1))
		end if
	end if
	
	' Assume POST
	strIn = Request.Form(fldName)
	if UBound(param)>1 then
		if LCase(param(2))="get" then
			strIn = Request.QueryString(fldName)
			' strIn is filtered next	
		end if
	end if	
	
	tmp = ""
	
	regEx.IgnoreCase = False
	regEx.Global = True
	Set matches = regEx.Execute(strIn)
	for each match in matches
		tmp = tmp & match
	next
	if tmp = strIn then
		getField = tmp
	end if
end function

function fileExists(pPath)
	'***************************************
	' input: /folder/folder/filename.asp
	' output: true or false
	'***************************************
	Dim fs, results
	results = false
	on error resume next
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	if err then
		fileExists = false
	elseif (fs.FileExists(Server.MapPath(pPath)))=true Then
		if err then
			results = false
		else
			results = true
			set fs=nothing
		end if	
	end If

	fileExists = results
end function

function getRedirectPath(pParam)
	Dim regEx, matches, match, tmp, path, paramsArray, server, results
	results = ""
	Set regEx = New RegExp
	regEx.Pattern = "^[a-zA-Z0-9\/\%_]+\.(php|asp|htm|html)+$"
	regEx.IgnoreCase = False
	regEx.Global = True
	path = Request.QueryString(pParam)
	
	Set matches = regEx.Execute(path)
	for each match in matches
		tmp = tmp & match
	next
	Set regEx=nothing
	
	if tmp = path then
		if fileExists(path) then
			results = path
		end if
	end if
	
	getRedirectPath = results
end function
%>
