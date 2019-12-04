<%@ Page Title="My Account" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="myaccount.aspx.cs" Inherits="myaccount" %>

<%@ Import Namespace="IndiaBobbles" %>
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
            <div class="col-sm-6">
                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41;">My Account</h1>
                <form runat="server" id="MainForm">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>

                    <uc1:message Visible="false" ID="message1" runat="server" />
                    <div class="form-group">
                        <label>
                            Registered Email
                        </label>

                        <asp:TextBox MaxLength="200" CssClass="form-control" ID="EmailTextBox" ReadOnly="true"
                            runat="server"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <label for="<%: NameTextBox.ClientID %>">
                            First Name (Required)</label>
                        <asp:TextBox MaxLength="200" CssClass="form-control" ID="NameTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="NameReqVal" runat="server" Display="Dynamic" ControlToValidate="NameTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <label for="<%: LastNameTextBox.ClientID %>">
                            Last Name (Required)</label>

                        <asp:TextBox MaxLength="200" CssClass="form-control" ID="LastNameTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="LastNameTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <label for="<%: YearDropDown.ClientID %>">
                            Date of Birth (Required)</label>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="YearDropDown" CssClass="form-control" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="YearDropDown_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Static"
                                    ControlToValidate="YearDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="MonthDropDown" CssClass="form-control" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="MonthDropDown_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Jan</asp:ListItem>
                                    <asp:ListItem Value="2">Feb</asp:ListItem>
                                    <asp:ListItem Value="3">Mar</asp:ListItem>
                                    <asp:ListItem Value="4">Apr</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">Jun</asp:ListItem>
                                    <asp:ListItem Value="7">Jul</asp:ListItem>
                                    <asp:ListItem Value="8">Aug</asp:ListItem>
                                    <asp:ListItem Value="9">Sep</asp:ListItem>
                                    <asp:ListItem Value="10">Oct</asp:ListItem>
                                    <asp:ListItem Value="11">Nov</asp:ListItem>
                                    <asp:ListItem Value="12">Dec</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Static"
                                    ControlToValidate="MonthDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="DateDropDown" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Static"
                                    ControlToValidate="DateDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                    <div class="form-group">
                        <label for="<%: CountryDropDown.ClientID %>">
                            Country (Required)</label>

                        <asp:DropDownList ID="CountryDropDown" CssClass="form-control" runat="server">
                            <asp:ListItem Selected="True" Value="">Country</asp:ListItem>
                            <asp:ListItem Value="IND">India</asp:ListItem>
                            <asp:ListItem Value="USA">United States of America</asp:ListItem>
                            <asp:ListItem Value="CAN">Canada</asp:ListItem>
                            <asp:ListItem Value="GBR">United Kingdom</asp:ListItem>
                            <asp:ListItem Value="AUS">Australia</asp:ListItem>
                            <asp:ListItem Value="IRL">Ireland</asp:ListItem>
                            <asp:ListItem Value="NZL">New Zealand</asp:ListItem>
                            <asp:ListItem Value="DEU">Germany</asp:ListItem>
                            <asp:ListItem Value="MEX">Mexico</asp:ListItem>
                            <asp:ListItem Value="NLD">Netherlands</asp:ListItem>
                            <asp:ListItem Value="NOR">Norway</asp:ListItem>
                            <asp:ListItem Value="DNK">Denmark</asp:ListItem>
                            <asp:ListItem Value="SWE">Sweden</asp:ListItem>
                            <asp:ListItem Value="ROU">Romania</asp:ListItem>
                            <asp:ListItem Value="FRA">France</asp:ListItem>
                            <asp:ListItem Value="ZAF">South Africa</asp:ListItem>
                            <asp:ListItem Value="UAE">United Arab Emirates</asp:ListItem>
                            <asp:ListItem Value="ITA">Italy</asp:ListItem>
                            <asp:ListItem Value="ESP">Spain</asp:ListItem>
                            <asp:ListItem Value="PRT">Portugal</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                            ControlToValidate="CountryDropDown" CssClass="validate" ValidationGroup="logingrp"
                            ErrorMessage="Required" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>
                    <div class="form-group">
                        <label for="<%: GenderDropDown.ClientID %>">
                            Gender</label>

                        <asp:DropDownList ID="GenderDropDown" runat="server">
                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                            <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                        </asp:DropDownList>

                    </div>
                    <div class="checkbox">

                        <label>
                            <asp:CheckBox ID="SubscribeCheckBox" runat="server" />
                            Newsletter Subscription
                        </label>

                    </div>
                    <asp:TextBox ID="AltEmailTextBox" MaxLength="245" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:TextBox ID="AltEmail2TextBox" MaxLength="245" Visible="false" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="form-group">
                        <label for="<%: MobileTextBox.ClientID %>">
                            Mobile (optional)</label>

                        <asp:TextBox ID="MobileTextBox" MaxLength="17" CssClass="form-control" runat="server"></asp:TextBox>

                    </div>
                    <div class="form-group" style="display: none;">
                        <label for="<%: PhoneTextBox.ClientID %>">
                            Phone (optional)</label>

                        <asp:TextBox ID="PhoneTextBox" MaxLength="17" CssClass="form-control" runat="server"></asp:TextBox>

                    </div>
                    <div class="form-group" style="display: none;">
                        <label for="<%: AddressTextBox.ClientID %>">
                            Address (optional)</label>

                        <asp:TextBox ID="AddressTextBox" MaxLength="290" CssClass="form-control" runat="server"></asp:TextBox>

                    </div>

                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Update" OnClick="SubmitButton_Click" />
                    <a class="btn" data-toggle="modal" data-target="#RemoveModal" id="removeaccount">Remove Account</a>


                    <div class="modal fade" tabindex="-1" role="dialog" id="RemoveModal">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">
                                        ×</button>
                                    <h3>Inactivate Account</h3>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Are you sure you want to inactivate your membership account?
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="DeleteButton" class="btn btn-primary" ValidationGroup="logingrp"
                                        runat="server" Text="Yes" OnClick="DeleteButton_Click" />
                                </div>
                            </div>


                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>


</asp:Content>
