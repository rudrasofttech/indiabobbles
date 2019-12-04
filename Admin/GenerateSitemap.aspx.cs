using IndiaBobbles;
using IndiaBobbles.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_GenerateSitemap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btGenerateSitemap_Click(object sender, EventArgs e)
    {

        try
        {

            System.Text.StringBuilder builder = new System.Text.StringBuilder();
            builder.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            builder.Append("<urlset xmlns=\"http://www.google.com/schemas/sitemap/0.9\">");

            //Add Home Page and other static pages
            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/</loc>", Utility.SiteURL));
            builder.Append("</url>");

            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/blog</loc>", Utility.SiteURL));
            builder.Append("</url>");

            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/cart/orderlist.aspx</loc>", Utility.SiteURL));
            builder.Append("</url>");
            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/cart/cart.aspx</loc>", Utility.SiteURL));
            builder.Append("</url>");

            foreach (Category c in Utility.CategoryList())
            {
                if (c.Status == (byte)GeneralStatusType.Active)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{1}/blog/{0}/index</loc>", c.UrlName, Utility.SiteURL));
                    builder.Append("</url>");
                }
            }

            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {

                var cp = from u in dc.CustomPages where u.Status == (byte)PostStatusType.Publish && u.Sitemap select u;
                foreach (var i in cp)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{1}/{0}</loc>", i.Name, Utility.SiteURL));
                    builder.Append("</url>");
                }

                var p = from t in dc.Posts
                        where t.Status == (byte)PostStatusType.Publish && t.Sitemap
                        orderby t.DateCreated descending
                        select t;
                foreach (var i in p)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{0}</loc>", Utility.GenerateBlogArticleURL(new Article() { URL = i.URL }, Utility.SiteURL)));
                    builder.Append("</url>");
                }
            }

            builder.Append("</urlset>");

            System.IO.File.WriteAllText(Server.MapPath("~/sitemap.xml"), builder.ToString());

            lbMessage.Text = string.Format("<a href='{0}/sitemap.xml'>{0}/sitemap.xml</a>",Utility.SiteURL);
            lbMessage.Visible = true;
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
            lbMessage.Visible = true;
            lbMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}