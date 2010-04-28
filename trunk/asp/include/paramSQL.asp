<%
' $Id$
'*******************************************************************************************************************
'* ParamSQL
'* Last Modification: 01 DEC 2009 rdivilbiss
'* Version:  2.0
'* On Entry: None
'* Input:    Various: See Functions
'* Output:   Global db_rs (recordset of results) or numAffected (number of rows affected by a command)
'* On Exit:  None
'******************************************************************************************************************
Dim db_cmd, db_conn, db_rs, db_cmdText, numAffected

Sub openCommand(pConnStr,pSource)
	if pConnStr="" then
		Response.Write "There was an openCommand error: "& pSource &" 1.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	on error resume next
	
	Set db_cmd = Server.CreateObject("ADODB.Command")
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 2.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	Set db_conn = Server.CreateObject("ADODB.Connection")
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 3.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	db_conn.open pConnStr

	if err then
		Response.Write "There was an openCommand error: "& pSource &" 4.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if

	Set db_cmd.ActiveConnection = db_conn
	if err then
		Response.Write "There was an openCommand error: "& pSource &" 5.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
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
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	db_cmd.Parameters.Append param
	if err then
		Response.Write "There was an error appending the database parameter: "& pSource &" 2.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	end if
	
	Set param = nothing
End Sub


Sub getRS(db_rs,db_cmdText,pSource)
	on error resume next
	Set db_rs = Server.CreateObject("ADODB.Recordset")
	
	if err then
		Response.Write "There was an error: "&pSource&" 1.<br>" & vbLF
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End	
	else
		db_cmd.CommandText = db_cmdText
		if err then
			Response.Write "There was an error: "&pSource&" 2.<br>" & vbLF
			'* Developer Only * 
			Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
			Response.End
		else
			' db_rs.Open db_cmd, adOpenStatic, adLockOptimistic
			' db_rs.open db_cmd, adOpenStatic, adLockReadOnly, adCmdText
			db_rs.Open db_cmd
			if err then
				Response.Write "There was an error "&pSource&" 3.<br>" & vbLF
				'* Developer Only * 
				Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
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
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End	
	else
		db_cmd.CommandText = db_cmdText
		if err then
			Response.Write "There was an error: "&pSource&" 2.<br>" & vbLF
			'* Developer Only * 
			Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
			Response.End
		else
			' db_rs.Open db_cmd, adOpenStatic, adLockOptimistic
			' db_rs.open db_cmd, adOpenStatic, adLockReadOnly, adCmdText
			db_rs.Open db_cmd
			if err then
				Response.Write "There was an error "&pSource&" 3.<br>" & vbLF
				'* Developer Only * 
				Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF & errMsg & "<br>" & gs_cmdTxt
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
		'* Developer Only * 
		Response.Write err.number & " " & err.description & " " & err.source & "<br>" & vbLF
		Response.End
	else
		db_cmd.Execute numAffected,, adExecuteNoRecords
		if err then
			Response.Write "There was an error executing command. "&pSource&" execCmd 2.<br>" & vbLF
			'* Developer Only * 
			Response.Write err.number & " " & err.description & " " & err.source & " Command: " &db_cmdText& "<br>" & vbLF
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