<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="article.aspx.cs" Inherits="_Article" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ContentPlaceHolderID="TopContent" runat="server" ID="Content3">
    <title>
        <%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %></title>
    <meta name="description" content="<%: PPM.Item.OGDescription %>" />
    <meta name="keywords" content="<%: PPM.Item.Tag %>" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="<%= Utility.GenerateBlogArticleURL(PPM.Item, Utility.SiteURL) %>" />
    <meta property="og:site_name" content="<%: Utility.SiteName %>" />
    <meta property="og:title" content="<%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %>" />
    <meta property="og:description" content="<%: PPM.Item.OGDescription %>" />
    <meta property="og:image" content="<%: PPM.Item.OGImage %>" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" type="text/javascript"></script>
    <link href="http://www.rudrasofttech.com/js-tools/SlideShow/slides.css" rel="stylesheet"
        type="text/css" />
    <script src="http://www.rudrasofttech.com/js-tools/SlideShow/slides.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".rst-slides").slides({
                Circular: true, HoverPause: true, ScrollInterval: 10000, NextHideAnimate: { Effect: 'fade', Props: { direction: '' }, Interval: 500 },
                PrevHideAnimate: { Effect: 'fade', Props: { direction: '' }, Interval: 500 },
                NextShowAnimate: { Effect: 'fade', Props: { direction: '' }, Interval: 500 },
                PrevShowAnimate: { Effect: 'fade', Props: { direction: '' }, Interval: 500 }
            });
        });
    </script>
    <link href="http://www.rudrasofttech.com/js-tools/Question/question.css" rel="stylesheet"
        type="text/css" />
    <script src="http://www.rudrasofttech.com/js-tools/Question/question.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".rstquestion").question({ Attempts: 1, OnAttempt: function (i, attemptcount) { } });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%= PPM.Item.Text%>
    <% if (CurrentUser != null)
       {
           if (CurrentUser.UserType == (byte)MemberTypeType.Admin || CurrentUser.ID == PPM.Item.CreatedBy)
           {%>
    <div style="padding-left: 10px; padding-top: 5px; padding-bottom: 5px; padding-right: 10px; position: fixed; top: auto; bottom: 0px; left: 0px; right: auto; background-color: #fff;">
        <a href="http://<%: Request.Url.Host%>/Admin/ManageArticle.aspx?id=<%: PPM.Item.ID.ToString()%>&mode=edit"
            target="_blank">Edit</a>
    </div>
    <% }
       } %>
</asp:Content>
