using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IndiaBobbles.Models;

namespace IndiaBobbles
{
    public class BasePage : System.Web.UI.Page
    {

        public Member CurrentUser { get; set; }

        public BasePage()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            string name = string.Empty, email = string.Empty;
            long memberid = 0;
            base.OnInit(e);
            if (!Request.IsAuthenticated)
            {
                CurrentUser = null;
            }
            else
            {
                CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
                name = CurrentUser.MemberName;
                email = CurrentUser.Email;
                memberid = CurrentUser.ID;
            }

            Guid visitid;
            string referer = string.Empty, searchKeyword = string.Empty;
            string url = string.Format("http://{0}{1}", Request.Url.Host, Request.RawUrl);
            if (Request.UrlReferrer != null)
            {
                referer = Request.UrlReferrer.OriginalString;
                if (Request.UrlReferrer.Host.Trim().ToLower().Contains("google.") || Request.UrlReferrer.Host.Trim().ToLower().Contains("bing."))
                {
                    try
                    {
                        searchKeyword = HttpUtility.ParseQueryString(Request.UrlReferrer.Query).Get("q");
                    }
                    catch { }
                }
            }

            if (!Guid.TryParse(CookieWorker.GetCookie("visit", "visitid"), out visitid))
            {
                VisitInfo vi = VisitManager.StartRecording(url, Request.UserAgent, Request.UserHostAddress, DateTime.Now, memberid, name, email, false, Guid.Empty, referer, Request.HttpMethod);
                vi.SearchKeyword = searchKeyword;
                CookieWorker.SetCookie("visit", "visitid", vi.ID.ToString(), DateTime.Now.AddDays(2));
                CacheManager.AddSliding(vi.ID.ToString(), vi, 2);
            }
            else
            {
                if (CacheManager.Get<VisitInfo>(visitid.ToString()) == null)
                {
                    VisitInfo vi = VisitManager.StartRecording(url, Request.UserAgent, Request.UserHostAddress, DateTime.Now, memberid, name, email, true, visitid, referer, Request.HttpMethod);
                    CookieWorker.SetCookie("visit", "visitid", vi.ID.ToString(), DateTime.Now.AddDays(2));
                    CacheManager.AddSliding(vi.ID.ToString(), vi, 2);
                }
            }
        }
    }
}