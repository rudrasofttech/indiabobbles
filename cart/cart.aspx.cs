using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class cart_cart : BasePage
{
    public OrderManager om = new OrderManager();
    public Order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        o = om.GetCart();
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            PopulateData();
        }
    }

    private void PopulateData()
    {
        CartGridView.DataSource = o.OrderItems;
        CartGridView.DataBind();
        if (o.OrderItems.Count > 0)
        {
            totaldiv.Visible = true;
        }
        else {
            totaldiv.Visible = false;
        }
        AmountLabel.Text = o.Amount.ToString("##00.00");
        DiscountLiteral.Text = o.Discount.ToString("##00.00");
        CouponLiteral.Text = o.Coupon;
        if (o.Coupon != "")
        {
            couponrow.Visible = true;
        }
        else
        {
            couponrow.Visible = false;
        }
        if (o.Discount > 0)
        {
            discountrow.Visible = true;
        }
        else { discountrow.Visible = false; }
    }

    protected void CartGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            om.RemoveItem(int.Parse(e.CommandArgument.ToString()), o.ID);
            om.UpdateTotal(o.ID);
            o = om.GetCart();
            PopulateData();
        }
        else if (e.CommandName == "Add")
        {
            om.AddItemQuantity(int.Parse(e.CommandArgument.ToString()), o.ID);
            om.UpdateTotal(o.ID);
            o = om.GetCart();
            PopulateData();
        }
        else if (e.CommandName == "Subtract")
        {
            om.ReduceItemQuantity(int.Parse(e.CommandArgument.ToString()), o.ID);
            om.UpdateTotal(o.ID);
            o = om.GetCart();
            PopulateData();
        }
    }
    protected void ApplyButton_Click(object sender, EventArgs e)
    {
        om.UpdateCouponCode(o.ID, CouponTextBox.Text.Trim());
        om.UpdateTotal(o.ID);
        Response.Redirect("~/cart/cart.aspx");
    }
    protected void RemoveCouponBtn_Click(object sender, EventArgs e)
    {
        om.UpdateCouponCode(o.ID, CouponTextBox.Text.Trim());
        om.UpdateTotal(o.ID);
        Response.Redirect("~/cart/cart.aspx");
    }
}