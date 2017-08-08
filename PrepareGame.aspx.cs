using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class PrepareGame : System.Web.UI.Page
    {

        string nID = "";
        string old = "";
        int sub = 0;
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                populate();
                Session["id"] = populateID();
            }

            if (Page.IsPostBack)
            {
                err.Style.Add("display","none");
                Msg.Style.Add("display","none");
                lblEmessage.Text = "";
                lblmsg.Text = "";
               
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

        private string populateID()
        {
            var result = db.Attendances.GroupBy(test => test.AttID)
                   .Select(grp => grp.First())
                   .ToList();

            if (result.Count == 0)
            {
                nID = "A00001";
            }
            else
            {
                foreach (Attendance l in result)
                {
                    old = l.AttID;
                    sub = Convert.ToInt32(old.Substring(1));
                    sub += 1;
                    nID = "A" + sub.ToString().PadLeft(5, '0');

                }
            }

            return nID;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
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
                    String id = (string)(Session["id"]);
                    if (id == null)
                    {
                        Session["id"] = populateID();
                        id = (string)(Session["id"]);
                    }
                    if (ListBox1.Items.Count > 0 == false)
                    {
                        var cetZone = TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time");
                        var cetTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, cetZone);
                        Attendance at = new Attendance();

                        at.AttID = id;
                        at.CreatedDate = cetTime;
                        at.LecID = Int32.Parse("1");
                        db.Attendances.InsertOnSubmit(at);
                    }

                    foreach (Student s in r)
                    {
                        AttList att = new AttList();
                        att.StuID = s.ID;
                        att.AttID = id;
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
            String id = (string)(Session["id"]);
            bool p = true;
            if(ListBox1.Items.Count == 0)
            {
                lblEmessage.Text = "<li>Program list is empty.</li>";
                err.Style.Add("display", "normal");
                p = false;
            }

            if (p)
            {
                if(ListBox1.SelectedIndex == -1)
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
                              where ss.Student.Intake.Name == res[0].TrimEnd() && ss.Student.Faculty.Name == res[1].TrimStart().TrimEnd() && ss.Student.Program.Name == facu[0].TrimStart().TrimEnd() && ss.Student.Year == sem[0].TrimStart().TrimEnd() && ss.Student.Semester == sem[1].TrimStart() && ss.AttID == id
                              select ss;

                    var rr = from att in db.Attendances
                             where att.AttID == id
                             select att;

                    ListBox1.Items.Remove(ListBox1.SelectedItem);
                    foreach (AttList s in del)
                    {
                        db.AttLists.DeleteOnSubmit(s);

                    }
                    if (ListBox1.Items.Count == 0)
                    {
                        foreach (Attendance a in rr)
                        {
                            db.Attendances.DeleteOnSubmit(a);
                        }
                    }
                    db.SubmitChanges();
                    Msg.Style.Add("style", "normal");
                    lblmsg.Text = "<li>Program delete Successful</li>";
                }

            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String code = "";
            String id = (string)(Session["id"]);
            bool pss = true;
            //Generated code
            Random n = new Random();
            char[] s = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
            for (int i = 1; i < 7; i++)
            {
                int random = n.Next(0, s.Length);
                code = code + s[random];
            }
            var r = from att in db.Attendances
                    where att.AttID == id
                    select att;
            if (txtSub.Text == "")
            {
                lblEmessage.Text += "<li>Please enter the subject name.</li>";
                err.Style.Add("display", "normal");
                pss = false;
            }
            if(ListBox1.Items.Count > 0 == false)
            {
                lblEmessage.Text += "<li>Selected program are empty, please add one.</li>";
                err.Style.Add("display", "normal");
                pss = false;
            }
            DateTime start = DateTime.Parse(txtstime.Text);
            DateTime end = DateTime.Parse(txtetime.Text);

            if (end < start)
            {
                lblEmessage.Text += "<li>Subject end time must be at least 1 hour later than start time.</li>";
                err.Style.Add("display", "normal");
                txtetime.Text = start.AddHours(1).ToString("HH:mm");
                pss = false;
            }
            if (end == start)
            {
                lblEmessage.Text += "<li>Subject end time must be at least 1 hour later than start time</li>";
                err.Style.Add("display", "normal");
                txtetime.Text = start.AddHours(1).ToString("HH:mm");
                pss = false;
            }
            if (pss)
            {
                foreach (Attendance at in r)
                {
                    at.Subject = txtSub.Text;
                    db.SubmitChanges();
                }
                GamePIN gp = new GamePIN();
                gp.PIN = code;
                gp.AttID = id;
                gp.Available = "No";
               db.GamePINs.InsertOnSubmit(gp);
                db.SubmitChanges();

                ListBox1.Items.Clear();
                Session.Clear();
                Session.Abandon();
                lblmsg.Text = "<li>Your game PIN is " + code + "</li>";
                Msg.Style.Add("display", "normal"); 
                txtSub.Text = "";
              
              
            }
        }
    }
}