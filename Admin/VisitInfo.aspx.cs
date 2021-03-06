﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_VisitInfo : AdminPage
{
    public VisitInfo VI = new VisitInfo();
    Guid id = Guid.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        message1.Visible = false;
        if (Request.QueryString["vid"] != null)
        {
            id = new Guid(Request.QueryString["vid"].ToString());
            if (CacheManager.Get<VisitInfo>(Request.QueryString["vid"].ToString()) != null)
            {
                VI = CacheManager.Get<VisitInfo>(Request.QueryString["vid"].ToString());

                if (VI.AdminId == 0)
                {
                    AdminLabel.Text = string.Empty;
                    AdminLabel.Visible = false;
                    RemoveAdminButton.Visible = false;
                    SetAdminButton.Visible = true;
                    ChatInputPlaceHolder.Visible = false;
                }
                else
                {
                    AdminLabel.Text = String.Format("Admin: {0}", VI.AdminName);
                    AdminLabel.Visible = true;
                    SetAdminButton.Visible = false;
                    ChatInputPlaceHolder.Visible = true;
                    if (CurrentUser.ID == VI.AdminId)
                    {
                        RemoveAdminButton.Visible = true;
                    }
                }
            }
            else { Response.Redirect("visitlist.aspx"); }
        }
        else { Response.Redirect("visitlist.aspx"); }
    }
    protected void AddActionButton_Click(object sender, EventArgs e)
    {
        if (ActionDropDown.SelectedValue != "")
        {
            VI.Actionables.Insert(0, new Actionable()
                {
                    ID = Guid.NewGuid(),
                    Name = ActionDropDown.SelectedValue,
                    Status = false
                });
            CacheManager.AddSliding(VI.ID.ToString(), VI, 2);
            message1.Text = "'" + ActionDropDown.SelectedValue + "' Action sent to client";
            message1.Visible = true;
            ActionDropDown.SelectedValue = string.Empty;
        }
    }
    protected void SetAdminButton_Click(object sender, EventArgs e)
    {
        VisitManager vm = new VisitManager(VI);
        vm.SetAdmin(CurrentUser.ID, CurrentUser.MemberName);
        Response.Redirect(string.Format("visitinfo.aspx?vid={0}", id.ToString()));
    }
    protected void RemoveAdminButton_Click(object sender, EventArgs e)
    {
        VisitManager vm = new VisitManager(VI);
        vm.RemoveAdmin();
        Response.Redirect(string.Format("visitinfo.aspx?vid={0}", id.ToString()));

    }

    protected void SendButton_Click(object sender, EventArgs e)
    {
        if (ChatMessageTextBox.Text.Trim() != string.Empty)
        {
            VisitChatManager cm = new VisitChatManager(VI.VisitBoard);
            cm.PushSentMessage(VI.AdminId, ChatMessageTextBox.Text.Trim(), VI.AdminName, string.Empty);
            ChatMessageTextBox.Text = string.Empty;
            ChatMessageTextBox.Focus();
        }
    }

    protected void RemoveVisitButton_Click(object sender, EventArgs e)
    {
        CacheManager.Remove(VI.ID.ToString());
        Response.Redirect("visitlist.aspx");
    }
}