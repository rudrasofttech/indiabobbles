<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<%@ Register src="../control/message.ascx" tagname="message" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="ArticleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>" SelectCommand="SELECT P.ID, P.Title, P.DateCreated, P.WriterName, P.Viewed, C.Name AS Category, PS.Name AS Status, P.URL, P.Sitemap FROM Category AS C INNER JOIN Post AS P ON C.ID = P.Category INNER JOIN PostStatus AS PS ON P.Status = PS.ID WHERE (P.Category = @Category) AND (P.Status = @Status)">
        <SelectParameters>
            <asp:ControlParameter ControlID="CategoryDropDown" Name="Category" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="StatusDropDown" Name="Status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>" SelectCommand="SELECT ID, Name FROM Category">
    </asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Article List</h1>
            <uc1:message ID="message1" Visible="false" EnableViewState="false" runat="server" />
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="<%: CategoryDropDown.ClientID %>">
                        Category</label>
                    <div class="controls">
                        <asp:DropDownList ID="CategoryDropDown" runat="server" DataMember="DefaultView" DataSourceID="CategorySource"
                            DataTextField="Name" DataValueField="ID">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
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
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Filter" />
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:GridView ID="ArticleGridView" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                DataKeyNames="ID" DataMember="DefaultView" DataSourceID="ArticleSource" GridLines="None"
                PageSize="30" EmptyDataText="No Article found for your selected filter criteria"
                OnRowCommand="ArticleGridView_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="DateCreated" DataFormatString="{0:d MMM y}" HeaderText="DateCreated"
                        SortExpression="DateCreated" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="WriterName" HeaderText="WriterName" SortExpression="WriterName" />
                    <asp:TemplateField ShowHeader="False" HeaderText="Viewed">
                        <ItemTemplate>
                            <a class="viewed" target="_blank" href='<%# string.Format("http://vtracker.rudrasofttech.com/report/WebpagePublicStats?id=2&path={0}{1}", HttpContext.Current.Server.UrlEncode("http://www.indiabobbles.com/blog/"), DataBinder.Eval(Container.DataItem, "URL")) %>'
                                vhref='<%# string.Format("http://www.indiabobbles.com/blog/{0}", DataBinder.Eval(Container.DataItem, "URL")) %>'></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:CheckBoxField DataField="Sitemap" HeaderText="Sitemap" SortExpression="Sitemap" ReadOnly="true" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="SetTopStoryButton" runat="server" CausesValidation="False" CommandName="TopStory"
                                CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Text="Top Story"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="managearticle.aspx?id={0}&amp;mode=edit"
                        Text="Edit" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>'
                                CausesValidation="False" CommandName="DeleteCommand" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this article?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="URL" DataNavigateUrlFormatString="http://www.indiabobbles.com/blog/{0}?preview=true"
                        Target="_blank" Text="Preview" />
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
