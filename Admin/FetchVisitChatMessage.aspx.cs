﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;
using System.Web.Script.Serialization;

public partial class Admin_FetchVisitChatMessage : AdminPage
{
    public VisitInfo VI = null;
    int messageId = 0;
    List<dynamic> messages = new List<dynamic>();
    JavaScriptSerializer serializer = new JavaScriptSerializer();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["messageId"] != null)
        {
            messageId = int.Parse(Request["messageId"].Trim());
        }
        if (Request["vid"] != null)
        {
            if (CacheManager.Get<VisitInfo>(Request["vid"].ToString()) != null)
            {
                VI = CacheManager.Get<VisitInfo>(Request["vid"].ToString());
                Trace.Write(messageId.ToString());
                VisitChatManager cm = new VisitChatManager(VI.VisitBoard);
                Trace.Write(cm.GetMessageUntil(messageId).Count().ToString());
                foreach (VisitChatMessage m in cm.GetMessageUntil(messageId))
                {
                    messages.Add(new
                    {
                        ID = m.ID,
                        Image = m.Image,
                        Message = m.Message,
                        Name = m.Name,
                        SentDate = m.SentDate.ToString()
                    });
                }

            }
        }

        Response.Cache.SetCacheability(HttpCacheability.Public);
        Response.Cache.SetMaxAge(new TimeSpan(1, 0, 0));
        Response.ContentType = "text/json";
        Response.Write(serializer.Serialize(new { Success = true, ChatMessages = messages }));
        Response.End();
    }
}