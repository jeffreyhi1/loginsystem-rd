<%
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 26 FEB 2010 rdivilbiss
'* Version:  beta 1.6
'* On Entry: 
'* Input   : 
'* Output  : 
'* On Exit : 
'******************************************************************************************************************

'*******************************************************************************************************************
'* On login success, provide link.
'*******************************************************************************************************************
If NOT Session("login") Then
        Response.Redirect("http://"& lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME"))
End If
%>