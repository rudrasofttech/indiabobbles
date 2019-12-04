using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Register : System.Web.UI.Page
{
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("logingrp");
        if (!Page.IsValid) return;

        try
        {
            string password = string.Format("{0} {1}{2}", Utility.UniversalPassword, DateTime.Now.Minute.ToString(), DateTime.Now.Second.ToString());
            if (MemberManager.CreateUser(EmailTextBox.Text.Trim(), password, NewsletterCheckBox.Checked, NameTextBox.Text.Trim(), null, string.Empty))
            {
                message1.Text = Resources.Resource.RegisterSuccessMessage;
                message1.Indicate = AlertType.Success;
                message1.Visible = true;

                SendEmail(EmailTextBox.Text.Trim(), NameTextBox.Text.Trim(), password);
            }
        }
        catch(Exception ex)
        {
            message1.Text = Resources.Resource.GenericMessage;
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
            Trace.Write("Register error");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    private void SendEmail(string email, string name, string password)
    {
        string emessage = Resources.Resource.ActivationEmail;
        string subject = Resources.Resource.ActivationEmailSubject;
        emessage = emessage.Replace("[name]", name);
        emessage = emessage.Replace("[activateurl]", string.Format("http://{0}/activate?mail={1}", Request.Url.Host, email));
        emessage = emessage.Replace("[password]", password);
        emessage = emessage.Replace(System.Environment.NewLine, "<br/>");

        EmailManager.SendMail(Utility.NewsletterEmail, email, Utility.SiteName, name, emessage, subject, EmailMessageType.Activation, EmailMessageType.Activation.ToString());
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if(MemberManager.EmailExist(EmailTextBox.Text.Trim()))
        {
            args.IsValid = false;
        }
    }
}