using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class UpdateLec : System.Web.UI.Page
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
                iID.Attributes.Add("class", "form-group");
                iname.Attributes.Add("class", "form-group");
                iIC.Attributes.Add("class", "form-group");
                iPhone.Attributes.Add("class", "form-group");
                iAdd.Attributes.Add("class", "form-group");
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
            txtemail.Text = "";
            txtID.Text = "";
            txtname.Text = "";
            txtSIC.Text = "";
            rd.SelectedIndex = 0;
            txtPhone.Text = "";
            txtAddress.InnerText = "";
            rd.Enabled = false;
            txtemail.Attributes.Add("disabled", "disabled");
            txtID.Attributes.Add("disabled", "disabled");
            txtname.Attributes.Add("disabled", "disabled");
            txtSIC.Attributes.Add("disabled", "disabled");
            txtPhone.Attributes.Add("disabled", "disabled");
            txtAddress.Attributes.Add("disabled", "disabled");
            Button1.Attributes.Add("disabled", "disabled");

        }
        private void open()
        {
            rd.Enabled = true;
            txtemail.Attributes.Remove("disabled");
            txtID.Attributes.Remove("disabled");
            txtname.Attributes.Remove("disabled");
            txtSIC.Attributes.Remove("disabled");
            txtPhone.Attributes.Remove("disabled");
            txtAddress.Attributes.Remove("disabled");
            Button1.Attributes.Remove("disabled");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var r = from l in db.Lecturers
                    where l.LecturerID == txtsearch.Text
                    select l;
            bool lID = db.Lecturers.Any(user => user.LecturerID.Equals(txtsearch.Text));
            if (lID == false)
            {
                lblEmessage.Text += "<li>Lecturer not found. Please try another.</li>";
                err.Style.Add("display", "normal");
                reset();
            }
            else
            {
                open();
                foreach (Lecturer l in r)
                {
                    Session["id"] = l.LecturerID;
                    Session["email"] = l.Login.Email;
                    txtemail.Text = l.Login.Email;
                    txtID.Text = l.LecturerID;
                    txtname.Text = l.LecturerName;
                    txtSIC.Text = l.LecturerIC;
                    if (l.Gender == "Male")
                    {
                        rd.SelectedIndex = 0;
                    }
                    else if (l.Gender == "Female")
                    {
                        rd.SelectedIndex = 1;
                    }
                    txtPhone.Text = l.Phone;
                    txtAddress.InnerText = l.Address;
                    lblmsg.Text += "<li>Lecturer found!</li>";
                    Msg.Style.Add("display", "normal");
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String oemail = (string)(Session["email"]);
            String old = (string)(Session["id"]);
            validateEmail();
            if (pass)
            {
                validateID();
                if (pass)
                {
                    if (txtname.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtname.Text, "^[a-zA-Z0-9'.\\s]{6,20}$") == false)
                    {

                        lblEmessage.Text += "<li>Make sure fullname is 6 to 20 characters long, with letters only.</li>";
                        iname.Attributes.Add("class", "form-group has-error");
                        err.Style.Add("display", "normal");
                        pass = false;

                    }
                    if (txtSIC.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtSIC.Text, "^[0-9]{6}-[0-9]{2}-[0-9]{4}$") == false)
                    {

                        lblEmessage.Text += "<li>This doesn't appear to be a valid IC format. Example: 951019-08-0001</li>";
                        iIC.Attributes.Add("class", "form-group has-error");
                        err.Style.Add("display", "normal");
                        pass = false;

                    }
                    if (txtPhone.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtPhone.Text, "^[0-9]{3,4}-[0-9]{7}$") == false)
                    {

                        lblEmessage.Text += "<li>This doesn't appear to be a valid Phone number format. Example: 012-3456789</li>";
                        iPhone.Attributes.Add("class", "form-group has-error");
                        err.Style.Add("display", "normal");
                        pass = false;

                    }
                    if (txtAddress.InnerText.Equals(""))
                    {
                        lblEmessage.Text += "<li>Address cannot be empty.</li>";
                        iAdd.Attributes.Add("class", "form-group has-error");
                        err.Style.Add("display", "normal");
                        pass = false;
                    }

                    if (pass)
                    {
                        Login login = db.Logins.Single(le => le.Email == oemail);
                        Lecturer l = db.Lecturers.Single(ll => ll.LecturerID == old);
                        login.Email = txtemail.Text;
                        login.UserName = txtname.Text.ToUpper();
                        l.LecturerID = txtID.Text;
                        l.Login.UserName = txtname.Text;
                        l.LecturerName = txtname.Text.ToUpper();
                        l.LecturerIC = txtSIC.Text;
                        l.Gender = rd.SelectedItem.Value;
                        l.Phone = txtPhone.Text;
                        l.Address = txtAddress.InnerText;
                        db.SubmitChanges();

                        lblmsg.Text += "<li>Lecturer successful update.</li>";
                        Msg.Style.Add("display", "normal");
                        reset();
                    }

                }
            }

        }
        private void validateEmail()
        {
            String old = (string)(Session["email"]);
            bool eExist = db.Logins.Any(user => user.Email.Equals(txtemail.Text));
            if (txtemail.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtemail.Text, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid email address.</li>";
                iemail.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (txtemail.Text != old)
            {
                if (eExist)
                {
                    lblEmessage.Text += "<li>This email address is already in use.</li>";
                    iemail.Attributes.Add("class", "form-group has-error");
                    err.Style.Add("display", "normal");
                    pass = false;
                }
            }
        }
        private void validateID()
        {
            String old = (string)(Session["id"]);
            bool idE = db.Lecturers.Any(user => user.LecturerID.Equals(txtID.Text));

            if (txtID.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtID.Text.ToUpper(), "^[0-9]{2}[A-Z]{3}[0-9]{5}$") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid Lecturer ID. Example: 15WAR08554</li>";
                iID.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (txtID.Text != old)
            {
                if (idE)
                {
                    lblEmessage.Text += "<li>This Lecturer ID is already in use.</li>";
                    iID.Attributes.Add("class", "form-group has-error");
                    err.Style.Add("display", "normal");
                    pass = false;
                }
            }
        }
    }
}