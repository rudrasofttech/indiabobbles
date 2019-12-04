using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_MemberList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin))
        {
            Response.Redirect("default.aspx");
        }

        if (Mode == "delete")
        {
            DeleteMember();
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            Bind(0);
        }
    }

    private void DeleteMember()
    {
        try
        {
            MemberManager mm = new MemberManager();
            MemberManager.Delete(ID);
            Response.Redirect("memberlist.aspx");
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to delete member.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    private void Bind(int pageIndex)
    {
        try
        {
            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                string query = "SELECT ID, Email, Createdate, Newsletter, UserType, MemberName, Status, Password, Mobile " +
                " FROM Member AS M WHERE UserType <> 1 ";

                if (MemberTypeDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(UserType = {1})", query, MemberTypeDropDown.SelectedValue);
                }

                if (StatusDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(Status = {1})", query, StatusDropDown.SelectedValue);
                }

                if (SubscribeList.SelectedValue != "")
                {
                    query = string.Format("{0} AND(Newsletter = {1})", query, SubscribeList.SelectedValue);
                }

                query = string.Format("{0} ORDER BY CreateDate desc ", query);

                MemberGridView.DataSource = db.ExecuteQuery<Member>(query, new object[] { }).ToList<Member>();
                MemberGridView.PageIndex = pageIndex;
                MemberGridView.DataBind();
            }
        }
        catch(Exception ex)
        {
            Trace.Write("Unable to fetch member records.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Bind(0);
    }

    protected void MemberGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Bind(e.NewPageIndex);
    }
    protected void MemberGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1)
        {
            switch (e.Row.Cells[4].Text)
            {
                case "2":
                    e.Row.Cells[4].Text = "Author";
                    break;
                case "3":
                    e.Row.Cells[4].Text = "Member";
                    break;
            }

            switch (e.Row.Cells[6].Text)
            {
                case "0":
                    e.Row.Cells[6].Text = "Active";
                    break;
                case "2":
                    e.Row.Cells[6].Text = "Deleted";
                    break;
                case "1":
                    e.Row.Cells[6].Text = "Inactive";
                    break;
            }
        }
    }
    protected void MemberGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove") {
            try {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    Member m = dc.Members.SingleOrDefault(t => t.ID == int.Parse(e.CommandArgument.ToString()));
                    if (m != null)
                    {
                        dc.Members.DeleteOnSubmit(m);
                        dc.SubmitChanges();
                        Bind(MemberGridView.PageIndex);
                    }
                }
            }
            catch(Exception ex) {
                message.Visible = true;
                message.Text = string.Format("Error: {0}", ex.Message);
                message.Indicate = AlertType.Error;
                message.Heading = "Oh Snap!";
            }
            
        }
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
        {
            foreach (GridViewRow row in MemberGridView.Rows)
            {
                if (row.RowIndex > -1)
                {
                    CheckBox ck = row.FindControl("cbSelect") as CheckBox;
                    if (ck.Checked)
                    {
                        Literal lt = row.FindControl("MemberIDLt") as Literal;
                        Member m = dc.Members.SingleOrDefault(t => t.ID == int.Parse(lt.Text));
                        if (m != null)
                        {
                            try
                            {
                                dc.Members.DeleteOnSubmit(m);
                                dc.SubmitChanges();
                            }
                            catch (Exception ex)
                            {
                                message.Visible = true;
                                message.Text = string.Format("{0} is not delete. Error: {1}", m.UserName, ex.Message);
                                message.Indicate = AlertType.Error;
                                message.Heading = "Oh Snap!";
                            }
                        }
                    }
                }
            }
            
        }
        Bind(MemberGridView.PageIndex);
    }
}