using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FinalYearProjectMasterPage.App_Code;
using System.Data.SqlClient;
using System.Web.Services;
using System.Collections;
using System.Windows.Forms;

namespace FinalYearProjectMasterPage
{
    public partial class Countdown : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
       

        protected void Page_Load(object sender, EventArgs e)
        {
            String id = (string)(Session["id"]);
            String QuizID = (string)(Session["QuizID"]);
            lblPIN.Text = id;
           

            if (!Page.IsPostBack)
            {
                jid.Text = HttpUtility.JavaScriptStringEncode(id, false);
                jqid.Text = HttpUtility.JavaScriptStringEncode(QuizID, false);
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "ccdown();", true);
            }
          
        }
     

        private void checkAbsent()
        {
            String id = (string)(Session["id"]);
            String attid = "";
            var rrrr = from d in db.GamePINs
                    where d.PIN == id
                    select d;
            
            foreach(GamePIN g in rrrr)
            {
                attid = g.AttID;
            }
            db.ExecuteCommand(@"insert into Absent( [StuID], [AttID],[EmailSent],[Subject] ) SELECT AttList.StuID, AttList.AttID, 'No', Attendance.Subject FROM AttList INNER JOIN Attendance ON AttList.AttID = Attendance.AttID where AttList.Status = 'A' and AttList.AttID = '" + attid + "'");
            var r = from a in db.AttLists
                    where a.Status == "A" && a.AttID == attid
                    select a;
            r.ToList().ForEach(u => u.Status = "Absent");
             db.SubmitChanges();

            var abb = db.Absents.Where(aa => aa.EmailSent == "No").GroupBy(aa => aa.Student.StudentName).Select(g => new { g.Key, count = g.Count() >= 3 });
            string subject = "";
            string email = "";
            foreach (var ab in abb)
            {

                if (ab.count == true)
                {

                    var abc = db.Absents.Where(aa => aa.Student.StudentName == ab.Key).GroupBy(aa => aa.Subject).Select(g => new { g.Key, count = g.Count() >= 3 });
                    foreach (var bbb in abc)
                    {
                        if (bbb.count == true)
                        {
                            var rr = from s in db.Absents
                                     where s.Student.StudentName == ab.Key && s.Subject == bbb.Key
                                     select s;
                            foreach (Absent s in rr)
                            {
                                email = s.Student.Login.Email;
                                subject += "<b style='Color:blue'>Subject: </b>" + bbb.Key + "<b  style='Color:blue'> Date: </b>" + s.Attendance.CreatedDate + " <b  style='Color:blue'>By Lecturer: </b>" + s.Attendance.Lecturer.LecturerName + "<br/><br/>";
                            }
                            string body = this.PopulateBody(ab.Key, bbb.Key, subject);
                            this.SendHtmlFormattedEmail(email, "Your Attendance Warning Letter", body);
                            subject = "";
                            var rrr = from bb in db.Absents
                                      where bb.Student.StudentName == ab.Key
                                      select bb;
                            rrr.ToList().ForEach(u => u.EmailSent = "Yes");
                            db.SubmitChanges();
                        }
                    }
                }
            }
        }

        private string PopulateBody(string userName,string sub, string subject)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/Emailatt.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Sub}", sub);
            body = body.Replace("{Subject}", subject);
            return body;
        }

        private void SendHtmlFormattedEmail(string recepientEmail, string subject, string body)
        {
            using (MailMessage mailMessage = new MailMessage())
            {
                mailMessage.From = new MailAddress(ConfigurationManager.AppSettings["UserName"], "ILearn Support", System.Text.Encoding.UTF8);
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true;
                mailMessage.To.Add(new MailAddress(recepientEmail));
                SmtpClient smtp = new SmtpClient();
                smtp.Host = ConfigurationManager.AppSettings["Host"];
                smtp.EnableSsl = Convert.ToBoolean(ConfigurationManager.AppSettings["EnableSsl"]);
                System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
                NetworkCred.UserName = ConfigurationManager.AppSettings["UserName"];
                NetworkCred.Password = ConfigurationManager.AppSettings["Password"];
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = int.Parse(ConfigurationManager.AppSettings["Port"]);
                smtp.Send(mailMessage);
            }
        }

        [WebMethod]
        public static Array loadQuestion(string quizID)
        {
            ArrayList questionList = new ArrayList();

            int id;
            string question;
            string correctAns;
            string beforeSplit;
            string[] options;
            string timelimit;
            string photo;
            SqlConnection conQuiz;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conQuiz = new SqlConnection(connStr);
            conQuiz.Open();

            string strSelect;
            SqlCommand cmdSelect;
            strSelect = "select * from Question where QsID = @QsID";
            cmdSelect = new SqlCommand(strSelect, conQuiz);
            cmdSelect.Parameters.AddWithValue("@QsID", quizID);
            SqlDataReader dtr;
            dtr = cmdSelect.ExecuteReader();
            if (dtr.HasRows)
            {
                while (dtr.Read())
                {
                    id = int.Parse(dtr["QsID"].ToString());
                    question = dtr["Question"].ToString();
                    correctAns = dtr["CorrectAns"].ToString();
                    beforeSplit = dtr["Answer"].ToString();
                    timelimit = dtr["TimeLimit"].ToString();
                    photo = dtr["Photo"].ToString();
                    options = beforeSplit.Split(',');
                    QuizClass quizClass = new QuizClass();
                    quizClass.QSID = id;
                    quizClass.Question = question;
                    quizClass.Options = options;
                    quizClass.CorrectAns = correctAns;
                    quizClass.TimeLimit = timelimit;
                    quizClass.Photo = photo;
                    questionList.Add(quizClass);
                  
                }
            }

            conQuiz.Close();
            dtr.Close();

            return questionList.ToArray();
        }


        [WebMethod]
        public static int createRealTimeQuiz(int quizID, int noOfStudent, string gamePin)
        {
            //MessageBox.Show(gamePin);
            int RTquizID = 0;
            /*Step 1: Create and Open Connection*/
            SqlConnection conAzure;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conAzure = new SqlConnection(connStr);
            conAzure.Open();
            if (conAzure != null)
            {
               
            }
          
            string strInsert;
            SqlCommand cmdInsert;

            strInsert = "SELECT MAX(RTQuizID) as maxID From RealTimeQuiz";
            cmdInsert = new SqlCommand(strInsert, conAzure);
            SqlDataReader dtr;
            dtr = cmdInsert.ExecuteReader();
            if (dtr.HasRows)
            {
                try
                {
                    while (dtr.Read())
                    {
                        RTquizID = Int32.Parse(dtr["maxID"].ToString());
                    }
                }catch(Exception ex)
                {
                    RTquizID = 1000000000;
                }
                
            }
            if (RTquizID == 0)
                RTquizID = 1000000000;
            else
                RTquizID += 1;
            dtr.Close();

            strInsert = "Insert Into RealTimeQuiz (RTQuizID, QsID, CreateDate, NumOfStudent, PinID) Values (@rtQuizID, @QsID , @createDate, @noStudent, @PinID)";

            cmdInsert = new SqlCommand(strInsert, conAzure);
            cmdInsert.Parameters.AddWithValue("@rtQuizID", RTquizID);
            cmdInsert.Parameters.AddWithValue("@QsID", quizID);
            cmdInsert.Parameters.AddWithValue("@createDate", DateTime.Now);
            cmdInsert.Parameters.AddWithValue("@noStudent", noOfStudent);
            cmdInsert.Parameters.AddWithValue("@PinID", gamePin);

            int a = cmdInsert.ExecuteNonQuery();
            conAzure.Close();
            return RTquizID;
        }

        [WebMethod]
        public static int updateToQuizList(int quizID, double score, double result, string studentID, int realTimeQuiz)
        {
            int quizListID = 0;
            SqlConnection conAzure;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conAzure = new SqlConnection(connStr);

            conAzure.Open();
            if (conAzure != null)
            {

            }

            string strInsert;
            SqlCommand cmdInsert;

            strInsert = "SELECT MAX(QuizListID) as maxID From QuizList";
            cmdInsert = new SqlCommand(strInsert, conAzure);
            SqlDataReader dtr;
            dtr = cmdInsert.ExecuteReader();
            if (dtr.HasRows)
            {
                try
                {
                    while (dtr.Read())
                    {
                        quizListID = Int32.Parse(dtr["maxID"].ToString());
                    }
                }
                catch (Exception ex)
                {
                    quizListID = 1000000000;
                }
            }
            if (quizListID == 0)
                quizListID = 1000000000;
            else
                quizListID += 1;
            dtr.Close();

            strInsert = "Insert into QuizList(QuizListID, QsID, StudentID, RealTimeScore, RealTimeResult, RTQuizID) values (@quizListID, @qsID, @studentID, @realTimeScore, @realTimeResult, @RTQuizID)";
            cmdInsert = new SqlCommand(strInsert, conAzure);
            cmdInsert.Parameters.AddWithValue("@quizListID", quizListID);
            cmdInsert.Parameters.AddWithValue("@realTimeScore", score);
            cmdInsert.Parameters.AddWithValue("@realTimeResult", result);
            cmdInsert.Parameters.AddWithValue("@qsID", quizID);
            cmdInsert.Parameters.AddWithValue("@studentID", studentID);
            cmdInsert.Parameters.AddWithValue("@RTQuizID", realTimeQuiz);
            int a = cmdInsert.ExecuteNonQuery();

            conAzure.Close();
            return quizListID;
        }

        [WebMethod]
        public static void updateToResultDetail(int quizListID, string correctness, string answer, int questionNo)
        {
            int resultID = 0;
            SqlConnection conAzure;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conAzure = new SqlConnection(connStr);

            conAzure.Open();
            if (conAzure != null)
            {

            }

            string strInsert;
            SqlCommand cmdInsert;

            strInsert = "SELECT MAX(ResultID) as maxID From QuizResultDetails";
            cmdInsert = new SqlCommand(strInsert, conAzure);
            SqlDataReader dtr;
            dtr = cmdInsert.ExecuteReader();
            if (dtr.HasRows)
            {
                try
                {
                    while (dtr.Read())
                    {
                        resultID = Int32.Parse(dtr["maxID"].ToString());
                    }
                }catch(Exception ex)
                {
                    resultID = 1000000000;
                }
                
            }
            if (resultID == 0)
                resultID = 1000000000;
            else
                resultID += 1;
            dtr.Close();
            strInsert = "Insert into QuizResultDetails(ResultID, QuizListID, Correctness, Answer, QuestionNum) values (@resultID, @quizListID, @correctness, @answer, @questionNo)";
            cmdInsert = new SqlCommand(strInsert, conAzure);
            cmdInsert.Parameters.AddWithValue("@resultID", resultID);
            cmdInsert.Parameters.AddWithValue("@quizListID", quizListID);
            cmdInsert.Parameters.AddWithValue("@correctness", correctness);
            cmdInsert.Parameters.AddWithValue("@answer", answer);
            cmdInsert.Parameters.AddWithValue("@questionNo", questionNo);

            int a = cmdInsert.ExecuteNonQuery();

            conAzure.Close();
        }

        [WebMethod]
        public static void updateAtt(string gamePin)
        {
            /*Step 1: Create and Open Connection*/
            SqlConnection conAzure;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conAzure = new SqlConnection(connStr);
            conAzure.Open();
            if (conAzure != null)
            {

            }

            string strInsert;
            SqlCommand cmdInsert;

            strInsert = strInsert = "Update GamePIN set Available = 'Complete' where PIN='" + gamePin + "'";

            cmdInsert = new SqlCommand(strInsert, conAzure);


            int a = cmdInsert.ExecuteNonQuery();
            conAzure.Close();

            Countdown co = new Countdown();
            co.checkAbsent();
        }
    }
}