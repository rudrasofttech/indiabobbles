using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_ManageOrder : AdminPage
{
    OrderManager om = new OrderManager();
    Order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        o = om.GetOrderDetail(int.Parse(Request.QueryString["orderid"]));
        if (!Page.IsCallback && !Page.IsPostBack) {
            ReceiptLink.NavigateUrl = Page.ResolveUrl("~/cart/receipt.aspx?id=" + o.ID);
            StatusDropDown.SelectedValue = o.Status.ToString();
            TrackTextBox.Text = o.ShippingTrackCode;
            ShippingServiceTextBox.Text = o.ShippingService;
            ShippingNotesTextBox.Text = o.ShippingNotes;
            DetailTextBox.Text = o.TransactionDetail;
        }
    }
    protected void OrderDetailView_DataBound(object sender, EventArgs e)
    {
        if (OrderDetailView.CurrentMode == DetailsViewMode.ReadOnly)
        {
            if (OrderDetailView.DataItem != null)
            {
                switch (OrderDetailView.Rows[17].Cells[1].Text)
                {
                    case "1":
                        OrderDetailView.Rows[17].Cells[1].Text = "New";
                        break;
                    case "2":
                        OrderDetailView.Rows[17].Cells[1].Text = "Process";
                        break;
                    case "3":
                        OrderDetailView.Rows[17].Cells[1].Text = "Paid By Card";
                        break;
                    case "4":
                        OrderDetailView.Rows[17].Cells[1].Text = "Paid By COD";
                        break;
                    case "5":
                        OrderDetailView.Rows[17].Cells[1].Text = "Shipped";
                        break;
                    case "6":
                        OrderDetailView.Rows[17].Cells[1].Text = "Complete";
                        break;
                    case "7":
                        OrderDetailView.Rows[17].Cells[1].Text = "Refund";
                        break;
                }
            }
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        om.UpdateOrderStatus(o.ID, (OrderStatusType)Enum.Parse(typeof(OrderStatusType), StatusDropDown.SelectedValue), ShippingNotesTextBox.Text.Trim());
        om.UpdateOrderShippingService(o.ID, ShippingServiceTextBox.Text.Trim());
        om.UpdateShippingTrackingCode(o.ID, TrackTextBox.Text);
        om.UpdateOrderTransactionDetail(o.ID, DetailTextBox.Text.Trim());
        Response.Redirect("~/admin/order/manageorder.aspx?orderid=" + o.ID);
    }
    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        om.DeleteOrder(o.ID);
        Response.Redirect("~/admin/order/orderlist.aspx");
    }
}