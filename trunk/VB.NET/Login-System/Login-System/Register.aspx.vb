
Imports System.Data.Common


Partial Public Class Register
    Inherits System.Web.UI.Page
    Public mUserid As String
    Public mEmail As String
    Public mName As String
    Public mWebsite As String
    Public mNews As Boolean
    Public mIp As String
    Public mRegion As String
    Public mCity As String
    Public mCountry As String
    Public mUseragent As String
    Public Destination As String
    Public Message As String
    Public NumAffected As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '"INSERT INTO users (dateRegistered, userid, password, name, email, ip, region, city, country, useragent, website, news, locked, dateLocked, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        Message = "<strong>" & ResString("lg_term_please_register") & "</strong>"
        Debug.WriteLine(Threading.Thread.CurrentThread.CurrentCulture.Name)
    End Sub

    Public Function ResString(ByVal Key As String) As String
        Return LoginResources.ResString(Key)
    End Function

    Public Function CultureName() As String
        Return Threading.Thread.CurrentThread.CurrentCulture.Name
    End Function

    Private Sub cmdSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
        Dim DateRegistered As Date = Now
        mIp = Request.UserHostAddress

        GetGEOID(mIp)
        mUserid = userid.Text
        mEmail = email.Text
        mName = name.Text
        mWebsite = website_address.Text
        mUseragent = Request.UserAgent
        mNews = news.Checked

        Dim InsertUserSQL As String = _
            "INSERT INTO users " & _
            "(dateRegistered, userid, password, name, " & _
             "email, ip, region, city, country, useragent, website, " & _
             "news, locked, dateLocked, token) " & _
             "VALUES (@dateRegistered, @userid, @password, @name, " & _
             "@email, @ip, @region, @city, @country, @useragent, @website, " & _
             "@news, @locked, @dateLocked, @token)"
        Try
            Using Da As New DataAccess
                Dim Params As New List(Of DbParameter)
                Params.Add(Da.ParmWithValue("@dateRegistered", DateRegistered))
                Params.Add(Da.ParmWithValue("@userid", mUserid))
                Params.Add(Da.ParmWithValue("@password", password.Text))
                Params.Add(Da.ParmWithValue("@name", mName))
                Params.Add(Da.ParmWithValue("@email", mEmail))
                Params.Add(Da.ParmWithValue("@ip", mIp))
                Params.Add(Da.ParmWithValue("@region", mRegion))
                Params.Add(Da.ParmWithValue("@city", mCity))
                Params.Add(Da.ParmWithValue("@country", mCountry))
                Params.Add(Da.ParmWithValue("@useragent", mUseragent))
                Params.Add(Da.ParmWithValue("@website", mWebsite))
                Params.Add(Da.ParmWithValue("@news", mNews))
                Params.Add(Da.ParmWithValue("@locked", 1))
                Params.Add(Da.ParmWithValue("@dateLocked", Now))
                Params.Add(Da.ParmWithValue("@token", GetToken()))
                NumAffected = Da.ExecuteScalar(InsertUserSQL, Params.ToArray)

            End Using
        Catch ex As Exception
            Debug.WriteLine(ex.ToString)

        End Try






    End Sub
    Private Function GetToken() As String
        Dim Guid As Guid = Guid.NewGuid
        Return HashEncode(Guid.ToString).Substring(0, 40)
    End Function
    Private Sub GetGEOID(ByVal IPAddress As String)
        Dim xDoc As XDocument = XDocument.Load("http://ipinfodb.com/ip_query.php?ip=" & IPAddress)
        mCountry = xDoc.<Response>.<CountryName>.Value
        mRegion = xDoc.<Response>.<RegionName>.Value
        mCity = xDoc.<Response>.<City>.Value



    End Sub
End Class