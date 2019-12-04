<%@ Page Title="Order Receipt" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="receipt.aspx.cs" Inherits="cart_receipt" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>Order Receipt</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        body {
            background-image: url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
    </style>
    <div class="container">
        <div class="row" style="background-color: white; padding: 10%;">
            <div class="col-sm-12">
                <a href="print.aspx?id=<%= o.ID %>" target="_blank" class="pull-right">Print</a>
                <h1>Order Number: <%= o.ID %></h1>

                <div class="row">
                    <div class="col-sm-4">
                        <h3>Ship To:</h3>
                        <address>
                            <strong><%: string.Format("{0} {1}", o.ShippingFirstName, o.ShippingLastName) %>, <%: o.ShippingPhone %></strong>
                            <br />
                            <%= o.ShippingAddress %>, <%= o.ShippingCity %><br />
                            <%= o.ShippingState %>, <%= o.ShippingCountry %><br />
                            <%=o.ShippingZip %>
                        </address>
                        <strong>Payment Mode: <%= (o.PaymentMode.ToLower() == "cc"? "PRE PAID" : o.PaymentMode) %></strong><br />
                        <strong>Total Amount: <%= o.Total.ToString("###0.00") %></strong>
                    </div>
                    <div class="col-sm-3">
                        Seller Name: Rudra Softtech LLP<br />
                        Order Date: <%= o.DateCreated.ToShortDateString() %><br />
                        Order Status: <%=(OrderStatusType)Enum.Parse(typeof(OrderStatusType), o.Status.ToString()) %><br />
                        <%if (o.ShippingService != "")
                          { %>
                Shipping Service: <%= o.ShippingService %><br />
                        <%} %>
                        <% if (o.ShippingTrackCode != "")
                           { %>
                Tracking Code: <%= o.ShippingTrackCode %><%} %>
                        <%if (o.TransactionCode != "")
                          { %>
                Transaction Code: <%=o.TransactionCode %>
                        <%} %>
                    </div>
                    <div class="col-sm-5">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <table class="table table-bordered">
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
                                <tr>
                                    <td colspan="4" style="text-align: right;">Discount</td>
                                    <td>- <%= o.Discount.ToString("###0.00") %></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="text-align: right;">Shipping Fee</td>
                                    <td><%= o.ShippingPrice.ToString("###0.00") %></td>
                                </tr>
                                <%if (o.PaymentMode == "COD")
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
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <h3>Shipping Address:</h3>
                        <address>
                            <strong><%: o.Name %>, <%: o.Phone %></strong>
                            <br />
                            <%= o.ShippingAddress %>, <%= o.ShippingCity %><br />
                            <%= o.ShippingState %>, <%= o.ShippingCountry %><br />
                            <%=o.ShippingZip %>
                        </address>

                    </div>
                    <div class="col-sm-4">
                        <h3>Billing Address:</h3>
                        <address>
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
        </div>
    </div>

    <script type="text/javascript">
        /* <![CDATA[ */
        var google_conversion_id = 1050939950;
        var google_conversion_language = "en";
        var google_conversion_format = "3";
        var google_conversion_color = "ffffff";
        var google_conversion_label = "PuSqCO2-lFsQrqSQ9QM";
        var google_remarketing_only = false;
        /* ]]> */
    </script>
    <script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
    </script>
    <noscript>
        <div style="display: inline;">
            <img height="1" width="1" style="border-style: none;" alt="" src="//www.googleadservices.com/pagead/conversion/1050939950/?label=PuSqCO2-lFsQrqSQ9QM&amp;guid=ON&amp;script=0" />
        </div>
    </noscript>

</asp:Content>

