<%
'* alpha 0.5a debug
'* $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
				<h1><%=lg_term_login_success%></h1>
				<div id="loginSuccess"><p><%=Server.HTMLEncode(Session("name"))%>&nbsp;<%=lg_phrase_is_logged_in%>.</p>
					<p><%="<a href="""& lg_home &""" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a>"%></p>
				</div>
			</div>