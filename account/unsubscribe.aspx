<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="unsubscribe.aspx.cs" Inherits="account_unsubscribe" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <section id="subintro">
        <div class="container">
            <div class="row">
                <div class="span8">
                    <ul class="breadcrumb">
                        <li><a href="http://www.indiabobbles.com"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
                        <li class="active">Unsubscribe</li>
                    </ul>
                </div>
                <div class="span4">
                    <div class="search">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section id="maincontent">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="span7" style="padding-left: 10px; padding-right: 10px;">
                        <h1>Unsubscribe</h1>
                        <p>
                            You will not recieve our newsletter after you unsubscribe. Your account will be
                active and you can logon anytime.
                <br />
                            Please do provide your geniune feedback.
                        </p>
                        <form runat="server" id="MainForm" class="form-horizontal">
                            <fieldset>
                                <legend>Few Details</legend>
                                <uc1:message ID="message1" Visible="false" runat="server" />
                                <div class="control-group">
                                    <label class="control-label" for="<%: EmailTextBox.ClientID %>">
                                        Email</label>
                                    <div class="controls">
                                        <asp:TextBox CssClass="input-xlarge" ID="EmailTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator1" ValidationGroup="logingrp" runat="server" ControlToValidate="EmailTextBox"
                                            Display="Dynamic" CssClass="validate" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="EmailTextBox"
                                            ValidationGroup="logingrp" Display="Dynamic" CssClass="validate" runat="server"
                                            ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="<%: ReasonDropDown.ClientID %>">
                                        Reason</label>
                                    <div class="controls">
                                        <asp:DropDownList ID="ReasonDropDown" runat="server">
                                            <asp:ListItem Value="Trying out">I Was Only Trying Out</asp:ListItem>
                                            <asp:ListItem Value="Inappropriate Newsletter Content">Inappropriate Newsletter Content</asp:ListItem>
                                            <asp:ListItem Value="Did Not Found What I Was Looking For">Did Not Found What I Was Looking For</asp:ListItem>
                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="<%: CommentTextBox.ClientID %>">
                                        Comments</label>
                                    <div class="controls">
                                        <asp:TextBox CssClass="input-xlarge" ID="CommentTextBox" TextMode="MultiLine" Rows="6"
                                            runat="server"></asp:TextBox>
                                        <p>
                                            Your comments are valuable to us, they help us improve ourself. Please do give a
                            genuine comment. We would really appreciate that.
                                        </p>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <asp:Button ID="SubmitButton" class="btn" ValidationGroup="logingrp" runat="server"
                                        Text="Submit" OnClick="SubmitButton_Click" />
                                    <a style="padding-left: 20px;" href="../default" class="btn btn-primary">Cancel</a>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
