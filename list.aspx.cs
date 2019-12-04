using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles.Models;
using IndiaBobbles;

public partial class list : BasePage
{
    public CategoryPageModel CPM { get; set; }
    private string CategoryName { get; set; }
    private int Year { get; set; }
    private int Month { get; set; }
    private int Day { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        CPM = new CategoryPageModel();
        CategoryName = string.Empty;
        if (Page.RouteData.Values["category"] != null)
        {
            CategoryName = Page.RouteData.Values["category"].ToString();
            Trace.Write(string.Format("Category: {0}", CategoryName));
        }
        
        try
        {
            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {
                var item = (from t in dc.Categories
                            where t.UrlName == CategoryName
                                && t.Status == (byte)GeneralStatusType.Active
                            select t).SingleOrDefault();
                if (item != null)
                {
                    CPM.Current = item;
                    CPM.ChildList.AddRange(item.Categories.ToList());
                }
                else
                {
                    CPM.ChildList.AddRange(new List<Category>());
                }
                var items = from t in dc.Posts
                            where t.Status == (byte)PostStatusType.Publish &&
                            (CategoryName == string.Empty || t.Category1.UrlName == CategoryName) 
                            orderby t.DateCreated descending
                            select t;
                foreach (var i in items)
                {
                    Article a = new Article();
                    a.Category = i.Category;
                    a.CategoryName = i.Category1.Name;
                    a.CreatedBy = i.CreatedBy;
                    a.CreatedByName = i.Member.MemberName;
                    a.DateCreated = i.DateCreated;
                    a.DateModified = i.DateModified;
                    a.Description = i.Description;
                    a.ID = i.ID;
                    a.ModifiedBy = i.ModifiedBy;
                    a.Status = (PostStatusType)i.Status;
                    a.Tag = i.Tag;
                    a.Text = string.Empty;
                    a.Title = i.Title;
                    a.WriterEmail = i.WriterEmail;
                    a.WriterName = i.WriterName;
                    a.OGDescription = i.OGDescription;
                    a.OGImage = i.OGImage;
                    a.Viewed = i.Viewed;
                    a.URL = i.URL;
                    CPM.ArticleList.Add(a);
                }

            }
        }
        catch (Exception ex)
        {
            Trace.Write("Invalid Category");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}