<%@ Page Language="C#" AutoEventWireup="true" CodeFile="email.aspx.cs" Inherits="email" %>

<html>
<head>
    <title>
        <%= EM.Subject %></title>
</head>
<body>
    <div style="margin: 10px 80px 10px 80px;">
        <%= EM.Message %>
    </div>
</body>
</html>
