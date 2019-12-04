<%@ Control Language="C#" AutoEventWireup="true" CodeFile="captcha.ascx.cs" Inherits="control_captcha" %>
<h6>
    CAPTCHA</h6>
<div class="input-prepend input-append">
    <span class="add-on">
        <img src="//<%: Request.Url.Host %>/handlers/captcha.ashx?key=<%= ViewState["key"].ToString() %>&height=60&width=120&fontsize=25&noise=20" alt="Captcha" style="height:23px;" /></span>
    <asp:TextBox ID="CaptchaTextBox" MaxLength="30" CssClass="span10" runat="server"></asp:TextBox>
    <span class="add-on"><asp:LinkButton ID="Refreshcaptcha" 
        CausesValidation="false" runat="server" onclick="Refreshcaptcha_Click" ToolTip="Click to refresh captcha."><i class="icon-refresh"></i></asp:LinkButton></span>
    
</div><asp:RequiredFieldValidator
        ID="CaptchaReqValidator" CssClass="validate" runat="server" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" ControlToValidate="CaptchaTextBox"></asp:RequiredFieldValidator><asp:CustomValidator
        ID="CaptchaValidator" runat="server" ErrorMessage="Text does not match." 
        ControlToValidate="CaptchaTextBox" CssClass="validate" Display="Static" 
        onservervalidate="CaptchaValidator_ServerValidate" SetFocusOnError="True" 
        ValidateEmptyText="True"></asp:CustomValidator>
<span class="help-block">Please write the text of image in input box.</span> 