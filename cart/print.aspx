<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print.aspx.cs" Inherits="cart_print" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%= Utility.GetSiteSetting("CommonHeadContent")%>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <table class="table table-condensed">
                    <tr>
                        <td class="col-sm-4">
                            <h5>Ship To:</h5>
                            <address>
                                <strong><%: o.ShippingFirstName %> <%: o.ShippingLastName %>, <%: o.ShippingPhone %></strong>
                                <br />
                                <%= o.ShippingAddress %>, <%= o.ShippingCity %><br />
                                <%= o.ShippingState %>, <%= o.ShippingCountry %><br />
                                <%=o.ShippingZip %>
                            </address>
                            <strong>Payment Mode: <%= (o.PaymentMode.ToLower() == "cc"? "PRE PAID" : o.PaymentMode) %></strong><br />
                            <strong>Total Amount: <%= o.Total.ToString("###0.00") %></strong>
                        </td>
                        <td class="col-sm-7" style="text-align: left; padding-left: 20px; padding-top: 20px;">
                            <% if (BarCodeImagePath != string.Empty)
                               { %>
                            <img src="<%=BarCodeImagePath %>" style="height: 100px;" />
                            <%} %>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row" style="margin-bottom: 0px;">
            <div class="col-sm-12">
                <h3>Order Number: <%= o.ID %></h3>
                Seller Name: Rudra Softtech LLP | Order Date: <%= o.DateCreated.ToShortDateString() %> | <%if (o.ShippingService != "")
                                                                                                           { %>
                Shipping Service: <%= o.ShippingService %> |
                <%} %>
                <% if (o.ShippingTrackCode != "")
                   { %>
                Tracking Code: <%= o.ShippingTrackCode %> |
                <%} %>
                <%if (o.TransactionCode != "")
                  { %>
                Transaction Code: <%=o.TransactionCode %>
                <%} %>
                <table class="table table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>Name
                            </th>
                            <th>Code
                            </th>
                            <th>Quantity
                            </th>
                            <th>Price
                            </th>
                            <th>Amount
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach (OrderItem item in o.OrderItems)
                          {
                        %>
                        <tr>
                            <td><%= item.ProductName %></td>
                            <td><%= item.ProductCode %></td>
                            <td><%= item.Quantity %></td>
                            <td><%= item.Price.ToString("###0.00") %></td>
                            <td><%= item.Amount.ToString("###0.00") %></td>
                        </tr>
                        <%
                          } %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Sub Total</td>
                            <td><%= o.Amount.ToString("###0.00") %></td>
                        </tr>
                        <% if (o.Coupon != "")
                           { %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Coupon</td>
                            <td><%= o.Coupon %></td>
                        </tr>
                        <%} %>
                        <% if (o.Discount > 0)
                           { %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Discount</td>
                            <td>- <%= o.Discount.ToString("###0.00") %></td>
                        </tr>
                        <%} %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Shipping Fee</td>
                            <td><%= o.ShippingPrice.ToString("###0.00") %></td>
                        </tr>
                        <%if (o.PaymentMode == "COD" && o.COD > 0)
                          { %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Cash on Delivery Fee</td>
                            <td><%= o.COD.ToString("###0.00") %></td>
                        </tr>
                        <%} %>
                        <tr>
                            <td colspan="4" style="text-align: right;">Total</td>
                            <td><%= o.Total.ToString("###0.00") %></td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>
        <div class="row" style="margin-bottom: 0px;">
            <div class="col-sm-4">
                <h3>Shipping Address:</h3>
                <address>
                    <strong><%: o.ShippingFirstName %> <%: o.ShippingLastName %>, <%: o.ShippingPhone %></strong>
                    <br />
                    <%= o.ShippingAddress %>, <%= o.ShippingCity %><br />
                    <%= o.ShippingState %>, <%= o.ShippingCountry %><br />
                    <%=o.ShippingZip %>
                </address>

            </div>
            <div class="col-sm-4">
                <h3>Billing Address:</h3>
                <address>
                    <strong><%: o.Name %>, <%: o.Phone %></strong>
                    <br />
                    <%= o.BillingAddress %>, <%= o.BillingCity %><br />
                    <%= o.BillingState %>, <%= o.BillingCountry %><br />
                    <%=o.BillingZip %>
                </address>
            </div>
            <div class="col-sm-4">
            </div>
        </div>
        <p>Thanks for your Purchase. If you have any question please contact us at preeti@indiabobbles.com or call us at 9871500276. Please provide your order id.</p>
    </div>
</body>
</html>
