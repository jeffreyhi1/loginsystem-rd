<%
'* alpha 0.3
'* $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
			<h1><strong>Welcome</strong></h1>
          	<p><% If Session("login") Then Response.Write("<a href=""logout.asp"">"& lg_term_log_out &"</a>&nbsp;<a href=""change_password.asp"">"& lg_term_change_password &"</a>&nbsp;<a href=""cancel_account.asp"">"& lg_term_cancel_account &"</a>") Else Response.Write("<a href=""login.asp"">"& lg_term_login &"</a>") End If %></p>
			<%=lg_phrase_default_body1 & " " & lg_term_project_home_link & lg_phrase_default_body2 & " " & lg_term_webloginproject_link & " " & lg_phrase_default_body3 %>
			</div>
