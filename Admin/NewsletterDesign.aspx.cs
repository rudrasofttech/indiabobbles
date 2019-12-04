using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;
using System.Text;

public partial class Admin_NewsletterDesign : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin))
        {
            Response.Redirect("default.aspx");
        }
        message1.Text = string.Empty;
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            EGroupTextBox.Text = string.Format("Newsletter {0}", DateTime.Now.ToString("d MMM yy"));
            SubjectTextBox.Text = string.Format("{0} Newsletter", Utility.SiteName);
            Bind();
        }
    }

    private void Bind()
    {
        KeyValueTextBox.Text = Utility.NewsletterDesign();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;
        try
        {
            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                WebsiteSetting rs = (from u in db.WebsiteSettings where u.KeyName == "NewsletterDesign" select u).SingleOrDefault();
                rs.KeyValue = KeyValueTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("NewsletterDesign");
                message1.Text = "Saved Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to save NewsletterDesign";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save NewsletterDesign.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void PreviewButton_Click(object sender, EventArgs e)
    {
        string emessage = System.IO.File.ReadAllText(Server.MapPath("~/EmailWrapper.htm"));
        emessage = emessage.Replace("[root]", Utility.SiteURL);
        emessage = emessage.Replace("[id]", Guid.Empty.ToString());
        emessage = emessage.Replace("[newsletteremail]", Utility.NewsletterEmail);
        emessage = emessage.Replace("[message]", KeyValueTextBox.Text.Trim());
        emessage = emessage.Replace("[toaddres]", "sample@email.com");
        emessage = emessage.Replace("[sitename]", Utility.SiteName);
        emessage = emessage.Replace("[sitetitle]", Utility.SiteTitle);
        emessage = emessage.Replace("[emailsignature]", Utility.GetSiteSetting("EmailSignature"));
        Literal1.Text = emessage;
    }

    protected void ArticleButton_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder builder = new StringBuilder();
            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                builder.Append("<ul style='list-style:none;'>\r\n");
                foreach (ListItem item in ArticleList.Items)
                {
                    if (item.Selected)
                    {
                        Post p = (from u in db.Posts where u.ID == int.Parse(item.Value) select u).SingleOrDefault();
                        if (p != null)
                        {
                            builder.Append("\t<li>\r\n");
                            builder.Append("\t\t<table border='0'>\r\n");
                            builder.Append("\t\t<tr>\r\n");
                            builder.Append("\t\t<td>\r\n");
                            builder.Append(string.Format("\t\t\t<a href='{1}/blog/{2}' target='_blank'><img src='{0}' style='max-width:150px;border:0px;' alt=''/></a>\r\n", p.OGImage, Utility.SiteURL, p.URL.ToString()));
                            builder.Append("\t\t\t</td>\r\n");
                            builder.Append("\t\t<td>\r\n");
                            builder.Append(string.Format("\t\t\t<a href='{1}/blog/{2}' target='_blank'><h3>{0}</h3></a>\r\n", p.Title, Utility.SiteURL, p.URL.ToString()));
                            builder.Append(string.Format("\t\t\t<p>{0}</p>\r\n", p.OGDescription));
                            builder.Append("\t\t\t</td>\r\n");
                            builder.Append("\t\t</tr>\r\n");
                            builder.Append("\t\t</table>\r\n");

                            builder.Append("\t</li>\r\n");
                            builder.Append("\t<li><hr/></li>\r\n");
                        }
                    }
                }
                builder.Append("</ul>\r\n");
            }
            KeyValueTextBox.Text = builder.ToString();
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to select article";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to select article");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void SendButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            List<string> forbiddenEmail = new List<string>();
            string[] arr = ForbiddenEmailTextBox.Text.Trim(",".ToCharArray()).Split(",".ToCharArray());

            foreach (string email in arr)
            {
                if (email.Trim() != "") {
                    forbiddenEmail.Add(email.ToLower().Trim());
                }
            }

            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                WebsiteSetting rs = (from u in db.WebsiteSettings where u.KeyName == "NewsletterDesign" select u).SingleOrDefault();
                rs.KeyValue = KeyValueTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("NewsletterDesign");

                List<Member> list = MemberManager.GetMemberList();
                foreach (Member m in list)
                {
                    if (m.Newsletter && !forbiddenEmail.Contains(m.Email.ToLower().Trim()))
                    {
                        EmailMessage em = new EmailMessage();
                        em.CCAdress = string.Empty;
                        em.CreateDate = DateTime.Now;
                        em.SentDate = DateTime.Now;
                        em.EmailGroup = EGroupTextBox.Text.Trim();
                        em.EmailType = (byte)EmailMessageType.Newsletter;
                        em.FromAddress = Utility.NewsletterEmail;
                        em.FromName = Utility.SiteName;
                        em.LastAttempt = DateTime.Now;
                        em.ID = Guid.NewGuid();
                        em.Subject = SubjectTextBox.Text.Trim();
                        em.ToAddress = m.Email;
                        em.ToName = m.MemberName;
                        em.Message = Utility.NewsletterDesign();

                        string emessage = Resources.Resource.EmailWrapper;
                        emessage = emessage.Replace("[root]", Utility.SiteURL);
                        emessage = emessage.Replace("[id]", em.ID.ToString());
                        emessage = emessage.Replace("[newsletteremail]", Utility.NewsletterEmail);
                        emessage = emessage.Replace("[message]", em.Message);
                        emessage = emessage.Replace("[toaddress]", em.ToAddress);
                        emessage = emessage.Replace("[sitename]", Utility.SiteName);
                        emessage = emessage.Replace("[sitetitle]", Utility.SiteTitle);
                        emessage = emessage.Replace("[emailsignature]", Utility.GetSiteSetting("EmailSignature"));
                        em.Message = emessage;

                        db.EmailMessages.InsertOnSubmit(em);
                    }
                }

                db.SubmitChanges();
                message1.Text = "Sent Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("Unable to save & send NewsletterDesign. Message {0}", ex.Message);
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save NewsletterDesign.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}