using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_Default : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor,MemberTypeType.Author))
        {
            Response.Redirect("default.aspx");
        }
    }
    protected void ArticleGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "TopStory")
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    TopStory ts = new TopStory();
                    ts.CreatedBy = CurrentUser.ID;
                    ts.DateCreated = DateTime.UtcNow;
                    ts.PostId = long.Parse(e.CommandArgument.ToString());
                    dc.TopStories.InsertOnSubmit(ts);
                    dc.SubmitChanges();
                    Response.Redirect("topstory.aspx");
                }
            }
            catch (Exception ex)
            {
                message1.Text = string.Format("Unable to set top story. Error - {0}", ex.Message);
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
                Trace.Write("Unable to set top story.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
        else if (e.CommandName == "DeleteCommand")
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var item = (from u in dc.Posts where u.ID == int.Parse(e.CommandArgument.ToString()) select u).SingleOrDefault();
                    if (item != null)
                    {
                        try
                        {
                            System.IO.File.Delete(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", item.ID, Utility.CustomPageFolder)));
                        }
                        catch (Exception iex)
                        {
                            Trace.Write("Unable to delete article file.");
                            Trace.Write(iex.Message);
                            Trace.Write(iex.StackTrace);
                            Trace.Write(iex.Source);
                        }
                        dc.Posts.DeleteOnSubmit(item);
                        dc.SubmitChanges();
                    }
                }
                Response.Redirect("default.aspx");
            }
            catch (Exception ex)
            {
                message1.Text = string.Format("Unable to delete article. Error - {0}", ex.Message);
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
                Trace.Write("Unable to delete article.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
                Trace.Write(ex.Source);
            }
        }

    }
}