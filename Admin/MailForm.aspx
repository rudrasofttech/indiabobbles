<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MailForm.aspx.cs" Inherits="Admin_MailForm" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mail Form</title>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }

        .sidebar-nav {
            padding: 9px 0;
        }

        .validate {
            color: Red;
        }
    </style>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span6">
                <form id="form1" runat="server" role="form">
                    <uc1:message ID="message1" Visible="false" EnableViewState="false" runat="server" />
                    <div class="form-group">
                        <label>
                            To Email</label>
                        <asp:TextBox CssClass="form-control span12" ID="ToTextBox" MaxLength="255" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="ToTextBox" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="mailgrp"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email" ControlToValidate="ToTextBox" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="mailgrp"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label>To Name</label>
                        <asp:TextBox CssClass="form-control span12" ID="TonameTextBox" MaxLength="255" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Subject</label>
                        <asp:TextBox CssClass="form-control span12" ID="SubjectTextBox" runat="server">Daku Sambhar Singh Amazon and eBay Link</asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="SubjectTextBox" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="mailgrp"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Message</label>
                        <asp:TextBox CssClass="form-control span12" ID="MessageTextBox" Rows="20" Columns="70" TextMode="MultiLine" runat="server">Hello,

As per our telephonic conversation here are amazon and eBay link to buy Daku Sambhar Singh Bobblehead.

Amazon link
&lt;a target=&quot;_blank&quot; href=&quot;http://www.amazon.in/dp/B00LDLXISG&quot;&gt;http://www.amazon.in/dp/B00LDLXISG&lt;/a&gt;

eBay Links

&lt;a target=&quot;_blank&quot; href=&quot;http://www.ebay.in/itm/171381299907&quot;&gt;http://www.ebay.in/itm/171381299907&lt;/a&gt;

&lt;a target=&quot;_blank&quot; href=&quot;http://www.ebay.in/itm/171371729921&quot;&gt;
http://www.ebay.in/itm/171371729921&lt;/a&gt;

Your order will be shipped as soon as you confirm it.

Thanks,
Preeti Singh
9871500276
9999159341
&lt;a href=&quot;http://www.indiabobbles.com&quot;&gt;India Bobbles&lt;/a&gt;</asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required" ControlToValidate="MessageTextBox" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="mailgrp"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Button ID="SendButton" runat="server" Text="Send Mail" CssClass="btn btn-default" ValidationGroup="mailgrp" OnClick="SendButton_Click" />
                </form>
            </div>
        </div>
    </div>
</body>
</html>
