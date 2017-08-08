using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class UpdateLogin : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool pass = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            if (Page.IsPostBack)
            {
                lblEmessage.Text = "";
                err.Style.Add("display", "none");
                lblmsg.Text = "";
                Msg.Style.Add("display", "none");
                iun.Attributes.Add("class", "form-group");
                iemail.Attributes.Add("class", "form-group");
            }

            if (!Page.IsPostBack)
            {
                reset();
            }

        }
        private void reset()
        {
            txtsearch.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            ddlPO.SelectedIndex = 0;
            rM.Checked = false;
            txtUsername.Attributes.Add("disabled", "disabled");
            txtEmail.Attributes.Add("disabled", "disabled");
            ddlPO.Attributes.Add("disabled", "disabled");
            Button1.Attributes.Add("disabled", "disabled");
        }
        private void open()
        {
            txtUsername.Attributes.Remove("disabled");
            txtEmail.Attributes.Remove("disabled");
            ddlPO.Attributes.Remove("disabled");
            Button1.Attributes.Remove("disabled");
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var r = from l in db.Logins
                    where l.Email == txtsearch.Text
                    select l;

            bool loginEmail = db.Logins.Any(user => user.Email.Equals(txtsearch.Text));
            if (loginEmail == false)
            {
                lblEmessage.Text += "<li>Login User not found. Please try another.</li>";
                err.Style.Add("display", "normal");
                reset();
            }
            else
            {
                foreach (Login l in r)
                {
                    open();
                    txtUsername.Text = l.UserName;
                    Session["email"] = l.Email;
                    txtEmail.Text = l.Email;
                    if (l.Position == "Admin")
                    {
                        ddlPO.SelectedIndex = 0;
                    }
                    else if (l.Position == "Guest")
                    {
                        ddlPO.SelectedIndex = 1;
                    }

                    if (l.Suspend == "No")
                    {
                        rM.Checked = false;
                    }
                    else
                    {
                        rM.Checked = true;
                    }
                    lblmsg.Text += "<li>Login User found!</li>";
                    Msg.Style.Add("display", "normal");
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            String old = (string)(Session["email"]);
            string position = "";
            string sta = "";
            if (txtUsername.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtUsername.Text, "^[a-zA-Z0-9'.\\s]{6,20}$") == false)
            {

                lblEmessage.Text += "<li>Make sure username is 6 to 20 characters long, with letters only.</li>";
                iun.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;

            }
            validateEmail();
            if (pass)
            {
                if (ddlPO.SelectedIndex == 0)
                {
                    position = "Admin";
                }
                else if (ddlPO.SelectedIndex == 1)
                {
                    position = "Guest";

                }
                if (rM.Checked == true)
                {
                    sta = "Yes";
                }
                else if (rM.Checked == false)
                {
                    sta = "No";
                }

                Login login = db.Logins.Single(l => l.Email == old);
                login.UserName = txtUsername.Text;
                login.Email = txtEmail.Text;
                login.Position = position;
                login.Suspend = sta;
                db.SubmitChanges();
                lblmsg.Text += "<li>Login User successful update.</li>";
                Msg.Style.Add("display", "normal");
                reset();
            }
        }


        private void validateEmail()
        {

            String old = (string)(Session["email"]);
            bool emailExist = db.Logins.Any(user => user.Email.Equals(txtEmail.Text));
            if (txtEmail.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtEmail.Text, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid email address.</li>";
                iemail.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }

            if (txtEmail.Text != old)
            {
                if (emailExist)
                {
                    lblEmessage.Text += "<li>This email address is already in use.</li>";
                    iemail.Attributes.Add("class", "form-group has-error");
                    err.Style.Add("display", "normal");
                    pass = false;
                }
            }

        }

    }
}