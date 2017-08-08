using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinalYearProjectMasterPage.App_Code
{
    public class QuizClass
    {
        public int QID { get; set; }
        public int QSID { get; set; }
        public string Question { get; set; }
        public string TimeLimit { get; set; }
        public string Photo { get; set; }
        public string[] Options { get; set; }
        public string CorrectAns { get; set; }
    }
}