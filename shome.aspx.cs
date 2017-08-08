using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class shome : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var r = from a in db.AttLists
                        where a.Student.Login.Email == HttpContext.Current.User.Identity.Name
                select a;

                lblatt.Text = r.Count().ToString();
                populateLog();


            }
            var rrr = from a in db.AttLists
                    where a.Student.Login.Email == HttpContext.Current.User.Identity.Name && a.Status == "Absent"
                    select a;

            var rr = from a in db.AttLists
                     where a.Student.Login.Email == HttpContext.Current.User.Identity.Name && a.Status == "Present"
                     select a;
          
            lbla.Text = rrr.Count().ToString();
            lblp.Text = rr.Count().ToString();

        }

        private void populateLog()
        {
            string sCon = "Data Source=ilearn.database.windows.net;Initial Catalog=ILearn;Persist Security Info=True;User ID=ilearn;Password=Admin123";

            using (SqlConnection con = new SqlConnection(sCon))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT LHistory.LastLoginDate AS 'Last Login', LHistory.Browser, LHistory.Device AS 'Windows', LHistory.IpAddress AS 'IP Address',LHistory.Country As 'Country' FROM LHistory INNER JOIN Login ON LHistory.LoginID = Login.LoginID WHERE Login.Email = '" + User.Identity.Name + "' ORDER BY LHistory.ID DESC"))
                {
                    SqlDataAdapter sda = new SqlDataAdapter();
                    try
                    {
                        cmd.Connection = con;
                        con.Open();
                        sda.SelectCommand = cmd;

                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        // BIND DATABASE WITH THE GRIDVIEW.
                        gd1.DataSource = dt;
                        gd1.DataBind();

                    }
                    catch (Exception ex)
                    {
                        //
                    }
                }
            }
        }

    }
}