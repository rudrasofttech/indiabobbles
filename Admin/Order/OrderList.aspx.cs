using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Admin_OrderList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1) {
            switch (e.Row.Cells[2].Text) { 
                case "2" :
                    e.Row.Cells[2].Text = "New";
                    e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                    break;
                case "3":
                    e.Row.Cells[2].Text = "Process";
                    e.Row.Cells[2].ForeColor = System.Drawing.Color.Green;
                    break;
                case "4":
                    e.Row.Cells[2].Text = "Card by Paid";
                    break;
                case "5":
                    e.Row.Cells[2].Text = "Cash on Delivery";
                    break;
                case "6":
                    e.Row.Cells[2].Text = "Shipped";
                    break;
                case "7":
                    e.Row.Cells[2].Text = "Complete";
                    break;
                case "8":
                    e.Row.Cells[2].Text = "Refund";
                    break;
                case "9":
                    e.Row.Cells[2].Text = "Deleted";
                    break;
            }
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        OrderManager om = new OrderManager();
        om.DeleteOrder(Convert.ToInt32(e.CommandArgument.ToString()));
        GridView1.DataBind();
    }
}