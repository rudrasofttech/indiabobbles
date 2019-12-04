<%@ Page Title="" Language="C#" MasterPageFile="~/Blog.master" AutoEventWireup="true"
    CodeFile="list.aspx.cs" Inherits="list" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%if (CPM.ArticleList.Count == 0)
      { %>
    <p class="well">
        There are no articles and videos here.
    </p>
    <%} %>
    <%
        foreach (Article a in CPM.ArticleList)
        {
    %>
    <article class="blog-post">
        <div class="post-heading">
            <h3>
                <a href="<%= Utility.GenerateBlogArticleURL(a, Utility.SiteURL) %>">
                    <%: a.Title %>
                </a>
            </h3>
        </div>
        <div class="row">
            <div class="span8">
                <div class="post-image">
                    <%if (a.OGImage != string.Empty)
                      { %><a href="<%= Utility.GenerateBlogArticleURL(a, Utility.SiteURL) %>">
                          <img src="<%= a.OGImage %>" alt="" /></a>
                    <%} %>
                </div>
                <ul class="post-meta">
                    <li class="first"><i class="icon-calendar"></i><span>
                        <%: a.DateCreated.ToString("MMM dd, yyyy") %></span></li>
                    <li><i class="icon-comments"></i><span>
                        <%: a.Viewed%>
                        Views</span></li>
                    <li class="last"><i class="icon-tags"></i>
                        <%: a.Tag%>
                    </li>
                </ul>
                <div class="clearfix">
                </div>
                <p>
                    <%:a.OGDescription %>
                </p>
                <a href="<%= Utility.GenerateBlogArticleURL(a, Utility.SiteURL) %>" class="btn btn-small btn-theme">
                    Read more</a>
            </div>
        </div>
    </article>
    <% } %>
</asp:Content>
