using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using System.Runtime.Serialization;
using System.Net.Mail;
using System.Configuration;
using System.Web.Security;
using System.Text.RegularExpressions;


namespace FinalYearProjectMasterPage
{
    public partial class signin : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool pass = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Home.aspx", false);
            }

            if (!IsPostBack)
            {
                if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
                {
                    txtEmail.Text = Request.Cookies["UserName"].Value;
                    txtPass.Attributes["value"] = Request.Cookies["Password"].Value;
                    rM.Checked = true;
                }
            }

            if (Page.IsPostBack)
            {
                lblEmessage.Text = "";
                err.Style.Add("display", "none");
                iemail.Attributes.Add("class", "field");
                ipass.Attributes.Add("class", "field");
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            var user = db.Logins.SingleOrDefault(x => x.Email == txtEmail.Text);


            if (txtEmail.Text == "" && txtPass.Text == "")
            {
                lblEmessage.Text += "<li>Please check your entries and try again. If you've forgotten your password, use the link below.</li>";
                err.Style.Add("display", "normal");
                iemail.Attributes.Add("class", "field has-error");
                ipass.Attributes.Add("class", "field has-error");

            }
            else if (user == null)
            {
                lblEmessage.Text += "<li>Sorry, ILearn doesn't recognize that email</li>";
                err.Style.Add("display", "normal");
                iemail.Attributes.Add("class", "field has-error");
            }
            if (user != null)
            {
                string md5 = FormsAuthentication.HashPasswordForStoringInConfigFile(txtPass.Text, "MD5");
                if (user.Password.Equals(md5))
                {
                    //verifyrecaptcha();
                    if (pass)
                    {
                        // Redirect
                        validateActive();
                        if (pass)
                        {
                            validateSus();
                            if (pass)
                            {
                                if (rM.Checked)
                                {
                                    Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                                    Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
                                }
                                else
                                {
                                    Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                                    Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

                                }
                                Response.Cookies["UserName"].Value = txtEmail.Text.Trim();
                                Response.Cookies["Password"].Value = txtPass.Text.Trim();
                                guardcode();

                            }

                        }
                    }

                }
                else
                {
                    lblEmessage.Text += "<li>Please check your entries and try again. If you've forgotten your password, use the link below.</li>";
                    err.Style.Add("display", "normal");
                    ipass.Attributes.Add("class", "field has-error");
                    txtPass.Text = "";
                }
            }

        }

        //Google recaptcha
        [DataContract]
        public class RecaptchaApiResponse
        {
            [DataMember(Name = "success")]
            public bool Success;

            [DataMember(Name = "error-codes")]
            public List<string> ErrorCodes;
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

        private void verifyrecaptcha()
        {
            //start building recaptch api call
            var sb = new StringBuilder();
            sb.Append("https://www.google.com/recaptcha/api/siteverify?secret=");

            //our secret key
            var secretKey = "6LcIQQkUAAAAAHZk8sa4Q4yKcbLm0sZp85RsjNGR";
            sb.Append(secretKey);

            //response from recaptch control
            sb.Append("&");
            sb.Append("response=");
            var reCaptchaResponse = Request["g-recaptcha-response"];
            sb.Append(reCaptchaResponse);

            //client ip address
            //---- This Ip address part is optional. If you donot want to send IP address you can
            //---- Skip(Remove below 4 lines)
            sb.Append("&");
            sb.Append("remoteip=");
            var clientIpAddress = GetUserIp();
            sb.Append(clientIpAddress);

            //make the api call and determine validity
            using (var client = new WebClient())
            {
                var uri = sb.ToString();
                var json = client.DownloadString(uri);
                var serializer = new DataContractJsonSerializer(typeof(RecaptchaApiResponse));
                var ms = new MemoryStream(Encoding.Unicode.GetBytes(json));
                var result = serializer.ReadObject(ms) as RecaptchaApiResponse;

                if (result == null)
                {
                    lblEmessage.Text += "<li>Captcha was unable to make the api call</li>";
                    err.Style.Add("display", "normal");
                    pass = false;
                }
                else if (result.ErrorCodes != null)
                {
                    if (result.ErrorCodes.Count > 0)
                    {

                        foreach (var error in result.ErrorCodes)
                        {
                            lblEmessage.Text += "<li>The captcha is not valid.</li>";
                            err.Style.Add("display", "normal");
                            pass = false;
                        }
                    }
                }
            }
        }
        private void validateSus()
        {
            var r = from s in db.Logins
                    where s.Email == txtEmail.Text
                    select s;
            foreach (Login l in r)
            {

                if (l.Suspend.Equals("Yes"))
                {

                    lblEmessage.Text += "<li>Your account has been suspended, please contact administrator for any inquiries.</li>";
                    err.Style.Add("display", "normal");
                    txtPass.Text = "";
                    txtPass.Focus();
                    pass = false;
                }
            }
        }
        private void validateActive()
        {
            var r = from s in db.Logins
                    where s.Email == txtEmail.Text
                    select s;

            foreach (Login l in r)
            {

                if (l.Active.Equals("Unactive"))
                {

                    lblEmessage.Text += "<li>Please activate your account, an email has been sent to " + l.Email + "</li>";
                    err.Style.Add("display", "normal");
                    txtPass.Text = "";
                    txtPass.Focus();
                    activec();
                    pass = false;
                }
            }
        }

        //Email template activation
        private string PopulateBodyC(string userName, string url, string title)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/Emailc.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Url}", url);
            body = body.Replace("Title", title);
            return body;
        }

        // Email template Guard code
        private string PopulateBody(string userName, string codes, string ips, string pcs)
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(Server.MapPath("~/Email.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", userName);
            body = body.Replace("{Code}", codes);
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

        //get Email content
        private void activec()
        {
            var r = from s in db.Logins
                    where s.Email == txtEmail.Text
                    select s;

            foreach (Login l in r)
            {
                Session["emailC"] = txtEmail.Text;
                string eemail = txtEmail.Text;
                string name = l.LoginID;
                string url = "http://ilearns.azurewebsites.net/activation.aspx?email=" + txtEmail.Text;
                string titles = "Activate your account";

                string body = this.PopulateBodyC(name, url, titles);
                this.SendHtmlFormattedEmail(eemail, "Your ILearn Account: Account activation.", body);
            }


        }

        //generate Guard code and User details
        private void guardcode()
        {
            var r = from s in db.Logins
                    where s.Email == txtEmail.Text
                    select s;

            foreach (Login l in r)
            {
                //User details
                String code = "";
                string email = l.Email;
                string name = l.UserName;
                string ip = GetUserIp();
                string[] ips = ip.Split(':');
                string version = "";

                //Generated code
                Random n = new Random();
                char[] s = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
                for (int i = 1; i < 7; i++)
                {
                    int random = n.Next(0, s.Length);
                    code = code + s[random];
                    Session["email"] = txtEmail.Text;
                    Login login = db.Logins.Single(ll => ll.Email == txtEmail.Text);
                    login.GCode = "ABC123";
                    db.SubmitChanges();
                }

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
                }

                string mname = browse.Browser + " on " + version;

                //send Email
                string body = this.PopulateBody(name, code, ips[0], mname);
                this.SendHtmlFormattedEmail(email, "Your ILearn Account: Access from web", body);
                Response.Redirect("~/GuardCode.aspx", false);
            }
        }
    }
}