using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FinalYearProjectMasterPage.App_Code;
using System.Data.SqlClient;
using System.Collections;
using System.Web.Services;
using System.Configuration;
using System.Windows.Forms;

namespace FinalYearProjectMasterPage
{
    public partial class nickname : System.Web.UI.Page
    {
       public string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           id = (string)(Session["fdefault"]);
            String stuid = (string)(Session["StuID"]);
            lblStuId.Text = stuid;
            gamePIN.Text = id;
        }

     
       
        [WebMethod]
        public static Array loadQuestion()
        {

            string gamePin = HttpContext.Current.Session["fdefault"].ToString();
            ArrayList questionList = new ArrayList();

            int id;
            string question;
            string correctAns;
            string beforeSplit;
            string[] options;
            string timelimit;
            SqlConnection conQuiz;
            string connStr = ConfigurationManager.ConnectionStrings["ilearnConnectionString"].ConnectionString;
            conQuiz = new SqlConnection(connStr);
            conQuiz.Open();

            string strSelect;
            SqlCommand cmdSelect;
           

            strSelect = "SELECT Question.Question, Question.TimeLimit, Question.Answer, Question.CorrectAns, GamePIN.PIN, Question.QsID FROM Question INNER JOIN QuestionSet ON Question.QsID = QuestionSet.QSId INNER JOIN GamePIN ON QuestionSet.QSId = GamePIN.QsID WHERE(GamePIN.PIN = '"+ gamePin + "')";
            cmdSelect = new SqlCommand(strSelect, conQuiz);
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
                    options = beforeSplit.Split(',');
                    QuizClass quizClass = new QuizClass();
                    quizClass.QSID = id;
                    quizClass.Question = question;
                    quizClass.Options = options;
                    quizClass.CorrectAns = correctAns;
                    quizClass.TimeLimit = timelimit;
                    questionList.Add(quizClass);
                }
            }
            else
            {

            }
            conQuiz.Close();
            dtr.Close();
            return questionList.ToArray();
        }

    }
}