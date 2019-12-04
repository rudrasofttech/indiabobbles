<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

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
            <div class="col-sm-8">

                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41;">Register</h1>
                <p>
                    All fields are mandatory. If you wish to recieve IndiaBobbles newsletter choose
                            "Newsletter".
                </p>
                <form runat="server" id="MainForm">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <uc1:message ID="message1" Visible="false" runat="server" />
                    <div class="form-group">
                        <label for="<%: EmailTextBox.ClientID %>">
                            Email</label>
                        <asp:TextBox CssClass="form-control" ID="EmailTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator><asp:CustomValidator
                                ID="CustomValidator1" CssClass="validate" ControlToValidate="EmailTextBox" ValidationGroup="logingrp"
                                Display="Dynamic" runat="server" ErrorMessage="Duplicate Email, please try different address"
                                OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="EmailTextBox"
                            CssClass="validate" ValidationGroup="logingrp" Display="Dynamic" ErrorMessage="Invalid Email"
                            SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                    </div>
                    <div class="form-group">
                        <label for="<%: NameTextBox.ClientID %>">
                            First Name</label>

                        <asp:TextBox CssClass="form-control" ID="NameTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="NameTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                    </div>
                    <div class="checkbox">

                        <label>
                            <asp:CheckBox ID="NewsletterCheckBox" Checked="true" runat="server" />
                            Newsletter
                        </label>

                    </div>

                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />

                </form>

            </div>
        </div>
    </div>
</asp:Content>
