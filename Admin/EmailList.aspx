<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="EmailList.aspx.cs" Inherits="Admin_EmailList" %>

<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>"
                SelectCommand="SELECT DISTINCT [EmailGroup] FROM [EmailMessage]"></asp:SqlDataSource>
            <h1>Emails</h1>
            <fieldset>
                <legend>Filter</legend>
                <div class="control-group">
                    <label class="control-label" for="<%: TypeDropDown.ClientID %>">
                        Find Anywhere</label>
                    <div class="controls">
                        <asp:TextBox ID="KeywordTextBox" MaxLength="200" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TypeDropDown.ClientID %>">
                        Type</label>
                    <div class="controls">
                        <asp:DropDownList ID="TypeDropDown" runat="server">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Activation</asp:ListItem>
                            <asp:ListItem Value="2">Unsubscribe</asp:ListItem>
                            <asp:ListItem Value="3">Newsletter</asp:ListItem>
                            <asp:ListItem Value="4">ChangePassword</asp:ListItem>
                            <asp:ListItem Value="5">Reminder</asp:ListItem>
                            <asp:ListItem Value="6">Communication</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: GroupDropDown.ClientID %>">
                        Group</label>
                    <div class="controls">
                        <asp:DropDownList ID="GroupDropDown" runat="server"
                            DataSourceID="SqlDataSource1" DataTextField="EmailGroup"
                            DataValueField="EmailGroup">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: SentDropDown.ClientID %>">
                        Sent</label>
                    <div class="controls">
                        <asp:DropDownList ID="SentDropDown" runat="server">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: ReadDropDown.ClientID %>">
                        Read</label>
                    <div class="controls">
                        <asp:DropDownList ID="ReadDropDown" runat="server">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Filter"
                        OnClick="SubmitButton_Click" />

                    <asp:Button ID="DeleteButton" runat="server" Text="Remove" OnClientClick="return confirm('You are about to delete emails, are you sure?')" CssClass="btn pull-right"
                        CausesValidation="false" OnClick="DeleteButton_Click"  />
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:GridView ID="EmailGrid" AllowPaging="True" PageSize="100"
                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                GridLines="None" runat="server" DataKeyNames="ID"
                OnPageIndexChanging="EmailGrid_PageIndexChanging" EmptyDataText="No Data Found.">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <input type="checkbox" id="selectchk" onchange="onSelectCheck();" /> Select
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbSelect" CssClass="gridCB" runat="server"></asp:CheckBox>
                            <asp:Literal ID="EmailIDLt" Text='<%# Eval("ID") %>' Visible="false" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="ID" HeaderText="Email" DataNavigateUrlFormatString="~/account/email/{0}" Text="View" Target="_blank" />
                    <asp:BoundField DataField="ToAddress" HeaderText="ToAddress" SortExpression="ToAddress" />
                    <asp:BoundField DataField="LastAttempt" HeaderText="LastAttempt" SortExpression="Attempt"
                        DataFormatString="{0:d MMM y}" />
                    <asp:BoundField DataField="ToName" HeaderText="ToName" SortExpression="To" />
                    <asp:BoundField DataField="ReadDate" DataFormatString="{0:d MMM y}" HeaderText="Read"
                        SortExpression="ReadDate" />
                    <asp:BoundField DataField="EmailGroup" HeaderText="EmailGroup" SortExpression="EmailGroup" />
                    <asp:CheckBoxField DataField="IsSent" HeaderText="IsSent" SortExpression="IsSent" />
                    <asp:CheckBoxField DataField="IsRead" HeaderText="IsRead" SortExpression="IsRead" />
                    <asp:BoundField DataField="CreateDate" DataFormatString="{0:d MMM y}" HeaderText="Create"
                        SortExpression="CreateDate" />
                    <asp:BoundField DataField="SentDate" DataFormatString="{0:d MMM y}" HeaderText="Sent"
                        SortExpression="SentDate" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink2" runat="server"
                                NavigateUrl='<%# Eval("ID", "SendMail.aspx?emailid={0}") %>'
                                Text="Mail"></asp:HyperLink>
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
