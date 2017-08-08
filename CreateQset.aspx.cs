using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace FinalYearProjectMasterPage
{
    public partial class CreateQset : System.Web.UI.Page
    {
        string newid = "";
        int old = 0;
        string code = "";
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            populateID();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string title = Textbox1.Text;
            string desc = Textarea1.InnerText;
            string url = Textbox2.Text;
            string type = ddlQType.SelectedValue;
            string photo = "No";
            if (QSphoto.ImageUrl != null)
            {
                photo = QSphoto.ImageUrl;
            }
            int lid = 0;
            var rr = from l in db.Lecturers
                     where l.Login.Email == HttpContext.Current.User.Identity.Name
                     select l;

            foreach (Lecturer l in rr)
            {
                lid = l.ID;
            }
            QuestionSet newQset = new QuestionSet();
            newQset.QSId = newid;
            newQset.Title = title;
            newQset.Description = desc;
            newQset.VideoUrl = url;
            newQset.Type = type;
            newQset.LecturerID = lid;
            newQset.Photo = photo;

            db.QuestionSets.InsertOnSubmit(newQset);
            db.SubmitChanges();
            reset();
            Session["selected"] = newid;
            Server.Transfer("ViewQ.aspx", true);


        }

        private void populateID()
        {
            try
            {
                var result = (from qs in db.QuestionSets
                              orderby qs.QSId descending
                              select qs.QSId).FirstOrDefault();

                if (result == null)
                {
                    newid = "1000000000";
                }
                else
                {
                    old = Convert.ToInt32(result);
                    old += 1;
                    newid = old.ToString();
                }
            }
            catch (Exception ex)
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + ex.Message + "')", true);

            }


        }
        private void reset()
        {
            Textbox1.Text = "";
            Textarea1.InnerText = "";
            Textbox2.Text = "";
            ddlQType.SelectedIndex = 0;


        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
                try
                {
                    Random n = new Random();
                    char[] s = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a','b','c','d','e','f','g','h','i','j','k','l','m','o','p','q','r','s','t','u','v','w','x','y','z','-','&','_','!','@','$'};
                    for (int i = 1; i < 21; i++)
                    {
                        int random = n.Next(0, s.Length);
                        code = code + s[random];
                    }
                    FileUpload1.SaveAs(Request.PhysicalApplicationPath + "/Image/" + code + FileUpload1.FileName);
                    QSphoto.ImageUrl = "~/Image/"+ code + FileUpload1.FileName;
                    uploadmsg.Text = "Uploaded.";
                    uploadmsg.ForeColor = System.Drawing.Color.Green;

                }
                catch (Exception ex)
                {
                    uploadmsg.Text = "ERROR: " + ex.Message.ToString();
                }

        }
    }
}