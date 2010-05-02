<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Register.aspx.vb" Inherits="Login_System.Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="content-language" content="en-US" />
    <meta name="language" content="en-US" />
    <meta name="author" content="Roderick Divilbiss" />
    <meta name="copyright" content="&copy; 2010 EE Collaborative Login Project http://www.webloginproject.com" />
    <style type="text/css">
        #details
        {
            font-family: Courier New;
            font-size: 10pt;
            border: 1px solid #000000;
            padding: 10px;
            background-color: #FFE2C6;
        }
        #message
        {
            font-size: 10pt;
            padding: 10px;
            background-color: #FFFFCC;
            border: 1px solid #000000;
        }
        #warning
        {
            font-size: 10pt;
            font-weight: bold;
            padding: 10px;
            background-color: #FFFFCC;
            color: #FF0000;
            border: 1px solid #FF0000;
        }
    </style>
    <title><%=PageTitle()%></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="login-system">
        <div id="message"><%=Message%></div>
        <fieldset>
            <legend><%=PageTitle()%></legend>
            
            <asp:Label ID="Label1" runat="server" Text="<%$ Resources:loginGlobals,lg_term_userid %>" AssociatedControlID="userid"></asp:Label><br />
            <asp:TextBox ID="userid" runat="server"></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="<%$ Resources:loginGlobals,lg_term_required %>">"></asp:Label>
            <asp:RequiredFieldValidator ID="ReqValidUserID" runat="server" ErrorMessage="*" 
               ControlToValidate="userid"></asp:RequiredFieldValidator><br />

            <asp:Label ID="Label3" runat="server" Text="<%$ Resources:loginGlobals,lg_term_password %>" AssociatedControlID="password"></asp:Label><br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <asp:Label ID="Label4" runat="server" Text="<%$ Resources:loginGlobals,lg_term_required %>"></asp:Label>
            <asp:RequiredFieldValidator ID="ReqValidPassword" runat="server" ErrorMessage="*"
                ControlToValidate="password"></asp:RequiredFieldValidator><br />

            <asp:Label ID="Label5" runat="server" Text="<%$ Resources:loginGlobals,lg_term_confirm %>" AssociatedControlID="confirm"></asp:Label><br />
            <asp:TextBox ID="confirm" runat="server"></asp:TextBox>
            <asp:Label ID="Label6" runat="server" Text="<%$ Resources:loginGlobals,lg_term_required %>"></asp:Label>
            <asp:RequiredFieldValidator ID="ReqValidConfirm" runat="server" ErrorMessage="*"
                ControlToValidate="confirm"></asp:RequiredFieldValidator><br />

            <asp:Label ID="Label7" runat="server" Text="<%$ Resources:loginGlobals,lg_term_email %>" AssociatedControlID="email"></asp:Label><br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
            <asp:Label ID="Label8" runat="server" Text="<%$ Resources:loginGlobals,lg_term_required %>"></asp:Label>
            <asp:RequiredFieldValidator ID="ReqValidEmail" runat="server" ErrorMessage="*" 
               ControlToValidate="email"></asp:RequiredFieldValidator><br />
            
            <asp:Label ID="Label9" runat="server" Text="<%$ Resources:loginGlobals,lg_term_name %>" AssociatedControlID="name"></asp:Label><br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <asp:Label ID="Label10" runat="server" Text="<%$ Resources:loginGlobals,lg_term_required %>"></asp:Label>
            <asp:RequiredFieldValidator ID="ReqValidName" runat="server" ErrorMessage="*" 
               ControlToValidate="name"></asp:RequiredFieldValidator><br />

            <asp:Label ID="Label11" runat="server" Text="<%$ Resources:loginGlobals,lg_term_website_address %>" AssociatedControlID="website_address"></asp:Label><br />
            <asp:TextBox ID="website_address" runat="server"></asp:TextBox>
            <asp:Label ID="Label12" runat="server" Text="<%$ Resources:loginGlobals,lg_term_optional %>"></asp:Label><br />

            <asp:CheckBox ID="news" runat="server" Text="<%$ Resources:loginGlobals,lg_phrase_news %>" /><br />
            
            <asp:Button ID="cmdSubmit" runat="server" Text="<%$ Resources:loginGlobals,lg_register_button_text %>" />
        </fieldset>
    </div>
       
    </form>
</body>
</html>
