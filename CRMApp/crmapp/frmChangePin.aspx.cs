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
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static CRMApp.crmEntity;
using Newtonsoft.Json.Linq;
using System.Data;

namespace CRMApp.crmapp
{
    public partial class frmChangePin : System.Web.UI.Page
    {
        #region global declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                //Send Email notification to user--------------------------------------
                //SendEmail(txtEmail.Text.Trim(), "BigR - Forgot PIN.");
                //---------------------------------------------------------------------
                if (Session["EmailId"] != null)
                {
                    txtUserEmail.Text = Session["EmailId"].ToString();
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
        }

        //protected void lnkNSubmit_Click(object sender, EventArgs e)
        //{
        //    AddEditNewPIN();
        //}

        //protected void lnkNCancel_Click(object sener, EventArgs e)
        //{
        //    txtPin1.Text = string.Empty; txtPin2.Text = string.Empty;
        //    txtPin3.Text = string.Empty; txtPin4.Text = string.Empty;
        //    txtPin5.Text = string.Empty; txtPin6.Text = string.Empty;

        //    message_nPin.InnerText = "";
        //}

        protected void lnkSave_Click(object sender, EventArgs e)
        {
            //Validate old password
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            string strOldPin = txtOldPin1.Text.Trim() + txtOldPin2.Text.Trim() + txtOldPin3.Text.Trim() + txtOldPin4.Text.Trim() + txtOldPin5.Text.Trim() + txtOldPin6.Text.Trim();
            string strNewPin = txtNewPin1.Text.Trim() + txtNewPin2.Text.Trim() + txtNewPin3.Text.Trim() + txtNewPin4.Text.Trim() + txtNewPin5.Text.Trim() + txtNewPin6.Text.Trim();
            ServiceUrl = "CRM/ValidateTransactionPin";

            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString()),
                pin_no = strOldPin
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Pin = response.Content.ReadAsStringAsync().Result;
                var dtPin = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Pin);
                if (dtPin.Rows.Count > 0)
                {
                    if(strOldPin == strNewPin)
                    {
                        message_cPin.InnerText = "Already exist the PIN";
                        message_cPin.Style.Add("color", "Red");
                    }
                    else
                    {
                        AddEditChangePIN();
                    }                    
                }
                else
                {
                    message_cPin.InnerText = "Incorrect PIN / PIN Not Created Yet";
                    message_cPin.Style.Add("color", "Red");
                }
            }
            else
            {
                message_cPin.InnerText = "PIN Not Created Yet";
                message_cPin.Style.Add("color", "Red");
            }
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            txtOldPin1.Text = string.Empty; txtOldPin2.Text = string.Empty;
            txtOldPin3.Text = string.Empty; txtOldPin4.Text = string.Empty;
            txtOldPin5.Text = string.Empty; txtOldPin6.Text = string.Empty;


            txtNewPin1.Text = string.Empty; txtNewPin2.Text = string.Empty; 
            txtNewPin3.Text = string.Empty; txtNewPin4.Text = string.Empty;
            txtNewPin5.Text = string.Empty; txtNewPin6.Text = string.Empty;

            message_cPin.InnerText = "";
        }

        //protected void lnkFCancel_Click(object sender, EventArgs e)
        //{
        //    txtEmail.Text = string.Empty;

        //    txtNewFPin1.Text = string.Empty;
        //    txtNewFPin2.Text = string.Empty;
        //    txtNewFPin3.Text = string.Empty;
        //    txtNewFPin4.Text = string.Empty;
        //    txtNewFPin5.Text = string.Empty;
        //    txtNewFPin6.Text = string.Empty;

        //    txtConfPin1.Text = string.Empty;
        //    txtConfPin2.Text = string.Empty;
        //    txtConfPin3.Text = string.Empty;
        //    txtConfPin4.Text = string.Empty;
        //    txtConfPin5.Text = string.Empty;
        //    txtConfPin6.Text = string.Empty;

        //    message_fPin.InnerText = "";
        //}

        protected void lnkFPinSave_Click(object sender, EventArgs e)
        {
            //Send Email notification to user--------------------------------------
            SendEmail(txtUserEmail.Text.Trim(), "BigR - Forgot PIN.");
        }

        //protected void lnkFSave_Click(object sender, EventArgs e)
        //{
        //    string strNewPin = txtNewFPin1.Text.Trim() + txtNewFPin2.Text.Trim() + txtNewFPin3.Text.Trim() + txtNewFPin4.Text.Trim() + txtNewFPin5.Text.Trim() + txtNewFPin6.Text.Trim();
        //    string strConfPin = txtConfPin1.Text.Trim() + txtConfPin2.Text.Trim() + txtConfPin3.Text.Trim() + txtConfPin4.Text.Trim() + txtConfPin5.Text.Trim() + txtConfPin6.Text.Trim();
        //    if(strNewPin == strConfPin)
        //    {
        //        //validate email of user

        //        //Insert/Update to DB
        //        AddEditForgotPIN();
        //    }
        //    else
        //    {
        //        message_fPin.InnerText = "PIN Not Match";
        //        message_fPin.Style.Add("color", "Red");
        //    }
        //}

        //public void AddEditNewPIN()
        //{
        //    //Insert record to DB-----------------------------------------
        //    string strNewPin = txtPin1.Text.Trim() + txtPin2.Text.Trim() + txtPin3.Text.Trim() + txtPin4.Text.Trim() + txtPin5.Text.Trim() + txtPin6.Text.Trim();
        //    var crm = new crmEntity()
        //    {
        //        user_id = Convert.ToInt32(Session["userid"].ToString()),
        //        pin_no = strNewPin,
        //        pin_id = 0,
        //        active_status = 1,
        //        created_by = Session["username"].ToString(),
        //        updated_by = Session["username"].ToString()
        //    };

        //    ServiceUrl = "CRM/AddEditTransactionPin";
        //    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
        //    if (response.IsSuccessStatusCode)
        //    {
        //        lnkNCancel_Click(null, null);
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessChangePinMsg();", true);            }
        //    else
        //    {
        //        //for change pin
        //        message_nPin.InnerText = response.ReasonPhrase.ToString();
        //        message_nPin.Style.Add("color", "Red");
        //    }
        //    //-------------------------------------------------------------
        //}

        public void AddEditChangePIN()
        {
            //Insert record to DB-----------------------------------------
            string strNewPin = txtNewPin1.Text.Trim() + txtNewPin2.Text.Trim() + txtNewPin3.Text.Trim() + txtNewPin4.Text.Trim() + txtNewPin5.Text.Trim() + txtNewPin6.Text.Trim();
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString()),
                pin_no = strNewPin,
                pin_id = 0,
                active_status = 1,
                created_by = Session["username"].ToString(),
                updated_by = Session["username"].ToString()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                ServiceUrl = "CRM/AddEditTransactionPin";
                response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    lnkCancel_Click(null, null);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessChangePinMsg();", true);
                }
                else
                {
                    //for change pin
                    message_cPin.InnerText = response.ReasonPhrase.ToString();
                    message_cPin.Style.Add("color", "Red");                    
                }
            }            
            //-------------------------------------------------------------
        }

        //public void AddEditForgotPIN()
        //{
        //    //Insert record to DB-----------------------------------------
        //    string strConfPin = txtConfPin1.Text.Trim() + txtConfPin2.Text.Trim() + txtConfPin3.Text.Trim() + txtConfPin4.Text.Trim() + txtConfPin5.Text.Trim() + txtConfPin6.Text.Trim();
        //    var crm = new crmEntity()
        //    {
        //        user_id = Convert.ToInt32(Session["userid"].ToString()),
        //        pin_no = strConfPin,
        //        pin_id = 0,
        //        active_status = 1,
        //        created_by = Session["username"].ToString(),
        //        updated_by = Session["username"].ToString()
        //    };
        //    ServiceUrl = "CRM/AddEditTransactionPin";
        //    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
        //    if (response.IsSuccessStatusCode)
        //    {
        //        response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
        //        if (response.IsSuccessStatusCode)
        //        {
        //            ////Send Email notification to user--------------------------------------
        //            //SendEmail(txtEmail.Text.Trim(), "BigR - Forgot PIN.");
        //            ////--------------------------------------------------------

        //            lnkFCancel_Click(null, null);
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessChangePinMsg();", true);
        //        }
        //        else
        //        {
        //            //for change pin
        //            message_fPin.InnerText = response.ReasonPhrase.ToString();
        //            message_fPin.Style.Add("color", "Red");
        //        }
        //    }
        //    //-------------------------------------------------------------
        //}

        protected void SendEmail(string to_sender, string subject)
        {
            try
            {
                string readUserFile = string.Empty, myStringUser = string.Empty;
                // USER EMAIL
                StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/userforgotpin_email.html"));
                readUserFile = readerUser.ReadToEnd();
                myStringUser = readUserFile;
                myStringUser = myStringUser.Replace("$$MemberName$$", Session["User_FirstName"].ToString());
                //string strEmailID = Session["EmailId"].ToString();
                myStringUser = myStringUser.Replace("$$EmailID$$", Session["EmailId"].ToString());
                myStringUser = myStringUser.Replace("$$User_id$$", Session["user_id"].ToString());

                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient();
                string s = string.Empty;
                s = strFromEmail;
                mail.From = new MailAddress(s);
                mail.To.Add(to_sender);
                mail.Subject = subject;
                mail.Body = myStringUser;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);

                readerUser.Close();
                readerUser.Dispose();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessForgotPinMsg();", true);
            }
            catch (Exception ex)
            {
                message_fPin.InnerText = ex.Message.ToString();
                return;
            }
        }

    }
}