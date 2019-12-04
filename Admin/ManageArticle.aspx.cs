using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_ManageArticle : AdminPage
{
    Article a = new Article();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor, MemberTypeType.Author))
        {
            Response.Redirect("default.aspx");
        }

        if (Mode == "edit")
        {
            PopulateArticle();
        }

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            TemplateDropDown.Items.Clear();
            TemplateDropDown.Items.Add(new ListItem("-- Select --", ""));
            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {

                foreach (CustomDataSource item in dc.CustomDataSources)
                {
                    TemplateDropDown.Items.Add(new ListItem(item.Name, item.Name));
                }
            }
            if (Mode == "edit")
            {
                PopulateForm();
            }
        }
    }

    private void PopulateArticle()
    {
        using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
        {
            try
            {
                a = Utility.Deserialize<Article>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", ID, Utility.ArticleFolder))));
                if (string.IsNullOrEmpty(a.MetaTitle))
                {
                    a.MetaTitle = a.Title;
                }
            }
            catch (Exception ex)
            {
                a = new Article();
                Trace.Write("Unable to read xml file of article.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
                Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
                if (p != null)
                {
                    a.Category = p.Category;
                    a.CreatedBy = p.CreatedBy;
                    a.DateCreated = p.DateCreated;
                    a.DateModified = p.DateModified;
                    a.Description = p.Description;
                    a.ID = p.ID;
                    a.ModifiedBy = p.ModifiedBy;
                    a.Status = (PostStatusType)Enum.Parse(typeof(PostStatusType), p.Status.ToString());
                    a.Tag = p.Tag;
                    a.Title = p.Title;
                    a.WriterEmail = p.WriterEmail;
                    a.WriterName = p.WriterName;
                    a.Viewed = p.Viewed;
                    a.Sitemap = p.Sitemap;
                    a.URL = p.URL;
                    try
                    { 
                        a.Text = System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/article-{0}.txt", p.ID, Utility.ArticleFolder)));
                    }
                    catch (Exception ex2)
                    {
                        Trace.Write(ex2.Message);
                        Trace.Write(ex2.StackTrace);
                    }
                }
                else
                {
                    Response.Redirect("default.aspx");
                }
            }
        }
    }

    private void PopulateForm()
    {
        TitleTextBox.Text = a.Title;
        TagTextBox.Text = a.Tag;
        WriterTextBox.Text = a.WriterName;
        WriterEmailTextBox.Text = a.WriterEmail;
        CategoryDropDown.SelectedValue = a.Category.ToString();
        FacebookImageTextBox.Text = a.OGImage;
        FacebookDescTextBox.Text = a.OGDescription;
        StatusDropDown.SelectedValue = ((byte)a.Status).ToString();
        TemplateDropDown.SelectedValue = a.TemplateName;
        DescTextBox.Text = a.Description;
        TextTextBox.Text = a.Text;
        SitemapCheckBox.Checked = a.Sitemap;
        URLTextBox.Text = a.URL;
        MetaTitleTextBox.Text = a.MetaTitle;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("VideoGrp");
        if (!Page.IsValid) return;

        try
        {
            a.Category = int.Parse(CategoryDropDown.SelectedValue);
            a.Description = DescTextBox.Text.Trim();
            a.OGDescription = FacebookDescTextBox.Text.Trim();
            a.OGImage = FacebookImageTextBox.Text.Trim();
            a.TemplateName = TemplateDropDown.SelectedValue;
            a.Status = (PostStatusType)Enum.Parse(typeof(PostStatusType), StatusDropDown.SelectedValue);
            a.Tag = TagTextBox.Text.Trim();
            a.Text = TextTextBox.Text.Trim();
            a.Title = TitleTextBox.Text.Trim();
            a.WriterEmail = WriterEmailTextBox.Text.Trim();
            a.WriterName = WriterTextBox.Text.Trim();
            a.URL = URLTextBox.Text.Trim();
            a.Sitemap = SitemapCheckBox.Checked;
            a.MetaTitle = MetaTitleTextBox.Text.Trim();
            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {
                if (Mode == "edit")
                {
                    Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
                    p.Category = a.Category;
                    p.DateModified = DateTime.Now;
                    p.Description = a.Description;
                    p.ID = ID;
                    p.ModifiedBy = CurrentUser.ID;
                    p.Status = (byte)a.Status;
                    p.Tag = a.Tag;
                    p.Title = a.Title;
                    p.WriterEmail = a.WriterEmail;
                    p.WriterName = a.WriterName;
                    p.OGDescription = a.OGDescription;
                    p.OGImage = a.OGImage;
                    p.URL = a.URL;
                    p.Sitemap = a.Sitemap;
                    dc.SubmitChanges();
                    string str = Utility.Serialize<Article>(a);
                    System.IO.File.WriteAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", p.ID, Utility.ArticleFolder)), str);
                }
                else
                {
                    Post p = new Post();
                    p.Category = a.Category;
                    p.DateCreated = DateTime.Now;
                    p.Description = a.Description;
                    p.CreatedBy = CurrentUser.ID;
                    p.Status = (byte)a.Status;
                    p.Tag = a.Tag;
                    p.Title = a.Title;
                    p.WriterEmail = a.WriterEmail;
                    p.WriterName = a.WriterName;
                    p.OGDescription = a.OGDescription;
                    p.OGImage = a.OGImage;
                    p.Article = string.Empty;
                    p.URL = a.URL;
                    p.Sitemap = a.Sitemap;
                    dc.Posts.InsertOnSubmit(p);
                    dc.SubmitChanges();
                    string str = Utility.Serialize<Article>(a);
                    System.IO.File.WriteAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", p.ID, Utility.ArticleFolder)), str);
                }
            }

            Response.Redirect("default.aspx");
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("Unable to save article. {0}", ex.Message);
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save article.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
        {
            if (Mode == "edit") {
                Post p = (from t in dc.Posts where t.ID != ID && t.URL == URLTextBox.Text.Trim() select t).SingleOrDefault();
                if (p != null)
                {
                    args.IsValid = false;
                }
                else {
                    args.IsValid = true;
                }
            }
            else {
                Post p = (from t in dc.Posts where t.URL == URLTextBox.Text.Trim() select t).SingleOrDefault();
                if (p != null)
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
        }
    }
    protected void TitleTextBox_TextChanged(object sender, EventArgs e)
    {
        URLTextBox.Text = Utility.Slugify(TitleTextBox.Text.Trim());
    }
    protected void URLTextBox_TextChanged(object sender, EventArgs e)
    {
        URLTextBox.Text = Utility.Slugify(URLTextBox.Text.Trim());
    }
}