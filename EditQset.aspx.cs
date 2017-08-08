using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class EditQset : System.Web.UI.Page
    {
        string code = "";
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string selectedid = (string)(Session["selected"]);
                var r = from qs in db.QuestionSets
                        where qs.QSId == selectedid
                        select qs;

                foreach (QuestionSet qs in r)
                {
                    Textbox1.Text = qs.Title;
                    Textbox2.Text = qs.VideoUrl;
                    Textarea1.InnerText = qs.Description;
                    ddlQType.SelectedValue = qs.Type;
                    if (qs.Photo != "No")
                    {
                        QSphoto.ImageUrl = qs.Photo;
                        Session["ofile"] = Server.MapPath(qs.Photo);
                        Session["oname"] = qs.Photo;
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
                try
                {
                    Random n = new Random();
                    char[] s = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                    'a','b','c','d','e','f','g','h','i','j','k','l','m','o','p','q','r','s','t','u','v','w','x','y','z','-','&','_','!','@','$'};
                    for (int i = 1; i < 21; i++)
                    {
                        int random = n.Next(0, s.Length);
                        code = code + s[random];
                    }
                    FileUpload1.SaveAs(Request.PhysicalApplicationPath + "/Image/"+ code + FileUpload1.FileName);
                    QSphoto.ImageUrl = "~/Image/" + code + FileUpload1.FileName;
                    uploadmsg.Text = "Uploaded.";
                    uploadmsg.ForeColor = System.Drawing.Color.Green;

                }
                catch (Exception ex)
                {
                    uploadmsg.Text = "ERROR: " + ex.Message.ToString();
                }
            else
                uploadmsg.Text = "You have not specified a file.";

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            QuestionSet ques = db.QuestionSets.Single(qs => qs.QSId == (string)(Session["selected"]));
            ques.Title = Textbox1.Text;
            ques.Description = Textarea1.InnerText;

            if (ques.Photo != "No")
            {
                ques.Photo = QSphoto.ImageUrl;
                string ofile = (String)(Session["ofile"]);
                string oname = (String)(Session["oname"]);
                if (oname != QSphoto.ImageUrl)
                {
                    File.Delete(ofile);

                }
            }
            ques.Type = ddlQType.SelectedValue;
            ques.VideoUrl = Textbox2.Text;

            db.SubmitChanges();
            Response.Redirect("ViewQset.aspx", true);


        }
    }
}