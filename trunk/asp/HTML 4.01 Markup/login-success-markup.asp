			<!-- HTML 4.01 Strict -->
			<!-- 25 APR 2010 alpha 0.1a -->
			<div id="login-system">
				<h1><%=lg_term_login_success%></h1>
				<div id="loginSuccess"><p><%=Server.HTMLEncode(Session("name"))%>&nbsp;<%=lg_phrase_is_logged_in%>.</p>
					<p><%="<a href="""& lg_home &""" title="""& lg_phrase_logout_continue &""">"& lg_phrase_logout_continue &"</a>"%></p>
				</div>
			</div>