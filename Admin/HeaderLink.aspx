<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="HeaderLink.aspx.cs" Inherits="Admin_HeaderLink" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="span12">
        <h1>Header Link</h1>
            <fieldset>
                <legend>
                    <asp:Literal ID="HeadingLiteral" runat="server">Add</asp:Literal></legend>
                <div class="control-group">
                    <label class="control-label" for="<%: UrlTextBox.ClientID %>">
                        URL</label>
                    <div class="controls">
                        <asp:TextBox ID="UrlTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UrlNameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="UrlTextBox" runat="server" ErrorMessage="Required" 
                            CssClass="validate" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="UrlTextBox" CssClass="validate" Display="Dynamic" 
                            ErrorMessage="Invalid URL" SetFocusOnError="True" 
                            ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" 
                            ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator></div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Title</label>
                    <div class="controls">
                        <asp:TextBox ID="TitleTextBox" MaxLength="100" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TextTextBox.ClientID %>">
                        Text</label>
                    <div class="controls">
                        <asp:TextBox ID="TextTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="TextTextBox" runat="server" 
                            ErrorMessage="Required" CssClass="validate" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TargetDropDown.ClientID %>">
                        Target</label>
                    <div class="controls">
                        <asp:DropDownList ID="TargetDropDown" runat="server">
                            <asp:ListItem Text="Empty" Selected="True" Value=""></asp:ListItem>
                            <asp:ListItem Text="_blank" Value="_blank"></asp:ListItem>
                            <asp:ListItem Text="_parent" Value="_parent"></asp:ListItem>
                            <asp:ListItem Text="_self" Value="_self"></asp:ListItem>
                            <asp:ListItem Text="_top" Value="_top"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: ParentDropDown.ClientID %>">
                        Parent Link</label>
                    <div class="controls">
                        <asp:DropDownList ID="ParentDropDown" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: SequenceTextBox.ClientID %>">
                        Sequence</label>
                    <div class="controls">
                        <asp:TextBox ID="SequenceTextBox" MaxLength="3" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="SequenceTextBox" runat="server" 
                            ErrorMessage="Required" CssClass="validate" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                            ControlToValidate="SequenceTextBox" CssClass="validate" Display="Dynamic" 
                            ErrorMessage="1 - 100 only" MaximumValue="100" MinimumValue="1" 
                            SetFocusOnError="True" Type="Integer" ValidationGroup="CategoryGrp"></asp:RangeValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary" runat="server" Text="Save"
                        OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <h2>
                Link</h2>
            <asp:GridView ID="LinkGrid" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                GridLines="None" runat="server" EmptyDataText="No Header Link">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" 
                        SortExpression="ID" />
                    <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Text" HeaderText="Text" SortExpression="Text" />
                    <asp:BoundField DataField="Target" HeaderText="Target" 
                        SortExpression="Target" />
                    <asp:BoundField DataField="ParentID" HeaderText="Parent" SortExpression="Parent" />
                    <asp:BoundField DataField="Sequence" HeaderText="Sequence" SortExpression="Sequence" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID" 
                        DataNavigateUrlFormatString="headerlink.aspx?id={0}&amp;mode=edit" 
                        Text="Edit" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                NavigateUrl='<%# Eval("ID", "headerlink.aspx?id={0}&mode=delete") %>' 
                                Text="Delete" onclick="return confirm('Are you sure you want to delete this link?');"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

