using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_CustomDataSourceList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin))
        {
            Response.Redirect("default.aspx");
        }
    }
    protected void SourceGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteCommand") {
            DataSourceManager dsm = new DataSourceManager();
            if (dsm.Delete(int.Parse(e.CommandArgument.ToString()))) {
                Response.Redirect("customdatasourcelist.aspx");
            }
        }
        else if (e.CommandName == "RefreshCommand")
        {
            DataSourceManager dsm = new DataSourceManager();
            dsm.Refresh(e.CommandArgument.ToString());            
        }
    }
}