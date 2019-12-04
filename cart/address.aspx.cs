using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class cart_Address : System.Web.UI.Page
{
    OrderManager om = new OrderManager();
    public Order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        o = om.GetCart();

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            PopulateForm();
        }
    }

    private void PopulateForm()
    {
        NameTextBox.Text = o.Name;
        EmailTextBox.Text = o.Email;
        PhoneTextBox.Text = o.Phone;

        BillingAddressTextBox.Text = o.BillingAddress;
        BillingCityTextBox.Text = o.BillingCity;
        BillingStateDropDown.SelectedValue = o.BillingState;
        BillingPincodeTextBox.Text = o.BillingZip;
        BillingCountryDropDown.SelectedValue = o.BillingCountry;


        ShippingFirstNameTextBox.Text = o.ShippingFirstName;
        ShippingLastNameTextBox.Text = o.ShippingLastName;
        ShippingPhoneTextBox.Text = o.ShippingPhone;
        ShippingAddressTextBox.Text = o.ShippingAddress;
        ShippingCityTextBox.Text = o.ShippingCity;
        ShippingPincodeTextBox.Text = o.ShippingZip;
        ShippingCountryDropDown.SelectedValue = o.ShippingCountry;
        ShippingStateDropDown.SelectedValue = o.ShippingState;
    }

    protected void CopyBillingButton_Click(object sender, EventArgs e)
    {
        NameTextBox.Text = string.Format("{0} {1}", ShippingFirstNameTextBox.Text.Trim(),  ShippingLastNameTextBox.Text.Trim()) ;

        PhoneTextBox.Text = ShippingPhoneTextBox.Text;
        BillingAddressTextBox.Text = ShippingAddressTextBox.Text;
        BillingCityTextBox.Text = ShippingCityTextBox.Text;
        BillingCountryDropDown.SelectedValue = ShippingCountryDropDown.SelectedValue;
        BillingPincodeTextBox.Text = ShippingPincodeTextBox.Text ;
        BillingStateDropDown.SelectedValue = ShippingStateDropDown.SelectedValue;
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        Page.Validate("addressgrp");
        if (!Page.IsValid) return;
        om.UpdateOrderContact(o.ID, NameTextBox.Text.Trim(), EmailTextBox.Text.Trim(), null, PhoneTextBox.Text.Trim());
        om.UpdateOrderBillingAddress(o.ID, BillingAddressTextBox.Text.Trim(), BillingCityTextBox.Text.Trim(), BillingStateDropDown.SelectedValue, BillingCountryDropDown.SelectedValue, BillingPincodeTextBox.Text.Trim());
        om.UpdateOrderShippingAddress(o.ID, ShippingAddressTextBox.Text.Trim(), ShippingCityTextBox.Text.Trim(), ShippingStateDropDown.Text.Trim(), ShippingCountryDropDown.SelectedValue, ShippingPincodeTextBox.Text.Trim(), ShippingFirstNameTextBox.Text.Trim(), ShippingLastNameTextBox.Text.Trim(), ShippingPhoneTextBox.Text.Trim());
        om.UpdateTotal(o.ID);
        Response.Redirect("~/cart/checkout.aspx");

    }
}