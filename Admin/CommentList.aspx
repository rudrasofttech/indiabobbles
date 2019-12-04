<%@ Page Title="Comment List" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="CommentList.aspx.cs" Inherits="Admin_CommentList" %>
    <%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CommentDataSource" runat="server" ConflictDetection="OverwriteChanges"
        ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" DeleteCommand="DELETE FROM PageComment WHERE (ID = @ID)"
        
    SelectCommand="SELECT PC.ID, PC.MemberID, PC.Name, PC.Email, PC.Website, PC.MessageText, PC.CreateDate, PC.Status, PC.ModifiedBy, PC.ModifyDate, PC.Note, PC.ParentId, PC.URL, PC.CommentType, PS.Name AS StatusName FROM PageComment AS PC INNER JOIN PostStatus AS PS ON PC.Status = PS.ID ORDER BY PC.CreateDate DESC" 
    UpdateCommand="UPDATE PageComment SET Status = 2 WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="CommentGridView" Name="ID" 
                PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="CommentGridView" Name="ID" 
                PropertyName="SelectedValue" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Comment List</h1>
            <asp:GridView ID="CommentGridView" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CssClass="table table-bordered" DataKeyNames="ID"
                DataSourceID="CommentDataSource" PageSize="20" 
                EmptyDataText="No Comments Posted" onrowcommand="CommentGridView_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Details" SortExpression="Name">
                        <ItemTemplate>
                            Name: <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label><br />
                            Email: <asp:Label ID="Label2" runat="server" Text='<%# Bind("Email") %>'></asp:Label><br />
                            Website: <asp:Label ID="Label3" runat="server" Text='<%# Bind("Website") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comment" SortExpression="Name">
                        <ItemTemplate>
                            URL: <asp:Label ID="Label4" runat="server" Text='<%# Bind("URL") %>'></asp:Label><br />
                            <div>
                                <asp:Literal ID="Label5" runat="server" Text='<%# Bind("MessageText") %>'></asp:Literal>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CreateDate" HeaderText="Date" SortExpression="CreateDate" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <div>
                                <asp:Literal ID="Label6" runat="server" Text='<%# Bind("StatusName") %>'></asp:Literal>
                            </div>
                            <asp:LinkButton ID="LinkButton1" Style="padding-right: 10px;" runat="server" CausesValidation="false"
                                CommandName="Update" CommandArgument='<%# Eval("ID") %>' Text='Approve' Visible='<%# (DataBinder.Eval(Container.DataItem, "Status").ToString() == ((byte)PostStatusType.Draft).ToString()) %>'></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2"  runat="server" CausesValidation="false"
                                CommandName="Delete" CommandArgument='<%# Eval("ID") %>' Text='Delete' OnClientClick="return confirm('Are you sure you want to delete this comment?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings Position="TopAndBottom" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
