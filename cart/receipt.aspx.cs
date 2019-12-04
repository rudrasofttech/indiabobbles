using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class cart_receipt : BasePage
{
    public OrderManager om = new OrderManager();
    public Order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            o = om.GetOrderDetail(int.Parse(Request.QueryString["id"].Trim()));
        }
        else
        {
            Response.Redirect(Utility.SiteURL);
        }
    }
}