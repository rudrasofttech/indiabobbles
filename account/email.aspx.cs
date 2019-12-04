using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class email : System.Web.UI.Page
{
    public EmailMessage EM = new EmailMessage();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.RouteData.Values["id"] != null)
        {
            try
            {
                EM.ID = new Guid(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception ex)
            {
                EM.ID = Guid.Empty;
                Trace.Write("Invalid id");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }

        EM = EmailManager.GetMessage(EM.ID);
        if (EM == null)
        {
            EM = new EmailMessage();
        }
        else
        {
            if (!EM.IsRead)
            {
                EM.IsRead = true;
                EM.ReadDate = DateTime.Now;
                EmailManager.UpdateMessage(EM);
            }
        }
    }
}