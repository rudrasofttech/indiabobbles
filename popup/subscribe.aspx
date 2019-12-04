<%@ Page Language="C#" AutoEventWireup="true" CodeFile="subscribe.aspx.cs" Inherits="popup_subscribe" %>

<%@ Register Src="~/control/message.ascx" TagPrefix="uc1" TagName="message" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" type="text/css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" type="text/javascript"></script>
    <style>
        body{
            background-image:url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12" style="background-color:#330B41; color:#fff; padding-bottom:20px;">
                <h1 style="font-family:'Spongeboy Me Bob';">Subscribe & Get Rs.200 Off</h1>
                <br />
                <form id="form1" runat="server">
                    <uc1:message runat="server" Heading="" HideClose="true" ID="message" Visible="false" />
                    <div class="form-group">
                        <label for="txtEmail">Email address</label>
                        <asp:TextBox ID="txtEmail" AutoCompleteType="Email" ClientIDMode="Static" MaxLength="255" placeholder="Email" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ValidationGroup="subscribegrp"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="subscribegrp"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtName">Name</label>
                        <asp:TextBox ID="txtName" AutoCompleteType="FirstName" ClientIDMode="Static" MaxLength="255" placeholder="Name" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="txtName" Display="Dynamic" ForeColor="Red" ValidationGroup="subscribegrp"></asp:RequiredFieldValidator>
                    </div>

                    <asp:CheckBox ID="CheckBox1" runat="server" TextAlign="Right" Text="You are allowing us to send you india bobbles product related emails. We promise that your email address will not be shared with any third party." />
                    <br />
                    <asp:Button ID="btnSubmit" runat="server" Text="Subscribe" CssClass="btn btn-primary" ValidationGroup="subscribegrp" OnClick="btnSubmit_Click" />
                </form>
            </div>
        </div>

    </div>
    <script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
        m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-421743-7', 'indiabobbles.com');
    ga('send', 'pageview');

</script>

</body>
</html>
