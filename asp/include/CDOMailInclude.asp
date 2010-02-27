<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" name="CDO for Windows Library" -->
<%
'*******************************************************************************************************************
'* CDO Mail Include Library
'* Purpose: Send email from a web application in HTML format via CDO
'*
'* NOTE: The mail server, port, and sending method are hard coded in this file.
'*       You may need to modify these, and/or add a user id and password for the sender
'*       in order for this code to function properly in your environment. Check with the
'*       mail server administrator or your ISP for the correct settings for your environment.
'*
'* Last Modification: 26 FEB 2010. Roderick Divilbiss
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