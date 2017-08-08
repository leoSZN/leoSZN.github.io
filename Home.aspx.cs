﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class Default : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
          

            if (!Page.IsPostBack)
            {
                var student = db.Students.Count();
                lblStudent.Text = student.ToString();
                var lec = db.Lecturers.Count();
                lblLec.Text = lec.ToString();
                var login = db.Logins.Count();
                lblLogin.Text = login.ToString();
                populateLog();
            }
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