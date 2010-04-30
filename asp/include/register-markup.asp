<%
' $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<!-- alpha 0.1b -->
			<div id="login-system">
    		<% If numAffected<>1 Then %>
    		<div id="message"><%=message%></div>
    		<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
    		  <fieldset>
    		    <legend><%=lg_term_registration%></legend>
    		    <label for="userid"><%=lg_term_userid %></label><br />
    		    <input id="userid" name="userid" title="<%=lg_phrase_userid_new_title%>" type="text" size="20" maxlength="50" value="<%=Server.HTMLEncode(userid)%>" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="password"><%=lg_term_password %></label><br />
    		    <input id="password" name="password" title="<%=lg_phrase_password_new_title%>" type="password" size="20" maxlength="255" autocomplete="off" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="confirm"><%=lg_term_confirm %></label><br />
    		    <input id="confirm" name="confirm" title="<%=lg_phrase_confirm_title%>" type="password" size="20" maxlength="255" autocomplete="off" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="email"><%=lg_term_email %></label><br />
    		    <input id="email" name="email" title="<%=lg_phrase_email_title%>" type="text" size="20" maxlength="100" value="<%=Server.HTMLEncode(email)%>" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="name"><%=lg_term_name %></label><br />
    		    <input id="name" name="name" title="<%=lg_phrase_name_title%>" type="text" size="20" maxlength="100" value="<%=Server.HTMLEncode(name)%>" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="website"><%=lg_term_website_address %></label><br />
    		    <input id="website" title="<%=lg_phrase_website_title%>" name="website" type="text" size="20" maxlength="100" value="<%=Server.HTMLEncode(website)%>" />
    		    <span class="field_normal"><%=lg_term_optional%></span><br />
    		    <label for="news"><%=lg_phrase_news %></label>
    		    <input id="news" name="news" type="checkbox" value="Yes"<% If news="Yes" Then Response.Write(" checked") End If %> />
    		    <input type="hidden" id="destination" name="destination" value="<%=destination%>" /><br />
    		    <% writeToken %><input type="submit" value="<%=lg_register_button_text %>" />
    		  </fieldset>
    		</form>
    		<% Else %>
    		<div id="registered"><p><%=lg_term_registration_thankyou%><br /><br />
    		  <strong><%=lg_term_userid%></strong>: <%=userid%><br />
    		  <strong><%=lg_term_email%></strong>: <%=email%><br />
    		  <strong><%=lg_term_name%></strong>: <%=name%><br />
    		  <strong><%=lg_term_website%></strong>: <%=website%><br />
    		  <strong><%=lg_term_ip%></strong>: <%=ip%><br />
    		  <strong><%=lg_term_region%></strong>: <%=region%><br />
    		  <strong><%=lg_term_city%></strong>: <%=city%><br />
    		  <strong><%=lg_term_country%></strong>: <%=country%><br />
    		  <strong><%=lg_term_useragent%></strong>: <%=useragent%><br />
    		  <% If destination<>"" Then %></p>
    		  	<p><a href="<%=lg_verify_page%>" title="<%=lg_phrase_logout_continue%>"><%=lg_phrase_logout_continue%></a></p>
    		  	<% Else %>
    		  	<p><a href="<%=lg_verify_page%>"><%=lg_phrase_logout_continue%></a></p>
  	  		  	<% End If %>
  		  		</div>
    		<% End If %>
  			</div>