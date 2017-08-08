using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class EditAttendance : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool pass = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bind();
                populate();
            }
            if (Page.IsPostBack)
            {
                err.Style.Add("display", "none");
                Msg.Style.Add("display", "none");
                lblEmessage.Text = "";
                lblmsg.Text = "";

            }
        }

        private void bind()
        {
            String attid = (string)(Session["attid"]);
            var intake = (from dbo in db.AttLists
                          where dbo.AttID == attid
                          select dbo.Student.Intake.Name + " | " + dbo.Student.Faculty.Name + " | " + dbo.Student.Program.Name + " Year " + dbo.Student.Year + " Semester " + dbo.Student.Semester).Distinct().OrderBy(name => name);

            var r = from a in db.Attendances
                    where a.AttID == attid
                    select a;

            foreach(Attendance at in r)
            {
                txtSub.Text = at.Subject;
            }
            foreach (var at in intake)
            {
                ListBox1.Items.Add(at.ToString());
            }
        }

        private void populate()
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            String attid = (string)(Session["attid"]);
            string match = ddlIntake.SelectedItem.Text + " | " + ddlFacu.SelectedItem.Text + " | " + ddlProgram.SelectedItem.Text + " Year " + ddlYear.SelectedValue + " Semester " + ddlsemes.SelectedValue;
            ListItem items = ListBox1.Items.FindByText(match);
            if (items != null)
            {
                lblEmessage.Text = "<li>Program already exist, please select another.</li>";
                err.Style.Add("display", "normal");
            }
            else
            {
                if (ddlProgram.SelectedValue == "" || ddlFacu.SelectedValue == "" || ddlIntake.SelectedValue == "")
                {
                    lblEmessage.Text = "<li>Make sure all field are selected.</li>";
                    err.Style.Add("display", "normal");
                }
                else
                {

                    var r = from ss in db.Students
                            where ss.IntakeID == Int32.Parse(ddlIntake.SelectedValue) && ss.FacultyID == Int32.Parse(ddlFacu.SelectedValue) && ss.ProgramID == Int32.Parse(ddlProgram.SelectedValue) && ss.Year == ddlYear.SelectedValue && ss.Semester == ddlsemes.SelectedValue
                            select ss;
                   
                  
                        foreach (Student s in r)
                        {
                            AttList att = new AttList();
                            att.StuID = s.ID;
                            att.AttID = attid;
                            att.Status = "A";
                            db.AttLists.InsertOnSubmit(att);
                        }

                    Msg.Style.Add("display", "normal");
                    lblmsg.Text = "<li>Program added Successful</li>";
                    db.SubmitChanges();
                    ListBox1.Items.Add(ddlIntake.SelectedItem.Text + " | " + ddlFacu.SelectedItem.Text + " | " + ddlProgram.SelectedItem.Text + " Year " + ddlYear.SelectedValue + " Semester " + ddlsemes.SelectedValue);
                    ddlIntake.SelectedIndex = 0;
                    ddlFacu.SelectedIndex = 0;
                    ddlProgram.SelectedIndex = 0;
                    ddlYear.SelectedIndex = 0;
                    ddlsemes.SelectedIndex = 0;
                }
            }
        }

        protected void btnDel_Click(object sender, EventArgs e)
        {
            String attid = (string)(Session["attid"]);
            bool p = true;
            if (ListBox1.Items.Count == 0)
            {
                lblEmessage.Text = "<li>Program list is empty.</li>";
                err.Style.Add("display", "normal");
                p = false;
            }

            if (p)
            {
                if (ListBox1.SelectedIndex == -1)
                {
                    lblEmessage.Text = "<li>Please select a program to delete.</li>";
                    err.Style.Add("display", "normal");
                    p = false;
                }
                if (p)
                {
                    string items = ListBox1.SelectedItem.Value;
                    List<string> res = new List<string>(items.Split(new string[] { "|" }, StringSplitOptions.None));
                    List<string> facu = new List<string>(res[2].Split(new string[] { "Year" }, StringSplitOptions.None));
                    List<string> sem = new List<string>(facu[1].Split(new string[] { "Semester" }, StringSplitOptions.None));


                    var del = from ss in db.AttLists
                              where ss.Student.Intake.Name == res[0].TrimEnd() && ss.Student.Faculty.Name == res[1].TrimStart().TrimEnd() && ss.Student.Program.Name == facu[0].TrimStart().TrimEnd() && ss.Student.Year == sem[0].TrimStart().TrimEnd() && ss.Student.Semester == sem[1].TrimStart() && ss.AttID == attid
                              select ss;

                    ListBox1.Items.Remove(ListBox1.SelectedItem);
                    foreach (AttList s in del)
                    {
                        db.AttLists.DeleteOnSubmit(s);

                    }
                
                    db.SubmitChanges();
                    Msg.Style.Add("style", "normal");
                    lblmsg.Text = "<li>Program delete Successful</li>";
                }

            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            String attid = (string)(Session["attid"]);
            bool pss = true;

            var r = from att in db.Attendances
                    where att.AttID == attid
                    select att;
            if (txtSub.Text == "")
            {
                lblEmessage.Text += "<li>Please enter the subject name.</li>";
                err.Style.Add("display", "normal");
                pss = false;
            }
            if (ListBox1.Items.Count > 0 == false)
            {
                lblEmessage.Text += "<li>Selected program are empty, please add one.</li>";
                err.Style.Add("display", "normal");
                pss = false;
            }
            if (pss)
            {
                foreach (Attendance at in r)
                {
                    at.Subject = txtSub.Text;
                    db.SubmitChanges();
                }
                ListBox1.Items.Clear();
                txtSub.Text = "";
                Session["success"] = "<li>Update Successful.</li>";
                Response.Redirect("ViewLGamePIN.aspx");
               

            }
        }
    }
}