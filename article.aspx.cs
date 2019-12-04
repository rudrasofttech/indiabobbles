using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class _Article : BasePage
{
    public PostPageModel PPM { get; set; }
    public int ID { get; set; }

    public bool Preview { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        PPM = new PostPageModel();
        string pname = "";
        if (Page.RouteData.Values["pagename"] != null)
        {
            pname = Page.RouteData.Values["pagename"].ToString();
        }
        
        if (Request.QueryString["preview"] != null)
        {
            try
            {
                Preview = Convert.ToBoolean(Request.QueryString["preview"]);
            }
            catch
            {
                Preview = false;
            }
        }

        using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
        {
            Post item = (from t in dc.Posts
                         where t.URL == pname
                             && (t.Status == (byte)PostStatusType.Publish || Preview == true)
                         select t).SingleOrDefault();
            if (item != null)
            {
                try
                {
                    dc.ExecuteCommand(string.Format("UPDATE dbo.Post SET Viewed = Viewed + 1 WHERE ID = {0}", item.ID), new object[] { });
                }
                catch (Exception er)
                {
                    Trace.Write("Unable to update view count");
                    Trace.Write(er.Message);
                    Trace.Write(er.StackTrace);
                }

                Article a = new Article();
                try
                {
                    a = Utility.Deserialize<Article>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", item.ID, Utility.ArticleFolder))));
                }
                catch (Exception ex)
                {
                    Trace.Write("Unable to read xml file of article.");
                    Trace.Write(ex.Message);
                    Trace.Write(ex.StackTrace);
                    try
                    {
                        a.Text = System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/article-{0}.txt", item.ID, Utility.ArticleFolder)));
                    }
                    catch (Exception ex1)
                    {
                        a.Text = string.Empty;
                        Trace.Write(ex1.Message);
                        Trace.Write(ex1.StackTrace);
                    }
                }
                a.Category = item.Category;
                a.CategoryName = item.Category1.Name;
                a.CreatedBy = item.CreatedBy;
                a.CreatedByName = item.Member.MemberName;
                a.DateCreated = item.DateCreated;
                a.DateModified = item.DateModified;
                a.Description = item.Description;
                a.ID = item.ID;
                a.ModifiedBy = item.ModifiedBy;
                a.Status = (PostStatusType)item.Status;
                a.Tag = item.Tag;
                a.Title = item.Title;
                a.WriterEmail = item.WriterEmail;
                a.WriterName = item.WriterName;
                a.Viewed = item.Viewed;
                a.URL = item.URL;
                PPM.Item = a;

                #region Replace Custom Data Source
                DataSourceManager dsm = new DataSourceManager();

                if (PPM.Item.TemplateName != string.Empty)
                {
                    HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                    string templateHTML = dsm.LoadContent(PPM.Item.TemplateName);
                    doc.LoadHtml(templateHTML);

                    if (doc.DocumentNode.SelectNodes("//datasource") != null)
                    {
                        foreach (HtmlAgilityPack.HtmlNode ds in doc.DocumentNode.SelectNodes("//datasource"))
                        {
                            try
                            {
                                HtmlAgilityPack.HtmlAttribute att = ds.Attributes["name"];

                                if (att != null)
                                {
                                    var temp = doc.CreateElement("temp");
                                    var current = ds;
                                    if (att.Value == "articletext")
                                    {
                                        temp.InnerHtml = PPM.Item.Text;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articleimg")
                                    {
                                        if (PPM.Item.OGImage != string.Empty)
                                            temp.InnerHtml = string.Format("<img src='{0}' alt='' />", PPM.Item.OGImage);
                                        else
                                            temp.InnerHtml = "";

                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articletitle")
                                    {
                                        temp.InnerHtml = PPM.Item.Title;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articledate")
                                    {
                                        temp.InnerHtml = PPM.Item.DateCreated.ToShortDateString();
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articleviewcount")
                                    {
                                        temp.InnerHtml = PPM.Item.Viewed.ToString();
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articletag")
                                    {
                                        temp.InnerHtml = PPM.Item.Tag;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articlewritername")
                                    {
                                        temp.InnerHtml = PPM.Item.WriterName;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articlewriteremail")
                                    {
                                        temp.InnerHtml = PPM.Item.WriterEmail;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articlecategory")
                                    {
                                        temp.InnerHtml = PPM.Item.CategoryName;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                    else if (att.Value == "articledescription")
                                    {
                                        temp.InnerHtml = PPM.Item.OGDescription;
                                        foreach (var child in temp.ChildNodes)
                                        {
                                            ds.ParentNode.InsertAfter(child, current);
                                            current = child;
                                        }
                                        ds.Remove();
                                    }
                                }
                            }
                            catch { }
                        }
                    }

                    PPM.Item.Text = doc.DocumentNode.OuterHtml;
                }
                PPM.Item.Text = dsm.ParseAndPopulate(PPM.Item.Text);
                #endregion

            }
        }        
    }
}