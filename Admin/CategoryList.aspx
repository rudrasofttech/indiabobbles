<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="CategoryList.aspx.cs" Inherits="Admin_CategoryList" %>

<%@ Register src="../control/message.ascx" tagname="message" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CategorySource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>"
        SelectCommand="SELECT C.ID, C.Name, C.UrlName, P.Name AS Parent, MS.Name AS Status FROM Category AS C LEFT OUTER JOIN MemberStatus AS MS ON C.Status = MS.ID LEFT OUTER JOIN Category AS P ON C.Parent = P.ID"
        DeleteCommand="UPDATE Category SET Status = 2 WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="CategoryView" Name="ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
        <uc1:message ID="message1" runat="server" Visible="false" />
        <h1>Category List</h1>
            <fieldset>
                <legend>
                    <asp:Literal ID="HeadingLiteral" runat="server">Add</asp:Literal></legend>
                <div class="control-group">
                    <label class="control-label" for="<%: NameTextBox.ClientID %>">
                        Name</label>
                    <div class="controls">
                        <asp:TextBox ID="NameTextBox" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="NameTextBox" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: UrlNameTextBox.ClientID %>">
                        Url Name</label>
                    <div class="controls">
                        <asp:TextBox ID="UrlNameTextBox" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UrlNameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="UrlNameTextBox" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: ParentDropDown.ClientID %>">
                        Parent Category</label>
                    <div class="controls">
                        <asp:DropDownList ID="ParentDropDown" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Value="0" Selected="True">Active</asp:ListItem>
                            <asp:ListItem Value="1">Inactive</asp:ListItem>
                            <asp:ListItem Value="2">Deleted</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary" runat="server" 
                        Text="Save" onclick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <h2>
                Category</h2>
            <asp:GridView ID="CategoryView" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                DataMember="DefaultView" DataSourceID="CategorySource" GridLines="None" runat="server"
                DataKeyNames="ID">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="UrlName" HeaderText="UrlName" SortExpression="UrlName" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Parent" HeaderText="Parent" SortExpression="Parent" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID" 
                        DataNavigateUrlFormatString="categorylist.aspx?id={0}&amp;mode=edit" 
                        Text="Edit" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
