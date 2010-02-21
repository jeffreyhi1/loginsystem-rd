<div id="login-system">
    		<% If numAffected<>1 Then %>
    		<div id="message"><%=message%></div>
    		<form id="frm" method="post" action="<%=lg_filename%>" onsubmit="return validate(this);">
    		  <fieldset>
    		    <legend>Registration</legend>
    		    <label for="userid"><%=lg_term_userid %></label><br />
    		    <input id="userid" name="userid" title="<%=lg_phrase_userid_new_title%>" type="text" size="20" maxlength="32" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="password"><%=lg_term_password %></label><br />
    		    <input id="password" name="password" title="<%=lg_phrase_password_new_title%>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="confirm"><%=lg_term_confirm %></label><br />
    		    <input id="confirm" name="confirm" title="<%=lg_phrase_confirm_title%>" type="password" size="20" maxlength="255" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="email"><%=lg_term_email %></label><br />
    		    <input id="email" name="email" title="<%=lg_phrase_email_title%>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="name"><%=lg_term_name %></label><br />
    		    <input id="name" name="name" title="<%=lg_phrase_name_title%>" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><%=lg_term_required%></span><br />
    		    <label for="website"><%=lg_term_website_address %></label><br />
    		    <input id="website" title="<%=lg_phrase_website_title%>" name="website" type="text" size="20" maxlength="100" />
    		    <span class="field_normal"><%=lg_term_optional%></span><br />
    		    <label for="news"><%=lg_phrase_news %></label>
    		    <input id="news" name="news" type="checkbox" value="Yes" />
    		    <input type="hidden" id="destination" name="destination" value="<%=destination%>" /><br />
    		    <% writeToken %> <input type="submit" value="<%=lg_register_button_text %>" />
    		  </fieldset>
    		</form>
    		<% Else %>
    		<div id="registered"><p>Thank you for registering.<br /><br />
    		  <strong>User ID</strong>: <%=userid%><br />
    		  <strong>EMail</strong>: <%=email%><br />
    		  <strong>Name</strong>: <%=name%><br />
    		  <strong>Website</strong>: <%=website%><br />
    		  <strong>IP</strong>: <%=ip%><br />
    		  <strong>Region</strong>: <%=region%><br />
    		  <strong>City</strong>: <%=city%><br />
    		  <strong>Country</strong>: <%=country%><br />
    		  <strong>UserAgent</strong>: <%=useragent%><br />
    		  <% If destination<>"" Then %></p>
    		  	<p><a href="<%=lg_verify_page%>" title="<%=lg_phrase_logout_continue%>"><%=lg_phrase_logout_continue%></a></p>
    		  	<% Else %>
    		  	<p><a href="<%=lg_verify_page%>"><%=lg_phrase_logout_continue%></a></p>
  	  		  	<% End If %>
  		  		</div>
    		<% End If %>
  			</div>