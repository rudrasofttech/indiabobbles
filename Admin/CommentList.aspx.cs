using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_CommentList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CommentGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        CacheManager.Remove("DraftCommentCount");
        CacheManager.Remove("AllCommentCount");
    }
}