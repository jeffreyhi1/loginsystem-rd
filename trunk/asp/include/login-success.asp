<%
' $Id$
'*******************************************************************************************************************
'* Page Name: Login Success
'* Version:  alpha 0.1c debug
'* On Entry: None
'* Input   : None
'* Output  : None
'* On Exit : Redirect to destination
'******************************************************************************************************************

'*******************************************************************************************************************
'* On login success, provide link.
'*******************************************************************************************************************
If NOT Session("login") Then
        Response.Redirect("http://"& lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME"))
End If
%>