using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewJoinStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String id = (string)(Session["GameID"]);

            SqlDataSource1.SelectParameters["gameID"].DefaultValue = id;

            Session.Abandon();
            Session.Clear();
        }
    }
}