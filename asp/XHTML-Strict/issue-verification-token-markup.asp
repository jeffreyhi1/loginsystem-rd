			<div id="login-system">
				<h1><%=lg_term_issue_verification_token%></h1>
				<% If (message = lg_phrase_issue_new_token) Then %>
				<div id="message"><%=message%></div>	
				<div id="formDiv">
					<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
						<fieldset>
						  <legend><%=lg_term_issue_verification_token%></legend>
						  <p><label for="userid"><%=lg_term_userid%></label><br /><input type="text" id="userid" name="userid" title="<%=lg_phrase_userid_title%>" size="50" maxlength="50" /><br />
						  <label for="email"><%=lg_term_email%></label><br /><input type="text" id="email" name="email" title="<%=lg_phrase_email_title%>" size="50" maxlength="255" /><br />
						  <input type="submit" value="<%=lg_term_submit%>" /><%=writeToken%></p>
						</fieldset>
					</form>
				</div>
				<% Else %>
				<div id="message"><%=message%></div>
				<% End If %>
			</div>