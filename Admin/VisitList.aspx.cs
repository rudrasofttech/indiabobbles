using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_VisitList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (VisitChatManager.ChatSetting.ChatOn)
        {
            ChatOnButton.Text = "Set Chat Off";
        }
        else { ChatOnButton.Text = "Set Chat On"; }

    }
    protected void ChatOnButton_Click(object sender, EventArgs e)
    {
        if (VisitChatManager.ChatSetting.ChatOn)
        {
            VisitChatManager.SetChatOn(false);
        }
        else { VisitChatManager.SetChatOn(true); }

        if (VisitChatManager.ChatSetting.ChatOn)
        {
            ChatOnButton.Text = "Set Chat Off";
        }
        else { ChatOnButton.Text = "Set Chat On"; }
    }
}