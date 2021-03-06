﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="VisitInfo.aspx.cs" Inherits="Admin_VisitInfo" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <div class="row-fluid">
        <div class="span12">
            <h1>Visit Info
            </h1>
            <div class="row-fluid">
                <div class="span8">
                    <p>
                        <%: VI.Area %>
                        <%: VI.City %>
                        <%: VI.State %>
                        <%: VI.Country %>
                        <span class="label"><%: VI.TimeSpent %> seconds</span> <span class="label label-info"><%: VI.TotalViews %> Page Views</span>
                        <span class="label label-inverse"><%: VI.VisitDate.ToShortDateString() %></span> <%= VI.ReturnVisit ? "<span class='label label-success'>Return Visit</span>" : "" %>
                        <asp:Label ID="AdminLabel" runat="server" Text="" CssClass="label label-warning" Visible="false" Style="margin-left: 10px;"></asp:Label><asp:LinkButton ID="RemoveAdminButton" runat="server" Style="margin-left: 10px;" OnClick="RemoveAdminButton_Click">Remove</asp:LinkButton><asp:LinkButton ID="SetAdminButton" CausesValidation="false" Visible="false" runat="server" OnClick="SetAdminButton_Click" Style="margin-left: 10px;">Engage</asp:LinkButton>
                        <asp:LinkButton ID="RemoveVisitButton" runat="server" Style="margin-left: 10px;" CausesValidation="false" OnClick="RemoveVisitButton_Click">Flush Visit</asp:LinkButton>
                    </p>
                </div>
                <div class="span4">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-inline">
                                <uc1:message ID="message1" runat="server" Visible="false" />
                                <asp:DropDownList ID="ActionDropDown" runat="server">
                                    <asp:ListItem Selected="True" Value="">Select Action</asp:ListItem>
                                    <asp:ListItem Value="AskSubscription">Ask Subscription</asp:ListItem>
                                    <asp:ListItem Value="AuthenticateVisitor">Authenticate Visitor</asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList><asp:Button ID="AddActionButton" runat="server" CssClass="btn" CausesValidation="false" Text="Add Action" OnClick="AddActionButton_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="AddActionButton" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span7" style="height: 450px; overflow-y: scroll; padding: 10px;">
                    <ul class="nav nav-tabs" id="visitTab">
                        <li class="active"><a href="#views" data-toggle="tab">Views</a></li>
                        <li><a href="#actions" data-toggle="tab">Actions</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="views">
                            <asp:Timer ID="Timer1" runat="server" Interval="4000">
                            </asp:Timer>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table class="table table-striped table-bordered table-condensed">
                                        <thead>
                                            <tr>
                                                <th>Raw URL
                                                </th>
                                                <th>Data
                                                </th>
                                                <th>Arrival
                                                </th>
                                                <th>Heartbeat</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% foreach (ViewInfo vi in VI.Views)
                                               { %>
                                            <tr>
                                                <td>
                                                    <%= vi.PageUrlRaw %>
                                                </td>
                                                <td>
                                                    <%= vi.PageUrlData %>
                                                </td>
                                                <td>
                                                    <%= vi.Arrival.ToString() %>
                                                </td>
                                                <td><%foreach (ViewAction va in vi.Actions)
                                                      {
                                                          if (va.Action.ToLower() == "heartbeat")
                                                          { 
                                                %>
                                                    <%: va.Created.ToLongTimeString() %>
                                                    <% break;
                                                          }
                                                      }%></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5">
                                                    <table class="table table-striped table-bordered table-condensed">
                                                        <thead>
                                                            <tr>
                                                                <th>Action</th>
                                                                <th>Element Name</th>
                                                                <th>Ele. ID</th>
                                                                <th>More Info</th>
                                                                <th>Time</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%foreach (ViewAction va in vi.Actions)
                                                              {
                                                                  if (va.Action.ToLower() == "heartbeat") { continue; }
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= va.Action %>
                                                                </td>
                                                                <td>
                                                                    <%= va.Name %>
                                                                </td>
                                                                <td>
                                                                    <%= va.ID %>
                                                                </td>
                                                                <td>
                                                                    <%= va.Other %>
                                                                </td>
                                                                <td>
                                                                    <%= va.Created.ToLongTimeString() %>
                                                                </td>
                                                            </tr>
                                                            <%} %>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                                </Triggers>
                            </asp:UpdatePanel>

                        </div>
                        <div class="tab-pane" id="actions">
                            <table class="table table-striped table-bordered table-condensed">
                                <thead>
                                    <tr>
                                        <th>Name
                                        </th>
                                        <th>Created
                                        </th>
                                        <th>Status
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% foreach (Actionable a in VI.Actionables)
                                       { %>
                                    <tr>
                                        <td><%: a.Name %></td>
                                        <td><%: a.Created.ToString() %></td>
                                        <td><%: a.Status ? "Taken" : "Not Taken" %></td>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <script>
                        $('#visitTab a').click(function (e) {
                            e.preventDefault();
                            $(this).tab('show');
                        });
                    </script>
                </div>
                <div class="span5">
                    <div class="row">
                        <div class="span12">
                            <div id='visitChatWindow'>
                                <div style='' id='chatMessageList'>
                                    <%
                                        VisitChatManager cm = new VisitChatManager(VI.VisitBoard);
                                        foreach (VisitChatMessage m in VI.VisitBoard.MessageList)
                                        {
                                            var item = new
                                            {
                                                Message = m.Message,
                                                ID = m.ID,
                                                Name = m.Name,
                                                SentDate = m.SentDate.ToString(),
                                                Image = m.Image
                                            };%>
                                    <div class='chatmessagebubble' style="" data-messageid='<%: item.ID %>'>
                                        <label class='sendername'><%: item.Name %></label>
                                        <label class='chatmessagedate'><%: item.SentDate %></label>
                                        <div class='chatmessage' style=""><%= item.Message %></div>
                                    </div>
                                    <%} %>
                                </div>

                                <asp:Panel DefaultButton="SendButton" ID="ChatInputPlaceHolder" Visible="false" runat="server">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="form-inline">
                                                <asp:TextBox ID="ChatMessageTextBox" AutoCompleteType="None" runat="server" CssClass="input-large chatMessageTxt"></asp:TextBox><asp:Button ID="SendButton" CausesValidation="false" runat="server" Text="Send" CssClass="btn" AccessKey="S" OnClick="SendButton_Click" />
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </asp:Panel>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="span12">
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <style>
        #visitChatWindow {
            border: 0px solid #B3B3B3;
            border-top-left-radius: 2px;
            border-top-right-radius: 2px;
            min-height: 450px;
        }

        #chatWindowTitle {
            background-color: #24B3EC;
            border-top-left-radius: 0px;
            border-top-right-radius: 0px;
            text-align: center;
            color: #fff;
            font-weight: bold;
            font-size: 13px;
            width: 100%;
            height: 25px;
        }

        #chatCloseButton {
            font-size: 10px;
            text-transform: capitalize;
            float: right;
            color: #fff;
            padding-right: 3px;
            cursor: pointer;
        }

        #chatMessageList {
            max-height: 400px;
            width: 100%;
            overflow: auto;
            width: 100%;
            border-top: 0px;
        }

        #chatInputGroupBox {
            width: 100%;
            text-align: center;
            border-top: 1px solid #EFEFEF;
        }

        .chatMessageTxt {
            font-family: Arial;
            font-size: 8px;
            border: none;
            border-radius: 0px;
            width: 270px;
            margin: 5px;
            padding: 0px;
        }

        .chatmessagebubble {
            margin: 3px;
            border-bottom: 1px dashed #D9D9D9;
            padding: 3px;
        }

        .chatmessage {
            font-size: 15px;
            font-family: Calibri;
            padding: 0px;
            clear: both;
        }

        .sendername {
            font-weight: bold;
            font-size: 14px;
            color: #53CCCB;
            font-family: Calibri;
            padding: 0px;
            float: left;
        }

        .chatmessagedate {
            float: right;
            font-size: 10px;
            color: #B2B2B2;
        }
    </style>
    <script type="text/javascript">
        function getChatMessages() {
            $.ajax({
                url: "FetchVisitChatMessage.aspx",
                data: { messageId: $("#chatMessageList .chatmessagebubble:last-child").attr("data-messageid"), vid: '<%: VI.ID.ToString() %>' },
                dataType: "json",
                type: 'post',
                async: true
            }).done(function (msg) {
                for (var item in msg.ChatMessages) {
                    var cm = msg.ChatMessages[item];
                    var cmmbox = $("<div class='chatmessagebubble' />");
                    cmmbox.attr("data-messageid", cm.ID);
                    cmmbox.append($("<label class='sendername'></label>").html(cm.Name));
                    cmmbox.append($("<label class='chatmessagedate'></label>").html(cm.SentDate));
                    cmmbox.append($("<div class='chatmessage'></div>").html(performActionOnChatMessage(cm.Message)));
                    cmmbox.appendTo($("#chatMessageList"));
                }
                if (msg.ChatMessages.length > 0) {
                    $("#chatMessageList").animate({ scrollTop: $("#chatMessageList")[0].scrollHeight }, "slow");
                }
            }).fail(function (jqXHR, textStatus) {
                console.log("Request failed: " + textStatus);
            });
        }

        function performActionOnChatMessage(message) {
            var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
            message = message.replace(exp, "<a href='$1'>$1</a>");
            return message;
        }

        $(document).ready(function () { getChatMessages(); setInterval(getChatMessages, 2000); });
    </script>
</asp:Content>
