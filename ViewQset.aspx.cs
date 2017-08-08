using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{

    public partial class ViewQ : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                reload();
            }
            if (Page.IsPostBack)
            {
                lblall.Text = "here";
            }
        }

        private void reload()
        {
            var r = from q in db.QuestionSets
                    where q.Lecturer.Login.Email == HttpContext.Current.User.Identity.Name
                    select q;
            Repeater1.DataSource = r;
            Repeater1.DataBind();
            lblall.Text = "<u>" + "You have " + r.Count() + " results" + "</u>";

            var r2 = from q in db.QuestionSets
                     where q.Type == "Public"
                     select q;
            Repeater2.DataSource = r2;
            Repeater2.DataBind();

            var r3 = from q in db.QuestionSets
                     where q.Type == "Private"
                     select q;
            Repeater3.DataSource = r3;
            Repeater3.DataBind();

            //share module
            var r4 = from q in db.QuestionSets
                     select q;
            Repeater4.DataSource = r4;
            Repeater4.DataBind();

        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //save id into session
            if (e.CommandName == "Editcmd")
            {
                Session["selected"] = (string)e.CommandArgument;
                Response.Redirect("ViewQ.aspx", true);
            }
            if (e.CommandName == "Playcmd")
            {
                Session["selected"] = (string)e.CommandArgument;
                Response.Redirect("PrepareLGame.aspx", true);

            }
            if (e.CommandName == "Sharecmd")
            {
                Session["selected"] = (string)e.CommandArgument;
            }
            if (e.CommandName == "Copycmd")
            {

            }
            if (e.CommandName == "Rankcmd")
            {

            }
            if (e.CommandName == "Deletecmd")
            {
                Session["selected"] = (string)e.CommandArgument;

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);



            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string selected = (string)(Session["selected"]);
            var q = from Q in db.Questions
                    where Q.QsID == selected
                    select Q;
            foreach (var Q in q)
            {
                db.Questions.DeleteOnSubmit(Q);
            }
            var qs = from Qs in db.QuestionSets
                     where Qs.QSId == selected
                     select Qs;
            foreach (var Qs in qs)
            {
                db.QuestionSets.DeleteOnSubmit(Qs);
            }
            db.SubmitChanges();
            Session.Remove("selected");
            reload();
            delmsg.Style.Add("display", "normal");


        }

        protected void btnadd_Click(object sender, EventArgs e)
        {

        }

        protected void btnshare_Click(object sender, EventArgs e)
        {

        }
    }
}