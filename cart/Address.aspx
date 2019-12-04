<%@ Page Title="Order Address" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="address.aspx.cs" Inherits="cart_Address" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        body{
            background-image:url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
    <div class="container" style="background-color: white; padding: 10%;">
        <div class="row">
            <div class="col-sm-12">
                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41; text-align: center">Billing & Shipping Address</h1>
                <br />
                <form id="form2" runat="server">
                    <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-6">
                                    <h4>Shipping Information
                                    </h4>
                                    <br />

                                    <div class="form-group">
                                        <label for="ShippingFirstNameTextBox">First Name*</label>
                                        <asp:TextBox ID="ShippingFirstNameTextBox" ClientIDMode="Static" MaxLength="50" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="ShippingFirstNameTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingLastNameTextBox">Last Name*</label>
                                        <asp:TextBox ID="ShippingLastNameTextBox" ClientIDMode="Static" MaxLength="50" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingPhoneTextBox">Phone*</label>
                                        <asp:TextBox ID="ShippingPhoneTextBox" ClientIDMode="Static" MaxLength="15" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="ShippingPhoneTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingAddressTextBox">Address*</label>
                                        <asp:TextBox ID="ShippingAddressTextBox" ClientIDMode="Static" MaxLength="900" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="ShippingAddressTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingCityTextBox">City*</label>
                                        <asp:TextBox ID="ShippingCityTextBox" ClientIDMode="Static" MaxLength="100" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="ShippingCityTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingStateDropDown">State*</label><br />
                                        <asp:DropDownList ID="ShippingStateDropDown" ClientIDMode="Static" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="Andaman and Nicobar Islands">Andaman and Nicobar Islands
                                            </asp:ListItem>
                                            <asp:ListItem Value="Andhra Pradesh">Andhra Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Arunachal Pradesh">Arunachal Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Assam">Assam
                                            </asp:ListItem>
                                            <asp:ListItem Value="Bihar">Bihar
                                            </asp:ListItem>
                                            <asp:ListItem Value="Chandigarh">Chandigarh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Chhattisgarh">Chhattisgarh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Dadra and Nagar Haveli">Dadra and Nagar Haveli
                                            </asp:ListItem>
                                            <asp:ListItem Value="Daman and Diu">Daman and Diu
                                            </asp:ListItem>
                                            <asp:ListItem Value="National Capital Territory of Delhi" Selected="selected">National Capital Territory of Delhi
                                            </asp:ListItem>
                                            <asp:ListItem Value="Goa">Goa
                                            </asp:ListItem>
                                            <asp:ListItem Value="Gujarat">Gujarat
                                            </asp:ListItem>
                                            <asp:ListItem Value="Haryana">Haryana
                                            </asp:ListItem>
                                            <asp:ListItem Value="Himachal Pradesh">Himachal Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Jammu and Kashmir">Jammu and Kashmir
                                            </asp:ListItem>
                                            <asp:ListItem Value="Jharkhand">Jharkhand
                                            </asp:ListItem>
                                            <asp:ListItem Value="Karnataka">Karnataka
                                            </asp:ListItem>
                                            <asp:ListItem Value="Kerala">Kerala
                                            </asp:ListItem>
                                            <asp:ListItem Value="Lakshadweep">Lakshadweep
                                            </asp:ListItem>
                                            <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Maharashtra">Maharashtra
                                            </asp:ListItem>
                                            <asp:ListItem Value="Manipur">Manipur
                                            </asp:ListItem>
                                            <asp:ListItem Value="Meghalaya">Meghalaya
                                            </asp:ListItem>
                                            <asp:ListItem Value="Mizoram">Mizoram
                                            </asp:ListItem>
                                            <asp:ListItem Value="Nagaland">Nagaland
                                            </asp:ListItem>
                                            <asp:ListItem Value="Odisha">Odisha
                                            </asp:ListItem>
                                            <asp:ListItem Value="Puducherry">Puducherry
                                            </asp:ListItem>
                                            <asp:ListItem Value="Punjab">Punjab
                                            </asp:ListItem>
                                            <asp:ListItem Value="Rajasthan">Rajasthan
                                            </asp:ListItem>
                                            <asp:ListItem Value="Sikkim">Sikkim
                                            </asp:ListItem>
                                            <asp:ListItem Value="Tamil Nadu">Tamil Nadu
                                            </asp:ListItem>
                                            <asp:ListItem Value="Tripura">Tripura
                                            </asp:ListItem>
                                            <asp:ListItem Value="Uttar Pradesh">Uttar Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Uttarakhand">Uttarakhand
                                            </asp:ListItem>
                                            <asp:ListItem Value="West Bengal">West Bengal
                                            </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingPincodeTextBox">Pincode*</label>
                                        <asp:TextBox ID="ShippingPincodeTextBox" ClientIDMode="Static" MaxLength="15"  CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="ShippingPincodeTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="ShippingCountryDropDown">Country*</label>
                                        <asp:DropDownList ID="ShippingCountryDropDown" ClientIDMode="Static" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="India">India</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <h4>Billing Information 
                                        <asp:Button ID="CopyBillingButton" runat="server" CausesValidation="false" Text="Copy Shipping Address" CssClass="btn btn-toolbar btn-sm" OnClick="CopyBillingButton_Click" />
                                    </h4>
                                    <br />

                                    <div class="form-group">
                                        <label for="NameTextBox">Full Name*</label>
                                        <asp:TextBox ID="NameTextBox" ClientIDMode="Static" MaxLength="100" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="NameTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="EmailTextBox">Email*</label>
                                        <asp:TextBox ID="EmailTextBox" ClientIDMode="Static" MaxLength="250" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email" ControlToValidate="EmailTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ValidationGroup="addressgrp" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="EmailTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="PhoneTextBox">Phone*</label>
                                        <asp:TextBox ID="PhoneTextBox" ClientIDMode="Static" MaxLength="15" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="PhoneTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="BillingAddressTextBox">Address*</label>
                                        <asp:TextBox ID="BillingAddressTextBox" ClientIDMode="Static" MaxLength="900" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="BillingAddressTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="BillingCityTextBox">City*</label>
                                        <asp:TextBox ID="BillingCityTextBox" ClientIDMode="Static" MaxLength="100" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="BillingCityTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="BillingStateDropDown">State*</label><br />
                                        <asp:DropDownList ID="BillingStateDropDown" ClientIDMode="Static" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="Andaman and Nicobar Islands">Andaman and Nicobar Islands
                                            </asp:ListItem>
                                            <asp:ListItem Value="Andhra Pradesh">Andhra Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Arunachal Pradesh">Arunachal Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Assam">Assam
                                            </asp:ListItem>
                                            <asp:ListItem Value="Bihar">Bihar
                                            </asp:ListItem>
                                            <asp:ListItem Value="Chandigarh">Chandigarh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Chhattisgarh">Chhattisgarh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Dadra and Nagar Haveli">Dadra and Nagar Haveli
                                            </asp:ListItem>
                                            <asp:ListItem Value="Daman and Diu">Daman and Diu
                                            </asp:ListItem>
                                            <asp:ListItem Value="National Capital Territory of Delhi" Selected="True">National Capital Territory of Delhi
                                            </asp:ListItem>
                                            <asp:ListItem Value="Goa">Goa
                                            </asp:ListItem>
                                            <asp:ListItem Value="Gujarat">Gujarat
                                            </asp:ListItem>
                                            <asp:ListItem Value="Haryana">Haryana
                                            </asp:ListItem>
                                            <asp:ListItem Value="Himachal Pradesh">Himachal Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Jammu and Kashmir">Jammu and Kashmir
                                            </asp:ListItem>
                                            <asp:ListItem Value="Jharkhand">Jharkhand
                                            </asp:ListItem>
                                            <asp:ListItem Value="Karnataka">Karnataka
                                            </asp:ListItem>
                                            <asp:ListItem Value="Kerala">Kerala
                                            </asp:ListItem>
                                            <asp:ListItem Value="Lakshadweep">Lakshadweep
                                            </asp:ListItem>
                                            <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Maharashtra">Maharashtra
                                            </asp:ListItem>
                                            <asp:ListItem Value="Manipur">Manipur
                                            </asp:ListItem>
                                            <asp:ListItem Value="Meghalaya">Meghalaya
                                            </asp:ListItem>
                                            <asp:ListItem Value="Mizoram">Mizoram
                                            </asp:ListItem>
                                            <asp:ListItem Value="Nagaland">Nagaland
                                            </asp:ListItem>
                                            <asp:ListItem Value="Odisha">Odisha
                                            </asp:ListItem>
                                            <asp:ListItem Value="Puducherry">Puducherry
                                            </asp:ListItem>
                                            <asp:ListItem Value="Punjab">Punjab
                                            </asp:ListItem>
                                            <asp:ListItem Value="Rajasthan">Rajasthan
                                            </asp:ListItem>
                                            <asp:ListItem Value="Sikkim">Sikkim
                                            </asp:ListItem>
                                            <asp:ListItem Value="Tamil Nadu">Tamil Nadu
                                            </asp:ListItem>
                                            <asp:ListItem Value="Tripura">Tripura
                                            </asp:ListItem>
                                            <asp:ListItem Value="Uttar Pradesh">Uttar Pradesh
                                            </asp:ListItem>
                                            <asp:ListItem Value="Uttarakhand">Uttarakhand
                                            </asp:ListItem>
                                            <asp:ListItem Value="West Bengal">West Bengal
                                            </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="BillingPincodeTextBox">Pincode*</label>
                                        <asp:TextBox ID="BillingPincodeTextBox" ClientIDMode="Static" MaxLength="15" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="BillingPincodeTextBox" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" runat="server" ValidationGroup="addressgrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="BillingCountryDropDown">Country*</label>
                                        <asp:DropDownList ID="BillingCountryDropDown" CssClass="form-control" ClientIDMode="Static" runat="server">
                                            <asp:ListItem Value="India">India</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 center" >
                                    <asp:Button ID="SaveButton" ValidationGroup="addressgrp" CssClass="btn btn-primary btn-large" runat="server" Text="Save & Checkout" OnClick="SaveButton_Click" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </div>
        </div>
    </div>
</asp:Content>

