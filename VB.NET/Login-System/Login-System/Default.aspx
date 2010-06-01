<%-- $Id$ --%>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Login_System._Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" title="<%$ Resources:loginGlobals,lg_term_home %>"></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="login-system">
        <h1>
            <strong>Welcome</strong>
        </h1>
        <p>
            <%  If True Then%>
            <asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="Logout.aspx" 
                Text="<%$ Resources:loginGlobals,lg_term_log_out %>"></asp:HyperLink>
            <asp:HyperLink ID="lnkChangePassword" runat="server" NavigateUrl="ChangePassword.aspx"
                Text="<%$ Resources:loginGlobals,lg_term_change_password %>"></asp:HyperLink>
            <asp:HyperLink ID="lnkCancelAccount" runat="server" NavigateUrl="CancelAccount.aspx"
                Text="<%$ Resources:loginGlobals,lg_term_cancel_account %>"></asp:HyperLink>
            <%  Else%>
            <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="Login.aspx" Text="<%$ Resources:loginGlobals,lg_term_login %>"></asp:HyperLink>
            <% End If%></p>
        <p>
            This site was created to demonstrate incorporating the Login System into your web
            site design. This demonstration site is using the XHTML templates and ASP.</p>
        <p>
            Every web site can be conceptualized as a template. Common sections of a web page
            template might include a banner, navigation, a main content area, and maybe a footer
            with links to Terms Of Use, Copyright details, and the Privacy Policy.&nbsp;
        </p>
        <p>
            The area where you are now reading in the &quot;Main Content Area&quot; of this
            page.&nbsp; This is the area where you will insert the (X)HTML mark-up templates
            that enable the Login System.&nbsp; Feel free to click the login link above, register
            and test the login system as implemented. This is a working beta test site and certain
            features may or not be implemented while you are testing.</p>
        <p>
            Visit the project home on Google Code at: <a title="Login System on Google Code"
                href="http://code.google.com/p/loginsystem-rd/">http://code.google.com/p/loginsystem-rd/</a>.</p>
        <p>
            Or visit various demo pages in a number of world languages at the <a title="Web Login Project"
                href="http://www.webloginproject.com/index.php">Web Login Project</a> demonstration
            and test site.</p>
    </div>
    </form>
</body>
</html>
