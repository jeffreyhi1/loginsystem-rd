<%
'*******************************************************************************************************************
'* FORM TOKEN
'* Purpose: Write anti-CSRF one time use token to a form page
'*          Verify on POST the token exists and was not tampered with.
'*
'* NOTE: Person browsing the site who use the back button to return to a form will get an error
'*       because the token is no longer valid.  Similaryly a double post will return an error due
'*       to an invalid token.
'*       Persons who take too long (default 5 minutes) to complete a form will throw a form error.
'*       Persons who do not accept cookies will have an error.
'* Last Modification: 19 FEB 2010. rdivilbiss
'*                    Changed default writeToken to write an XHTML compatible input field
'*                    and added writeTokenH to write an HTML 4.01 Strict input field.
'*
'* Requires include/hashSHA1.asp
'* Requires include/generalPurpose.asp
'*
'* Copyright Information
'* © 2010, EE Collaborative Login Project, Some Rights Reserved 
'*
'* This code is protected by a compilation copyright in the United States of America based on 
'* U.S. Copyright Law (17 U.S.C. sec.101 et seq) and International Copyright Laws.  
'* This code distributed in accordance with the GNU General Public License v2. 
'* If you do not agree with the conditions of that license you may not use, copy, distribute or 
'* make derivative works based on this code.
'*
'* The author of this code is Roderick W. Divilbiss of Overland Park, Kansas, USA. The content is contributed to
'* the EE Collaborative Login Project and is distributed in accordance with the Creative Commons 3.0 BY-SA
'* license.
'*
'* NOTE that this in part requires that:
'*   * You must attribute the use of the code as follows:
'*     This site includes work © 2010, by the EE Collaborative Login Project, 
'*     used by permission in accordance with the Creative Commons 3.0 BY-SA license.
'*
'*   * If you alter, transform, or build upon this work, you may distribute the resulting work only 
'*     under the same, similar or a compatible license and must attribute the original authors as stated 
'*     above.
'*
'*   * For any reuse or distribution, you must make clear to others the license terms of this work. 
'*     The best way to do this is with a link to Creative Commons 3.0 BY-SA.
'*
'* Disclaimer of Warranties
'* NO WARRANTY 
'* Because the code is licensed free of charge, there is no warranty For the code, to the extent 
'* permitted by applicable law. Except when Otherwise stated in writing the copyright holders and/or 
'* other parties Provide the code "as is" without warranty of any kind, either expressed Or implied, 
'* including, but not limited to, the implied warranties of Merchantability and fitness for a particular 
'* purpose. The entire risk as To the quality and performance of the code is with you.
'*
'* Should the code prove defective, you assume the cost of all necessary servicing, Repair or correction. 
'* In no event unless required by applicable law or agreed to in writing Will any copyright holder, or 
'* any other party who may modify and/or Redistribute the program as permitted above, be liable to you 
'* for damages, Including any general, special, incidental or consequential damages arising out of the 
'* use or inability to use this code (including but not limited To loss of data or data being rendered 
'* inaccurate or losses sustained by You or third parties or a failure of the code to operate with any 
'* other Programs), even if such holder or other party has been advised of the Possibility of such damages.
'*
'*******************************************************************************************************************

function checkToken
	'*****************************************************************************************
	' Check the posted token for correctness
	'*****************************************************************************************
	Dim oldToken, testToken, tokenStr, page
		page = Request.ServerVariables("HTTP_REFERER")
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