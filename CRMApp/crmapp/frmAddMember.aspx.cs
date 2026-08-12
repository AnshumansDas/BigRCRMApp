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
using Newtonsoft.Json.Linq;
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmAddMember : System.Web.UI.Page
    {
        #region global declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        string dtStartDate = string.Empty;
        string dtEndDate = string.Empty;     
        string strCreatedBy = string.Empty;             
        string strPerVoucherChargesByPercent = string.Empty;
       
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindState();
                if (!string.IsNullOrEmpty(Request.QueryString["userlogin_id"]))
                {
                    GetMemberDetails();
                }
                else
                { clearobject(); }
            }
          
        }
        public void BindState()
        {
            ServiceUrl = "CRM/GetStateDetails";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlState.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlState.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["State_name"].ToString())))
                        {
                            ddlState.Items.Add(new ListItem(dtRow["state_name"].ToString(), dtRow["state_id"].ToString()));
                        }
                    }
                }
            }
        }
        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity(ddlState.SelectedValue.Trim());
        }
        public void BindCity(string strVal)
        {
            ServiceUrl = "CRM/GetCityListing";
            ddlCity.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlCity.Items.Insert(0, item);
            var crm = new crmEntity()
            {
                state_id = Convert.ToInt16(strVal.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var City = response.Content.ReadAsStringAsync().Result;
                var dtCity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(City);
                if (dtCity.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtCity.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["city_name"].ToString())))
                        {
                            ddlCity.Items.Add(new ListItem(dtRow["city_name"].ToString(), dtRow["city_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void GetMemberDetails()
        {
            string strUserloginID = string.Empty;
            if (!string.IsNullOrEmpty(Request.QueryString["userlogin_id"].ToString().Trim()))
            { strUserloginID = Request.QueryString["userlogin_id"].ToString().Trim(); }
            ServiceUrl = "CRM/GetMemberDetails";
            var crm = new crmEntity()
            {
                userlogin_id = Convert.ToInt16(strUserloginID.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    
                    txtName.Text = dtChargeType.Rows[0]["user_fistname"].ToString().Trim();
                    txtEmail.Text = dtChargeType.Rows[0]["email_id"].ToString().Trim();
                    txtMobileNo.Text = dtChargeType.Rows[0]["mobile_no"].ToString().Trim();
                    if (!string.IsNullOrEmpty(Request.QueryString["userlogin_id"].Trim()))
                    { txtEmail.Enabled = false; }
                    else
                    { txtEmail.Enabled = true; }
                    txtDob.Text = dtChargeType.Rows[0]["user_dateofbirth"].ToString().Trim();
                    txtAddress1.Text = dtChargeType.Rows[0]["address1"].ToString().Trim();
                    txtAddress2.Text = dtChargeType.Rows[0]["address2"].ToString().Trim();
                    txtPostcode.Text = dtChargeType.Rows[0]["postcode_id"].ToString().Trim();
                    ddlState.SelectedValue = dtChargeType.Rows[0]["state_id"].ToString().Trim();
                    BindCity(ddlState.SelectedValue.Trim());
                    ddlCity.SelectedValue = dtChargeType.Rows[0]["city_id"].ToString().Trim();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void btnsave_click(object sender,EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["userlogin_id"]))
            {
                SaveMemberInfo(Request.QueryString["userlogin_id"].ToString().Trim());
            }
            else
            {
                if (!string.IsNullOrEmpty(txtEmail.Text.Trim()))
                {
                    ServiceUrl = "CRM/ValidateExistingMerchantEmail";
                    HttpResponseMessage responseemail = new HttpResponseMessage();
                    var validateemail = new crmEntity()
                    {
                        email_id = txtEmail.Text.Trim(),
                    };
                    responseemail = client.PostAsJsonAsync(ServiceUrl, validateemail).Result;
                    if (responseemail.IsSuccessStatusCode)
                    {
                        var EmailList = responseemail.Content.ReadAsStringAsync().Result;
                        var dtEmail = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(EmailList);
                        if (dtEmail.Rows.Count > 0)
                        {
                            checkemailmsg.InnerText = "Email was existed & please add new email.";
                            checkemailmsg.Style.Add("color", "Red");
                            checkemailmsg.Visible = true;
                        }
                        else
                        {
                            checkemailmsg.Visible = false;
                            checkemailmsg.InnerText = string.Empty;
                            ViewState["userEmail"] = txtEmail.Text.Trim();
                            SaveMemberInfo(string.Empty);
                        }
                    }
                    else
                    {
                        message.InnerText = responseemail.ReasonPhrase.ToString();
                        message.Style.Add("color", "Red");
                    }
                }
            }
        }

        public void SaveMemberInfo(string strUserloginID)
        {
            message.Visible = false;
            try
            {
                string strNewPassword = string.Empty, strDOB = string.Empty, strConvertDOB = string.Empty;
                DateTime dtdob = new DateTime();
                int UserloginID = 0;
                if (!string.IsNullOrEmpty(strUserloginID))
                { UserloginID = Convert.ToInt16(strUserloginID.Trim()); }
                if (!string.IsNullOrEmpty(txtDob.Text.Trim()))
                {
                    string[] starttokens = txtDob.Text.Split('/');
                    strDOB = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtdob = Convert.ToDateTime(strDOB);
                    strConvertDOB = dtdob.ToString("yyyy-MM-dd");
                }
                #region save member
                ServiceUrl = "CRM/AddEditMemberDetails";
                var crm = new crmEntity()
                {
                    userlogin_id = UserloginID,
                    name = txtName.Text.Trim(),
                    email_id = txtEmail.Text.Trim(),
                    mobile_no = txtMobileNo.Text.Trim(),
                    user_dateofbirth = strConvertDOB.Trim(),
                    address1 = txtAddress1.Text,
                    address2 = txtAddress2.Text,
                    state_id = Convert.ToInt16(ddlState.SelectedValue.Trim()),
                    city_id = Convert.ToInt16(ddlCity.SelectedValue.Trim()),
                    postcode = txtPostcode.Text.Trim()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var varNewPwdList = response.Content.ReadAsStringAsync().Result;
                    strNewPassword = varNewPwdList.ToString();
                    strNewPassword = strNewPassword.Substring(2, strNewPassword.Length - 4);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessPreSignupMsg();", true);

                    #region send email to user
                    string readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty, myStringUser = string.Empty;
                    // ADMIN EMAIL
                    StreamReader readerAdmin = new StreamReader(Server.MapPath("../crmadminemail.html"));
                    readAdminFile = readerAdmin.ReadToEnd();
                    myStringAdmin = readAdminFile;
                    myStringAdmin = myStringAdmin.Replace("$$MemberName$$", txtName.Text.Trim());
                    SendEmail(strAdminEmail, "User has Registered his/her account Successfully.", myStringAdmin);
                    readerAdmin.Close();
                    readerAdmin.Dispose();

                    //user
                    StreamReader readerUser = new StreamReader(Server.MapPath("../crmapp/createmerchuserbyadmin_email.html"));
                    readUserFile = readerUser.ReadToEnd();
                    myStringUser = readUserFile;
                    myStringUser = myStringUser.Replace("$$MemberName$$", txtName.Text.Trim());
                    myStringUser = myStringUser.Replace("$$UserName$$", ViewState["userEmail"].ToString().Trim());
                    myStringUser = myStringUser.Replace("$$UserPassword$$", strNewPassword.Trim());
                    myStringUser = myStringUser.Replace("$$EmailID$$", ViewState["userEmail"].ToString().Trim());
                    SendEmail(ViewState["userEmail"].ToString().Trim(), "Congratulations! Your Registration With BigR Is Successful.", myStringUser);
                    readerUser.Close();
                    readerUser.Dispose();

                    #endregion
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
                #endregion
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
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
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                WriteToFile(ex.Message.ToString());
                return;
            }
        }

        public void clearobject()
        {
            txtName.Text = "";
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            txtEmail.Text = "";
            txtMobileNo.Text = "";
            txtPostcode.Text = "";
            txtDob.Text = "";
            ddlState.SelectedIndex = 0;
            ddlCity.SelectedIndex = 0;
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAddMemberListing.aspx");
        }
    }
}