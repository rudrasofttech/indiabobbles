<%@ Page Title="Generate Sitemap File" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="GenerateSitemap.aspx.cs" Inherits="Admin_GenerateSitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="span12">
            <h1>
                Generate Sitemap XML File</h1>
            <asp:Label ID="lbMessage" runat="server" Visible="False" EnableViewState="False"></asp:Label>
            <asp:Button ID="btGenerateSitemap" CausesValidation="false" runat="server" Text="Generate Sitemap" CssClass="btn btn-primary btn-large" OnClick="btGenerateSitemap_Click" />
            </div>
         </div>
</asp:Content>

