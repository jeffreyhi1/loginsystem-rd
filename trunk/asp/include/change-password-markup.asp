          <!-- XHTML 1.1 Strict -->
          <!-- 25 APR 2010 alpha 0.1a -->
          <div id="login-system">
			<h1><%=lg_term_change_password%></h1>
			<h2><%=Session("name")%></h2>
			<% If message <> lg_phrase_password_changed Then %>
				<div id="message"><%=message%></div>
				<form id="frm" name="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
				<fieldset>
				  <legend><%=lg_term_change_password%></legend>
				  <label for="oldpassword"><%=lg_term_current_password%>&nbsp;</label><br /><input id="oldpassword" name="oldpassword" type="password" size="25" maxlength="255" title="<%=lg_phrase_oldpassword_title%>" /><span class="field_normal"><%=lg_term_required%></span><br />
				  <label for="newpassword"><%=lg_term_password%>&nbsp;</label><br /><input id="password" name="password" type="password" size="25" maxlength="255" title="<%=lg_phrase_password_title%>" /><span class="field_normal"><%=lg_term_required%></span><br />
				  <label for="confirm"><%=lg_term_confirm%>&nbsp;</label><br /><input id="confirm" name="confirm" type="password" size="25" maxlength="255" title="<%=lg_phrase_confirm_title%>" /><span class="field_normal"><%=lg_term_required%></span><br />
				  <%=writeToken%><input id="bSubmit" name="bSubmit" type="submit" value="<%=lg_term_change_password_button_text%>" />
				</fieldset>
				</form>
			<% Else %>
				<div id="message"><%=message%><br />
					<a href="<%=lg_home%>"><%=lg_phrase_logout_continue%></a>
				</div>
			<% End If %>
		</div>