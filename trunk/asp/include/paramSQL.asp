<%
'*******************************************************************************************************************
'* PARAMETERIZED SQL LIBRARY
'* Purpose: Provide abstraction of the preparation and execution of parameterized SQL commands.
'*          Tested using Microsoft ADO from MDAC 2.8 on Windows XP Pro SP3, Windows Server 2003 and 2008
'*          Known functional for MS Access 2003, MS SQL Server 2000, 2005, and MySql 5.0.45  
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
'* The author of this code is Roderick W. Divilbiss of Overland Park, Kansas, USA. The content is 
'* contributed to the EE Collaborative Login Project and is distributed in accordance with the 
'* Creative Commons 3.0 BY-SA license.
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
Dim db_cmd, db_conn, db_rs, db_cmdText, numAffected

Sub openCommand(pConnStr,pSource)
	if pConnStr="" then
		Response.Write "There was an openCommand error: "& pSource &" 1.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	on error resume next
	
	Set db_cmd = Server.CreateObject("ADODB.Command")
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 2.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	Set db_conn = Server.CreateObject("ADODB.Connection")
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 3.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	db_conn.open pConnStr

	if err then
		Response.Write "There was an openCommand error: "& pSource &" 4.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if

	Set db_cmd.ActiveConnection = db_conn
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 5.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
End Sub


Sub closeCommand()
	on error resume next
	if IsObject(db_cmd) then
		Set db_cmd = nothing
	end if
	if IsObject(db_conn) then
		if db_conn.open then
			db_conn.close
		end if	
		Set db_conn = nothing
	end if	
End Sub


Sub addParam(pName,pType,pDir,pSize,pValue,pSource)
	Dim param
	on error resume next
	Set param = db_cmd.CreateParameter(pname,ptype,pdir,psize,pvalue)
	if err then
		Response.Write "There was an error creating a database parameter: "& pSource &" 1.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	db_cmd.Parameters.Append param
	if err then
		Response.Write "There was an error appending the database parameter: "& pSource &" 2.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	Set param = nothing
End Sub


Sub getRS(db_rs,db_cmdText,pSource)
	on error resume next
	Set db_rs = Server.CreateObject("ADODB.Recordset")
	
	if err then
		Response.Write "There was an error: "&pSource&" 1.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End	
	else
		db_cmd.CommandText = db_cmdText
		if err then
			Response.Write "There was an error: "&pSource&" 2.<br>" & vbLF
			'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
			Response.End
		else
			db_rs.Open db_cmd
			if err then
				Response.Write "There was an error "&pSource&" 3.<br>" & vbLF
				'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
				Response.End
			end if
		end if
	end if				
End Sub

Sub getRSdynamic(db_rs,db_cmdText,pSource)
	on error resume next
	Set db_rs = Server.CreateObject("ADODB.Recordset")
	db_rs.CursorLocation = adOpenStatic 
	db_rs.CursorType = adLockReadOnly
	db_rs.LockType = adCmdText
	if err then
		Response.Write "There was an error: "&pSource&" 1.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End	
	else
		db_cmd.CommandText = db_cmdText
		if err then
			Response.Write "There was an error: "&pSource&" 2.<br>" & vbLF
			'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
			Response.End
		else
			db_rs.Open db_cmd
			if err then
				Response.Write "There was an error "&pSource&" 3.<br>" & vbLF
				'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF & errMsg & "<br>" & gs_cmdTxt
				Response.End
			end if
		end if
	end if				
End Sub

Sub execCmd(db_cmdText)
	on error resume next
	db_cmd.CommandText = db_cmdText
	if err then
		Response.Write "There was an error setting command text. "&pSource&" execCmd 1.<br>" & vbLF
		'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	else
		db_cmd.Execute numAffected,, adExecuteNoRecords
		if err then
			Response.Write "There was an error executing command. "&pSource&" execCmd 2.<br>" & vbLF
			'* Developer Only * Response.Write err.number & " " & err.description & " " & err.source & " Command: " &db_cmdText& "<br>" & vbLF
			Response.End
		end if
	end if				
End Sub

Sub closeRS
	on error resume next
	if IsObject(db_rs) then
		db_rs.close
	end if
End Sub
%>