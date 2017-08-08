using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class ViewQ1 : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                reload();
            }
        }
        private void reload()
        {
            string selected = (string)(Session["selected"]);
            var qs = from Qs in db.QuestionSets
                     where Qs.QSId == selected
                     select Qs;
            foreach (var Qs in qs)
            {
                Image1.ImageUrl = Qs.Photo;
                lblTitle.Text = Qs.Title;
                if (Qs.Description.Count() >= 60)
                {
                    lbldesc.Text = Qs.Description.Substring(0, 50);
                    lbldes2.Text = Qs.Description.Substring(51, 100);

                }
                else
                    lbldesc.Text = Qs.Description;
                lbldes2.Visible = false;
                lbltype.Text = Qs.Type;
            }
            var r = from q in db.Questions
                    where q.QsID == selected
                    select q;
            Repeater1.DataSource = r;
            Repeater1.DataBind();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string selected = (string)(Session["selectedq"]);
            var q = from Q in db.Questions
                    where Q.QID == selected
                    select Q;
            foreach (var Q in q)
            {
                Session["Deleteq"] = Q;
                db.Questions.DeleteOnSubmit(Q);
                string file = Server.MapPath(Q.Photo);
                File.Delete(file);
                Session.Abandon();
                Session.Clear();
            }

            db.SubmitChanges();
            Session.Remove("selectedq");
            reload();
            delmsg.Style.Add("display", "normal");



        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //save id into session
            if (e.CommandName == "Editcmd")
            {
                Session["selectedq"] = (string)e.CommandArgument;
                Response.Redirect("EditQ.aspx", true);
            }

            if (e.CommandName == "Copycmd")
            {

            }

            if (e.CommandName == "Deletecmd")
            {
                Session["selectedq"] = (string)e.CommandArgument;

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);



            }
        }

        protected void ImgbtnEdit_Click(object sender, ImageClickEventArgs e)
        {

            Response.Redirect("EditQset.aspx", true);
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateQ.aspx", true);
        }

        protected void btnBac_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewQset.aspx", true);
        }

        protected void Button2_Click(object sender, EventArgs e)
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
            Response.Redirect("ViewQset.aspx", true);
        }

        protected void ImgbtnDelete_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal2').modal();", true);
        }
    }
}