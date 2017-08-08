using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class UpdateStudent : System.Web.UI.Page
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
                iemail.Attributes.Add("class", "form-group");
                iID.Attributes.Add("class", "form-group");
                iname.Attributes.Add("class", "form-group");
                iIC.Attributes.Add("class", "form-group");
                iPhone.Attributes.Add("class", "form-group");
                iAdd.Attributes.Add("class", "form-group");
            }
            if (!Page.IsPostBack)
            {
                bind();
                reset();
            }

         }
        private void reset()
        {
            txtsearch.Text = "";
            txtEmail.Text = "";
            txtSID.Text = "";
            txtSName.Text = "";
            txtSIC.Text = "";
            rd.Enabled = false;
            rd.SelectedIndex = 0;
            txtPhone.Text = "";
            txtAddress.InnerText = "";
            txtsearch.Text = "";
            Button1.Attributes.Add("disabled", "disabled");
            ddlIntake.SelectedIndex = 0;
            ddlFacu.SelectedIndex = 0;
            ddlProgram.SelectedIndex = 0;
            ddlYear.SelectedIndex = 0;
            ddlSemester.SelectedIndex = 0;
            ddlFacu.Attributes.Add("disabled", "disabled");
            ddlIntake.Attributes.Add("disabled", "disabled");
            ddlProgram.Attributes.Add("disabled", "disabled");
            ddlSemester.Attributes.Add("disabled", "disabled");
            ddlYear.Attributes.Add("disabled", "disabled");

            txtEmail.Attributes.Add("disabled", "disabled");
            txtSID.Attributes.Add("disabled", "disabled");
            txtSName.Attributes.Add("disabled", "disabled");
            txtSIC.Attributes.Add("disabled", "disabled");
            txtPhone.Attributes.Add("disabled", "disabled");
            txtAddress.Attributes.Add("disabled", "disabled");
        }

        private void open()
        {
            Button1.Attributes.Remove("disabled");
            ddlFacu.Attributes.Remove("disabled");
            ddlIntake.Attributes.Remove("disabled");
            ddlProgram.Attributes.Remove("disabled");
            ddlSemester.Attributes.Remove("disabled");
            ddlYear.Attributes.Remove("disabled");
            rd.Enabled = true;
            txtEmail.Attributes.Remove("disabled");
            txtSID.Attributes.Remove("disabled");
            txtSName.Attributes.Remove("disabled");
            txtSIC.Attributes.Remove("disabled");
            txtPhone.Attributes.Remove("disabled");
            txtAddress.Attributes.Remove("disabled");
        }
        private void bind()
        {
            try
            {
                ddlFacu.DataSource = (from f in db.Faculties
                                      select new
                                      {
                                          Text = f.Name,
                                          Value = f.ID
                                      }).ToList();
                ddlFacu.DataTextField = "Text";
                ddlFacu.DataValueField = "Value";
                ddlFacu.DataBind();
                ddlFacu.Items.Insert(0, new ListItem("Select Faculty...", String.Empty));
                ddlFacu.SelectedIndex = 0;

                ddlIntake.DataSource = (from i in db.Intakes
                                        select new
                                        {
                                            Text = i.Name,
                                            Value = i.ID
                                        }).ToList();
                ddlIntake.DataTextField = "Text";
                ddlIntake.DataValueField = "Value";
                ddlIntake.DataBind();
                ddlIntake.Items.Insert(0, new ListItem("Select Intake...", String.Empty));
                ddlIntake.SelectedIndex = 0;


                ddlProgram.DataSource = (from p in db.Programs
                                         select new
                                         {
                                             Text = p.Name,
                                             Value = p.ID
                                         }).ToList();
                ddlProgram.DataTextField = "Text";
                ddlProgram.DataValueField = "Value";
                ddlProgram.DataBind();
                ddlProgram.Items.Insert(0, new ListItem("Select Program...", String.Empty));
                ddlProgram.SelectedIndex = 0;


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please check your connectivity.')", true);
            }


        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var r = from s in db.Students
                    join i in db.Intakes on s.IntakeID equals i.ID
                    join f in db.Faculties on s.FacultyID equals f.ID
                    join p in db.Programs on s.ProgramID equals p.ID
                    where s.StudentID == txtsearch.Text
                    select s;
            bool stuID = db.Students.Any(user => user.StudentID.Equals(txtsearch.Text));
            if (stuID == false)
            {
                lblEmessage.Text += "<li>Student not found. Please try another.</li>";
                err.Style.Add("display", "normal");
                reset();
            }
            else
            {
                foreach (Student s in r)
                {
                    open();
                    ddlIntake.SelectedValue = s.Intake.ID.ToString();
                    ddlFacu.SelectedValue = s.Faculty.ID.ToString();
                    ddlProgram.SelectedValue = s.Program.ID.ToString();
                    ddlYear.SelectedValue = s.Year.ToString();
                    ddlSemester.SelectedValue = s.Semester.ToString();
                    Session["email"] = s.Login.Email;
                    txtEmail.Text = s.Login.Email;
                    txtSID.Text = s.StudentID;
                    txtSName.Text = s.StudentName;
                    txtSIC.Text = s.StudentIC;
                    string gender = s.Gender;
                    if (gender == "Male")
                    {
                        rd.SelectedIndex = 0;
                    }
                    else if (gender == "Female")
                    {
                        rd.SelectedIndex = 1;
                    }
                    txtPhone.Text = s.Phone;
                    txtAddress.InnerText = s.Address;

                    lblmsg.Text += "<li>Student found!</li>";
                    Msg.Style.Add("display", "normal");

                }
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String old = (string)(Session["email"]);
            bool emailExist = db.Logins.Any(user => user.Email.Equals(txtEmail.Text));
            if (ddlIntake.SelectedItem.Value.Equals(String.Empty))
            {
                lblEmessage.Text += "  <li>Please Select Intake</li>";
                err.Style.Add("display", "normal");
                pass = false;
            }

            if (ddlFacu.SelectedItem.Value.Equals(String.Empty))
            {
                lblEmessage.Text += "  <li>Please Select Faculty</li>";
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (ddlProgram.SelectedItem.Value.Equals(String.Empty))
            {
                lblEmessage.Text += "  <li>Please Select Program</li>";
                err.Style.Add("display", "normal");
                pass = false;
            }
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
                else
                {
                    cont();
                }
            }
            else
            {
                cont();
            }



        }
        private void cont()
        {
            String old = (string)(Session["email"]);
            if (txtSID.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtSID.Text.ToUpper(), "^[0-9]{2}[A-Z]{3}[0-9]{5}$") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid Student ID. Example: 15WAR08554</li>";
                iID.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (txtSName.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtSName.Text, "^[a-zA-Z0-9'.\\s]{6,20}$") == false)
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
                Login login = db.Logins.Single(l => l.Email == old);
                Student s = db.Students.Single(ss => ss.StudentID == txtsearch.Text);
                login.Email = txtEmail.Text;
                login.UserName = txtSName.Text.ToUpper();
                s.IntakeID = Int32.Parse(ddlIntake.SelectedValue);
                s.FacultyID = Int32.Parse(ddlFacu.SelectedValue);
                s.ProgramID = Int32.Parse(ddlProgram.SelectedValue);
                s.Year = ddlYear.SelectedValue;
                s.Semester = ddlSemester.SelectedValue;
                s.StudentID = txtSID.Text;
                s.StudentName = txtSName.Text.ToUpper();
                s.StudentIC = txtSIC.Text;
                s.Gender = rd.SelectedItem.Value;
                s.Phone = txtPhone.Text;
                s.Address = txtAddress.InnerText;
                db.SubmitChanges();
                lblmsg.Text += "<li>Student successful update.</li>";
                Msg.Style.Add("display", "normal");
                reset();
            }
        }
    }
}