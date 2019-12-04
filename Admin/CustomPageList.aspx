<%@ Page Title="Custom Page List" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="CustomPageList.aspx.cs" Inherits="Admin_CustomPageList" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CustomPageSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>" SelectCommand="SELECT M.MemberName AS CreatedBy, CP.ID, CP.Name, CP.DateCreated, CP.DateModified, PS.Name AS Status, CP.Sitemap FROM CustomPage AS CP INNER JOIN Member AS M ON CP.CreatedBy = M.ID INNER JOIN PostStatus AS PS ON CP.Status = PS.ID WHERE (CP.Status = @Status)">
        <SelectParameters>
            <asp:ControlParameter ControlID="StatusDropDown" Name="Status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="UserIDHidden" runat="server" />
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Page List</h1>
            <uc1:message ID="message1" runat="server" Visible="false" EnableViewState="false" />
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Value="1">Draft</asp:ListItem>
                            <asp:ListItem Selected="True" Value="2">Publish</asp:ListItem>
                            <asp:ListItem Value="3">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Filter"
                        OnClick="SubmitButton_Click" />
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:GridView ID="PageGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered table-condensed" DataKeyNames="ID"
                DataMember="DefaultView" DataSourceID="CustomPageSource" GridLines="None" EmptyDataText="No Page found"
                OnRowCommand="PageGridView_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False"
                        ReadOnly="True" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy" />
                    <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated"
                        DataFormatString="{0:d MMM y}" />
                    <asp:BoundField DataField="DateModified" HeaderText="DateModified" SortExpression="DateModified"
                        DataFormatString="{0:d MMM y}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:CheckBoxField DataField="Sitemap" HeaderText="Sitemap" SortExpression="Sitemap" ReadOnly="true" />
                    <asp:TemplateField ShowHeader="False" HeaderText="Viewed">
                        <ItemTemplate>
                            <a class="viewed" target="_blank" href='<%# string.Format("http://vtracker.rudrasofttech.com/report/WebpagePublicStats?id=2&path={0}{1}", HttpContext.Current.Server.UrlEncode("http://www.indiabobbles.com/"), DataBinder.Eval(Container.DataItem, "Name")) %>'
                                vhref='<%# string.Format("http://www.indiabobbles.com/{0}", DataBinder.Eval(Container.DataItem, "Name")) %>'></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="ManageCustomPage.aspx?id={0}&amp;mode=edit"
                        Text="Edit" />
                    <asp:HyperLinkField DataNavigateUrlFields="Name" Target="_blank" DataNavigateUrlFormatString="../{0}?preview=true"
                        Text="View" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandArgument='<%# Eval("ID") %>'
                                CommandName="DeleteCommand" Text='Delete' OnClientClick="return confirm('Are you sure you want to delete this page?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NextPrevious" NextPageText="Next"
                    PageButtonCount="30" Position="TopAndBottom" PreviousPageText="Previous" />
                <PagerStyle CssClass="pager" />
            </asp:GridView>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".viewed").each(function () {
                var ele = $(this);
                $.get("../handlers/visitsinfo.ashx?u=" + encodeURI(ele.attr("vhref")), function (data) { ele.html(data); });
            });
        });
    </script>
</asp:Content>
