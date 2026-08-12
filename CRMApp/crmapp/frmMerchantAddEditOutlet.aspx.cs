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
using System.Text;
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmMerchantAddEditOutlet : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        int BrandID = 0;
        string strBranchID = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
             strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
             strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
             strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantList();
                BindState();
                if (!string.IsNullOrEmpty(Request.QueryString["bID"]))
                {
                    GetMerchantDetails();
                }
            }
        }

        public void BindMerchantList()
        {
            ServiceUrl = "CRM/BindMerchantList";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlMerchName.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlMerchName.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["organization_name"].ToString())))
                        {
                            ddlMerchName.Items.Add(new ListItem(dtRow["organization_name"].ToString(), dtRow["merchant_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindState()
        {
            ServiceUrl = "CRM/GetStateDetails";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
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

        public void BindCity(string strVal)
        {
            string strStateID = string.Empty;
            ServiceUrl = "CRM/GetCityListing";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
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

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity(ddlState.SelectedValue.Trim());
        }

        public void GetMerchantDetails()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["bID"].ToString().Trim()))
            { strBranchID = Request.QueryString["bID"].ToString().Trim(); }

            ServiceUrl = "CRM/ListMerchantOutletDetails";
            var crm = new crmEntity()
            {
                branch_id = Convert.ToInt16(strBranchID.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    if (Session["roleid"].ToString() == "5")
                    {
                        ddlMerchName.SelectedValue = dtChargeType.Rows[0]["merchant_id"].ToString().Trim();
                        ddlMerchName.Enabled = false;
                        txtUsername.Text = dtChargeType.Rows[0]["user_name"].ToString().Trim();
                        txtUsername.Enabled = false;
                    }
                    else
                    {
                        ddlMerchName.SelectedValue = dtChargeType.Rows[0]["merchant_id"].ToString().Trim();
                        txtUsername.Text = dtChargeType.Rows[0]["user_name"].ToString().Trim();
                        txtUsername.Enabled = false;
                    }
                    txtBranchName.Text = dtChargeType.Rows[0]["branch_name"].ToString().Trim();
                    txtLongitude.Text = dtChargeType.Rows[0]["longitude"].ToString().Trim();
                    txtLatitude.Text = dtChargeType.Rows[0]["latitude"].ToString().Trim();
                    txtPersonInCharge.Text = dtChargeType.Rows[0]["person_incharge"].ToString().Trim();
                    txtMobileNo.Text = dtChargeType.Rows[0]["mobile_phone"].ToString().Trim();
                    txtOfficeNo.Text = dtChargeType.Rows[0]["office_phone"].ToString().Trim();
                    txtFaxNo.Text = dtChargeType.Rows[0]["fax_no"].ToString().Trim();
                    txtEmail.Text = dtChargeType.Rows[0]["email"].ToString().Trim();
                    if (!string.IsNullOrEmpty(Request.QueryString["bID"].Trim()))
                    { txtEmail.Enabled = false; }
                    else
                    { txtEmail.Enabled = true; }
                    txtAddress1.Text = dtChargeType.Rows[0]["branch_address_1"].ToString().Trim();
                    txtAddress2.Text = dtChargeType.Rows[0]["branch_address_2"].ToString().Trim();
                    txtPostcode.Text = dtChargeType.Rows[0]["branch_postcode"].ToString().Trim();
                    ddlState.SelectedValue = dtChargeType.Rows[0]["state_id"].ToString().Trim();
                    BindCity(ddlState.SelectedValue.Trim());
                    ddlCity.SelectedValue = dtChargeType.Rows[0]["city_id"].ToString().Trim();
                    txtRemark.Text = dtChargeType.Rows[0]["remarks"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtChargeType.Rows[0]["status"].ToString().Trim();
                }
                else
                {
                    if (Session["roleid"].ToString() == "5")
                    {
                        ddlMerchName.SelectedValue = Session["MerchID"].ToString().Trim();
                        ddlMerchName.Enabled = false;
                        txtUsername.Enabled = true;
                    }
                    else
                    {
                        Session["MerchID"] = string.Empty;
                        ddlMerchName.Enabled = true;
                        txtUsername.Enabled = true;
                    }
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
            if (!string.IsNullOrEmpty(Request.QueryString["bID"]))
            {
                SaveMerchOutletInfo(Request.QueryString["bID"].ToString().Trim());
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
                            SaveMerchOutletInfo(string.Empty);
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

        public void SaveMerchOutletInfo(string strBranchID)
        {
            message.Visible = false;
            try
            {
                StringBuilder htmlTable = new StringBuilder();
                htmlTable.AppendLine("https://maps.google.com.my/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=" + txtLatitude.Text.Trim() + "," + txtLongitude.Text.Trim() + "&amp;aq=&amp;sll=3.3,101.41&amp;sspn=0.088088,0.169086&amp;ie=UTF8&amp;t=m&amp;z=14&amp;ll=" + txtLatitude.Text.Trim() + "," + txtLongitude.Text.Trim() + "&amp;output=embed");
                litTable.Text = htmlTable.ToString();

                string strNewPassword = string.Empty;
                string strCreatedBy = string.Empty;

                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = "crmadmin123"; }

                if (!string.IsNullOrEmpty(strBranchID))
                { BrandID = Convert.ToInt16(strBranchID.Trim()); }

                #region save outlet
                ServiceUrl = "CRM/AddEditMerchantOutletDetails";
                var crm = new crmEntity()
                {
                    branch_id = BrandID,
                    branch_name = txtBranchName.Text.Trim(),
                    longitude = txtLongitude.Text.Trim(),
                    latitude = txtLatitude.Text.Trim(),
                    person_incharge = txtPersonInCharge.Text,
                    merchant_id = Convert.ToInt16(ddlMerchName.SelectedValue.Trim()),
                    address_1 = txtAddress1.Text,
                    address_2 = txtAddress2.Text,
                    postcode = txtPostcode.Text,
                    state_id = Convert.ToInt16(ddlState.SelectedValue.Trim()),
                    city_id = Convert.ToInt16(ddlCity.SelectedValue.Trim()),
                    remarks = txtRemark.Text.Trim(),
                    active_status = Convert.ToInt16(ddlActiveStatus.SelectedValue.Trim()),
                    user_by = strCreatedBy,
                    map_path = litTable.Text.Trim(),
                    office_phone = txtOfficeNo.Text.Trim(),
                    mobile_no = txtMobileNo.Text.Trim(),
                    fax_no = txtFaxNo.Text.Trim(),
                    email = txtEmail.Text.Trim(),
                    user_name = txtUsername.Text.Trim()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var varNewPwdList = response.Content.ReadAsStringAsync().Result;
                    strNewPassword = varNewPwdList.ToString();
                    strNewPassword = strNewPassword.Substring(2, strNewPassword.Length - 4);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessOutletMsg();", true);

                    #region send email to user
                    string readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty, myStringUser = string.Empty;
                    // ADMIN EMAIL
                    StreamReader readerAdmin = new StreamReader(Server.MapPath("../crmadminemail.html"));
                    readAdminFile = readerAdmin.ReadToEnd();
                    myStringAdmin = readAdminFile;
                    myStringAdmin = myStringAdmin.Replace("$$MemberName$$", txtPersonInCharge.Text.Trim());
                    SendEmail(strAdminEmail, "User has Registered his/her account Successfully.", myStringAdmin);
                    readerAdmin.Close();
                    readerAdmin.Dispose();

                    //user
                    StreamReader readerUser = new StreamReader(Server.MapPath("../crmapp/createmerchuserbyadmin_email.html"));
                    readUserFile = readerUser.ReadToEnd();
                    myStringUser = readUserFile;
                    myStringUser = myStringUser.Replace("$$MemberName$$", txtPersonInCharge.Text.Trim());
                    myStringUser = myStringUser.Replace("$$UserName$$", txtUsername.Text.Trim());
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

        public void SetGoogleMap()
        {
            StringBuilder htmlTable = new StringBuilder();
            //<small><a target=_blank 
            //href ="https://maps.google.com.my/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=3.137503,101.630385&amp;aq=&amp;sll=3.3,101.41&amp;sspn=0.088088,0.169086&amp;ie=UTF8&amp;t=m&amp;z=14&amp;ll=3.137503,101.630385" style="color:#0000FF;text-align:left">View Larger Map</a></small>
            //htmlTable.AppendLine("<a target=_blank href ='https://maps.google.com.my/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=2.994054,101.721331&amp;aq=&amp;sll=3.3,101.41&amp;sspn=0.088088,0.169086&amp;ie=UTF8&amp;t=m&amp;z=14&amp;ll=2.994054,101.721331' style='color:#0000FF;text-align:left'>View Larger Map</a>");
            htmlTable.AppendLine("https://maps.google.com.my/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=" + txtLatitude.Text.Trim() + "," + txtLongitude.Text.Trim() + "&amp;aq=&amp;sll=3.3,101.41&amp;sspn=0.088088,0.169086&amp;ie=UTF8&amp;t=m&amp;z=14&amp;ll=" + txtLatitude.Text.Trim() + "," + txtLongitude.Text.Trim() + "&amp;output=embed");
            //htmlTable.AppendLine("<td width='65'><strong>MAKE</strong></td>");
            //htmlTable.AppendLine("<td width='65'><strong>MODEL</strong></td>");
            //htmlTable.AppendLine("<td width='65'><strong>VARIANT</strong></td>");
            //htmlTable.AppendLine("</tr>");
            //string strMapPath = 'https://maps.google.com.my/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q="+txtLatitude+",101.721331&amp;aq=&amp;sll=3.3,101.41&amp;sspn=0.088088,0.169086&amp;ie=UTF8&amp;t=m&amp;z=14&amp;ll=2.994054,101.721331&amp;output=embed";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmMerchantOutlet.aspx");
        }
    }
}