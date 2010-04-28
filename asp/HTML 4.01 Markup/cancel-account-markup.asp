<%
' $Id$
%>
			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
			<h1><%=lg_term_cancel_account%></h1>
			<% If message <> lg_phrase_cancel_account_canceled Then %>
			<div id="message"><%=message%></div>
			<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_term_cancel_account%></legend>
			  <div id="warning"><%=lg_phrase_cancel_account_warning%></div>
			  <label for="userid"><%=lg_term_userid %></label><br><input id="userid" name="userid" title="lg_phrase_userid_title" type="text" size="20" maxlength="32"><span class="field_normal"><%=lg_term_required%></span><br>
			  <label for="password"><%=lg_term_password %></label><br><input id="password" name="password" title="lg_phrase_password_title" type="password" size="20" maxlength="255"><span class="field_normal"><%=lg_term_required%></span><br>
			  <input type="submit" value="<%=lg_term_cancel%>"><% writeTokenH %>
			</fieldset>
			<p><a title="<%=lg_term_recover_password%>" href="<%=lg_recover_passsword_page%>"><%=lg_term_recover_password%></a></p>
			</form>
			<% Else %>
			<div id="message"><%=message%></div>
			<% End If %>
			</div>

