using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FinalYearProjectMasterPage
{
    public partial class GuardCode : System.Web.UI.Page
    {
        AceDataContext db = new AceDataContext();
        string cn = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();

            if (Page.IsPostBack)
            {
                err.Style.Add("display", "none");
                icode.Attributes.Add("class", "field");
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String email = (string)(Session["email"]);
            var r = from s in db.Logins
                    where s.Email == email
                    select s;

            foreach (Login l in r)
            {
                if (l.GCode != txtCode.Text.ToUpper())
                {
                    err.Style.Add("display", "normal");
                    icode.Attributes.Add("class", "field has-error");

                }
                else if (l.GCode == txtCode.Text.ToUpper())
                {
                    FormsAuthentication.RedirectFromLoginPage(email, true);
                   // Response.Redirect("Home.aspx", false);
                    Session.Abandon();
                    Session.Clear();

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

                    Login login = db.Logins.Single(ll => ll.Email == email);
                    login.LastLoginDate = cetTime.ToString();

                    LHistory lh = new LHistory();
                    lh.LastLoginDate = cetTime.ToString();
                    lh.Browser = browse.Browser;
                    lh.Device = version;
                    lh.LoginID = login.LoginID;
                    lh.IpAddress = ipp[0];
                    lh.Country = cn;

                    db.LHistories.InsertOnSubmit(lh);
                    db.SubmitChanges();
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
    }
}