using IndiaBobbles;
using IndiaBobbles.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MailForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void SendButton_Click(object sender, EventArgs e)
    {
        Page.Validate("mailgrp");
        if (!Page.IsValid) return;

        try
        {
            EmailMessage em = new EmailMessage();
            em.CCAdress = string.Empty;
            em.CreateDate = DateTime.Now;
            em.EmailGroup = "SahilCallingDaku";
            em.EmailType = (byte)EmailMessageType.Communication;
            em.FromAddress = "preeti@indiabobbles.com";
            em.FromName = "Preeti Singh";
            em.ID = Guid.NewGuid();
            em.Message = MessageTextBox.Text.Trim().Replace(Environment.NewLine, "<br />");
            em.Subject = SubjectTextBox.Text.Trim();
            em.ToAddress = ToTextBox.Text.Trim();
            em.ToName = TonameTextBox.Text.Trim();
            EmailManager.SendMail(em);
            message1.Text = "Mail Sent Successfuly";
            message1.Visible = true;
            message1.Indicate = AlertType.Success;
            TonameTextBox.Text = "";
            ToTextBox.Text = "";
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to send email.";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to send email.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}