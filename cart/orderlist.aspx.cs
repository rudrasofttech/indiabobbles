using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class cart_orderlist : BasePage
{
    public OrderManager om = new OrderManager();
    public List<Order> OrderList = new List<Order>();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void SearchButton_Click(object sender, EventArgs e)
    {
        OrderList.AddRange(om.GetOrderList(KeywordTextBox.Text.Trim()));
    }
}