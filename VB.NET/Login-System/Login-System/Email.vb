' $Id$

Imports System.Net.Mail

Public Class Email


    Public Shared Sub SendUnlockTokenEmail(ByVal Token As String, ByVal Email As String, ByVal Name As String, ByVal Destination As String)

        Dim mailBody As String = String.Empty
        mailBody = mailBody & "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
        mailBody = mailBody & "<HTML><HEAD><META http-equiv=Content-Type content=""text/html; charset=us-ascii"">"
        mailBody = mailBody & "</HEAD><BODY><DIV><FONT face=Arial size=2>" & ResString("lg_term_register_confirmation") & "<br><br>"
        mailBody = mailBody & ResString("lg_term_to") & " " & Name & "<br><br>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail1") & " " & ResString("lg_domain") & ". " & ResString("lg_phrase_registration_mail2") & "<br>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail3") & "<br><br>"
        mailBody = mailBody & "<a href=""http://" & ResString("lg_domain") & ResString("lg_loginPath") & ResString("lg_verify_page") & "?token=" & Token & "&p=" & Destination & """>" & ResString("lg_phrase_registration_mail4") & "</a><br><br>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail5")
        mailBody = mailBody & ResString("lg_domain") & ResString("lg_loginPath") & ResString("lg_verify_page") & "</p>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail6") & ".<br><br>"
        mailBody = mailBody & Token & "<br><br>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail7") & " "
        mailBody = mailBody & ResString("lg_phrase_registration_mail8") & ResString("lg_domain") & ResString("lg_loginPath") & ResString("lg_register_delete_page") & "?email=" & Email & """>" & ResString("lg_term_remove_registration") & "</a>.<br><br>"
        mailBody = mailBody & ResString("lg_phrase_registration_mail9") & ResString("lg_domain") & ResString("lg_contact_form") & """>" & ResString("lg_phrase_contact_webmaster") & "</a>.<br><br>"
        mailBody = mailBody & ResString("lg_copyright") & "<br>"
        mailBody = mailBody & "</FONT></DIV></BODY></HTML>"


        SendMail(ConfigurationManager.AppSettings("lg_webmaster_email"), Email, "User Registration", mailBody)
        SendMail(ConfigurationManager.AppSettings("lg_webmaster_email"), "rod@rodsdot.com", "ATTN:Webmaster User Registration", mailBody)

    End Sub

    Public Shared Sub SendMail(ByVal FromAddress As String, ByVal ToAddress As String, ByVal Subject As String, ByVal Body As String)
        'Configuration in 
        Dim Client As New SmtpClient
        Client.Send(FromAddress, ToAddress, Subject, Body)
    End Sub

End Class
