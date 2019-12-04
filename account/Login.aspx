<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        body{
            background-image:url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container" style="background-color: white; padding: 10% 0px;">
        <div class="row">
            <div class="col-md-offset-3 col-md-6">
                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41; text-align: center">Login</h1>
                <form runat="server" id="MainForm" class="form-horizontal">
                    <uc1:message ID="message1" Visible="false" runat="server" />
                    <h5>Email and Password both are mandatory. If you want to preserve login please choose
                        "Remember Me" option.
                    </h5>
                    <div class="form-group">
                        <label for="<%: EmailTextBox.ClientID %>">
                            Email</label>
                        <asp:TextBox CssClass="form-control" ID="EmailTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="EmailReqVal" runat="server" Display="Dynamic" ForeColor="Red" ControlToValidate="EmailTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <label for="<%: PasswordTextBox.ClientID %>">
                            Password</label>

                        <asp:TextBox CssClass="form-control" ID="PasswordTextBox" TextMode="Password" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1" runat="server"  ForeColor="Red" ControlToValidate="PasswordTextBox"
                            Display="Dynamic" CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                    </div>
                    <div class="checkbox">
                        <label class="checkbox">
                            <asp:CheckBox ID="RememberCheckBox" runat="server" />
                            Remember Me
                        </label>
                    </div>

                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Login" OnClick="SubmitButton_Click" />

                </form>
            </div>
        </div>
    </div>
</asp:Content>
