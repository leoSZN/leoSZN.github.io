using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class _default : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        string cn = "";
        string studentID = "";
        bool pass = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                var r = from l in db.Students
                        where l.Login.Email == HttpContext.Current.User.Identity.Name
                        select l;

                foreach(Student s in r)
                {
                    studentID = s.StudentID;
                }
            }
            if (!Page.IsPostBack)
            {

                Session.Abandon();
                Session.Clear();
            }
          
            if (Page.IsPostBack)
            {
                err.Style.Add("display", "none");
                lblEmessage.Text = "";
                lblMsg.Text = "";
                Msg2.Style.Add("display", "none");
            }

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            bool exist = db.GamePINs.Any(id => id.PIN.Equals(txtPin.Text));
          
            if (exist == false)
            {
                lblEmessage.Text = "<li>We didn't recognize that game PIN. Please check and try again.</li>";
                err.Style.Add("display", "normal");
            }
            else
            {
                if (HttpContext.Current.User.Identity.Name == "")
                {
                    err.Style.Add("display", "normal");
                    lblEmessage.Text = "<li>Please Login into your account to continue the game.</li>";
                }
                else
                {
                    var gggg = from gp in db.GamePINs
                               where gp.PIN == txtPin.Text
                               select gp;
                    string avai = "";

                    foreach (GamePIN g in gggg)
                    {
                        avai = g.Available;
                    }
                    if (avai == "No")
                    {
                        err.Style.Add("display", "normal");
                        lblEmessage.Text = "<li>Attendance update time not yet started. Please inform your lecturer for any inquery.</li>";
                        pass = false;

                    }
                    if (avai == "Complete")
                    {
                        err.Style.Add("display", "normal");
                        lblEmessage.Text = "<li>Attendance update time is over, you can still join the game.</li>";
                        Session["fdefault"] = txtPin.Text.ToUpper();
                        Session["StuID"] = studentID;
                        Response.Redirect("nickname.aspx");
                        pass = false;

                    }

                    if (pass)
                    {
                        var r = from p in db.GamePINs
                                where p.PIN == txtPin.Text
                                select p;

                        foreach (GamePIN pp in r)
                        {
                            bool ee = db.AttLists.Any(id => id.AttID.Equals(pp.AttID) && id.Student.Login.Email.Equals(HttpContext.Current.User.Identity.Name));

                            if (ee)
                            {

                                string version = "";
                                HttpBrowserCapabilities browse = Request.Browser;
                                String userAgent = Request.UserAgent;
                                if (Request.UserAgent.IndexOf("Windows NT 5.1") > 0)
                                {
                                    version = "Windows XP";
                                }
                                else if (Request.UserAgent.IndexOf("Windows NT 6.0") > 0)
                                {
                                    version = "Windows VISTA";
                                }
                                else if (Request.UserAgent.IndexOf("Windows NT 6.1") > 0)
                                {
                                    version = "Windows 7";
                                }
                                else if (Request.UserAgent.IndexOf("Windows NT 6.2") > 0)
                                {
                                    version = "Windows 8";
                                }
                                else if (Request.UserAgent.IndexOf("Windows NT 6.3") > 0)
                                {
                                    version = "Windows 8.1";
                                }
                                else if (Request.UserAgent.IndexOf("Windows NT 10.0") > 0)
                                {
                                    version = "Windows 10";
                                }
                                else
                                {
                                    Regex OS = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|samsumg|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
                                    if (OS.IsMatch(userAgent))
                                    {
                                        string device_info = string.Empty;
                                        device_info = OS.Match(userAgent).Groups[0].Value;
                                        string[] split = device_info.Split(';');
                                        version = split[0];
                                    }
                                    else
                                    {
                                        version = "Mac OS";
                                    }
                                }
                                string ip = GetUserIp();
                                string[] ipp = ip.Split(':');
                                var cetZone = TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time");
                                var cetTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, cetZone);

                                //get country
                                try
                                {
                                    GeoService.GeoIPService service = new GeoService.GeoIPService();
                                    GeoService.GeoIP country = service.GetGeoIP(ipp[0]);
                                    cn = country.CountryName;

                                }
                                catch (Exception ex)
                                {
                                    cn = "Unknown";
                                }

                                var pin = from gp in db.GamePINs
                                          where gp.PIN == txtPin.Text
                                          select gp;
                                string attID = "";
                                foreach (GamePIN g in pin)
                                {
                                    attID = g.AttID;
                                }
                                AttList ats = db.AttLists.Single(l => l.Student.Login.Email == HttpContext.Current.User.Identity.Name && l.AttID == attID);
                                if (ats.Status == "A")
                                {


                                    ats.Status = "Present";
                                    ats.IP = ipp[0] + " " + cn;
                                    ats.Device = browse.Browser + " in " + version;
                                    ats.Time = cetTime;
                                    Msg2.Style.Add("display", "normal");
                                    lblMsg.Text = "<li>Your attendance have been updated.</li>";
                                    db.SubmitChanges();

                                    string body = this.PopulateBody(ats.Student.StudentName, ats.Attendance.Subject, ipp[0] + " " + cn, cetTime.ToString(), browse.Browser + " in " + version);
                                    this.SendHtmlFormattedEmail(HttpContext.Current.User.Identity.Name, "Your ILearn Account: Attendance Update", body);
                                    Session["fdefault"] = txtPin.Text;
                                    Session["StuID"] = studentID;
                                    Response.Redirect("nickname.aspx");

                                }
                                else if (ats.Status == "Present")
                                {
                                    Msg2.Style.Add("display", "normal");
                                    lblMsg.Text = "<li>Your attendance already updated.</li>";
                                    Session["fdefault"] = txtPin.Text;
                                    Session["StuID"] = studentID;
                                    Response.Redirect("nickname.aspx");
                                }
                            }
                            else
                            {
                                Msg2.Style.Add("display", "normal");
                                lblMsg.Text = "<li>You are not in our program, so you can't join the game.</li>";
                            }
                        }
                    }
                }
            }
        }

        private string GetUserIp()
        {
            var visitorsIpAddr = string.Empty;

            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                visitorsIpAddr = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            else if (!string.IsNullOrEmpty(Request.UserHostAddress))
            {
                visitorsIpAddr = Request.UserHostAddress;
            }

            return visitorsIpAddr;
        }

        private string PopulateBody(string userName,string subject, string ip,string time, string pc)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/EmailA.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Subject}", subject);
            body = body.Replace("{IP}", ip);
            body = body.Replace("{Time}", time);
            body = body.Replace("{PC}", pc);
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
    }
}