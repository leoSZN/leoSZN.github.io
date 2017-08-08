using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewGameList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
             LinkButton lb = (LinkButton)sender;
            Session["GameID"] = lb.Text;
            Response.Redirect("ViewJoinStudent.aspx");

        }
    }
}