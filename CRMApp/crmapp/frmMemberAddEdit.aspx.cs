using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CRMApp.crmapp
{
    public partial class frmMemberAddEdit : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(),
        ServiceUrl = string.Empty, strCreatedby = string.Empty,
        //strAdminEmailTemplate = ConfigurationManager.AppSettings["AdminEmailTemplateURL"].ToString(),
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString(),
              strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                Bindroles();
            }
            lblstatusMessage.Text = "";
            
        }
        protected void Bindroles()
        {
            ServiceUrl = "CRM/GetRoleDetails";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlRole.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlRole.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var Role = response.Content.ReadAsStringAsync().Result;
                var dtRole = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Role);
                if (dtRole.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtRole.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["user_role"].ToString())))
                        {
                            ddlRole.Items.Add(new ListItem(dtRow["user_role"].ToString(), dtRow["role_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmMember.aspx");
        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            lblstatusMessage.Text = "";
            //ServiceUrl = "CRM/AddMemberDetails";
            ServiceUrl = "CRM/SignupRegistration";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (Session["username"] != null)
            { strCreatedby = Session["username"].ToString(); }
            string strPasswrd = "12345";

            var memDetValue = new crmEntity()
            {
                //name = txtName.Text.Trim(),
                //email_id = txtEmailId.Text.Trim(),
                //user_password = txtPassword.Text.Trim(),
                //device_type = string.Empty,
                //device_id = string.Empty,
                //fcm_id = string.Empty,
                //signup_category = 2
                name = TxtName.Text.Trim(),
                //user_name = Convert.ToString(TxtLoginID.Text.Trim()),
                email_id = TxtEmail.Text.Trim(),
                user_password = strPasswrd.Trim(),
                device_type = string.Empty,
                device_id = string.Empty,
                fcm_id = string.Empty,
                role_id = Convert.ToInt32(ddlRole.SelectedValue.ToString().Trim()),
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, memDetValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var getResponse = response.Content.ReadAsStringAsync().Result;
                string strtest = getBetween(getResponse, "[\"", "\"]");
                                      
                if (strtest.Trim() == "Record Inserted Successfully")
                {
                    message.InnerText = "Member Created Successfully.";
                    message.Style.Add("color", "Green");
                    //SendEmailNotificationToUser();
                    Response.Redirect("../crmapp/frmMember.aspx", false);
                    return;
                }
                else
                {
                    lblstatusMessage.Text = strtest;
                    lblstatusMessage.Style.Add("color", "red");
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }


        public static string getBetween(string strSource, string strStart, string strEnd)
        {
            int Start, End;
            if (strSource.Contains(strStart) && strSource.Contains(strEnd))
            {
                Start = strSource.IndexOf(strStart, 0) + strStart.Length;
                End = strSource.IndexOf(strEnd, Start);
                return strSource.Substring(Start, End - Start);
            }
            else
            {
                return "";
            }
        }


        public void SendEmailNotificationToUser()
        {
            string readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty, myStringUser = string.Empty;
            try
            {
                // ADMIN EMAIL
                StreamReader readerAdmin = new StreamReader(Server.MapPath("~/crmapp/crmaddbusinessuseremail.html"));
                readAdminFile = readerAdmin.ReadToEnd();
                myStringAdmin = readAdminFile;
                myStringAdmin = myStringAdmin.Replace("$$MemberName$$", TxtName.Text.Trim());
                myStringAdmin = myStringAdmin.Replace("$$UserName$$", TxtLoginID.Text.Trim());
                myStringAdmin = myStringAdmin.Replace("$$UserPassword$$", TxtPassword.Text.Trim());
                SendEmail(TxtEmail.Text.Trim(), "bigR Account Created Successfully.", myStringAdmin);
                readerAdmin.Close();
                readerAdmin.Dispose();
            }
            catch (Exception ex)
            {
                WriteToFile(ex.Message.ToString());
                return;
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
                //SmtpServer.EnableSsl = true;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                WriteToFile(ex.Message.ToString());
                return;
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
    }
}