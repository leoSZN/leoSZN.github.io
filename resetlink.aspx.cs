using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class resetlink : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool ok = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            populate();
            pass.Focus();
            if (Page.IsPostBack)
            {

                err.Style.Add("display", "none");
                Msg.Style.Add("display", "none");
                lblEmessage.Text = "";
                pass.Attributes.Add("class", "field");
                cpass.Attributes.Add("class", "field");
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (!txtpass.Text.Equals(txtcpass.Text))
            {
                err.Style.Add("display", "normal");
                lblEmessage.Text = "<li>Password not match.</li>";
                pass.Attributes.Add("class", "field has-error");
                cpass.Attributes.Add("class", "field has-error");
                ok = false;
            }

            if (System.Text.RegularExpressions.Regex.IsMatch(txtpass.Text, "^[a-zA-Z0-9]{6,}$") == false)
            {
                err.Style.Add("display", "normal");
                lblEmessage.Text = "<li>Passwords must be 6 or more characters long.</li>";
                pass.Attributes.Add("class", "field has-error");
                ok = false;
            }

            if (ok)
            {
                Msg.Style.Add("display", "normal");
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
    "setTimeout(function() { window.location.replace('signin.aspx') }, 3000);", true);

                string email = Session["email"].ToString();
                var r = from s in db.Logins
                        where s.Email == email
                        select s;
                string md5 = FormsAuthentication.HashPasswordForStoringInConfigFile(txtpass.Text, "MD5");
                foreach (Login l in r)
                {
                    Login login = db.Logins.Single(ll => ll.Email == email);
                    login.Password = md5;
                    login.EmailToken = "False";
                    db.SubmitChanges();
                    Session.Abandon();
                    Session.Clear();
                    txtpass.Text = "";
                    txtcpass.Text = "";

                }
            }
        }

        private void populate()
        {
            try
            {
                string email = Session["email"].ToString();
                var r = from l in db.Logins
                        where l.Email == email
                        select l;

                foreach (Login l in r)
                {
                    if (l.EmailToken.Equals("False"))
                    {
                        Response.Redirect("signin.aspx", false);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("signin.aspx", false);
            }

        }
    }
}