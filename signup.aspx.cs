using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Text;
using System.Net;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Runtime.Serialization;
using System.Web.Security;
using System.Net.Mail;
using System.Configuration;

namespace FinalYearProjectMasterPage
{

    public partial class signup : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        bool pass = true;
        string old = "";
        int sub = 0;
        string nID = "";
        string CN = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Home.aspx", false);
            }
            if (Page.IsPostBack)
            {
                lblEmessage.Text = "";
                err.Style.Add("display", "none");
                iemail.Attributes.Add("class", "field");
                ipass.Attributes.Add("class", "field");
                iname.Attributes.Add("class", "field ");
                icpass.Attributes.Add("class", "field");
            }
        }
        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            bool emailExist = db.Logins.Any(user => user.Email.Equals(txtEmail.Text));

            if (txtEmail.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtEmail.Text, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*") == false)
            {
                lblEmessage.Text += "<li>This doesn't appear to be a valid email address.</li>";
                iemail.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (emailExist)
            {
                lblEmessage.Text += "<li>This email address is already in use.</li>";
                iemail.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                pass = false;
            }
            if (txtName.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtName.Text, "^[a-zA-Z0-9'.\\s]{6,20}$") == false)
            {

                lblEmessage.Text += "<li>Make sure your username is 6 to 20 characters long, with letters, numbers only.</li>";
                iname.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                pass = false;

            }
            if (txtPass.Text == "" || System.Text.RegularExpressions.Regex.IsMatch(txtPass.Text, "[a-zA-Z0-9]{6,}$") == false)
            {

                lblEmessage.Text += "<li>Passwords must be 6 or more characters long.</li>";
                ipass.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                txtPass.Text = "";
                txtcPass.Text = "";
                pass = false;
            }
            if (txtcPass.Text != txtPass.Text)
            {

                lblEmessage.Text += "<li>Passwords must be matched.</li>";
                ipass.Attributes.Add("class", "field has-error");
                icpass.Attributes.Add("class", "field has-error");
                err.Style.Add("display", "normal");
                txtPass.Text = "";
                txtcPass.Text = "";
                pass = false;
            }
            verifyrecaptcha();

            if (pass)
            {
                var cetZone = TimeZoneInfo.FindSystemTimeZoneById("Singapore Standard Time");
                var cetTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, cetZone);

                //split IP
                string ip = GetUserIp();
                string[] ipp = ip.Split(':');

                //getDevice
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
                try
                {
                    //get country
                    GeoService.GeoIPService service = new GeoService.GeoIPService();
                    GeoService.GeoIP country = service.GetGeoIP(ipp[0]);
                    CN = country.CountryName;


                }
                catch (Exception ex)
                {
                    CN = "Unknown";

                }
                //insert
                Login l = new Login();
                l.LoginID = populateID();
                l.UserName = txtName.Text;
                l.Password = FormsAuthentication.HashPasswordForStoringInConfigFile(txtPass.Text, "MD5");
                l.Email = txtEmail.Text;
                l.Suspend = "No";
                l.EmailToken = "False";
                l.Active = "Unactive";
                l.Position = "Guest";
                l.Browser = browse.Browser;
                l.Device = version;
                l.CreatedDate = cetTime;
                l.AccCreatedIP = ipp[0];
                l.AccCreatedCountry = CN;


                db.Logins.InsertOnSubmit(l);
                db.SubmitChanges();

                active();
                Msg.Style.Add("display", "normal");
                reset();

            }

        }

        private void reset()
        {
            txtcPass.Text = "";
            txtEmail.Text = "";
            txtName.Text = "";
            txtPass.Text = "";

        }
        private string populateID()
        {
            var result = db.Logins.GroupBy(test => test.LoginID)
                   .Select(grp => grp.First())
                   .ToList();

            if (result.Count == 0)
            {
                nID = "L00001";
            }
            else
            {
                foreach (Login l in result)
                {
                    old = l.LoginID;
                    sub = Convert.ToInt32(old.Substring(1));
                    sub += 1;
                    nID = "L" + sub.ToString().PadLeft(5, '0');
                }
            }
            return nID;

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

        private void active()
        {
            Session["emailC"] = txtEmail.Text;
            string eemail = txtEmail.Text;
            string name = txtName.Text;
            string url = "http://ilearns.azurewebsites.net/activation.aspx?email=" + txtEmail.Text;
            string titles = "Activate your account";

            string body = this.PopulateBodyC(name, url, titles);
            this.SendHtmlFormattedEmail(eemail, "Your ILearn Account: Account activation.", body);

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

    }
}