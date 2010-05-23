<%
'* alpha 0.5a debug
'* $Id$
%>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">
			<h1><%=lg_phrase_registration_email_verify%></h1>
			<% If (message = lg_phrase_registration_email_verify_msg) Then %>
			<div id="message"><%=message%></div>	
			<div id="formDiv">
			<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_term_registration_verification%></legend>
			  <p><label for="token"><%=lg_phrase_enter_unlock_code%></label><br><input type="text" id="token" name="token" size="50" maxlength="64"><br>
			  <input type="submit" value="<%=lg_term_submit%>"></p>
			</fieldset>
			</form>
			</div>
			<% Else %>
			<div id="message"><%=message%></div>
			<% End If %>