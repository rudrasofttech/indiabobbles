using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class custompage : BasePage
{
    public CPage CP { get; set; }
    public bool Preview
    {
        get
        {
            if (Request.QueryString["preview"] != null)
            {
                try { return bool.Parse(Request.QueryString["preview"].ToString()); }
                catch { return false; }
            }
            return false;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string pname = "home";
            if (Page.RouteData.Values["pagename"] != null)
            {
                pname = Page.RouteData.Values["pagename"].ToString();
            }
            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {
                int pid = (from u in dc.CustomPages where u.Name == pname && (u.Status == (byte)PostStatusType.Publish || (Preview))  select u.ID).SingleOrDefault();
                CP = Utility.Deserialize<CPage>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/cpagexml-{0}.txt", pid, Utility.CustomPageFolder))));
                Master.NoTemplate = CP.NoTemplate;
                
                #region Replace Custom Data Source
                DataSourceManager dsm = new DataSourceManager();
                CP.Body = dsm.ParseAndPopulate(CP.Body);
                #endregion
            }
        }
        catch (Exception ex)
        {
            CP = new CPage();
            CP.Body = Resources.Resource.Error404;
            Trace.Write("Invalid pagename");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}