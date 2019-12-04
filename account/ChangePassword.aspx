<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="account_ChangePassword" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        body {
            background-image: url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container" style="background-color: white; padding: 10%;">
        <div class="row">
            <div class="col-sm-offset-3 col-sm-6">
                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41;">Change Password</h1>
                <form runat="server" id="MainForm">

                    <uc1:message ID="message1" Visible="false" runat="server" />
                    <div class="form-group">
                        <label for="<%: OldPasswordTextBox.ClientID %>">
                            Old Password</label>
                        <div class="controls">
                            <asp:TextBox CssClass="form-control" ID="OldPasswordTextBox" TextMode="Password"
                                MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="EmailReqVal"
                                    runat="server" Display="Dynamic" ControlToValidate="OldPasswordTextBox" CssClass="validate"
                                    ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="<%: NewPasswordTextBox.ClientID %>">
                            New Password</label>
                        <div class="controls">
                            <asp:TextBox CssClass="form-control" ID="NewPasswordTextBox" TextMode="Password"
                                MaxLength="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                    runat="server" Display="Dynamic" ControlToValidate="NewPasswordTextBox" CssClass="validate"
                                    ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <asp:Button ID="SubmitButton" class="btn btn-default" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />

                </form>
            </div>
        </div>
    </div>

</asp:Content>
