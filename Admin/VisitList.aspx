﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="VisitList.aspx.cs" Inherits="Admin_VisitList" %>

<%@ Import Namespace="IndiaBobbles" %>
<%@ Import Namespace="IndiaBobbles.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row-fluid">
        <div class="span12">
            <h1>On Going Visits</h1>

            <asp:Timer ID="Timer1" runat="server" Interval="3000"></asp:Timer>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Button ID="ChatOnButton" runat="server" Text="" cssclass="btn" OnClick="ChatOnButton_Click" />
                    <% List<Guid> vList = ApplicationWorker.Visits;
                       if (vList != null)
                       { 
                    %>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Admin</th>
                                <th>Location</th>
                                <th>Summary</th>
                                <th>Message</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                           for (int icount = vList.Count - 1; icount >= 0; icount--)
                           {
                               if (CacheManager.Get<VisitInfo>(vList[icount].ToString()) != null)
                               {
                                   VisitInfo vi = CacheManager.Get<VisitInfo>(vList[icount].ToString());
                                   if (DateTime.Now.Subtract(vi.LastHeartBeat).Seconds > 8) { CacheManager.Remove(vi.ID.ToString()); }  
                            %>
                            <tr>
                                <td><%= string.Format("<a href='visitinfo.aspx?vid={0}'>View</a>",vi.ID.ToString()) %></td>
                                <td>
                                    <%: vi.AdminName %>
                                </td>
                                <td><%: vi.Name.Trim() == "" ? "" : string.Format("{0} ", vi.Name.Trim()) %>
                                    <%: vi.Area %>
                                    <%: vi.City %>
                                    <%: vi.State %>
                                    <%: vi.Country %></td>
                                <td>
                                    <span class="label"><%: vi.TimeSpent %> seconds</span>
                                    <span class="label label-info"><%: vi.TotalViews %> Page Views</span>
                                    <span class="label label-inverse"><%: vi.VisitDate.ToShortDateString() %></span>
                                    <span class="badge"><small>Last Heartbeat 
                            <%: vi.LastHeartBeat.ToShortTimeString() %></small></span>
                                    <%= vi.ReturnVisit ? "<span class='label label-success'>Return Visit</span>" : "" %>
                                </td>
                                <td><%= vi.LastVisitorMessage %></td>
                            </tr>

                            <%}
                               else
                               {
                                   vList.RemoveAt(icount);
                            %>
                            <%}
                           } %>
                            <%if (vList.Count == 0)
                              { %><tr>
                                  <td colspan="5" style="text-align: center;">There are no live visits at present.</td>
                              </tr>
                            <%} %>
                        </tbody>
                    </table>
                    <%} %>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>
