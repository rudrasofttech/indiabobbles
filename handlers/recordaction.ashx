﻿<%@ WebHandler Language="C#" Class="recordaction" %>

using System;
using System.Web;
using System.Web.Script;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using IndiaBobbles;
using IndiaBobbles.Models;

public class recordaction : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        try
        {
            context.Response.ContentType = "text/json";

            if (ApplicationWorker.Visits == null)
            {
                ApplicationWorker.Visits = new List<Guid>();
            }
            List<Guid> vlist = ApplicationWorker.Visits;
            Guid visitid;
            context.Trace.Write("Inside");
            if (Guid.TryParse(CookieWorker.GetCookie("visit", "visitid"), out visitid))
            {
                context.Trace.Write(visitid.ToString());
                VisitInfo vi = CacheManager.Get<VisitInfo>(visitid.ToString());
                if (vi != null)
                {
                    VisitManager vm = new VisitManager(vi);
                    context.Trace.Write(context.Request["d"].ToString());
                    if (context.Request["d"] != null)
                    {
                        vi = vm.RecordAction(context.Server.UrlDecode(context.Request["d"].ToString()));

                        dynamic a = null;
                        if (vi.Actionables.Count > 0)
                        {
                            if (vi.Actionables[0].Status == false)
                            {
                                a = new
                                {
                                    Status = vi.Actionables[0].Status,
                                    ID = vi.Actionables[0].ID,
                                    Name = vi.Actionables[0].Name,
                                    Created = vi.Actionables[0].Created.ToString()
                                };
                                vi.Actionables[0].Status = true;
                            }
                        }
                        context.Response.Write(serializer.Serialize(new
                        {
                            Success = true,
                            Action = a,
                            Message = "",
                            VisitID = vi.ID.ToString(),
                            MemberID = vi.MemberID,
                            MemberName = vi.Name,
                            VisitDate = vi.VisitDate.ToString()
                        }));

                        
                        if (!vlist.Contains(vi.ID))
                        {
                            vlist.Add(vi.ID);
                        }
                    }
                    else
                    {
                        context.Response.Write(serializer.Serialize(new
                        {
                            Success = true,
                            Message = "",
                            VisitID = vi.ID.ToString(),
                            MemberID = vi.MemberID,
                            MemberName = vi.Name,
                            VisitDate = vi.VisitDate.ToString()
                        }));
                    }
                    CacheManager.AddSliding(vi.ID.ToString(), vi, 2);
                }
                else {
                    string name = string.Empty, email = string.Empty;
                    long memberid = 0;
                    if (context.Request.IsAuthenticated)
                    {
                        Member m = MemberManager.GetUser(HttpContext.Current.User.Identity.Name.ToString());
                        name = m.MemberName;
                        email = m.Email;
                        memberid = m.ID;
                    }
                    context.Trace.Write("New Visit");
                    vi = VisitManager.StartRecording(context.Request.UrlReferrer.OriginalString, context.Request.UserAgent, context.Request.UserHostAddress, DateTime.Now, memberid, name, email, true, visitid, string.Empty, string.Empty);
                    context.Trace.Write(vi.ID.ToString());
                    CookieWorker.SetCookie("visit", "visitid", vi.ID.ToString(), DateTime.Now.AddDays(2));
                    CacheManager.AddSliding(vi.ID.ToString(), vi, 2);
                    context.Response.Write(serializer.Serialize(new { Success = false, Message = "Old visit expired, new visit created." })); 
                }
            }
            ApplicationWorker.Visits = vlist;
        }
        catch (Exception ex)
        {
            //context.Response.Write(ex.Message);
            context.Trace.Write("Problem recording action of visitor.");
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.StackTrace);
            context.Response.Write(serializer.Serialize(new { Success = false, Message = "Visit not found" }));
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