<%
'* alpha 0.4 debug
'* $Id$
%>
			<!-- XHTML 1.1 Strict -->
			<div id="login-system">
			<% 
			If lg_password_min_bits>0 Then 
				Response.Write("<script type=""text/javascript"">var e=" & lg_password_min_bits & ";</script>" & vbLF)
				Response.Write("<script type=""text/javascript"">document.write(unescape('%3C%73%63%72%69%70%74%20%6C%61%6E%67%75%61%67%65%3D%22%6A%61%76%61%73%63%72%69%70%74%22%3E%66%75%6E%63%74%69%6F%6E%20%64%46%28%73%29%7B%76%61%72%20%73%31%3D%75%6E%65%73%63%61%70%65%28%73%2E%73%75%62%73%74%72%28%30%2C%73%2E%6C%65%6E%67%74%68%2D%31%29%29%3B%20%76%61%72%20%74%3D%27%27%3B%66%6F%72%28%69%3D%30%3B%69%3C%73%31%2E%6C%65%6E%67%74%68%3B%69%2B%2B%29%74%2B%3D%53%74%72%69%6E%67%2E%66%72%6F%6D%43%68%61%72%43%6F%64%65%28%73%31%2E%63%68%61%72%43%6F%64%65%41%74%28%69%29%2D%73%2E%73%75%62%73%74%72%28%73%2E%6C%65%6E%67%74%68%2D%31%2C%31%29%29%3B%64%6F%63%75%6D%65%6E%74%2E%77%72%69%74%65%28%75%6E%65%73%63%61%70%65%28%74%29%29%3B%7D%3C%2F%73%63%72%69%70%74%3E'));dF('%286Fvfulsw%2853w%7Csh%286G%2855wh%7Bw2mdydvfulsw%2855%286H%283Dydu%2853o%2853%286G%2853%2855defghijklmnopqrstuvwxyz%7B%7C%7D%2855%286E%283Dydu%2853x%2853%286G%2853%2855DEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%2855%286E%283Dydu%2853v%2853%286G%2853%2855%28%3AH%2893%2854C%2856%2857%2858%288H%2859-%285%3B%285%3C0b.%286G%2855%286E%283Dydu%2853g%2853%286G%2853%2855456789%3A%3B%3C3%2855%286E%283D%283Dydu%2853h4%286GPdwk1iorru%285%3Bh-31999%3A%285%3C%286E%283Dydu%2853h5%286GPdwk1iorru%285%3Bh-316667%285%3C%286E%283Dydu%2853wf%2853%286G%2853%3C8%286E%283Dydu%2853of%2853%286G%2853o1ohqjwk%286E%283Dydu%2853xf%2853%286G%2853x1ohqjwk%286E%283Dydu%2853vf%2853%286G%2853v1ohqjwk%286E%283Dydu%2853gf%2853%286G%2853g1ohqjwk%286E%283Dydu%2853rf%2853%286G%2853wf0%285%3Bof.xf.vf.gf%285%3C%286E%283D%283Dixqfwlrq%2853%7D%285%3Bs%285%3C%2853%28%3AE%283D%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1ydoxh%2853%286G%2853s%286E%283D%283%3Cli%2853%285%3Bs%286G%286G%285%3Avwurqj%285%3A%285%3C%283D%283%3C%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1vw%7Coh1edfnjurxqgFroru%286G%285%3A%285633FF33%285%3A%286E%283D%283%3Chovh%2853li%2853%285%3Bs%286G%286G%285%3Aphglxp%285%3A%285%3C%283D%283%3C%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1vw%7Coh1edfnjurxqgFroru%286G%285%3A%2856IIII33%285%3A%286E%283D%283%3Chovh%2853li%2853%285%3Bs%286G%286G%285%3Aidlu%285%3A%285%3C%283D%283%3C%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1vw%7Coh1edfnjurxqgFroru%286G%285%3A%2856IIFF33%285%3A%286E%283D%283%3Chovh%2853li%2853%285%3Bs%286G%286G%285%3Asrru%285%3A%285%3C%283D%283%3C%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1vw%7Coh1edfnjurxqgFroru%286G%285%3A%2856II3333%285%3A%286E%283D%283%3Chovh%283D%283%3C%283%3Cgrfxphqw1jhwHohphqwE%7CLg%285%3B%285%3Auhvxowv%285%3A%285%3C1vw%7Coh1edfnjurxqgFroru%286G%285%3A%2856IIIIII%285%3A%286E%283%3C%283D%28%3AG%283D%283Dixqfwlrq%2853j%285%3Bs%285%3C%2853%28%3AE%283D%2853%2853%2853%2853li%2853%285%3Bs1ohqjwk%2853%286F%28533%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853uhwxuq%28533%286E%283D%2853%2853%2853%2853%28%3AG%283D%283D%2853%2853%2853%2853ydu%2853ko%2853%286G%2853idovh%286E%283D%2853%2853%2853%2853ydu%2853kx%2853%286G%2853idovh%286E%283D%2853%2853%2853%2853ydu%2853kv%2853%286G%2853idovh%286E%283D%2853%2853%2853%2853ydu%2853kg%2853%286G%2853idovh%286E%283D%2853%2853%2853%2853ydu%2853kr%2853%286G%2853idovh%286E%283D%2853%2853%2853%2853ydu%2853u%2853%286G%28533%286E%283D%283D%2853%2853%2853%285322ydu%2853f%286Gqhz%2853Duud%7C%285%3B%285%3C%286E%283D%283D%2853%2853%2853%2853iru%2853%285%3Bydu%2853l%2853%286G%28533%286E%2853l%2853%286F%2853s1ohqjwk%286E%2853l..%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853ydu%2853f%2853%286G%2853s1fkduDw%285%3Bl%285%3C%286E%283D%283D%2853%2853%2853%2853%2853%2853%2853%2853li%2853%285%3Bo1lqgh%7BRi%285%3Bf%285%3C%2854%286G04%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853ko%2853%286G%2853wuxh%286E%283D%2853%2853%2853%2853%2853%2853%2853%2853hovh%2853li%2853%285%3Bx1lqgh%7BRi%285%3Bf%285%3C%2854%286G04%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853kx%2853%286G%2853wuxh%286E%283D%2853%2853%2853%2853%2853%2853%2853%2853hovh%2853li%2853%285%3Bg1lqgh%7BRi%285%3Bf%285%3C%2854%286G04%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853kg%2853%286G%2853wuxh%286E%283D%2853%2853%2853%2853%2853%2853%2853%2853hovh%2853li%2853%285%3Bv1lqgh%7BRi%285%3Bf%285%3C%2854%286G04%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853kv%2853%286G%2853wuxh%286E%283D%2853%2853%2853%2853%2853%2853%2853%2853hovh%283D%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853%2853kr%2853%286G%2853wuxh%286E%283D%283D%2853%2853%2853%2853%28%3AG%283D%283D%2853%2853%2853%283D%2853%2853%2853%2853li%2853%285%3Bko%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853u%2853.%286G%2853of%286E%283D%2853%2853%2853%2853li%2853%285%3Bkx%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853u%2853.%286G%2853xf%286E%283D%2853%2853%2853%2853li%2853%285%3Bkg%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853u%2853.%286G%2853gf%286E%283D%2853%2853%2853%2853li%2853%285%3Bkv%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853u%2853.%286G%2853vf%286E%283D%2853%2853%2853%2853li%2853%285%3Bkr%285%3C%283D%2853%2853%2853%2853%2853%2853%2853%2853u%2853.%286G%2853rf%286E%283D%283D%2853%2853%2853%2853ydu%2853e%2853%286G%2853Pdwk1orj%285%3Bu%285%3C-%285%3Bs1ohqjwk%28532%2853Pdwk1orj%285%3B5%285%3C%285%3C%286E%283D%2853%2853%2853%2853%283D%2853%2853%2853%2853uhwxuq%2853Pdwk1iorru%285%3Be%285%3C%286E%283D%28%3AG%283D%283D%283Dixqfwlrq%2853%7C%285%3Bs%285%3C%2853%28%3AE%283D%2853%2853%2853%2853ydu%2853e%2853%286G%2853j%285%3Bs%285%3C%286E%283D%283D%2853%2853%2853%2853li%2853%285%3Be%2853%286H%286G%2853h%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853%7D%285%3B%285%3Avwurqj%285%3A%285%3C%286E%283D%2853%2853%2853%2853%28%3AG%283D%2853%2853%2853%2853hovh%2853li%2853%285%3Be%2853%286F%2853h%2853%2859%2859%2853e%2853%286H%286G%2853h4%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853%7D%285%3B%285%3Aphglxp%285%3A%285%3C%286E%283D%2853%2853%2853%2853%28%3AG%283D%2853%2853%2853%2853hovh%2853li%2853%285%3Be%286Fh4%2853%2859%2859%2853e%286H%286Gh5%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853%7D%285%3B%285%3Aidlu%285%3A%285%3C%286E%283D%2853%2853%2853%2853%28%3AG%283D%2853%2853%2853%2853hovh%2853li%2853%285%3Be%286Fh5%285%3C%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853%7D%285%3B%285%3Asrru%285%3A%285%3C%286E%283D%2853%2853%2853%2853%28%3AG%283D%2853%2853%2853%2853hovh%2853%28%3AE%283D%2853%2853%2853%2853%2853%2853%2853%2853%7D%285%3B%285%3Avwuhqjwk%2853phwhu%285%3A%285%3C%286E%283D%2853%2853%2853%2853%28%3AG%283D%28%3AG%283D%286F2vfulsw%286H3')</script>" & vbLF)
			End If
			%>
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
                <input id="password" name="password" title="<%=lg_phrase_password_title%>" type="password" size="20" maxlength="255" <% If lg_password_min_bits>0 Then Response.Write("onkeyup=""y(this.value);"" ") End If %>autocomplete="off" />
                <span class="field_normal"><%=lg_term_required%></span><br />
                <% If lg_password_min_bits>0 Then %>
					<style type="text/css">#results { text-align:center; font-size:x-small; height:10px; }</style>
					<input id="results" name="results" title="Password Strength" type="text" size="20" maxlength="255" autocomplete="off" value="Strength Meter" /><br />
				<% End If %>
				<% 
				If lg_term_remember Then
                	Response.Write("<label for=""remember"">" & lg_term_rememberme & "</label>")
                	Response.Write("<input id=""remember"" name=""remember"" type=""checkbox"" value=""Yes""")
                	If remember="Yes" Then
                		Response.Write(" checked")
                	End If
                	Response.Write(" /><br />")
                	Response.Write("<div id=""remember_me_warning"">" & lg_phrase_remember_me_warning & "</div>")
                End If
                %>	
                <input type="hidden" id="destination" name="destination" value="<%=destination%>" /><br />
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