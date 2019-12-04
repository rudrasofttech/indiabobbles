<%@ Page Title="Browse IndiaBobbles Categories" Language="C#" MasterPageFile="~/Blog.master"
    AutoEventWireup="true" CodeFile="categories.aspx.cs" Inherits="categories" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <h1 class="sectionheading">
        Browse Articles & Videos By Category</h1>
    <div class="row-fluid">
        <%
            int counter = 0;
            foreach (Category c in Utility.CategoryList())
            {

                if (c.Status == (byte)GeneralStatusType.Active)
                {
                    counter++;
        %>
        <div class="span3" style="border-bottom: 1px dotted #000; margin-top: 10px; margin-bottom: 10px;">
            <a href="http://<%: Request.Url.Host %>/blog/<%:c.UrlName %>/index">
                <h4>
                    <%:c.Name%></h4>
            </a>
        </div>
        <% if (counter % 4 == 0)
           { %>
    </div>
    <div class="row-fluid">
        <%} %>
        <%}%>
        <% } %>
    </div>
</asp:Content>
