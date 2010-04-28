<%
' $Id$
'*******************************************************************************************************************
'* Page Name
'* Last Modification: 26 APR 2010 rdivilbiss
'* Version:  alpha 0.1b
'* On Entry: None
'* Input   : None
'* Output  : None
'* On Exit : Redirect to destination
'******************************************************************************************************************
' no browser caching of this page !! to be used on all pages
Response.Expires=-1
Response.ExpiresAbsolute = Now() - 1

' do not allow proxy servers to cache this page !! to be used on all pages
Response.AddHeader "pragma","no-cache"
Response.CacheControl="private"
Response.CacheControl="no-cache"
Response.CacheControl="no-store"
'*******************************************************************************************************************
'* On login success, provide link.
'*******************************************************************************************************************
If NOT Session("login") Then
        Response.Redirect("http://"& lg_domain & lg_loginPath & lg_loginPage & "?p=" & Request.ServerVariables("SCRIPT_NAME"))
End If
%>