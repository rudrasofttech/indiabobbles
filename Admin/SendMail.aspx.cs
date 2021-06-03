using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_SendMail : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin, MemberTypeType.Editor))
        {
            Response.Redirect("default.aspx");
        }
        if (!Page.IsPostBack && !Page.IsCallback)
        {

            Member m = MemberManager.GetUser(ID);
            if (m != null)
            {
                ToNameTextBox.Text = m.MemberName;
                ToEmailTextBox.Text = m.Email;

                
            }

            if(Request["email"] != null)
            {
                ToEmailTextBox.Text = Request["email"].ToString();
            }
            if (Request["name"] != null)
            {
                ToNameTextBox.Text = Request["name"].ToString();
            }
            FromEmailTextBox.Text = Utility.NewsletterEmail;
            FromNameTextBox.Text = Utility.AdminName;
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            EmailMessage em = new EmailMessage();
            em.CCAdress = string.Empty;
            em.CreateDate = DateTime.Now;
            em.EmailGroup = EGroupTextBox.Text.Trim();
            em.EmailType = byte.Parse(ETypeList.SelectedValue);
            em.FromAddress = FromEmailTextBox.Text.Trim();
            em.FromName = FromNameTextBox.Text.Trim();
            em.ID = Guid.NewGuid();
            em.Message = MessageTextBox.Text.Trim();
            em.Subject = SubjectTextBox.Text.Trim();
            em.ToAddress = ToEmailTextBox.Text.Trim();
            em.ToName = ToNameTextBox.Text.Trim();
            if (EmailManager.SendMail(em))
            {
                message1.Text = "Mail Sent Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
            else
            {
                message1.Text = "Failure";
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
            }
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