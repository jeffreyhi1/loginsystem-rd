			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
			<h1><%=lg_phrase_recover_password%></h1>
			<% If (message <> lg_phrase_recover_password_success) Then %>
			<div id="message"><%=message%></div>	
			<div id="formDiv">
			<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_phrase_recover_password%></legend>
			  <p><label for="userid"><%=lg_term_userid%></label><br><input type="text" id="userid" name="userid" title="<%=lg_phrase_userid_title%>" size="50" maxlength="50"><br>
			  <label for="email"><%=lg_term_email%></label><br><input type="text" id="email" name="email" title="<%=lg_phrase_email_title%>" size="50" maxlength="255"><br>
			  <input type="submit" value="<%=lg_term_submit%>"><%=writeTokenH %></p>
			</fieldset>
			</form>
			</div>
			<% Else %>
			<div id="message"><%=message%></div>
			<% End If %>
			</div>