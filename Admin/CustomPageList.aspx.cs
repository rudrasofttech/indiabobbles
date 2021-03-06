﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_CustomPageList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor))
        {
            Response.Redirect("default.aspx");
        }

        UserIDHidden.Value = CurrentUser.ID.ToString();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {

    }
    protected void PageGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteCommand")
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var item = (from u in dc.CustomPages where u.ID == int.Parse(e.CommandArgument.ToString()) select u).SingleOrDefault();
                    if (item != null)
                    {
                        try
                        {
                            System.IO.File.Delete(Server.MapPath(string.Format("{1}/cpagexml-{0}.txt", item.ID, Utility.CustomPageFolder)));
                        }
                        catch (Exception iex)
                        {
                            Trace.Write("Unable to delete custom page file.");
                            Trace.Write(iex.Message);
                            Trace.Write(iex.StackTrace);
                            Trace.Write(iex.Source);
                        }
                        dc.CustomPages.DeleteOnSubmit(item);
                        dc.SubmitChanges();
                    }
                }
                Response.Redirect("custompagelist.aspx");
            }
            catch(Exception ex)
            {
                message1.Text =string.Format("Unable to delete the page. Error - {0}", ex.Message);
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
                Trace.Write("Unable to delete page.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
                Trace.Write(ex.Source);
            }
        }
    }
}