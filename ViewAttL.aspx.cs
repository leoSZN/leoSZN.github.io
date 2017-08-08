using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewAttL : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
 
               String id = (string)(Session["AttID"]);
            
           
                SqlDataSource1.SelectParameters["attid"].DefaultValue = id;

                var r = (from d in db.AttLists
                         where d.AttID == id
                         select d).Distinct().ToArray();

                foreach (AttList al in r)
                {
                    lblatt.Text = id;
                    lblname.Text = al.Attendance.Lecturer.LecturerName;
                    lblsub.Text = al.Attendance.Subject;
                    lbldate.Text = al.Attendance.CreatedDate.ToString();
                }

                Session.Abandon();
                Session.Clear();
        }
    }
}