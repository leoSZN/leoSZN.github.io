using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class activation : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string email = Session["emailC"].ToString();
                var r = from s in db.Logins
                        where s.Email == email
                        select s;

                foreach (Login l in r)
                {
                    if (l.Active.Equals("Active"))
                    {
                        Label1.Text = "Session has expired, please login to your account.";
                        Label1.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        Login login = db.Logins.Single(ll => ll.Email == email);
                        login.Active = "Active";
                        db.SubmitChanges();
                        Label1.Text = "Account activation successful";
                        Label1.ForeColor = System.Drawing.Color.Green;
                    }

                }

            }
            catch (Exception ex)
            {
                Label1.Text = "Session has expired, please login to your account.";
                Label1.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("signin.aspx");
        }
    }
}