<%
' $Id$
%>
			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
				<h1><%=lg_phrase_delete_account%></h1>
				<% If message = lg_term_register_delete_enter_email Then %>
					<div id="message"><%=message%></div>
					<div id="formDiv">
						<form name="frm" method="post" action="<%=lg_filename%>">
						<fieldset>
						  <legend><%=lg_phrase_delete_account%></legend>
						  <p><lable for="email"><%=lg_term_email%></lable><br><input type="text" id="email" name="email" size="50" maxsize="100"><br>
						  <input type="submit" value="<%=lg_term_submit%>"><%=writeTokenH %></p>
						</fieldset>  
						</form>
				<% Else %>
					<div id="message"><%=message%></div>
				<% End If %>
			</div>