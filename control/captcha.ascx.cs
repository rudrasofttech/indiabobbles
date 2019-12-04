using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles.Models;

public partial class control_captcha : System.Web.UI.UserControl
{

    public string ValidationGroup {
        set {
            CaptchaValidator.ValidationGroup = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack && !Page.IsCallback) {
            ViewState["key"] = Guid.NewGuid().ToString();
        }
    }

    public void Update() {
        ViewState["key"] = Guid.NewGuid().ToString();
        CaptchaTextBox.Text = string.Empty;
    }
    
    protected void CaptchaValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try {
            Trace.Write(ViewState["key"].ToString());
        }
        catch {
            Trace.Write("not found");
        }
        if (CacheManager.Get<string>(ViewState["key"].ToString()) == CaptchaTextBox.Text.Trim())
        {
            args.IsValid = true;
        }
        else {
            args.IsValid = false;
        }
    }
    protected void Refreshcaptcha_Click(object sender, EventArgs e)
    {
        Update();
    }
}