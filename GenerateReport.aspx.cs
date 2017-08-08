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
    public partial class GenerateReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if(DropDownList1.SelectedIndex == 0)
            {
                DataTable DisplayAtt = getAtt(HttpContext.Current.User.Identity.Name);
                ReportViewer1.Reset();
                ReportViewer1.LocalReport.ReportPath = "StuAttendance.rdlc";
                ReportDataSource ds = new ReportDataSource("DataSet1", DisplayAtt);
                ReportViewer1.LocalReport.DataSources.Add(ds);
                ReportViewer1.LocalReport.Refresh();
                ReportViewer1.ShowReportBody = true;
                ReportViewer1.Visible = true;
            }
            else if (DropDownList1.SelectedIndex == 1)
            {
                DataTable DisplayAbsent = getAbsent(HttpContext.Current.User.Identity.Name);
                ReportViewer1.Reset();
                ReportViewer1.LocalReport.ReportPath = "StuAbsent.rdlc";
                ReportDataSource ds = new ReportDataSource("DataSet1", DisplayAbsent);
                ReportViewer1.LocalReport.DataSources.Add(ds);
                ReportViewer1.LocalReport.Refresh();
                ReportViewer1.ShowReportBody = true;
                ReportViewer1.Visible = true;
            }
        }

        private DataTable getAbsent(String email)
        {
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            using (SqlConnection cn = new SqlConnection(conStr))
            {
                string query = @"SELECT Absent.Subject, Attendance.CreatedDate, Lecturer.LecturerName FROM Absent INNER JOIN Attendance ON Absent.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Student ON Absent.StuID = Student.ID INNER JOIN Login ON Student.LoginID = Login.LoginID WHERE Login.Email = '"+ HttpContext.Current.User.Identity.Name + "'";
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

        private DataTable getAtt(String email)
        {
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            using (SqlConnection cn = new SqlConnection(conStr))
            {
                string query = @"SELECT Attendance.Subject, Attendance.CreatedDate, AttList.Status, AttList.IP, AttList.Device, AttList.Time, Lecturer.LecturerName FROM AttList INNER JOIN Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Login ON Student.LoginID = Login.LoginID WHERE Login.Email = '" + HttpContext.Current.User.Identity.Name + "'";
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
    }
}