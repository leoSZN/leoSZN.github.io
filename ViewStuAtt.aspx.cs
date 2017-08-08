using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewStuAtt : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            String id = (string)(Session["AttID"]);
            SqlDataSource1.SelectParameters["id"].DefaultValue = id;
            SqlDataSource1.SelectParameters["email"].DefaultValue = HttpContext.Current.User.Identity.Name;
   

            Session.Abandon();
            Session.Clear();
        }
    }
}