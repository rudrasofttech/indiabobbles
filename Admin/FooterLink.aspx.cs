using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_FooterLink : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor))
        {
            Response.Redirect("default.aspx");
        }

        if (Mode == "delete")
        {
            LinkManager lm = new LinkManager();
            lm.DeleteLink(ID);
            Response.Redirect("footerlink.aspx?mode=add");
        }

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            BindGrid();
            PopulateParent();
            BindForm();
        }
    }

    private void BindGrid()
    {
        LinkManager lm = new LinkManager();
        LinkGrid.DataSource = lm.GetLinkList("Footer-Link");
        LinkGrid.DataBind();
    }

    private void PopulateParent()
    {
        ParentDropDown.Items.Clear();
        ParentDropDown.Items.Add(new ListItem("--Select--", ""));
        LinkManager lm = new LinkManager();
        foreach (Link l in lm.GetLinkList("Footer-Link"))
        {
            if (ID != l.ID)
            {
                ParentDropDown.Items.Add(new ListItem(l.Text, l.ID.ToString()));
            }
        }
    }

    private void BindForm()
    {
        if (Mode == "edit")
        {
            try
            {
                LinkManager lm = new LinkManager();
                Link l = lm.GetLink(ID);
                UrlTextBox.Text = l.URL;
                TitleTextBox.Text = l.Title;
                TextTextBox.Text = l.Text;
                TargetDropDown.SelectedValue = l.Target;
                SequenceTextBox.Text = l.Sequence.ToString();
                if (l.ParentID.HasValue)
                {
                    ParentDropDown.SelectedValue = l.ParentID.Value.ToString();
                }
            }
            catch (Exception ex)
            {
                Trace.Write("Unable to load url list data.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        LinkManager lm = new LinkManager();
        int? parent = null;
        try
        {
            parent = int.Parse(ParentDropDown.SelectedValue);
        }
        catch
        {
        }
        if (Mode == "add")
        {
            lm.AddLink("Footer-Link", UrlTextBox.Text.Trim(), TitleTextBox.Text.Trim(), TextTextBox.Text.Trim(), TargetDropDown.SelectedValue, parent, int.Parse(SequenceTextBox.Text.Trim()));
        }
        else if (Mode == "edit")
        {
            lm.UpdateLink(ID, "Footer-Link", UrlTextBox.Text.Trim(), TitleTextBox.Text.Trim(), TextTextBox.Text.Trim(), TargetDropDown.SelectedValue, parent, int.Parse(SequenceTextBox.Text.Trim()));
        }

        CacheManager.Remove("FooterLink");
        Response.Redirect("footerlink.aspx?mode=add");
    }
}