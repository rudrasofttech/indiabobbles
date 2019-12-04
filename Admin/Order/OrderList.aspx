<%@ Page Title="Order List" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="Admin_OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>Order List
            </h1>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:DropDownList ID="StatusDropDown" runat="server" AutoPostBack="True">
                        <asp:ListItem Text="New" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Process" Value="2"></asp:ListItem>
                        <asp:ListItem Text="CardPaid" Value="3" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="CODPaid" Value="4"></asp:ListItem>
                        <asp:ListItem Text="Shipped" Value="5"></asp:ListItem>
                        <asp:ListItem Text="Complete" Value="6"></asp:ListItem>
                        <asp:ListItem Text="Refund" Value="7"></asp:ListItem>
                        <asp:ListItem Text="Deleted" Value="8"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="OrderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>" SelectCommand="SELECT O.ID, O.DateCreated, O.Name, O.Email, O.Phone, O.BillingAddress, O.BillingCity, O.MemberID, O.BillingState, O.BillingCountry, O.BillingZip, O.ShippingAddress, O.ShippingCity, O.ShippingState, O.ShippingCountry, O.ShippingZip, O.Coupon, O.Status, O.ShippingTrackCode, O.DateModified, O.Amount, O.Tax, O.Discount, O.Total, O.TransactionCode, O.TransactionDate, O.ShippingPrice, COUNT(OI.ID) AS ItemCount FROM [Order] AS O INNER JOIN OrderItem AS OI ON O.ID = OI.OrderID GROUP BY O.ID, O.DateCreated, O.Name, O.Email, O.Phone, O.BillingAddress, O.BillingCity, O.MemberID, O.BillingState, O.BillingCountry, O.BillingZip, O.ShippingAddress, O.ShippingCity, O.ShippingState, O.ShippingCountry, O.ShippingZip, O.Coupon, O.Status, O.ShippingTrackCode, O.DateModified, O.Amount, O.Tax, O.Discount, O.Total, O.TransactionCode, O.TransactionDate, O.ShippingPrice HAVING (O.Status = @status) ORDER BY O.DateCreated DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="StatusDropDown" Name="status" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <div class="control-group">

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="OrderDataSource" AllowSorting="True" CssClass="table table-striped table-bordered table-condensed" PageSize="30" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No Orders Found." OnRowCommand="GridView1_RowCommand" EnableSortingAndPagingCallbacks="True">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" OnClientClick="return confirm('Are you sure you want to remove this order?');" runat="server" CausesValidation="false" CommandArgument='<%# Eval("ID") %>' CommandName="Remove" Text="Remove"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:HyperLinkField DataNavigateUrlFields="ID" Target="_blank" DataNavigateUrlFormatString="manageorder.aspx?orderid={0}" Text="View" />
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                <asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="DateCreated" DataFormatString="{0:d MMM yyyy h:m tt}" />
                                <asp:BoundField DataField="ItemCount" HeaderText="Item Count" ReadOnly="True" SortExpression="ItemCount" />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />

                                <asp:TemplateField ShowHeader="False" HeaderText="Email">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# string.Format("../sendmail.aspx?email={0}&name={1}", DataBinder.Eval(Container.DataItem, "Email"), DataBinder.Eval(Container.DataItem, "Name")) %>'><%# DataBinder.Eval(Container.DataItem, "Email") %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                                <asp:BoundField DataField="MemberID" HeaderText="MemberID" SortExpression="MemberID" />
                                <asp:BoundField DataField="ShippingAddress" HeaderText="Shipping Address" SortExpression="ShippingAddress" />
                                <asp:BoundField DataField="ShippingCity" HeaderText="Shipping City" SortExpression="ShippingCity" />
                                <asp:BoundField DataField="ShippingState" HeaderText="Shipping State" SortExpression="ShippingState" />
                                <asp:BoundField DataField="ShippingZip" HeaderText="Shipping Zip" SortExpression="ShippingZip" />
                                <asp:BoundField DataField="Coupon" HeaderText="Coupon" SortExpression="Coupon" />
                                <asp:BoundField DataField="ShippingTrackCode" HeaderText="TrackCode" SortExpression="ShippingTrackCode" />
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:##00.00}" />
                                <asp:BoundField DataField="TransactionCode" HeaderText="Transaction Code" SortExpression="TransactionCode" />
                                <asp:BoundField DataField="TransactionDate" HeaderText="Transaction Date" SortExpression="TransactionDate" DataFormatString="{0:d MMM yyyy h:m tt}" />

                            </Columns>
                            <PagerSettings Position="TopAndBottom" />
                        </asp:GridView>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>

