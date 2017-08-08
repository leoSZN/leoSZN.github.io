using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class Settings : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            if (!Page.IsPostBack)
            {

                binId();
            }


            if (Page.IsPostBack)
            {
                lblmsg.Text = "";
                lblEmessage.Text = "";
                Msg.Style.Add("display", "none");
                err.Style.Add("display", "none");
                ipass.Attributes.Add("class", "form-group");
                icpass.Attributes.Add("class", "form-group");
                iopass.Attributes.Add("class", "form-group");

            }
        }
        private void binId()
        {

            var r = from l in db.Logins
                    where l.Email == User.Identity.Name
                    select l;
            try
            {
                foreach (Login l in r)
                {
                    lblEmail.Text = l.Email;
                    Session["email"] = l.Email;
                    txtEmail.Text = l.Email;
                    txtUsername.Text = l.UserName;
                    lblPosition.Text = l.Position;
                    lblIp.Text = l.AccCreatedIP;
                    lblCountry.Text = l.AccCreatedCountry;
                    lblCT.Text = l.CreatedDate.ToString();
                    if (l.Browser == null && l.Device == null)
                    {
                        lblBrowser.Text = "Google Chrome";
                        lblOS.Text = "Windows 10";
                    }
                    else
                    {
                        lblBrowser.Text = l.Browser;
                        lblOS.Text = l.Device;
                    }

                }
            }
            catch
            {

            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            String old = (string)(Session["email"]);
            string id = "";
            var r = from l in db.Logins
                    where l.Email == old
                    select l;

            foreach (Login l in r)
            {
                id = l.LoginID;
            }

            Login login = db.Logins.Single(l => l.Email == old);
            string name = "";
            bool emailExist = db.Logins.Any(user => user.Email.Equals(txtEmail.Text));
            if (txtEmail.Text == old)
            {
                if (login.Position == "Student")
                {
                    Student s = db.Students.Single(ss => ss.LoginID == id);
                    s.StudentName = txtUsername.Text.ToUpper();
                    name = txtUsername.Text.ToUpper();

                }
                else if (login.Position == "Lecturer")
                {
                    Lecturer lec = db.Lecturers.Single(ll => ll.LoginID == id);
                    lec.LecturerName = txtUsername.Text.ToUpper();
                    name = txtUsername.Text.ToUpper();
                }
                else
                {
                    name = txtUsername.Text;
                }

                login.UserName = name;
                db.SubmitChanges();
                lblmsg.Text += "<li>Profile update successful.</li>";
                Msg.Style.Add("display", "normal");
                binId();

            }
            else
            {
                if (emailExist)
                {
                    lblEmessage.Text += "<li>That email is taken. Try another. </li>";
                    err.Style.Add("display", "normal");
                }
                else
                {

                    if (login.Position == "Student")
                    {
                        Student s = db.Students.Single(ss => ss.LoginID == id);
                        s.StudentName = txtUsername.Text.ToUpper();
                        name = txtUsername.Text.ToUpper();

                    }
                    else if (login.Position == "Lecturer")
                    {
                        Lecturer lec = db.Lecturers.Single(ll => ll.LoginID == id);
                        lec.LecturerName = txtUsername.Text.ToUpper();
                        name = txtUsername.Text.ToUpper();
                    }
                    else
                    {
                        name = txtUsername.Text;
                    }
                    login.UserName = name;
                    login.Email = txtEmail.Text;
                    db.SubmitChanges();
                    lblmsg.Text += "<li>Profile update successful.</li>";
                    Msg.Style.Add("display", "normal");
                    FormsAuthentication.RedirectFromLoginPage(txtEmail.Text, true);
                    Response.Redirect("Settings.aspx", false);
                    Session.Clear();
                    Session.Abandon();
                }

            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            bool pass = true;
            bool password = db.Logins.Any(user => user.Password.Equals(FormsAuthentication.HashPasswordForStoringInConfigFile(txtOPass.Text, "MD5")));
            String old = (string)(Session["email"]);
            if (txtNPass.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtNPass.Text, "[a-zA-Z0-9]{6,}$") == false)
            {

                lblEmessage.Text += "<li>Passwords must be 6 or more characters long.</li>";
                ipass.Attributes.Add("class", "form-group has-error");
                icpass.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                txtNPass.Text = "";
                txtCpass.Text = "";
                txtOPass.Text = "";
                pass = false;
            }
            if (txtCpass.Text != txtNPass.Text)
            {

                lblEmessage.Text += "<li>Passwords must be matched.</li>";
                ipass.Attributes.Add("class", "form-group has-error");
                icpass.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                txtNPass.Text = "";
                txtCpass.Text = "";
                txtOPass.Text = "";
                pass = false;
            }
            if (pass)
            {
                if (password)
                {
                    Login login = db.Logins.Single(l => l.Email == old);
                    login.Password = FormsAuthentication.HashPasswordForStoringInConfigFile(txtNPass.Text, "MD5");
                    db.SubmitChanges();
                    lblmsg.Text += "<li>Password successful changed.</li>";
                    Msg.Style.Add("display", "normal");
                    txtNPass.Text = "";
                    txtCpass.Text = "";
                    txtOPass.Text = "";
                }
                else
                {
                    lblEmessage.Text += "<li>Current password is incorrect.</li>";
                    iopass.Attributes.Add("class", "form-group has-error");
                    err.Style.Add("display", "normal");
                    txtNPass.Text = "";
                    txtCpass.Text = "";
                    txtOPass.Text = "";
                }
            }


        }
    }
}