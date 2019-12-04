<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageArticle.aspx.cs" Inherits="Admin_ManageArticle" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:ProjectConnectionString.ProviderName %>" SelectCommand="SELECT ID, Name FROM Category WHere Status=0"></asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
            <uc1:message ID="message1" Visible="false" runat="server" />
            <fieldset>
                <legend>
                    <asp:Literal ID="HeadingLit" runat="server">Create</asp:Literal></legend>
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Article Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TitleTextBox" MaxLength="250" runat="server" AutoPostBack="True"
                            OnTextChanged="TitleTextBox_TextChanged"></asp:TextBox><asp:RequiredFieldValidator
                                ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                                runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: MetaTitleTextBox.ClientID %>">
                        Meta Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="MetaTitleTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" ValidationGroup="VideoGrp" ControlToValidate="MetaTitleTextBox"
                                runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: URLTextBox.ClientID %>">
                        URL</label>
                    <div class="controls">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="input-prepend">
                                    <span class="add-on"><%= IndiaBobbles.Utility.SiteURL %>/blog/</span>
                                    <asp:TextBox CssClass="span6" ID="URLTextBox" MaxLength="250" runat="server"
                                        AutoPostBack="True" OnTextChanged="URLTextBox_TextChanged"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="VideoGrp"
                                    ControlToValidate="URLTextBox" runat="server" ErrorMessage="Required" CssClass="validate"
                                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CustomValidator
                                        ID="CustomValidator1" runat="server" ValidationGroup="VideoGrp" ControlToValidate="URLTextBox"
                                        ErrorMessage="Duplicate URL, Please change the title or modify the url." CssClass="validate"
                                        Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="TitleTextBox" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TagTextBox.ClientID %>">
                        Tag</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TagTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="TagReqVal" ValidationGroup="VideoGrp" ControlToValidate="TagTextBox" runat="server"
                            ErrorMessage="Required" CssClass="validate" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: SitemapCheckBox.ClientID %>">
                        Add To Sitemap</label>
                    <div class="controls">
                        <asp:CheckBox ID="SitemapCheckBox" Checked="true" runat="server" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: WriterTextBox.ClientID %>">
                        Writer Name</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="WriterTextBox" MaxLength="250" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="WriterReqVal" ValidationGroup="VideoGrp" ControlToValidate="WriterTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: WriterEmailTextBox.ClientID %>">
                        Writer Email</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="WriterEmailTextBox" MaxLength="250" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="WriterEmailReqVal" ValidationGroup="VideoGrp" ControlToValidate="WriterEmailTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: CategoryDropDown.ClientID %>">
                        Category</label>
                    <div class="controls">
                        <asp:DropDownList ID="CategoryDropDown" runat="server" DataMember="DefaultView" DataSourceID="CategorySource"
                            DataTextField="Name" DataValueField="ID">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="CategoryReqVal" ValidationGroup="VideoGrp" ControlToValidate="CategoryDropDown"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: FacebookImageTextBox.ClientID %>">
                        Facebook Image (<a href="#driveModal" data-toggle="modal" role="button">Open Drive</a>)</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="FacebookImageTextBox" MaxLength="250" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: FacebookDescTextBox.ClientID %>">
                        Facebook Description</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="FacebookDescTextBox" MaxLength="250" runat="server"></asp:TextBox>
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
                <div class="control-group">
                    <div class="controls">
                        <label class="checkbox">
                            <asp:CheckBox ID="SlideShowCheckBox" Text="Slide Show" runat="server" />
                        </label>
                    </div>
                    <div class="controls">
                        <label class="checkbox">
                            <asp:CheckBox ID="QuestionCheckBox" Text="Question" runat="server" />
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TemplateDropDown.ClientID %>">
                        Template</label>
                    <div class="controls">
                        <asp:DropDownList ID="TemplateDropDown" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: DescTextBox.ClientID %>">
                        Small Description</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="DescTextBox" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="DescReqVal" ValidationGroup="VideoGrp" ControlToValidate="DescTextBox" runat="server"
                            ErrorMessage="Required" CssClass="validate" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TextTextBox.ClientID %>">
                        Text (<a href="#driveModal" data-toggle="modal" role="button">Open Drive</a>)</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TextTextBox" TextMode="MultiLine" Rows="20" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="TextReqVal" ValidationGroup="VideoGrp" ControlToValidate="TextTextBox" runat="server"
                            ErrorMessage="Required" CssClass="validate" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="VideoGrp" class="btn btn-primary"
                        runat="server" Text="Save" OnClick="SubmitButton_Click" />
                    <a href="Default.aspx" class="btn">Cancel</a>
                </div>
            </fieldset>
        </div>
    </div>
    <div id="driveModal" class="modal hide fade" tabindex="-1" role="dialog">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3>Drive</h3>
        </div>
        <div class="modal-body">
            <iframe style="border: none; width: 100%; height: 400px;" src="viewdrive.aspx"></iframe>
        </div>
    </div>
</asp:Content>
