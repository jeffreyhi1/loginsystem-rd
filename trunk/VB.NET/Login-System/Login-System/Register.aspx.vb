Imports Login_System

Partial Public Class Register
    Inherits System.Web.UI.Page
    Public mUserid As String
    Public mEmail As String
    Public mName As String
    Public mWebsite As String
    Public mIp As String
    Public mRegion As String
    Public mCity As String
    Public mCountry As String
    Public mUseragent As String
    Public Destination As String
    Public Message As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '"INSERT INTO users (dateRegistered, userid, password, name, email, ip, region, city, country, useragent, website, news, locked, dateLocked, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        Message = "<strong>" & ResString("lg_term_please_register") & "</strong>"

    End Sub

    Public Function ResString(ByVal Key As String) As String
        Return LoginResources.ResString(Key)
    End Function

End Class