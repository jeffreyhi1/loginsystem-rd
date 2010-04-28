<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" name="CDO for Windows Library" -->
<%
' $Id$
'*******************************************************************************************************************
'* CDO Mail Include
'* Last Modification: 01 JAN 2008 rdivilbiss
'* Version:  1.0
'* On Entry: none
'* Input:    email to, email from, subject, message
'* Output:   email sent
'* On Exit:  nothing
'******************************************************************************************************************
Dim CDOMailIncludeResults
CDOMailIncludeResults = "Not Sent"
Sub sendmail(pFrom, pTo, pSubject, pBody)
     Dim objCDO
     Dim iConf
     Dim Flds

     Const cdoSendUsingPort = 2

     Set objCDO = Server.CreateObject("CDO.Message")
     Set iConf = Server.CreateObject("CDO.Configuration")

     Set Flds = iConf.Fields
     With Flds
          .Item(cdoSendUsingMethod) = cdoSendUsingPort
          .Item(cdoSMTPServer) = "localhost"
          .Item(cdoSMTPServerPort) = 25
          .Item(cdoSMTPconnectiontimeout) = 10
          .Update
     End With

     Set objCDO.Configuration = iConf

     objCDO.From = pFrom
     objCDO.To = pTo
     objCDO.Subject = pSubject
     ' objCDO.TextBody = pBody
     objCDO.HTMLBody = pBody
     on error resume next
     objCDO.Send
     if err then
     	CDOMailIncludeResults="ERROR: "&err.number & " " & err.description & " " & err.source
     else
     	CDOMailIncludeResults="Sent"
     end if
     on error goto 0	
     
     Set ObjCDO = Nothing
     Set iConf = Nothing
     Set Flds = Nothing
End Sub
%>