﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using IndiaBobbles.Models;
using IndiaBobbles;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Action = string.Format("login{0}", Request.Url.Query);
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate("logingrp");
            if (!Page.IsValid) return;

            if (MemberManager.ValidateUser(EmailTextBox.Text, PasswordTextBox.Text))
            {
                FormsAuthentication.SetAuthCookie(EmailTextBox.Text.Trim(), RememberCheckBox.Checked);
                Member m = MemberManager.UpdateLastLogon(EmailTextBox.Text.Trim());
                if (m.UserType == (byte)MemberTypeType.Admin || m.UserType == (byte)MemberTypeType.Author)
                {
                    Response.Redirect("~/admin/CustomPageList.aspx");
                }
                else
                {
                    Response.Redirect(string.Format("//{0}", Request.Url.Host));
                }
            }
            else
            {
                message1.Text = Resources.Resource.LoginFailure;
                message1.Visible = true;
                message1.Heading = Resources.Resource.WarningHeading;
                message1.Indicate = AlertType.Error;
            }
        }
        catch (Exception ex)
        {
            message1.Text = Resources.Resource.GenericMessage;
            message1.Visible = true;
            message1.Heading = Resources.Resource.WarningHeading;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to login in to rockying.com.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }

    }
}