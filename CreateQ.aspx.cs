using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class CreateQ : System.Web.UI.Page
    {
        string newid = "";
        int old = 0;
        string code = "";
        AceDataContext db = new AceDataContext();


        protected void Page_Load(object sender, EventArgs e)
        {
            populateID();
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
                try
                {
                    Random n = new Random();
                    char[] s = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                    'a','b','c','d','e','f','g','h','i','j','k','l','m','o','p','q','r','s','t','u','v','w','x','y','z','-','&','_','!','@'};
                    for (int i = 1; i < 21; i++)
                    {
                        int random = n.Next(0, s.Length);
                        code = code + s[random];
                    }

                    FileUpload1.SaveAs(Request.PhysicalApplicationPath + "/Image/" + code + FileUpload1.FileName );
                    QSphoto.ImageUrl = "~/Image/" + code + FileUpload1.FileName ;
                    uploadmsg.Text = "Uploaded.";
                    uploadmsg.ForeColor = System.Drawing.Color.Green;

                }
                catch (Exception ex)
                {
                    uploadmsg.Text = "ERROR: " + ex.Message.ToString();
                }

        }
        private void populateID()
        {
            try
            {
                var result = (from q in db.Questions
                              orderby q.QID descending
                              select q.QID).FirstOrDefault();

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

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {


            if (ImageButton1.ImageUrl == "~/Img/deselect.png")
            {

                ImageButton1.ImageUrl = "~/Img/select.png";
                ImageButton2.Enabled = false;
                ImageButton3.Enabled = false;
                ImageButton4.Enabled = false;


            }
            else if (ImageButton1.ImageUrl == "~/Img/select.png")
            {

                ImageButton1.ImageUrl = "~/Img/deselect.png";
                ImageButton2.Enabled = true;
                ImageButton3.Enabled = true;
                ImageButton4.Enabled = true;
            }


        }
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (ImageButton2.ImageUrl == "~/Img/deselect.png")
            {

                ImageButton2.ImageUrl = "~/Img/select.png";
                ImageButton1.Enabled = false;
                ImageButton3.Enabled = false;
                ImageButton4.Enabled = false;

            }
            else if (ImageButton2.ImageUrl == "~/Img/select.png")
            {

                ImageButton2.ImageUrl = "~/Img/deselect.png";
                ImageButton1.Enabled = true;
                ImageButton3.Enabled = true;
                ImageButton4.Enabled = true;

            }

        }
        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            if (ImageButton3.ImageUrl == "~/Img/deselect.png")
            {

                ImageButton3.ImageUrl = "~/Img/select.png";
                ImageButton1.Enabled = false;
                ImageButton2.Enabled = false;
                ImageButton4.Enabled = false;


            }
            else if (ImageButton3.ImageUrl == "~/Img/select.png")
            {

                ImageButton3.ImageUrl = "~/Img/deselect.png";
                ImageButton1.Enabled = true;
                ImageButton2.Enabled = true;
                ImageButton4.Enabled = true;

            }

        }
        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            if (ImageButton4.ImageUrl == "~/Img/deselect.png")
            {

                ImageButton4.ImageUrl = "~/Img/select.png";
                ImageButton1.Enabled = false;
                ImageButton2.Enabled = false;
                ImageButton3.Enabled = false;

            }
            else if (ImageButton4.ImageUrl == "~/Img/select.png")
            {

                ImageButton4.ImageUrl = "~/Img/deselect.png";
                ImageButton1.Enabled = true;
                ImageButton2.Enabled = true;
                ImageButton3.Enabled = true;
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Question ques = new Question();
            ques.QID = newid;
            ques.TimeLimit = Convert.ToInt32(Dropdownlist1.SelectedValue);
            ques.QsID = (string)Session["selected"];
            ques.Question1 = Textarea2.InnerText;

            string newAns = "";
            string ans = "";

            if (Textbox1.Text != "")
            {
                ans += Textbox1.Text;
            }
            else
            {
                ans += "";
            }
            if (Textbox3.Text != "")
            {
                ans += "," + Textbox3.Text;
            }
            else
            {
                ans += "";
            }
            if (Textbox4.Text != "")
            {
                ans += "," + Textbox4.Text;
            }
            else
            {
                ans += "";
            }
            if (Textbox5.Text != "")
            {
                ans += "," + Textbox5.Text;
            }
            else
            {
                ans += "";
            }
            ques.Answer = ans;


            if (ImageButton1.ImageUrl == "~/Img/select.png")
            {
                newAns += Textbox1.Text;
            }
            else
            {
                newAns += "".TrimStart().TrimEnd();

            }
            if (ImageButton2.ImageUrl == "~/Img/select.png")
            {
                newAns += Textbox3.Text;
            }
            else
            {
                newAns += "".TrimStart().TrimEnd();

            }
            if (ImageButton3.ImageUrl == "~/Img/select.png")
            {
                newAns +=  Textbox4.Text;

            }
            else
            {
                newAns += "".TrimStart().TrimEnd();

            }
            if (ImageButton4.ImageUrl == "~/Img/select.png")
            {
                newAns += Textbox5.Text;
            }
            else
            {
                newAns += "".TrimStart().TrimEnd();

            }
            ques.CorrectAns = newAns.TrimEnd();
            if (QSphoto.ImageUrl != null)
            {
                ques.Photo = QSphoto.ImageUrl;
            }
         
            if(ImageButton1.ImageUrl == "~/Img/deselect.png" && ImageButton2.ImageUrl == "~/Img/deselect.png"&& ImageButton3.ImageUrl == "~/Img/deselect.png"&& ImageButton4.ImageUrl == "~/Img/deselect.png")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "failalert();", true);
            } 
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert();", true);
                db.Questions.InsertOnSubmit(ques);
                db.SubmitChanges();
                reset();
            }
           
        }
        private void reset()
        {
            Textbox1.Text = "";
            Textarea2.InnerText = "";
            Textbox3.Text = "";
            Textbox4.Text = "";
            Textbox5.Text = "";
            Dropdownlist1.SelectedIndex = 0;


        }
    }
}