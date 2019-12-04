using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IndiaBobbles.Models;

namespace IndiaBobbles
{
    public class AdminPage : System.Web.UI.Page
    {
        public Member CurrentUser { get; set; }
        public AdminPage()
        {
            Mode = string.Empty;
        }

        public string Mode { get; set; }
        public int ID { get; set; }

        /// <summary>
        /// Validate user access based on allowed membertype
        /// </summary>
        /// <param name="ValidUserTypes"></param>
        /// <returns></returns>
        public bool ForbidUserAccess(params MemberTypeType[] ValidUserTypes)
        {
            MemberTypeType utype = (MemberTypeType)CurrentUser.UserType;
            for (int i = 0; i < ValidUserTypes.Length; i++)
            {
                if (ValidUserTypes[i] == utype)
                {
                    return false;
                }
            }
            return true;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/account/login");
            }
            else
            {
                CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
            }

            if (Request.QueryString["mode"] != null)
            {
                if (Request.QueryString["mode"].ToString() != string.Empty)
                {
                    Mode = Request.QueryString["mode"].ToString();
                }
            }

            if (Request.QueryString["id"] != null)
            {
                if (Request.QueryString["id"].ToString() != string.Empty)
                {
                    ID = int.Parse(Request.QueryString["id"].ToString());
                }
            }
        }
    }
}