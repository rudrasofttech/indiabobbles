using System;
using System.Data;
using System.Linq;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Text;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class cart_payumoneyresponse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            string[] merc_hash_vars_seq;
            string merc_hash_string = string.Empty;
            string merc_hash = string.Empty;
            string order_id = string.Empty;
            string hash_seq = "key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";

            if (Request.Form["status"] == "success")
            {

                merc_hash_vars_seq = hash_seq.Split('|');
                Array.Reverse(merc_hash_vars_seq);
                merc_hash_string = ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];


                foreach (string merc_hash_var in merc_hash_vars_seq)
                {
                    merc_hash_string += "|";
                    merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");

                }
                Response.Write(merc_hash_string);
                merc_hash = Generatehash512(merc_hash_string).ToLower();
                if (merc_hash != Request.Form["hash"])
                {
                    Response.Write("Hash value did not matched");
                }
                else
                {
                    order_id = Request.Form["txnid"];
                    Response.Write("value matched");
                    if (Request.Form["mihpayid"] != null)
                    {
                        string payumoneytransid = Request.Form["mihpayid"];
                        string paymentmode = Request.Form["mode"];
                        string status = Request.Form["status"];
                        string payuMoneyId = Request.Form["payuMoneyId"];
                        var array = (from key in Request.Form.AllKeys
                                     from value in Request.Form.GetValues(key)
                                     select string.Format("{0}={1}", HttpUtility.UrlEncode(key), HttpUtility.UrlEncode(value))).ToArray();
                        string payumoneydata = string.Join("&", array);
                        OrderManager om = new OrderManager();
                        Order o = om.GetOrderDetail(int.Parse(order_id));
                        if (o != null)
                        {
                            om.UpdateOrderPayment(o.ID, payumoneytransid, DateTime.Now, payumoneydata);
                            string notes = o.ShippingNotes;
                            om.UpdateOrderStatus(o.ID, OrderStatusType.CardPaid, notes);
                            try
                            {
                                string body = om.GenerateReceipt(o.ID);
                                EmailManager.SendMail(Utility.NewsletterEmail, o.Email, Utility.AdminName, o.Name, body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
                                EmailManager.SendMail(Utility.NewsletterEmail, "Preeti@indiabobbles.com", Utility.AdminName, "Preeti Singh", body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
                                EmailManager.SendMail(Utility.NewsletterEmail, "rajkiran.singh@rudrasofttech.com", Utility.AdminName, "Raj Kiran Singh", body, String.Format("Order Receipt : {0} from {1}", o.ID, Utility.SiteName), EmailMessageType.Communication, "Order Receipt");
                            }
                            catch (Exception ex) { Trace.Write(ex.Message); }
                            CookieWorker.RemoveCookie(CookieWorker.OrderIdKey);
                            o = om.GetOrderDetail(int.Parse(order_id));
                            Response.Redirect("~/cart/receipt.aspx?id=" + o.ID);
                        }

                    }
                }

            }

            else
            {
                Response.Write("Hash value did not matched");
            }
        }

        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");

        }
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
}