<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="orderlist.aspx.cs" Inherits="cart_orderlist" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Search Order</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        body {
            background-image: url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
    <div class="container">
        <div class="row " style="background-color: white; padding: 10%;">
            <div class="col-sm-12">
                <form id="form2" runat="server">
                    <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41; text-align: center">Order</h1>
                    <p style="text-align: center">Search your previous orders by Order Id or your email or your phone.</p>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <asp:TextBox ID="KeywordTextBox" placeholder="Order ID or Email or Phone" CssClass="form-control" MaxLength="100" runat="server"></asp:TextBox>

                            <span class="input-group-btn">
                                <asp:Button ID="SearchButton" runat="server" CausesValidation="false" CssClass="btn btn-default" Text="Search" OnClick="SearchButton_Click" />
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-12" style="margin-top: 20px;">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Contact</th>
                                    <th>Shipping Address</th>
                                    <th>Item Count</th>
                                    <th>Order Total</th>
                                    <th>Date</th>
                                    <th>Payment mode</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%foreach (Order o in OrderList)
                                  { %>
                                <tr>
                                    <td><a href="receipt.aspx?id=<%= o.ID %>" target="_blank">Receipt</a> </td>
                                    <td><%= o.ID %></td>
                                    <td><%= o.Name %></td>
                                    <td><%= o.Email %><br />
                                        <%= o.Phone %></td>
                                    <td><%= o.ShippingAddress %></td>
                                    <td><%= o.OrderItems.Count %></td>
                                    <td><%= o.Total.ToString("##00.00") %></td>
                                    <td><%= o.DateCreated.ToShortDateString() %></td>
                                    <td><%= o.PaymentMode%></td>
                                </tr>
                                <%} %>
                                <%if (OrderList.Count == 0)
                                  { %>
                                <tr>
                                    <td colspan="9">No Orders Here.
                                    </td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>

</asp:Content>

