<%
'* alpha 0.5a debug
'* $Id$
%>
			<!-- HTML 4.01 Strict -->
			<div id="login-system">
			<h1><strong>Welcome</strong></h1>
          	<p><% If Session("login") Then Response.Write("<a href=""logout.asp"">"& lg_term_log_out &"</a>&nbsp;<a href=""change_password.asp"">"& lg_term_change_password &"</a>&nbsp;<a href=""cancel_account.asp"">"& lg_term_cancel_account &"</a>") Else Response.Write("<a href=""login.asp"">"& lg_term_login &"</a>") End If %></p>
			<p>This site was created to demonstrate incorporating the Login System into your web site design. This demonstration site is using the XHTML templates and ASP.</p>
            <p>Every web site can be conceptualized as a template. Common sections of a web page template might include a banner, navigation, a main content area, and maybe a footer with links to Terms Of Use, Copyright details, and the Privacy Policy.&nbsp; </p>
            <p>The area where you are now reading in the &quot;Main Content Area&quot; of this page.&nbsp; This is the area where you will insert the (X)HTML mark-up templates that enable the Login System.&nbsp; Feel free to click the login link above, register and test the login system as implemented. This is a working beta test site and certain features may or not be implemented while you are testing.</p>
			<p>Visit the project home on Google Code at: <a title="Login System on Google Code" href="http://code.google.com/p/loginsystem-rd/">http://code.google.com/p/loginsystem-rd/</a>.</p>
			<p>Or visit various demo pages in a number of world languages at the <a title="Web Login Project" href="http://www.webloginproject.com/index.php">Web Login Project</a> demonstration and test site.</p>
			</div>
