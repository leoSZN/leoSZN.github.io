using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class StudentAtt : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            

            SqlDataSource1.SelectParameters["email"].DefaultValue = HttpContext.Current.User.Identity.Name;

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            Session["AttID"] = lb.Text;
            Response.Redirect("ViewStuAtt.aspx");

        }
    }
}