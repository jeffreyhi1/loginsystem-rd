			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
			<h1><%=lg_term_reset_password%></h1>
			<% If Session("action")="token" Then %>
			<div id="message"><%=message%></div>	
			<div id="formDiv">
			<form name="frm1" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_term_registration_verification%></legend>
			  <p><lable for="resettoken"><%=lg_phrase_enter_unlock_code%></lable><br><input type="text" id="resettoken" name="resettoken" size="50" maxsize="64"><br>
			  <input type="submit" value="<%=lg_term_submit%>"><%=writeTokenH%><input name="changePassword" type="hidden" value=""></p>
			</fieldset>
			</form>
			</div>
			<% 
			Else
				If Session("action")="password" Then
			%>
			<div id="message"><%=message%></div>
			<div id="formDiv">
			<form name="frm2" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_term_set_new_password%></legend>
			  <p><lable for="newpassword"><%=lg_term_new_password%></lable><br><input id="newpassword" name="newpassword" type="password" size="50" maxsize="255"><br>
			  <lable for="newpassword"><%=lg_term_confirm%></lable><br><input id="confirm" name="confirm" type="password" size="50" maxsize="255"><br>
			  <input type="submit" value="<%=lg_term_submit%>"><%=writeTokenH %><input name="changePassword" type="hidden" value="1"><input type="hidden" name="resettoken" value="<%=resettoken%>"></p>
			</fieldset>
			</form>
			</div>
			<%
				Else
				' must be success or error, in either case we just show a message.
			%>
			<div id="message"><%=message%></div>
			<% 
				End If
			End If 
			%>
			</div>