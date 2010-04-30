<%
' $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<!-- 26 APR 2010 alpha 0.1b -->
			<div id="login-system">
            <h1><%=lg_term_login%></h1>
            <% If Session("login")<>True Then %>
            <div id="message"><%=message%></div>
              <form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
                <fieldset>
                <legend><%=lg_term_login%></legend>
                <label for="userid"><%=lg_term_userid %></label><br />
                <input id="userid" name="userid" title="<%=lg_phrase_userid_title%>" type="text" size="20" maxlength="50" value="<%=useridValue%>" />
                <span class="field_normal"><%=lg_term_required%></span><br />
                <label for="password"><%=lg_term_password %></label><br />
                <input id="password" name="password" title="<%=lg_phrase_password_title%>" type="password" size="20" maxlength="255" autocomplete="off" />
                <span class="field_normal"><%=lg_term_required%></span><br />
                <label for="remember"><%=lg_term_rememberme %></label>
                <input id="remember" name="remember" type="checkbox" value="Yes"<% If remember="Yes" Then Response.Write(" checked") End If %> />
                <input type="hidden" id="destination" name="destination" value="<%=destination%>" /><br />
                <div id="remember_me_warning"><%=lg_phrase_remember_me_warning%></div>
                <% writeToken %>
                <input type="submit" value="<%=lg_login_button_text %>" />
                </fieldset>
              </form>
                <p><a title="<%=lg_term_recover_password%>" href="<%=lg_recover_passsword_page%>"><%=lg_term_recover_password%></a>
                &nbsp;|&nbsp;<a href="<%=lg_register_page%>" title="<%=lg_term_register%>"><%=lg_term_register%></a></p>
            <% Else %>
                <div id="message"><%=message%></div>
            <% End If %>
            </div>