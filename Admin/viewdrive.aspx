<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewdrive.aspx.cs" EnableViewState="false" Inherits="account_viewdrive" %>

<%@ Register Src="~/control/message.ascx" TagName="message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
        type="text/css" />
    <link href="bootstrap/css/bootstrap-responsive.min.css"
        rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    
</head>
<body>
    <form id="form1" runat="server">
    <uc1:message ID="message4" Visible="false" runat="server" />
    <div class="row-fluid">
        <div class="span12">
            <ul class="breadcrumb" style="margin-bottom: 4px;">
                <li><a href="viewdrive.aspx">Home</a> <span class="divider">
                    /</span></li>
                <%
                    StringBuilder temp = new StringBuilder();
                    foreach (string i in FolderList)
                    {
                        if (i != string.Empty)
                        {
                            temp.Append(i);
                            temp.Append("/");
                %>
                <li><a href="viewdrive.aspx?folderpath=<%= temp %>">
                    <%= i%></a> <span class="divider">/</span></li>
                <%}
                    } %>
            </ul>
            <asp:Repeater ID="FolderTableRepeater" runat="server">
                <HeaderTemplate>
                    <table id="folderitemtable" class="table table-hover table-condensed cursor-pointer">
                        <thead>
                            <tr>
                                <th>
                                </th>
                                <th class="type-string cursor-pointer">
                                    Name
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <img src='<%# DataBinder.Eval(Container.DataItem, "ThumbNail")%>' alt="" style="max-width: 40px;" />
                        </td>
                        <td>
                            <a href="viewdrive.aspx?folderpath=<%# DataBinder.Eval(Container.DataItem, "Location").ToString().Replace("\\", "/")%>">
                                <%# DataBinder.Eval(Container.DataItem, "Name")%></a>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Repeater ID="FileItemRepeater" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <img src='<%# DataBinder.Eval(Container.DataItem, "ThumbNail")%>' alt="" style="max-width: 40px;" />
                        </td>
                        <td> 
                            <input type="text" value='<%# DataBinder.Eval(Container.DataItem, "WebPath")%>' style='border: none; width:100%;'/>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
    </form>
</body>
</html>
