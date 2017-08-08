using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace FinalYearProjectMasterPage
{
    public partial class OverallAtt : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                SqlDataSource1.SelectParameters["email"].DefaultValue = HttpContext.Current.User.Identity.Name;
            }
            if (Page.IsPostBack)
            {
                hide.Style.Add("display", "none");
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            hide.Style.Add("display", "normal");
            if (ddl.SelectedItem.Text == null)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No record to generated')", true);
            }else
            {
                rpt1.DataSource = GetData("SELECT DISTINCT Intake.Name + ' | ' + Faculty.Name + ' | ' + Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS pro FROM AttList INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN" +
                     " Intake ON Student.IntakeID = Intake.ID INNER JOIN" +
                     "  Faculty ON Student.FacultyID = Faculty.ID INNER JOIN" +
                     "  Program ON Student.ProgramID = Program.ID INNER JOIN" +
                     " Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID"+
                     " WHERE Attendance.Subject = '" + ddl.SelectedItem.Text + "' and (Login.Email = '" + HttpContext.Current.User.Identity.Name + "')");
                rpt1.DataBind();
                Label1.Text = ddl.SelectedItem.Text;

                var r = from l in db.Lecturers
                        where l.Login.Email == HttpContext.Current.User.Identity.Name
                        select l;

                foreach(Lecturer l in r)
                {
                    Label2.Text = l.LecturerName;
                }
            }
           
        }

        protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string pro = (e.Item.FindControl("lblProgram") as Label).Text;
                Repeater rptstudent = e.Item.FindControl("rpt2") as Repeater;
                rptstudent.DataSource = GetData(string.Format("SELECT distinct Student.StudentID, Student.StudentName FROM AttList INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Intake ON Student.IntakeID = Intake.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID INNER JOIN Program ON Student.ProgramID = Program.ID INNER JOIN Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE (Intake.Name + ' | ' + Faculty.Name + ' | ' + Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester ='"+ pro + "') AND (Attendance.Subject = '"+ ddl.SelectedItem.Text+"') AND (login.email = '" + HttpContext.Current.User.Identity.Name + "') order by Student.StudentName asc"));
                rptstudent.DataBind();
            }
        }

        protected void OnItemDataBound2(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    string stu = (e.Item.FindControl("lblStuname") as Label).Text;
                    Repeater rptSta = e.Item.FindControl("rpt3") as Repeater;
                    rptSta.DataSource = GetData(string.Format("SELECT Attendance.CreatedDate, AttList.Status FROM AttList INNER JOIN Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE(Attendance.Subject = '" + ddl.SelectedItem.Text +"') AND(Student.StudentName = '"+ stu +"') AND (Login.Email = '" + HttpContext.Current.User.Identity.Name + "')"));
                    rptSta.DataBind();
                }
            }catch(Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('"+ex.Message+"')", true);

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
             Response.Clear();
             Response.Buffer = true;
             Response.AddHeader("content-disposition", "attachment;filename="+Label2.Text + " "+ ddl.SelectedItem.Text+"Attendances.xls");
             Response.Charset = "";
             Response.ContentType = "application/vnd.ms-excel";
             StringWriter sw = new StringWriter();
             HtmlTextWriter hw = new HtmlTextWriter(sw);
             rpt1.RenderControl(hw);
             Response.Output.Write(sw.ToString());
             Response.Flush();
             Response.End();


        }
    }
}