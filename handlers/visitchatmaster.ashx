﻿<%@ WebHandler Language="C#" Class="visitchatmaster" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web.Script.Serialization;
using System.Text;
using IndiaBobbles;
using IndiaBobbles.Models;

public class visitchatmaster : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/json";
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<dynamic> messages = new List<dynamic>();
        string message = string.Empty;
        DateTime requestDate = DateTime.Now;
        Guid visitid;
        string action = string.Empty;
        try
        {

            if (Guid.TryParse(CookieWorker.GetCookie("visit", "visitid"), out visitid))
            {
                VisitInfo cv = CacheManager.Get<VisitInfo>(visitid.ToString());
                if (cv != null)
                {
                    VisitChatManager cm = new VisitChatManager(cv.VisitBoard);

                    if (context.Request["action"] != null)
                    {
                        action = context.Request["action"].Trim();
                    }

                    if (action == "push")
                    {
                        if (context.Request["message"] != null)
                        {
                            message = context.Request["message"].Trim();
                        }
                        if (message != string.Empty)
                        {
                            cm.PushSentMessage(cv.MemberID, message, cv.Name == "" ? "Visitor" : cv.Name,cv.MemberImage);
                        }
                        context.Response.Write(serializer.Serialize(new { Success = true, ChatMessages = messages }));
                    }
                    else if (action == "fetch")
                    {
                        int messageId;
                        if (context.Request["mid"] != null)
                        {
                            if (!int.TryParse(context.Request["mid"].ToString(), out messageId))
                            {
                                messageId = 0;
                            }
                        }
                        else { messageId = 0; }
                        
                        foreach (VisitChatMessage m in cm.GetMessageUntil(messageId)) {
                            messages.Add(new { 
                                ID= m.ID,
                                Image = m.Image,
                                Message = m.Message,
                                Name = m.Name,
                                SentDate = m.SentDate.ToString()
                            });
                        }

                        context.Response.Write(serializer.Serialize(new { Success = true, ChatMessages = messages }));
                    }
                }
            }


        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
            context.Trace.Write("Problem with accepting chat message.");
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.StackTrace);
            context.Response.Write(serializer.Serialize(new { Success = false, Message = ex.Message }));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}