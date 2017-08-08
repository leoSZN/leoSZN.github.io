using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class AddStudent : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool pass = true;
        string old = "";
        int sub = 0;
        string nID = "";
        string password = "";
        string cn = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            populateID();

            if (!Page.IsPostBack)
            {

                bind();
            }
            if (Page.IsPostBack)
            {
                lblEmessage.Text = "";
                err.Style.Add("display", "none");
                Msg.Style.Add("display", "none");
                iemail.Attributes.Add("class", "form-group");
                iID.Attributes.Add("class", "form-group");
                iname.Attributes.Add("class", "form-group");
                iIC.Attributes.Add("class", "form-group");
                iPhone.Attributes.Add("class", "form-group");
                iAdd.Attributes.Add("class", "form-group");
            }
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
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please check your internet connections')", true);
            }


        }
        private void populateID()
        {
            try
            {
                var result = (from l in db.Logins
                              orderby l.LoginID descending
                              select l.LoginID).First();

                if (result == null)
                {
                    nID = "L00001";
                }
                else
                {
                    old = result;
                    sub = Convert.ToInt32(old.Substring(1));
                    sub += 1;
                    nID = "L" + sub.ToString().PadLeft(5, '0');

                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);

            }


        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            bool emailExist = db.Logins.Any(user => user.Email.Equals(txtEmail.Text));
            bool idExist = db.Students.Any(user => user.StudentID.Equals(txtSID.Text));
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
            if (emailExist)
            {
                lblEmessage.Text += "<li>This email address is already in use.</li>";
                iemail.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (txtSID.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtSID.Text.ToUpper(), "^[0-9]{2}[A-Z]{3}[0-9]{5}$") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid Student ID. Example: 15WAR08554</li>";
                iID.Attributes.Add("class", "form-group has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (idExist)
            {
                lblEmessage.Text += "<li>This student ID already in use.</li>";
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

                var cetZone = TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time");
                var cetTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, cetZone);
                //split IP
                string ip = GetUserIp();
                string[] ipp = ip.Split(':');

                try
                {
                    //get country
                    GeoService.GeoIPService service = new GeoService.GeoIPService();
                    GeoService.GeoIP country = service.GetGeoIP(ipp[0]);
                    cn = country.CountryName;
                }
                catch (Exception ex)
                {
                    cn = "Unknown";
                }

                password = txtSIC.Text;
                string[] passs = password.Split('-');
                string newpass = passs[0] + passs[1] + passs[2];


                Login l = new Login();
                l.LoginID = nID;
                l.UserName = txtSName.Text.ToUpper();
                l.Email = txtEmail.Text;
                l.Password = FormsAuthentication.HashPasswordForStoringInConfigFile(newpass, "MD5");
                l.Suspend = "No";
                l.EmailToken = "False";
                l.Active = "Active";
                l.Position = "Student";
                l.CreatedDate = cetTime;
                l.AccCreatedIP = ipp[0];
                l.AccCreatedCountry = cn;

                Student s = new Student();
                s.StudentID = txtSID.Text.ToUpper();
                s.StudentName = txtSName.Text.ToUpper();
                s.StudentIC = txtSIC.Text;
                s.Gender = rd.SelectedItem.Value;
                s.Phone = txtPhone.Text;
                s.Address = txtAddress.InnerText;
                s.Year = ddlYear.SelectedItem.Value;
                s.Semester = ddlSemester.SelectedItem.Value;
                s.LoginID = nID;
                s.FacultyID = Int32.Parse(ddlFacu.SelectedItem.Value);
                s.IntakeID = Int32.Parse(ddlIntake.SelectedItem.Value);
                s.ProgramID = Int32.Parse(ddlProgram.SelectedItem.Value);

                db.Students.InsertOnSubmit(s);
                db.Logins.InsertOnSubmit(l);
                db.SubmitChanges();
                reset();
                Msg.Style.Add("display", "normal");


            }
        }

        //Get User IP Address
        private string GetUserIp()
        {
            var visitorsIpAddr = string.Empty;

            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                visitorsIpAddr = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            else if (!string.IsNullOrEmpty(Request.UserHostAddress))
            {
                visitorsIpAddr = Request.UserHostAddress;
            }

            return visitorsIpAddr;
        }

        private void reset()
        {
            ddlIntake.SelectedIndex = 0;
            ddlFacu.SelectedIndex = 0;
            ddlProgram.SelectedIndex = 0;
            ddlYear.SelectedIndex = 0;
            ddlSemester.SelectedIndex = 0;
            txtEmail.Text = "";
            txtSID.Text = "";
            txtSName.Text = "";
            txtSIC.Text = "";
            rd.SelectedIndex = 0;
            txtPhone.Text = "";
            txtAddress.InnerText = "";

        }
    }
}