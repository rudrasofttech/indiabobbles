<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="SendMail.aspx.cs" Inherits="Admin_SendMail" %>

<%@ Import Namespace="IndiaBobbles.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Send Mail</h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <fieldset>
                <legend></legend>
                <div class="control-group">
                    <label class="control-label">
                        Send To Email:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="ToEmailTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="ToEmailTextBox" runat="server" ErrorMessage="Required" CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Sent To Name:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="ToNameTextBox" MaxLength="200" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Sent By Email:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="FromEmailTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="FromEmailTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Send By Name:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="FromNameTextBox" MaxLength="200" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Type:
                    </label>
                    <div class="controls">
                        <asp:DropDownList ID="ETypeList" runat="server">
                            <asp:ListItem Value="3">Newsletter</asp:ListItem>
                            <asp:ListItem Value="5">Reminder</asp:ListItem>
                            <asp:ListItem Value="6">Communication</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Group:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="EGroupTextBox" MaxLength="50" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Subject:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SubjectTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="SubjectTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Message:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="MessageTextBox" TextMode="MultiLine" Rows="10" Style="width: 100%;"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="MessageTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                        runat="server" Text="Send Mail" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
