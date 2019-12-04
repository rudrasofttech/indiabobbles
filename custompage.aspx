<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="custompage.aspx.cs" Inherits="custompage" %>
<%@ MasterType virtualpath="~/Site.master" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>

<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="server">
    <title><%: CP.Title %></title>
    <%= CP.PageMeta %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%= CP.Head %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%= CP.Body %>
</asp:Content>
