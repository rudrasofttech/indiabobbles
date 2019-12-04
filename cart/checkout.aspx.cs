using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;

public partial class cart_checkout : BasePage
{
    public OrderManager om = new OrderManager();
    public Order o;
    public string SuccessURL = "http://www.indiabobbles.com/cart/payumoneyresponse.aspx?id=";
    public string FailureURL = "http://www.indiabobbles.com/cart/checkout.aspx?id=";
    public string CancelURL = "http://www.indiabobbles.com/cart/checkout.aspx?id=";
    protected void Page_Load(object sender, EventArgs e)
    {
        o = om.GetCart();
        SuccessURL = SuccessURL + o.ID;
        FailureURL = FailureURL + o.ID;
        CancelURL = CancelURL + o.ID;
        CODFeeInfoLabel.Text = string.Format("Rs. {0} will be charged extra as Cash on Delivery fee.", om.CODFee);
        if (o.OrderItems.Count == 0)
        {
            Response.Redirect("~/cart/cart.aspx");
        }
        om.UpdateTotal(o.ID);

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            PopulateData();
            if (!om.CODAllowed(o.ShippingZip))
            {
                BuyNowButton.Visible = false;
                CODFeeInfoLabel.Visible = false;
            }
        }
    }

    private void PopulateData()
    {
        CartGridView.DataSource = o.OrderItems;
        CartGridView.DataBind();
    }

    protected void BuyNowButton_Click(object sender, EventArgs e)
    {
        om.UpdatePaymentMode(o.ID, "COD");

        om.UpdateCOD(o.ID);

        om.UpdateTotal(o.ID);

        om.UpdateOrderStatus(o.ID, OrderStatusType.Process, "");
        string body = om.GenerateReceipt(o.ID);
        try
        {
            EmailManager.SendMail(Utility.NewsletterEmail, o.Email, Utility.AdminName, o.Name, body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
            EmailManager.SendMail(Utility.NewsletterEmail, "Preeti@indiabobbles.com", Utility.AdminName, "Preeti Singh", body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
            
            EmailManager.SendMail(Utility.NewsletterEmail, "rajkiran.singh@rudrasofttech.com", Utility.AdminName, "Raj Kiran Singh", body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
            EmailManager.SendMail(Utility.NewsletterEmail, "preeti.singh@rudrasofttech.com", Utility.AdminName, "Preeti Singh", body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
        }
        catch (Exception ex) { Trace.Write(ex.Message); }
        CookieWorker.RemoveCookie(CookieWorker.OrderIdKey);
        Response.Redirect("~/cart/receipt.aspx?id=" + o.ID);
    }

    public string Generatehash512(string text)
    {

        byte[] message = Encoding.UTF8.GetBytes(text);
        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;

    }

    private string PreparePOSTForm(string url, System.Collections.Hashtable data)      // post form
    {
        //Set a name for the form
        string formID = "PostForm";
        //Build the form using the specified data to be posted.
        StringBuilder strForm = new StringBuilder();
        strForm.Append("<form id=\"" + formID + "\" name=\"" +
                       formID + "\" action=\"" + url +
                       "\" method=\"POST\">");

        foreach (System.Collections.DictionaryEntry key in data)
        {

            strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                           "\" value=\"" + key.Value + "\">");
        }

        strForm.Append("</form>");
        //Build the JavaScript which will do the Posting operation.
        StringBuilder strScript = new StringBuilder();
        strScript.Append("<script language='javascript'>");
        strScript.Append("var v" + formID + " = document." +
                         formID + ";");
        strScript.Append("v" + formID + ".submit();");
        strScript.Append("</script>");
        //Return the form and the script concatenated.
        //(The order is important, Form then JavaScript)
        return strForm.ToString() + strScript.ToString();
    }

    private string GetProductInfoForPaisaPay(Order or)
    {
        StringBuilder builder = new StringBuilder();
        foreach (OrderItem oi in or.OrderItems)
        {
            builder.Append("Item: ");
            builder.Append(oi.ProductCode);
            builder.Append(", Quantity: ");
            builder.Append(oi.Quantity);
            builder.Append(", Amount: ");
            builder.Append(oi.Amount);
            builder.Append(Environment.NewLine);
        }
        return builder.ToString();
    }

    //protected void PaymentList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    om.UpdatePaymentMode(o.ID, PaymentList.SelectedValue);
    //    if (PaymentList.SelectedValue == "COD")
    //    {
    //        om.UpdateCOD(o.ID);
    //    }
    //    om.UpdateTotal(o.ID);
    //    Response.Redirect("~/cart/checkout.aspx");
    //}

    protected void ApplyButton_Click(object sender, EventArgs e)
    {
        om.UpdateCouponCode(o.ID, CouponTextBox.Text.Trim());
        om.UpdateTotal(o.ID);
        Response.Redirect("~/cart/checkout.aspx");
    }
    protected void PayCCBtn_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            om.UpdatePaymentMode(o.ID, "CC");
            string[] hashVarsSeq;
            string hash_string = string.Empty;
            string action1 = string.Empty;
            string hash1 = string.Empty;
            string txnid1 = o.ID.ToString();
            string productInfo = GetProductInfoForPaisaPay(o);

            // generating hash value
            hashVarsSeq = ConfigurationManager.AppSettings["hashSequence"].Split('|'); // spliting hash sequence from config
            hash_string = "";
            foreach (string hash_var in hashVarsSeq)
            {
                if (hash_var == "key")
                {
                    hash_string = hash_string + ConfigurationManager.AppSettings["MERCHANT_KEY"];
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "txnid")
                {
                    hash_string = hash_string + txnid1;
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "amount")
                {
                    hash_string = hash_string + o.Total.ToString("g29");
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "productinfo")
                {
                    hash_string = hash_string + "IndiaBobblesProducts";
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "firstname")
                {
                    hash_string = hash_string + o.Name;
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "email")
                {
                    hash_string = hash_string + o.Email;
                    hash_string = hash_string + '|';
                }
                else
                {
                    hash_string = hash_string + (Request.Form[hash_var] != null ? Request.Form[hash_var] : "");// isset if else
                    hash_string = hash_string + '|';
                }
            }

            hash_string += ConfigurationManager.AppSettings["SALT"];// appending SALT
            //Response.Write(hash_string);
            hash1 = Generatehash512(hash_string).ToLower();         //generating hash
            //Response.Write("<br/>");
            //Response.Write(hash1);
            action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";// setting URL

            System.Collections.Hashtable data = new System.Collections.Hashtable(); // adding values in gash table for data post
            data.Add("hash", hash1);
            data.Add("txnid", txnid1);
            data.Add("key", ConfigurationManager.AppSettings["MERCHANT_KEY"]);
            string AmountForm = o.Total.ToString("g29");// eliminating trailing zeros
            data.Add("amount", AmountForm);
            data.Add("firstname", o.Name);
            data.Add("email", o.Email);
            data.Add("phone", o.Phone);
            data.Add("productinfo", "IndiaBobblesProducts");
            data.Add("surl", SuccessURL);
            data.Add("furl", FailureURL);
            data.Add("lastname", "");
            data.Add("curl", CancelURL);
            data.Add("address1", o.BillingAddress);
            data.Add("address2", "");
            data.Add("city", o.BillingCity.Trim());
            data.Add("state", o.BillingState.Trim());
            data.Add("country", o.BillingCountry.Trim());
            data.Add("zipcode", o.BillingZip.Trim());
            data.Add("udf1", "");
            data.Add("udf2", "");
            data.Add("udf3", "");
            data.Add("udf4", "");
            data.Add("udf5", "");
            data.Add("pg", "");
            data.Add("service_provider", "payu_paisa");
            string strForm = PreparePOSTForm(action1, data);
            Page.Controls.Add(new LiteralControl(strForm));
        }
        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");
        }

    }
}