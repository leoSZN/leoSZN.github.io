using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewLGamePIN : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
           String msg = (string)(Session["success"]);
         
            if (msg != null)
            {
                lblmsg.Text = msg;
                Msg.Style.Add("display", "normal");
               Session.Clear();
               Session.Abandon();
            }
            else
            {
                lblmsg.Text = "";
                Msg.Style.Add("display", "none");
            }
            if (!Page.IsPostBack)
            {
                SqlDataSource1.SelectParameters["email"].DefaultValue = HttpContext.Current.User.Identity.Name;
            }
            
            if (Page.IsPostBack)
            {
               
                lblEmessage.Text = "";
                err.Style.Add("display", "none");
                lblmsg.Text = "";
                Msg.Style.Add("display", "none");
            }

        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "share":
                    //get command argument here
                    string id = e.CommandArgument.ToString();
                    Session["id"] = id;
                   
                    var r = from p in db.GamePINs
                            where p.PIN == id
                            select p;
                    foreach (GamePIN g in r)
                    {
                        Session["QuizID"] = g.QsID;
                     
                        if(g.Available == "No" || g.Available == "Yes")
                        {
                            g.Available = "Yes";
                            db.SubmitChanges();
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('Countdown.aspx','_parent');", true);
                          //  Response.Redirect("Countdown.aspx");
                            //Server.Transfer("Countdown.aspx");
                        }
                        else if(g.Available == "Complete"){
                            lblEmessage.Text = "<li>This Attendance list is already complete, you cannot share it for second times.</li>";
                            err.Style.Add("display", "normal");
                        }
                    }
                  
                    break;
                case "edit":
                    string attid = e.CommandArgument.ToString();
                    Session["attid"] = attid;
                    var ee = from gg in db.GamePINs
                             where gg.AttID == attid
                             select gg;
                    string status = "";
                    foreach (GamePIN g in ee)
                    {
                        status = g.Available;
                    }
                    if(status == "No")
                    {
                      
                       // Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('EditDetails.aspx','_blank');", true);
                        Response.Redirect("EditDetails.aspx");
                        // Server.Transfer("EditDetails.aspx");
                    }
                    else
                    {
                        lblEmessage.Text = "<li>This Information cannot be edit due to completed.</li>";
                        err.Style.Add("display", "normal");
                    }

                    break;
                case "del":
                    Session["delid"] = e.CommandArgument.ToString();
                   
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
                     break;

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String delid = (string)(Session["delid"]);
            var confirm = from a in db.GamePINs
                          where a.AttID == delid
                          select a;
            string status = "";
            foreach(GamePIN g in confirm)
            {
                status = g.Available;
            }

            try
            {
                if(status == "No")
                {
                    var del = from b in db.Absents
                              where b.AttID == delid
                              select b;
                    var dels = from b in db.AttLists
                               where b.AttID == delid
                               select b;

                    var delss = from b in db.GamePINs
                                where b.AttID == delid
                                select b;

                    var delsss = from b in db.Attendances
                                 where b.AttID == delid
                                 select b;

                    foreach (var a in del)
                    {
                        db.Absents.DeleteOnSubmit(a);
                    }
                    db.SubmitChanges();

                    foreach (var b in dels)
                    {
                        db.AttLists.DeleteOnSubmit(b);
                    }
                    db.SubmitChanges();

                    foreach (var c in delss)
                    {
                        db.GamePINs.DeleteOnSubmit(c);
                    }
                    db.SubmitChanges();

                    foreach (var d in delsss)
                    {
                        db.Attendances.DeleteOnSubmit(d);
                    }
                    db.SubmitChanges();

                    lblmsg.Text = "<li>All Information Deleted Successful.</li>";
                    Msg.Style.Add("display", "normal");
                    
                    Repeater1.DataBind();
                }
                else
                {
                    lblEmessage.Text = "<li>This Information cannot be delete due to completed.</li>";
                    err.Style.Add("display", "normal");
                }
               
            }
            catch(Exception ex)
            {

            }
           
        }
    }
}