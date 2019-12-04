using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;
using System.IO;

public partial class Admin_simpleupload : AdminPage
{
    string folderPath;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["folderpath"] != null)
        {
            folderPath = Request.QueryString["folderpath"];
        }

        if (!IsPostBack)
        {
            //MultipleFileUpload.StorageFolder = folderPath; 
        }

    }
    protected void UploadButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (SingleFileUpload.HasFile) {
                SingleFileUpload.SaveAs(Server.MapPath(Path.Combine(Utility.SiteDriveFolderPath,folderPath, SingleFileUpload.FileName)));
                if (File.Exists(Server.MapPath(Path.Combine(Utility.SiteDriveFolderPath, folderPath, SingleFileUpload.FileName))))
                {
                    message1.Text = "File uploaded successfully";
                    message1.Visible = true;
                    message1.Indicate = AlertType.Success;
                }
                else {
                    message1.Text = "Unable to upload file.";
                    message1.Visible = true;
                    message1.Indicate = AlertType.Error;
                }
            }
        }
        catch (Exception ex) {
            message1.Text = string.Format("Unable to upload file. {0}", ex.Message);
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
            Trace.Write(ex.Source);
        }
    }
}