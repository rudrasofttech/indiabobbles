using IndiaBobbles;
using IndiaBobbles.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class popup_agnisubscribe : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Page.Validate("subscribegrp");
        if (Page.IsValid)
        {
            if (CheckBox1.Checked)
            {
                SubscribeMember();
            }
            else
            {
                message.Visible = true;
                message.Heading = "Oh Snap!";
                message.Text = "Please check you have not given us the permission to send you email.";
                message.Indicate = AlertType.Error;
            }
        }
    }

    private void SendEmail(string email, string name)
    {
        string emessage = "<img src='http://www.indiabobbles.com/drive/theme/khichdi/img/agni-game.jpg' />";
        string subject = "AGNI Coming Soon";
        EmailManager.SendMail(Utility.NewsletterEmail, email, Utility.SiteName, name, emessage, subject, EmailMessageType.Activation, EmailMessageType.Activation.ToString());
        EmailManager.SendMail(Utility.NewsletterEmail, "preeti.singh@rudrasofttech.com", Utility.SiteName, "Preeti", name + " " + email + " subscribed", "Subscribed", EmailMessageType.Communication, EmailMessageType.Communication.ToString());
        EmailManager.SendMail(Utility.NewsletterEmail, "rajkiran.singh@rudrasofttech.com", Utility.SiteName, "Raj Kiran Singh", name + " " + email + " subscribed", "Subscribed", EmailMessageType.Communication, EmailMessageType.Communication.ToString());
    }

    private void SubscribeMember()
    {
        try
        {
            if (MemberManager.EmailExist(txtEmail.Text.Trim()))
            {
                MemberManager.ToggleSubscriptionUser(MemberManager.GetUser(txtEmail.Text.Trim()).ID, true);
                SendEmail(txtEmail.Text.Trim(), txtName.Text.Trim());
                message.Visible = true;
                message.Heading = "Good!";
                message.Text = "We have sent a thank you email.";
                message.Indicate = AlertType.Success;
            }
            else
            {
                string password = string.Format("{0}{1}{2}", Utility.UniversalPassword, DateTime.Now.Minute.ToString(), DateTime.Now.Second.ToString());
                if (MemberManager.CreateUser(txtEmail.Text.Trim(), password, true, txtName.Text.Trim(), null, string.Empty))
                {
                    SendEmail(txtEmail.Text.Trim(), txtName.Text.Trim());
                    message.Visible = true;
                    message.Heading = "Good!";
                    message.Text = "We have sent a thank you email.";
                    message.Indicate = AlertType.Success;
                }
            }
        }
        catch (Exception ex)
        {
            message.Visible = true;
            message.Heading = "Oh Snap!";
            message.Text = "Unable to process your request.";
            message.Indicate = AlertType.Error;
            Trace.Write(ex.Message);
        }
    }
}