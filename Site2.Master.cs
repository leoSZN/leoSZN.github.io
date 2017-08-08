using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class Site2 : System.Web.UI.MasterPage
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            else
            {
                var r = from l in db.Logins
                        where l.Email == HttpContext.Current.User.Identity.Name
                        select l;

                foreach (Login l in r)
                {
                    if (l.Position == "Lecturer" )
                    {
                        Response.Redirect("Restrict.aspx");
                    }
                    if(l.Position == "Guest")
                    {
                        Response.Redirect("Restrict.aspx");
                    }
                }
            }


            if (!Page.IsPostBack)
            {

                binId();
            }
        }
        protected void logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();

            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie (not necessary for your current problem but i would recommend you do it anyway)
            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);

            FormsAuthentication.RedirectToLoginPage();
        }

        protected void settings_Click(object sender, EventArgs e)
        {
            Response.Redirect("sSetting.aspx");
        }

        private void binId()
        {

            var r = from l in db.Logins
                    where l.Email == HttpContext.Current.User.Identity.Name
                    select l;

            try
            {
                foreach (Login l in r)
                {

                    Label1.Text = l.UserName + " (" + l.Position + ")";
                    Label2.Text = "Your last login on " + l.LastLoginDate;
                }
            }
            catch
            {

            }
        }
    }
}