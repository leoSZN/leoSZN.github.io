using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class reset : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                err.Style.Add("display", "none");
                Msg2.Style.Add("display", "none");
                iemail.Attributes.Add("class", "field");
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["email"] = txtEmail.Text;
            var r = from l in db.Logins
                    where l.Email == txtEmail.Text
                    select l;
            bool exist = db.Logins.Any(o => o.Email.Equals(txtEmail.Text));

            if (exist)
            {
                foreach (Login l in r)
                {
                    string name = "";
                    string email = txtEmail.Text;
                    string ip = GetUserIp();
                    string[] ipp = ip.Split(':');
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
                    }

                    string mname = browse.Browser + " on " + version;
                    string url = "http://ilearns.azurewebsites.net/resetlink.aspx?email=" + txtEmail.Text;
                    string titles = "Reset password";
                    name = l.UserName;
                    Login login = db.Logins.Single(ll => ll.Email == txtEmail.Text);
                    login.EmailToken = "True";
                    db.SubmitChanges();

                    ThreadPool.RegisterWaitForSingleObject(
                       new AutoResetEvent(false),
                       (state, timedOut) =>
                       {
                           login.EmailToken = "False";
                           db.SubmitChanges();

                       }, null, TimeSpan.FromHours(24), true);

                    //Send Email
                    string body = this.PopulateBodyR(name, url, titles, ipp[0], mname);
                    this.SendHtmlFormattedEmail(email, "Your ILearn Account: Password reset", body);

                    Msg2.Style.Add("display", "normal");

                }
            }
            else
            {
                iemail.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                lblEmessage.Text = "<li>We couldn't find that email address</li>";

            }
        }

        //Email template
        private string PopulateBodyR(string userName, string url, string title, string ips, string pcs)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/Emailf.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Url}", url);
            body = body.Replace("Title", title);
            body = body.Replace("{IP}", ips);
            body = body.Replace("{PC}", pcs);
            return body;
        }

        // Send Email
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

        //Get User IP Address
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
    }
}