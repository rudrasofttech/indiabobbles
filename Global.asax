<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        RegisterRoutes(RouteTable.Routes);
    }

    public static void RegisterRoutes(RouteCollection routes)
    {
        routes.Ignore("{resource}.axd/{*pathInfo}");
        routes.Ignore("{resource}.ashx/{*pathInfo}");
        routes.Ignore("{pages}.aspx/{*pathInfo}");

        //Direct URL
        routes.MapPageRoute("LogoutPage", "logout", "~/handlers/logout.ashx");
        routes.MapPageRoute("Sitemap", "sitemap", "~/sitemap.aspx");

        //IndiaBobbles Content Related URL
        routes.MapPageRoute("BlogListPage", "blog/", "~/list.aspx");
        routes.MapPageRoute("BlogCategoryPage", "blog/categories", "~/categories.aspx");
        routes.MapPageRoute("BlogCategoryListPage", "blog/{pagename}/index", "~/custompage.aspx");
        //anyother blog url pattern should be given to article page
        routes.MapPageRoute("BlogArticleRoute", "blog/{*pagename}", "~/article.aspx");

        //Account Related URL
        routes.MapPageRoute("LoginPage", "account/login", "~/account/login.aspx");
        routes.MapPageRoute("MyAccount", "account/myaccount", "~/account/myaccount.aspx");
        routes.MapPageRoute("register", "account/register", "~/account/register.aspx");
        routes.MapPageRoute("forgotpassword", "account/forgotpassword", "~/account/forgotpassword.aspx");
        routes.MapPageRoute("changepassword", "account/changepassword", "~/account/changepassword.aspx");
        routes.MapPageRoute("subscribe", "account/subscribe", "~/account/subscribe.aspx");
        routes.MapPageRoute("activate", "account/activate", "~/account/activate.aspx");
        routes.MapPageRoute("unsubscribe", "account/unsubscribe", "~/account/unsubscribe.aspx");
        routes.MapPageRoute("viewemail", "account/email/{id}", "~/account/email.aspx");


        //Any Damn Thing Catch Here
        routes.MapPageRoute("DefaultPageRoute", string.Empty, "~/custompage.aspx");
        routes.MapPageRoute("CustomPageRoute", "{*pagename}", "~/custompage.aspx");
    }

    void Application_End(object sender, EventArgs e)
    {
    }

    void Application_Error(object sender, EventArgs e)
    {
    }

    void Session_Start(object sender, EventArgs e)
    {
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        //Special code to permanently redirect url with non "www."
        if (!HttpContext.Current.Request.Url.Host.ToLower().Contains("www."))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.StatusCode = 301;
            HttpContext.Current.Response.AddHeader("Location", string.Format("http://www.{0}{1}", HttpContext.Current.Request.Url.Host.ToLower(), HttpContext.Current.Request.RawUrl));
        }
    }
       
</script>
