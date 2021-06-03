<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="MemberList.aspx.cs" Inherits="Admin_MemberList" %>

<%@ Register Src="~/control/message.ascx" TagPrefix="uc1" TagName="message" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>Member List</h1>
            <fieldset>
                <legend>Filter </legend>
                <div class="form-inline">
                    <asp:TextBox ID="FilterTextBox" placeholder="Search with in email" MaxLength="30" runat="server"></asp:TextBox>
                    <asp:DropDownList ID="StatusDropDown" runat="server">
                        <asp:ListItem Value="">--Status--</asp:ListItem>
                        <asp:ListItem Value="0">Active</asp:ListItem>
                        <asp:ListItem Value="2">Deleted</asp:ListItem>
                        <asp:ListItem Value="1">Inactive</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="MemberTypeDropDown" runat="server">
                        <asp:ListItem Value="">--Member Type--</asp:ListItem>
                        <asp:ListItem Value="2">Author</asp:ListItem>
                        <asp:ListItem Value="3">Member</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="SubscribeList" runat="server">
                        <asp:ListItem Value="">--Subscribed--</asp:ListItem>
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                    

                    <asp:Button ID="SubmitButton" runat="server" Text="Filter" CssClass="btn btn-primary"
                        CausesValidation="false" OnClick="SubmitButton_Click" />

                    <asp:Button ID="DeleteButton" runat="server" Text="Remove" OnClientClick="return confirm('You are about to delete members, are you sure?')" CssClass="btn pull-right"
                        CausesValidation="false" OnClick="DeleteButton_Click"  />
                </div>
            </fieldset>
            <br />
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <uc1:message runat="server" ID="message" Visible="false" />
            <asp:GridView ID="MemberGridView" runat="server" AutoGenerateColumns="False" EmptyDataText="No Members Found" AllowPaging="True" CssClass="table table-striped table-bordered table-condensed"
                PageSize="50" OnPageIndexChanging="MemberGridView_PageIndexChanging"
                OnRowDataBound="MemberGridView_RowDataBound" OnRowCommand="MemberGridView_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <input type="checkbox" id="selectchk" onchange="onSelectCheck();" /> Select
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbSelect" CssClass="gridCB" runat="server"></asp:CheckBox>
                            <asp:Literal ID="MemberIDLt" Text='<%# Eval("ID") %>' Visible="false" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                    <asp:BoundField DataField="Createdate" DataFormatString="{0:d MMM y}" HeaderText="Createdate"
                        SortExpression="Createdate" />
                    <asp:CheckBoxField DataField="Newsletter" HeaderText="Newsletter" SortExpression="Newsletter" />
                    <asp:BoundField DataField="UserType" HeaderText="UserType" SortExpression="UserType" />
                    <asp:BoundField DataField="MemberName" HeaderText="MemberName" SortExpression="MemberName" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" runat="server"
                                NavigateUrl='<%# Eval("ID", "managemember.aspx?id={0}&mode=edit") %>'
                                Text="Edit"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink2" runat="server"
                                NavigateUrl='<%# Eval("ID", "SendMail.aspx?id={0}") %>'
                                Text="Mail"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return confirm('You are about to delete a member, be sure?');" CausesValidation="false" CommandName="Remove" CommandArgument='<%# Eval("ID") %>' Text="Remove"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <script>
        function onSelectCheck() {
            if ($('#selectchk').attr('checked') == "checked") {
                $(".gridCB input").attr("checked", "checked");
            } else {
                $(".gridCB input").removeAttr("checked", "checked");
            }
        }
    </script>
</asp:Content>
