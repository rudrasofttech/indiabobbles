<%@ WebHandler Language="C#" Class="emailstatus" %>

using System;
using System.Web;
using IndiaBobbles.Models;

public class emailstatus : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["id"] != null)
        {
            EmailMessage EM = new EmailMessage();

            try
            {
                EM.ID = new Guid(context.Request.QueryString["id"].ToString());
                EM = EmailManager.GetMessage(EM.ID);

                if (!EM.IsRead)
                {
                    EM.IsRead = true;
                    EM.ReadDate = DateTime.Now;
                    EmailManager.UpdateMessage(EM);
                }

            }
            catch (Exception ex)
            {
                EM.ID = Guid.Empty;
                context.Trace.Write("Invalid id");
                context.Trace.Write(ex.Message);
                context.Trace.Write(ex.StackTrace);
            }
        }
        context.Response.ContentType = "image/png";
        context.Response.WriteFile("~/handlers/beacon.png");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}