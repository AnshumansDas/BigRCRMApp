using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Data;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmEmailBlasting : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
            strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
            strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
            strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        string strckfinderPath = ConfigurationManager.AppSettings["ckfinder"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {

                if (Request.QueryString["id"].Trim() == "''")
                {
                    Txtid.Text = null;
                }
                else
                {
                    Bindnotificationdetails();

                }
            }
            CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser();
            _FileBrowser.BasePath = strckfinderPath;
            _FileBrowser.SetupCKEditor(txtMessageDescription);
        }
        protected void Bindnotificationdetails()
        {
            string id = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetemailblastingList";
            if (Request.QueryString["id"].Trim() != null)
            {
                id = Request.QueryString["id"].Trim();

            }
            var crm = new crmEntity()
            {
                notification_id = Convert.ToInt32(id)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    // lblMerchantCode.Text = dtChargeType.Rows[0]["merchant_code"].ToString().Trim();
                    Txtid.Text = dtChargeType.Rows[0]["notification_id"].ToString().Trim();
                    txtSubject.Text = dtChargeType.Rows[0]["notification_title"].ToString().Trim();
                    ddlSendTo.SelectedValue = dtChargeType.Rows[0]["notification_user_category"].ToString().Trim();
                    txtMessageDescription.Text = dtChargeType.Rows[0]["notification_summary"].ToString().Trim();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int notificationid = 0;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/insertemailblastingdetails";
            if (Txtid.Text != "")
            {
                notificationid = Convert.ToInt32(Txtid.Text);
            }
            var crm = new crmEntity()
            {
                notification_id = notificationid,
                role_id = Convert.ToInt32(ddlSendTo.SelectedValue.Trim()),
                subject = txtSubject.Text,
                message = txtMessageDescription.Text
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {

                string readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty, myStringUser = string.Empty, Username = string.Empty, Email = string.Empty;
                try
                {
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    ServiceUrl = "CRM/Getemaillistbyroleid";
                    var crmEmail = new crmEntity()
                    {
                        role_id = Convert.ToInt32(ddlSendTo.SelectedValue.Trim()),

                    };
                    HttpResponseMessage response1 = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    var ChargeType = response1.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    if (dtChargeType.Rows.Count > 0)
                    {
                        // lblMerchantCode.Text = dtChargeType.Rows[0]["merchant_code"].ToString().Trim();
                        Username = dtChargeType.Rows[0]["user_fistname"].ToString().Trim();
                        Email = dtChargeType.Rows[0]["email_id"].ToString().Trim();

                        string strpagename = "frmEmailBlastListing.aspx";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessFBMsg('" + strpagename + "');", true);

                        // USER EMAIL
                        StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/crmnotificationemail.html"));
                        readUserFile = readerUser.ReadToEnd();
                        myStringUser = readUserFile;
                        myStringUser = myStringUser.Replace("$$MemberName$$", txtSubject.Text);
                        myStringUser = myStringUser.Replace("$$UserName$$", Username);
                        myStringUser = myStringUser.Replace("$$MessageDesc$$", txtMessageDescription.Text);
                        SendEmail(Email, "Promotional", myStringUser);
                        readerUser.Close();
                        readerUser.Dispose();
                    }
                }
                catch (Exception ex)
                {
                    WriteToFile(ex.Message.ToString());
                    return;
                }

            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        private void WriteToFile(string text)
        {
            string filePath = Server.MapPath(ConfigurationManager.AppSettings["ErrorLogFileName"].ToString());
            if (!File.Exists(filePath))
            {
                using (var stream = File.Create(filePath)) { }
            }
            using (StreamWriter writer = new StreamWriter(filePath, true))
            {
                writer.WriteLine(Environment.NewLine);
                writer.WriteLine("************Exception Details on " + " " + DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt") + "****************");
                writer.WriteLine(text);
                writer.WriteLine("--------------------------------*End*------------------------------------------");
                writer.Flush();
                writer.Close();
            }
        }

        public void SendEmail(string to_sender, string subject, string message)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient();
                string s = string.Empty;
                s = strFromEmail;
                mail.From = new MailAddress(s);
                mail.To.Add(to_sender);
                mail.Subject = subject;
                mail.Body = message;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                WriteToFile(ex.Message.ToString());
                return;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/crmapp/frmEmailBlastListing.aspx");
        }
    }
}