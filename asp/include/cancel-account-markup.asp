<%
'* alpha 0.5 debug
'* $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<!-- alpha 0.3 -->
			<div id="login-system">
			<h1><%=lg_term_cancel_account%></h1>
			<% If message <> lg_phrase_cancel_account_canceled Then %>
			<div id="message"><%=message%></div>
			<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
			<fieldset>
			  <legend><%=lg_term_cancel_account%></legend>
			  <div id="warning"><%=lg_phrase_cancel_account_warning%></div>
			  <label for="userid"><%=lg_term_userid %></label><br /><input id="userid" name="userid" title="lg_phrase_userid_title" type="text" size="20" maxlength="50" value="<%=Server.HTMLEncode(userid) %>" /><span class="field_normal"><%=lg_term_required%></span><br />
			  <label for="password"><%=lg_term_password %></label><br /><input id="password" name="password" title="lg_phrase_password_title" type="password" size="20" maxlength="255" autocomplete="off" /><span class="field_normal"><%=lg_term_required%></span><br />
			  <input type="submit" value="<%=lg_term_cancel%>" /><% writeToken %>
			</fieldset>
			<p><a title="<%=lg_term_recover_password%>" href="<%=lg_recover_passsword_page%>"><%=lg_term_recover_password%></a></p>
			</form>
			<% Else %>
			<div id="message"><%=message%></div>
			<% End If %>
			</div>

