<%@ Page Title="Manage Order" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="ManageOrder.aspx.cs" Inherits="Admin_ManageOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>Manage Order
                
                <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="IndiaBobbles.IndiaBobblesDataClassesDataContext" EntityTypeName="" Select="new (ID, ProductImg, ProductName, ProductCode, Quantity, Price, Amount)" TableName="OrderItems" Where="OrderID == @OrderID">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="OrderID" QueryStringField="orderid" Type="Int32" />
                    </WhereParameters>
                </asp:LinqDataSource>

            </h1>
            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="IndiaBobbles.IndiaBobblesDataClassesDataContext" EntityTypeName="" Select="new (ID, DateCreated, Name, Email, MemberID, Phone, BillingAddress, BillingCity, BillingState, BillingCountry, BillingZip, ShippingAddress, ShippingCity, ShippingState, ShippingCountry, ShippingZip, Coupon, Status, ShippingTrackCode, ShippingNotes, DateModified, Amount, Tax, TaxPercentage, Discount, Total, TransactionCode, TransactionDate, TransactionDetail, ShippingPrice, OrderItems, COD, PaymentMode, ShippingService)" TableName="Orders" Where="ID == @ID">
                <WhereParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="orderid" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <div class="row-fluid">
                <div class="span6">
                    <asp:DetailsView ID="OrderDetailView" runat="server" AutoGenerateRows="False" RowStyle-Width="100%" CssClass="table table-striped table-bordered table-condensed" DataSourceID="LinqDataSource1" OnDataBound="OrderDetailView_DataBound">
                        <Fields>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" ReadOnly="True" SortExpression="DateCreated" DataFormatString="{0:d MMM yyyy h:m tt}" />
                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                            <asp:BoundField DataField="MemberID" HeaderText="MemberID" ReadOnly="True" SortExpression="MemberID" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" ReadOnly="True" SortExpression="Phone" />
                            <asp:BoundField DataField="BillingAddress" HeaderText="BillingAddress" ReadOnly="True" SortExpression="BillingAddress" />
                            <asp:BoundField DataField="BillingCity" HeaderText="BillingCity" ReadOnly="True" SortExpression="BillingCity" />
                            <asp:BoundField DataField="BillingState" HeaderText="BillingState" ReadOnly="True" SortExpression="BillingState" />
                            <asp:BoundField DataField="BillingCountry" HeaderText="BillingCountry" ReadOnly="True" SortExpression="BillingCountry" />
                            <asp:BoundField DataField="BillingZip" HeaderText="BillingZip" ReadOnly="True" SortExpression="BillingZip" />
                            <asp:BoundField DataField="ShippingAddress" HeaderText="ShippingAddress" ReadOnly="True" SortExpression="ShippingAddress" />
                            <asp:BoundField DataField="ShippingCity" HeaderText="ShippingCity" ReadOnly="True" SortExpression="ShippingCity" />
                            <asp:BoundField DataField="ShippingState" HeaderText="ShippingState" ReadOnly="True" SortExpression="ShippingState" />
                            <asp:BoundField DataField="ShippingCountry" HeaderText="ShippingCountry" ReadOnly="True" SortExpression="ShippingCountry" />
                            <asp:BoundField DataField="ShippingZip" HeaderText="ShippingZip" ReadOnly="True" SortExpression="ShippingZip" />
                            <asp:BoundField DataField="Coupon" HeaderText="Coupon" ReadOnly="True" SortExpression="Coupon" />
                            <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />
                            <asp:BoundField DataField="ShippingTrackCode" HeaderText="ShippingTrackCode" ReadOnly="True" SortExpression="ShippingTrackCode" />
                            <asp:BoundField DataField="ShippingNotes" HeaderText="ShippingNotes" ReadOnly="True" SortExpression="ShippingNotes" />
                            <asp:BoundField DataField="DateModified" HeaderText="DateModified" ReadOnly="True" SortExpression="DateModified" DataFormatString="{0:d MMM yyyy h:m tt}" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" SortExpression="Amount" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="Tax" HeaderText="Tax" ReadOnly="True" SortExpression="Tax" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="TaxPercentage" HeaderText="TaxPercentage" ReadOnly="True" SortExpression="TaxPercentage" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="Discount" HeaderText="Discount" ReadOnly="True" SortExpression="Discount" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="COD" HeaderText="COD" ReadOnly="True" SortExpression="COD" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="PaymentMode" HeaderText="PaymentMode" ReadOnly="True" SortExpression="PaymentMode" />
                            <asp:BoundField DataField="TransactionCode" HeaderText="TransactionCode" ReadOnly="True" SortExpression="TransactionCode" />
                            <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" ReadOnly="True" SortExpression="TransactionDate" DataFormatString="{0:d MMM yyyy h:m tt}" />
                            <asp:BoundField DataField="TransactionDetail" HeaderText="TransactionDetail" ReadOnly="True" SortExpression="TransactionDetail" Visible="false" />
                            <asp:BoundField DataField="ShippingPrice" HeaderText="ShippingPrice" ReadOnly="True" SortExpression="ShippingPrice" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="ShippingService" HeaderText="ShippingService" ReadOnly="True" SortExpression="ShippingService" />
                        </Fields>
                    </asp:DetailsView>
                </div>
                <div class="span6">
                    <asp:GridView ID="OrderItemGrid" runat="server" CssClass="table table-striped table-bordered table-condensed" AutoGenerateColumns="False" DataSourceID="LinqDataSource2">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                            <asp:ImageField DataImageUrlField="ProductImg" ItemStyle-Height="70px" ControlStyle-Height="70px" HeaderText="Product Img">
                            </asp:ImageField>
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" ReadOnly="True" SortExpression="ProductName" />
                            <asp:BoundField DataField="ProductCode" HeaderText="Product Code" ReadOnly="True" SortExpression="ProductCode" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" SortExpression="Quantity" />
                            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" SortExpression="Price" DataFormatString="{0:##00.00}" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" SortExpression="Amount" DataFormatString="{0:##00.00}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label">Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Text="Process" Value="2" />
                            <asp:ListItem Text="Card by Paid" Value="3" />
                            <asp:ListItem Text="Cash on Delivery" Value="4" />
                            <asp:ListItem Text="Shipped" Value="5" />
                            <asp:ListItem Text="Complete" Value="6" />
                            <asp:ListItem Text="Refund" Value="7" />
                            <asp:ListItem Text="Deleted" Value="8" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Tracking Code</label>
                    <div class="controls">
                        <asp:TextBox ID="TrackTextBox" MaxLength="20" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Shipping Service</label>
                    <div class="controls">
                        <asp:TextBox ID="ShippingServiceTextBox" MaxLength="100" Text="Delhivery" TextMode="SingleLine" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Shipping Notes</label>
                    <div class="controls">
                        <asp:TextBox ID="ShippingNotesTextBox" MaxLength="1000" TextMode="MultiLine" Rows="5" Columns="10" runat="server"></asp:TextBox>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label">Transaction Detail</label>
                    <div class="controls">
                        <asp:TextBox ID="DetailTextBox" MaxLength="2000" TextMode="MultiLine" Rows="5" Columns="10" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Save"
                        OnClick="SubmitButton_Click" />
                    <asp:HyperLink ID="ReceiptLink" Target="_blank" runat="server">Receipt</asp:HyperLink>
                    <asp:Button ID="DeleteButton" CssClass="btn btn-inverse pull-right" runat="server" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this order? Once deleted you wont be able to recover this order?');" OnClick="DeleteButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

