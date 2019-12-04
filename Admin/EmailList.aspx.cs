using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_EmailList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor))
        {
            Response.Redirect("default.aspx");
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            Bind(0);
        }
    }

    private void Bind(int pageIndex)
    {
        try
        {
            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                string query = "SELECT [ID], [ToAddress], [LastAttempt], [ToName], [ReadDate], [EmailGroup], [EmailType], [IsSent], [IsRead], [CreateDate], [SentDate], [Subject] FROM [EmailMessage] WHERE 1=1 ";

                if (KeywordTextBox.Text.Trim() != "")
                {
                    query = string.Format("{0} AND([ToName] like '%{1}%' OR [Subject] like '%{1}%' OR [Message] like '%{1}%')", query, KeywordTextBox.Text.Trim());
                }

                if (TypeDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([EmailType] = {1})", query, TypeDropDown.SelectedValue);
                }
                
                if (GroupDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(EmailGroup = '{1}')", query, GroupDropDown.SelectedValue);
                }

                if (SentDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([IsSent] = {1})", query, SentDropDown.SelectedValue);
                }

                if (ReadDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([IsRead] = {1})", query, ReadDropDown.SelectedValue);
                }

                query = string.Format("{0} ORDER BY CreateDate desc ", query);

                EmailGrid.DataSource = db.ExecuteQuery<EmailMessage>(query, new object[] { }).ToList<EmailMessage>();
                EmailGrid.PageIndex = pageIndex;
                EmailGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to fetch email records.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Bind(0);
    }
    protected void EmailGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Bind(e.NewPageIndex);
    }
    
    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
        {
            foreach (GridViewRow row in EmailGrid.Rows)
            {
                if (row.RowIndex > -1)
                {
                    CheckBox ck = row.FindControl("cbSelect") as CheckBox;
                    if (ck.Checked)
                    {
                        Literal lt = row.FindControl("EmailIDLt") as Literal;
                        var em = dc.EmailMessages.SingleOrDefault(m => m.ID.ToString() == lt.Text);
                        if (em != null)
                        {
                            dc.EmailMessages.DeleteOnSubmit(em);
                            
                        }
                    }
                }
            }
            dc.SubmitChanges();
        }
        Bind(EmailGrid.PageIndex);
    }
}