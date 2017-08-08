using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class EditQ : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        string qid = "";
        string code ="";
        protected void Page_Load(object sender, EventArgs e)
        {
            qid = (string)(Session["selectedq"]);
         
            if (!Page.IsPostBack)
            {
             
                var r = from q in db.Questions
                        where q.QID == qid
                        select q;
                foreach (Question q in r)
                {
                    Textarea2.InnerText = q.Question1;
                    Dropdownlist1.SelectedValue = q.TimeLimit.ToString();
                    string answer = q.Answer;
                    string[] split = answer.Split(',');

                    int final = 4;
                    string psp = ", ";
                    int splitCount = 0;

                    splitCount = split.Count();

                    while (splitCount < final)
                    {
                        splitCount += 1;
                        answer += psp;
                    }
                    split = answer.Split(',');

                    Textbox1.Text = split[0].Trim();
                    Textbox3.Text = split[1].Trim();
                    Textbox4.Text = split[2].Trim();
                    Textbox5.Text = split[3].Trim();


                    if (split[0].Trim() == q.CorrectAns)
                    {
                        ImageButton1.ImageUrl = "~/Img/select.png";
                        ImageButton2.Enabled = false;
                        ImageButton3.Enabled = false;
                        ImageButton4.Enabled = false;
                    }
                    if (split[1].Trim() == q.CorrectAns)
                    {
                        ImageButton2.ImageUrl = "~/Img/select.png";
                        ImageButton1.Enabled = false;
                        ImageButton3.Enabled = false;
                        ImageButton4.Enabled = false;
                    }
                    if (split[2].Trim() == q.CorrectAns)
                    {
                        ImageButton3.ImageUrl = "~/Img/select.png";
                        ImageButton1.Enabled = false;
                        ImageButton2.Enabled = false;
                        ImageButton4.Enabled = false;
                    }
                    if (split[3].Trim() == q.CorrectAns)
                    {
                        ImageButton4.ImageUrl = "~/Img/select.png";
                        ImageButton1.Enabled = false;
                        ImageButton3.Enabled = false;
                        ImageButton2.Enabled = false;
                    }

                    if (q.Photo != "No")
                    {
                        QSphoto.ImageUrl = q.Photo;
                        Session["ofile"] = Server.MapPath(q.Photo);
                        Session["oname"] = q.Photo;
                    }

                }

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
            Question que = db.Questions.Single(q => q.QID == qid);
            que.Question1 = Textarea2.InnerText;
            que.TimeLimit = Convert.ToInt32(Dropdownlist1.SelectedValue);

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

            que.Answer = ans;


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
                newAns += Textbox4.Text;

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

            que.CorrectAns = newAns;

         
            if (QSphoto.ImageUrl != null)
            {
                que.Photo = QSphoto.ImageUrl;
                string ofile = (String)(Session["ofile"]);
                string oname = (String)(Session["oname"]);

                if(oname == "")
                {
                    db.SubmitChanges();
                    Response.Redirect("ViewQ.aspx", true);
                }
                else if (oname != QSphoto.ImageUrl)
                {
                    File.Delete(ofile);
                }

            }


            db.SubmitChanges();
            Response.Redirect("ViewQ.aspx", true);



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
                    QSphoto.ImageUrl = "Image/" + code + FileUpload1.FileName;
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
    }
}