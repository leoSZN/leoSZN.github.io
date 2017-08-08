using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class GenerateLReport : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
          //  Button1.Attributes.Add("Onclick", "return MyFunction()");
            if (!Page.IsPostBack)
            {
                bind();
            }

            if (Page.IsPostBack)
            {
                if(ddltype.SelectedIndex == 1)
                {
                    ReportViewer1.ShowReportBody = false;
                    ReportViewer1.Visible = false;
                }
                rpt1.Style.Add("display", "none");
               
                if (ddltype.SelectedIndex != 0)
                {
                    aid.Style.Add("display", "none");
                }
                else
                {
                    aid.Style.Add("display", "normal");
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (ddltype.SelectedIndex == 0)
            {
                if (DropDownList1.SelectedValue == "")
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No record to generated')", true);
                }
                else
                {
                    rpt1.Style.Add("display", "none");
                    
                    string sub = "";
                    string cdate = "";
                    var r = from a in db.Attendances
                            where a.AttID == DropDownList1.SelectedValue
                            select a;

                    foreach (Attendance a in r)
                    {
                        sub = a.Subject;
                        cdate = a.CreatedDate.ToString();

                    }
                    DataTable DisplayStuList = getStuList(DropDownList1.SelectedValue);
                    ReportViewer1.Reset();
                    ReportViewer1.LocalReport.ReportPath = "StuList.rdlc";
                    ReportParameter[] param = new ReportParameter[3];
                    param[0] = new ReportParameter("Subject", sub);
                    param[1] = new ReportParameter("Cdate", cdate);
                    param[2] = new ReportParameter("id", DropDownList1.SelectedValue);
                    ReportViewer1.LocalReport.SetParameters(param);
                    ReportDataSource ds = new ReportDataSource("DataSet1", DisplayStuList);
                    ReportViewer1.LocalReport.DataSources.Add(ds);
                    ReportViewer1.LocalReport.Refresh();
                    ReportViewer1.ShowReportBody = true;
                    ReportViewer1.Visible = true;
                 
                }
            }
            else if (ddltype.SelectedIndex == 1)
            {
                SqlDataSource1.SelectParameters["email"].DefaultValue = HttpContext.Current.User.Identity.Name;
                Repeater1.DataBind();
                rpt1.Style.Add("display","normal");
                ScriptManager.RegisterStartupScript(this,GetType(), "CallMyFunction", "MyFunction()", true);


            }
        }

        private DataTable getStuList(String email)
        {
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            using (SqlConnection cn = new SqlConnection(conStr))
            {
                string query = @"SELECT Student.StudentID, Student.StudentName, AttList.Status, AttList.IP, AttList.Device, AttList.Time, Intake.Name, Faculty.Name AS Faculty, Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS Program FROM AttList INNER JOIN Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Intake ON Student.IntakeID = Intake.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID INNER JOIN Program ON Student.ProgramID = Program.ID WHERE AttList.AttID = '" +DropDownList1.SelectedValue + "' ORDER BY Program";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    dt.Load(reader);
                }
            }
            return dt;
        }

        private void bind()
        {
            try
            {
                DropDownList1.DataSource = (from f in db.Attendances
                                            where f.Lecturer.Login.Email == HttpContext.Current.User.Identity.Name
                                            select new
                                            {
                                                Text = f.Subject + " | Time: " + f.CreatedDate + " | " + f.AttID,
                                                Value = f.AttID
                                            }).ToList().OrderByDescending(x => x.Value);

                DropDownList1.DataTextField = "Text";
                DropDownList1.DataValueField = "Value";
                DropDownList1.DataBind();
            }
            catch(Exception ex)
            {
              
            }
        }

        protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddltype.SelectedIndex != 0)
            {
                aid.Style.Add("display", "none");
            }
            else
            {
                aid.Style.Add("display", "normal");
            }
        }

        protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string sub = (e.Item.FindControl("lblSub") as Label).Text;
                string stu = (e.Item.FindControl("lblStuID") as Label).Text;
                var r = from ab in db.Students
                        where ab.StudentID == stu
                        select ab;
                int newstu = 0;
                foreach(Student a in r)
                {
                    newstu = a.ID;
                }
                Repeater rptstudent = e.Item.FindControl("rpt2") as Repeater;
                rptstudent.DataSource = GetData(string.Format("SELECT Attendance.CreatedDate, Attendance.AttID FROM Attendance INNER JOIN Absent ON Attendance.AttID = Absent.AttID INNER JOIN Student ON Absent.StuID = Student.ID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE (Absent.Subject = '"+ sub+"') AND (Student.ID = '"+ newstu + "') AND (Login.Email = '"+ HttpContext.Current.User.Identity.Name + "') AND (Absent.EmailSent = 'Yes') ORDER BY Attendance.CreatedDate DESC"));
                rptstudent.DataBind();
            }
        }

        private static DataTable GetData(string query)
        {
            string constr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }
    }
}