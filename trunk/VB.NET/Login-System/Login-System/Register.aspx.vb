Public Partial Class Register
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '"INSERT INTO users (dateRegistered, userid, password, name, email, ip, region, city, country, useragent, website, news, locked, dateLocked, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

    End Sub

    Public Function PageTitle() As String
        Return ResString("lg_term_registration")
    End Function

    Public Function Message() As String
        Return "<strong>" & ResString("lg_term_please_register") & "</strong>"
    End Function

End Class