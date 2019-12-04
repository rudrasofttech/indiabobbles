<%@ Page Language="C#" AutoEventWireup="true" CodeFile="simpleupload.aspx.cs" Inherits="Admin_simpleupload" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="row-fluid">
        <div class="span12">
            <uc1:message ID="message1" runat="server" Visible="false" />
            <div class="well form-inline">
                <asp:FileUpload ID="SingleFileUpload" runat="server" />
                <asp:Button ID="UploadButton"
                    runat="server" Text="Upload" CssClass="btn" onclick="UploadButton_Click" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
