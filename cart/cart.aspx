<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="cart_cart" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        body {
            background-image: url(http://www.indiabobbles.com/drive/theme/khichdi/img/India-Bobbles-package-1300.jpg);
        }
        h5{
            font-weight:bold;
        }
    </style>
    <div class="container">
        <div class="row " style="background-color: white; padding: 10%;">
            <div class="col-sm-12">
                <h1 style="font-family: 'Spongeboy Me Bob'; color: #330B41; text-align: center">My Cart</h1>
                <form id="form2" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="CartUpdatePanel" runat="server">
                        <ContentTemplate>

                            <div class="table-responsive">
                                <asp:GridView ID="CartGridView" EmptyDataText="You don't have any items in your cart." runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="CartGridView_RowCommand">
                                <Columns>
                                    <asp:ImageField DataAlternateTextField="ProductName" ControlStyle-Height="80px" DataImageUrlField="ProductImg">
                                        <ControlStyle Height="80px" />
                                        <ItemStyle Height="80px" />
                                    </asp:ImageField>
                                    <asp:BoundField DataField="ProductName" HeaderText="Name" />
                                    <asp:BoundField DataField="ProductCode" HeaderText="Code" ReadOnly="True" SortExpression="ProductCode" />
                                    <asp:TemplateField HeaderText="Quantity" SortExpression="Quantity">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="ReduceButton" runat="server" CausesValidation="false" CssClass="label label-default" CommandName="Subtract" CommandArgument='<%# Bind("ID") %>' Text="-"></asp:LinkButton>
                                            <asp:Label ID="Label1" Style="margin-left: 10px; margin-right: 10px;" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                                            <asp:LinkButton ID="AddButton" runat="server" CausesValidation="false" CssClass="label label-default" CommandName="Add" CommandArgument='<%# Bind("ID") %>' Text="+"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" DataFormatString="{0:#0.00}" SortExpression="Price" />
                                    <asp:BoundField DataField="Amount" DataFormatString="{0:#0.00}" HeaderText="Amount" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="RemoveButton" runat="server" CausesValidation="false" CssClass="label label-info" CommandName="Remove" CommandArgument='<%# Bind("ID") %>' Text="&times"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            </div>
                            
                            <div class="row" id="totaldiv" runat="server">
                                <div class="col-sm-6">
                                    <div class="form-inline">
                                        <asp:TextBox ID="CouponTextBox" placeholder="Coupon Code" CssClass="form-control" MaxLength="100" runat="server"></asp:TextBox>
                                        <asp:Button ID="ApplyButton" runat="server" CausesValidation="false" CssClass="btn btn-default" Text="Apply" OnClick="ApplyButton_Click" />
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td align="right">
                                                <h5>Sub Total</h5>
                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <h5>
                                                    <asp:Literal ID="AmountLabel" runat="server" Text=""></asp:Literal></h5>
                                            </td>
                                        </tr>
                                        <tr id="couponrow" runat="server">
                                            <td align="right">
                                                <h5>Coupon<br />
                                                    <asp:LinkButton ID="RemoveCouponBtn" CausesValidation="false" runat="server" OnClick="RemoveCouponBtn_Click">Remove</asp:LinkButton></h5>

                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <h5>
                                                    <asp:Literal ID="CouponLiteral" runat="server" Text=""></asp:Literal></h5>
                                            </td>
                                        </tr>
                                        <tr id="discountrow" runat="server">
                                            <td align="right">
                                                <h5>Discount</h5>
                                            </td>
                                            <td style="width: 100px; text-align: right;">
                                                <h5>-
                                                        <asp:Literal ID="DiscountLiteral" runat="server" Text=""></asp:Literal></h5>
                                            </td>
                                        </tr>
                                    </table>

                                </div>
                            </div>
                            <div style="margin: 10px 0px;">
                                <a href="http://<%= Request.Url.Host %>" class="btn btn-large btn-default pull-left hidden-xs">Continue Shopping</a>
                                <%if (o.OrderItems.Count > 0)
                                  { %>
                                <a href="<%= Page.ResolveClientUrl("~/cart/address.aspx") %>" class="btn btn-large btn-primary pull-right">Proceed to Checkout</a>
                                <%} %>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </form>
            </div>
        </div>
    </div>


</asp:Content>


