<%
'* alpha 0.5a debug
'* $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
				<h1><%=lg_phrase_delete_account%></h1>
				<% If message = lg_term_register_delete_enter_email Then %>
					<div id="message"><%=message%></div>
					<div id="formDiv">
						<form name="frm" method="post" action="<%=lg_filename%>">
						<fieldset>
						  <legend><%=lg_phrase_delete_account%></legend>
						  <p><lable for="email"><%=lg_term_email%></lable><br /><input type="text" id="email" name="email" size="50" maxsize="100" value="<%=Server.HTMLEncode(email) %>" /><br />
						  <input type="submit" value="<%=lg_term_submit%>" /><%=writeToken %></p>
						</fieldset>  
						</form>
				<% Else %>
					<div id="message"><%=message%></div>
				<% End If %>
			</div>