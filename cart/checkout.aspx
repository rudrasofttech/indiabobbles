<%@ Page Title="Check Out" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="cart_checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        label {
            display: inline-block;
            margin-left: 20px;
        }

        body {
            background-image: url(//www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }

        h4, h5 {
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <div class="row" style="background-color: white; padding: 10%;">
            <div class="col-sm-12">
                <h1>Checkout</h1>
                <form id="form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div class="table-responsive">
                        <asp:GridView ID="CartGridView" EmptyDataText="You don't have any items in your cart." runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
                            <Columns>
                                <asp:ImageField DataAlternateTextField="ProductName" ControlStyle-Height="80px" DataImageUrlField="ProductImg">
                                    <ControlStyle Height="80px" />
                                    <ItemStyle Height="80px" />
                                </asp:ImageField>
                                <asp:BoundField DataField="ProductName" HeaderText="Name" />
                                <asp:BoundField DataField="ProductCode" HeaderText="Code" ReadOnly="True" SortExpression="ProductCode" />
                                <asp:TemplateField HeaderText="Quantity" SortExpression="Quantity">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Style="margin-left: 10px; margin-right: 10px;" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" DataFormatString="{0:#0.00}" SortExpression="Price" />
                                <asp:BoundField DataField="Amount" DataFormatString="{0:#0.00}" HeaderText="Amount" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-inline">
                                <asp:TextBox ID="CouponTextBox" placeholder="Coupon Code" CssClass="form-contro" MaxLength="100" runat="server"></asp:TextBox>
                                <asp:Button ID="ApplyButton" runat="server" CausesValidation="false" CssClass="btn btn-default" Text="Apply" OnClick="ApplyButton_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <h4>Billing Address</h4>
                            <address>
                                <%= o.Name %>, <%= o.Phone %><br />
                                <%= o.Email %><br />
                                <%= o.BillingAddress %><br />
                                <%= o.BillingCity %><br />
                                <%= o.BillingState %>, <%= o.BillingZip %><br />
                                <%= o.BillingCountry %>
                            </address>
                        </div>
                        <div class="col-sm-4">
                            <h4>Shipping Address</h4>
                            <address>
                                <%= o.ShippingFirstName %> <%= o.ShippingLastName %><br />
                                <%= o.ShippingPhone %>
                                <%= o.ShippingAddress %><br />
                                <%= o.ShippingCity %><br />
                                <%= o.ShippingState %>, <%= o.ShippingZip %><br />
                                <%= o.ShippingCountry %>
                            </address>
                            <a href="<%=Page.ResolveClientUrl("~/cart/address.aspx") %>" class="btn btn-mini btn-default"><strong>Change Address</strong></a>
                        </div>
                        <div class="col-sm-4">
                            <table style="width: 100%;">
                                <tr>
                                    <td align="right">
                                        <h5>Sub Total</h5>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h5><%= o.Amount.ToString("##00.00") %></h5>
                                    </td>
                                </tr>
                                <% if (o.Coupon.Trim() != "")
                                   { %>
                                <tr>
                                    <td align="right">
                                        <h5>Coupon Code</h5>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h5>
                                            <%= o.Coupon%></h5>
                                    </td>
                                </tr>
                                <%} %>
                                <% if (o.Discount > 0)
                                   { %>
                                <tr>
                                    <td align="right">
                                        <h5>Discount</h5>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h5>
                                            <%= o.Discount.ToString("##00.00") %></h5>
                                    </td>
                                </tr>
                                <% } %>
                                <tr>
                                    <td align="right">
                                        <h5>Shipping Fee</h5>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h5>
                                            <%= o.ShippingPrice.ToString("##00.00") %></h5>
                                    </td>
                                </tr>
                                <%if (o.PaymentMode == "COD")
                                  { %>
                                <tr>
                                    <td align="right">
                                        <h5>Cash On Delivery Fee</h5>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h5><%= o.COD.ToString("##00.00") %></h5>

                                    </td>
                                </tr>
                                <% } %>
                                <tr>
                                    <td align="right">
                                        <h4>Total</h4>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <h4>
                                            <%= o.Total.ToString("##00.00") %></h4>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 hidden-xs">
                            <p>We use PAYUMONEY for online credit card/debit card payments.</p>
                            <img src="<%= Page.ResolveClientUrl("~/theme/img/payupaisa.jpg") %>" style="margin-top: 10px; height: 120px;" />
                        </div>
                        <div class="col-sm-6" style="text-align: right;">
                            <asp:ImageButton ID="PayCCBtn" CausesValidation="false" runat="server" ImageUrl="~/theme/img/Paynow.png" OnClick="PayCCBtn_Click" />
                            <br />
                            <br />
                            <asp:Button ID="BuyNowButton" runat="server" Visible="false" Text="Pay via Cash On Delivery" CausesValidation="false" CssClass="btn btn-default" OnClick="BuyNowButton_Click" ValidationGroup="ConfirmGrp" />
                            <br />
                            <asp:Label ID="CODFeeInfoLabel" runat="server" Visible="false" Text=""></asp:Label>
                        </div>
                    </div>
                </form>

            </div>
        </div>

    </div>
</asp:Content>

