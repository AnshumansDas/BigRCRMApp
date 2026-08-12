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
    public partial class frmCommunityAddEdit : System.Web.UI.Page
    {
        #region global declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();

        //string dtStartDate = string.Empty;
        //string dtEndDate = string.Empty;
        //int MerchID = 0;
        //double strPerVoucherChargesByRM = 0;
        //double strOneTimeChargesByRM = 0;
        //double strPremiumFeesByRM = 0;
        string strCreatedBy = string.Empty;
        //string strPerVoucherChargesByPercent = string.Empty;
        static string CheckImg;
        int Com_det_id;
        Boolean Insert_SP_Status; Boolean Isert_Community_DB;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                Insert_SP_Status = false; Isert_Community_DB = false;
                BindSpID();
                BindCommunity();
                BindState();

                ViewState["email"] = string.Empty;
                ViewState["telephone"] = string.Empty;
                ViewState["community_id"] = string.Empty;

                if (!string.IsNullOrEmpty(Request.QueryString["c_det_id"]))
                {
                    GetCommunityDetails();
                }
            }
        }
        
        public void BindSpID()
        {
            //ServiceUrl = "http://demo10.absecmy.com/AEVISAPI/api/Aevis/GetServiceProviderDetails";
            ServiceUrl = ConfigurationManager.AppSettings["AevisAPIURL"].ToString() + "/GetServiceProviderDetails";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var crm = new crmEntity();
            
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,crm).Result;
            ddlSPid.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlSPid.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var SPid = response.Content.ReadAsStringAsync().Result;
                var dtSPid = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(SPid);
                if (dtSPid.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtSPid.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["sp_id"].ToString())))
                        {
                            ddlSPid.Items.Add(new ListItem(dtRow["sp_name"].ToString(), dtRow["sp_id"].ToString()));
                            if (ddlSPid.Items.FindByText("BIGR") != null)
                            {
                                ddlSPid.SelectedValue = dtRow["sp_id"].ToString(); ddlSPid.Enabled = false; return;
                            }
                        }
                    }
                }
            }
        }

        public void GetCommunityDetails()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityDetails_by_Id";
            if (!string.IsNullOrEmpty(Request.QueryString["c_det_id"]))
            {
                Com_det_id = Convert.ToInt16(Request.QueryString["c_det_id"]);
            }

            var crm = new crmEntity()
            {
                community_det_id = Com_det_id
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);
                if (dtCommunity.Rows.Count > 0)
                {
                    ddlCommunity.SelectedValue = dtCommunity.Rows[0]["community_id"].ToString().Trim();
                    ddlCommunity_SelectedIndexChanged(null, null);
                    txtEmail.Text = dtCommunity.Rows[0]["email"].ToString().Trim(); ViewState["email"] = dtCommunity.Rows[0]["email"].ToString().Trim(); txtEmail.ReadOnly = true;
                    txtAddress1.Text = dtCommunity.Rows[0]["address_1"].ToString().Trim();
                    txtAddress2.Text = dtCommunity.Rows[0]["address_2"].ToString().Trim();
                    txtPostcode.Text = dtCommunity.Rows[0]["postcode"].ToString().Trim();
                    ddlState.SelectedValue = dtCommunity.Rows[0]["state_id"].ToString().Trim();
                    BindCity(ddlState.SelectedValue.Trim());
                    ddlCity.SelectedValue = dtCommunity.Rows[0]["city_id"].ToString().Trim();
                    txtPersonInCharge.Text = dtCommunity.Rows[0]["person_incharge"].ToString().Trim();
                    txtTelephoneNo.Text = dtCommunity.Rows[0]["telephone_phone"].ToString().Trim(); ViewState["telephone"] = dtCommunity.Rows[0]["telephone_phone"].ToString().Trim();
                    txtFaxNo.Text = dtCommunity.Rows[0]["fax_no"].ToString().Trim();
                    txtPICphoneNo.Text = dtCommunity.Rows[0]["pic_phone"].ToString().Trim();
                    
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        public void BindCommunity()
        {
            ServiceUrl = "CRM/BindCommunityList";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlCommunity.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlCommunity.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);
                if (dtCommunity.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtCommunity.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["community_name"].ToString())))
                        {
                            ddlCommunity.Items.Add(new ListItem(dtRow["community_name"].ToString(), dtRow["community_id"].ToString()));                            
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (!string.IsNullOrEmpty(Request.QueryString["c_det_id"]))
                {
                    Com_det_id = Convert.ToInt16(Request.QueryString["c_det_id"]);
                }
                else
                {
                    Com_det_id = 0;
                }
                var crm = new crmEntity()
                {
                    community_det_id = Com_det_id,
                    community_id = Convert.ToInt32(ddlCommunity.SelectedValue.ToString()),
                    email = txtEmail.Text.Trim(),
                    email_id = txtEmail.Text.Trim(),
                    user_name = txtEmail.Text.Trim(),
                    address_1 = txtAddress1.Text.Trim(),
                    address_2 = txtAddress2.Text.Trim(),
                    postcode = txtPostcode.Text.Trim(),
                    city_id = Convert.ToInt32(ddlCity.SelectedValue.ToString()),
                    state_id = Convert.ToInt32(ddlState.SelectedValue.ToString()),
                    person_incharge = txtPersonInCharge.Text.Trim(),
                    telephone_phone = txtTelephoneNo.Text.Trim(),
                    fax_no = txtFaxNo.Text.Trim(),
                    pic_phone = txtPICphoneNo.Text.Trim(),
                    active_status = Convert.ToInt32(ddlActiveStatus_Community.SelectedValue.ToString()),
                    created_by = Session["username"].ToString(),
                    updated_by = Session["username"].ToString()
                };

                //Check duplicate email/phone entry---------------------------
                //ServiceUrl = "CRM/GetDuplicateCommunity_Details";
                ServiceUrl = "CRM/ValidateExistingMerchantEmail";
                
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var community = response.Content.ReadAsStringAsync().Result;
                    var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(community);
                    if (dtCommunity != null)
                    {
                        if (dtCommunity.Rows.Count > 0)
                        {
                            //if current_entry == bind_data then no duplicacy else duplicate check
                            //if (txtEmail.Text.Trim().ToUpper().Replace(" ", "") != ViewState["email"].ToString().ToUpper().Replace(" ", "") || txtTelephoneNo.Text.Trim().ToUpper().Replace(" ", "") != ViewState["telephone"].ToString().ToUpper().Replace(" ", ""))                                
                            if (txtEmail.Text.Trim().ToUpper().Replace(" ", "") != ViewState["email"].ToString().ToUpper().Replace(" ", ""))
                            {
                                message.InnerText = "Email has been registered.";
                                message.Style.Add("color", "Red");
                                return;                                
                            }
                            else
                            {
                                //Insert record to DB----------------------------------
                                ServiceUrl = "CRM/AddEditCommunityDetails";
                                response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    CreateCommunityUser();
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMsgDet();", true);
                                }
                                else
                                {
                                    message.InnerText = response.ReasonPhrase.ToString();
                                    message.Style.Add("color", "Red");
                                }
                            }                            
                        }
                        else
                        {
                            //Insert record to DB----------------------------------
                            ServiceUrl = "CRM/AddEditCommunityDetails";
                            response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                CreateCommunityUser();
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMsgDet();", true);
                            }
                            else
                            {
                                message.InnerText = response.ReasonPhrase.ToString();
                                message.Style.Add("color", "Red");
                            }
                        }
                    }
                    else
                    {
                        //Insert record to DB----------------------------------
                        ServiceUrl = "CRM/AddEditCommunityDetails";
                        response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            CreateCommunityUser();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMsgDet();", true);
                        }
                        else
                        {
                            message.InnerText = response.ReasonPhrase.ToString();
                            message.Style.Add("color", "Red");
                        }
                    }                    
                }           
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void ddlCommunity_SelectedIndexChanged(object sender, EventArgs e)
        {
            var crm = new crmEntity()
            {
                community_id = Convert.ToInt32(ddlCommunity.SelectedValue.ToString())
            };

            ServiceUrl = "CRM/GetActivationUrlByComId";

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(community);

                if (dtCommunity != null)
                {
                    if (dtCommunity.Rows.Count > 0)
                    {
                        txtActivationUrl.Text = dtCommunity.Rows[0]["community_url"].ToString();
                    }
                    else
                    {
                        txtActivationUrl.Text = "";
                    }                    
                }
                else
                {
                    txtActivationUrl.Text = "";
                }
            }
        }

        protected void SaveToServiceProviderDB()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var crm = new crmEntity()
            {
                community_id = Convert.ToInt32(ViewState["community_id"].ToString()),
                sp_id = Convert.ToInt32(ddlSPid.SelectedValue.ToString()),
                community_name = txtCommunityName.Text.Trim(),
                community_url = txtCommunityUrl.Text.Trim(),
                active_status = Convert.ToInt32(ddlActiveStatus_Community.SelectedValue.ToString()),
                created_by = Session["username"].ToString(),
                updated_by = Session["username"].ToString()
            };
            //Insert record to DB
            ServiceUrl = ConfigurationManager.AppSettings["AevisAPIURL"].ToString() + "/SaveCommunityMasterByServProvider";
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                Insert_SP_Status = true;
            }
            else
            {
                Insert_SP_Status = false;
            }
        }

        protected void CreateCommunityUser()
        {
            //Record save to community DB login_ifo and user_details table--------
            SaveUserToMetroDB();
            //--------------------------------------------------------------------
            if (Isert_Community_DB == true)
            {
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/CreateCommunityUserByAdmin";
                var crm = new crmEntity()
                {
                    user_fistname = txtPersonInCharge.Text.Trim(),
                    email_id = txtEmail.Text.Trim(),
                    mobile_no = txtPICphoneNo.Text.Trim(),
                    address1 = txtAddress1.Text.Trim(),
                    address2 = txtAddress2.Text.Trim(),
                    country_id = 1,
                    city_id = Convert.ToInt32(ddlCity.SelectedValue.ToString()),
                    state_id = Convert.ToInt32(ddlState.SelectedValue.ToString()),
                    created_by = Session["username"].ToString()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var CommunityList = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CommunityList);
                    if (DataTable.Rows.Count > 0)
                    {
                        string readUserFile = string.Empty, myStringUser = string.Empty;
                        try
                        {
                            // USER EMAIL
                            StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/createcommunityuserbyadmin_email.html"));
                            readUserFile = readerUser.ReadToEnd();
                            myStringUser = readUserFile;
                            myStringUser = myStringUser.Replace("$$MemberName$$", DataTable.Rows[0]["user_fistname"].ToString().Trim());
                            myStringUser = myStringUser.Replace("$$UserName$$", DataTable.Rows[0]["user_name"].ToString().Trim());
                            myStringUser = myStringUser.Replace("$$UserPassword$$", DataTable.Rows[0]["user_password"].ToString().Trim());
                            //myStringUser = myStringUser.Replace("$$CommunityURL$$", DataTable.Rows[0]["community_url"].ToString().Trim());
                            myStringUser = myStringUser.Replace("$$CommunityURL$$", txtActivationUrl.Text.Trim());

                            string strEmailID = DataTable.Rows[0]["email_id"].ToString().Trim();

                            //System only allowed new email to be registered----------------------------------------
                            if (!string.IsNullOrEmpty(Request.QueryString["c_det_id"]))
                            {
                                //No mail should forward to user
                            }
                            else
                            {
                                SendEmail(strEmailID.Trim(), "BigR - Successful Registration.", myStringUser);
                            }
                            //---------------------------------------------------------------------------------------

                            readerUser.Close();
                            readerUser.Dispose();
                        }
                        catch (Exception ex)
                        {
                            message.InnerText = ex.Message.ToString();
                            return;
                        }
                    }
                }
            }
        }

        protected void SaveUserToMetroDB()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var crm = new crmEntity()
            {
                user_fistname = txtPersonInCharge.Text.Trim(),
                email_id = txtEmail.Text.Trim(),
                mobile_no = txtPICphoneNo.Text.Trim(),
                address1 = txtAddress1.Text.Trim(),
                address2 = txtAddress2.Text.Trim(),
                country_id = 1,
                city_id = Convert.ToInt32(ddlCity.SelectedValue.ToString()),
                state_id = Convert.ToInt32(ddlState.SelectedValue.ToString()),
                created_by = Session["username"].ToString()
            };
            //Insert record to Metro DB
            //ServiceUrl = "http://localhost:16113/api/MetroParkingAdmin/CreateCommunityUserByAdmin";
            ServiceUrl = ConfigurationManager.AppSettings["CommunityAPIURL"].ToString() + "/CreateCommunityUserByAdmin";
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                Isert_Community_DB = true;
            }
            else
            { Isert_Community_DB = false; }
        }

        protected void SendEmail(string to_sender, string subject, string strmessage)
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
                mail.Body = strmessage;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //Session["merchantRegid"] = null;
            Response.Redirect("frmcommunity.aspx");
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity(ddlState.SelectedValue.Trim());
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var crm = new crmEntity()
                {
                    community_id = 0,
                    sp_id = Convert.ToInt32(ddlSPid.SelectedValue.ToString()),
                    community_name = txtCommunityName.Text.Trim(),
                    community_url = txtCommunityUrl.Text.Trim(),
                    active_status = Convert.ToInt32(ddlActiveStatus_Community.SelectedValue.ToString()),
                    created_by = Session["username"].ToString(),
                    updated_by = Session["username"].ToString()
                };

                //Check duplicate community or url entry
                ServiceUrl = "CRM/GetDuplicateCommunity";
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var community = response.Content.ReadAsStringAsync().Result;
                    var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(community);
                    if (dtCommunity != null)
                    {
                        if (dtCommunity.Rows.Count > 0)
                        {
                            message_community.InnerText = "Community has been registered.";
                            message_community.Style.Add("color", "Red");
                            return;
                        }
                        else
                        {
                            //Insert record to DB
                            ServiceUrl = "CRM/AddEditCommunityMaster";
                            response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                var Community_id = response.Content.ReadAsStringAsync().Result;
                                var dtCommunity_id = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community_id);
                                if (dtCommunity_id.Rows.Count > 0)
                                {
                                    ViewState["community_id"] = dtCommunity_id.Rows[0]["community_id"].ToString().Trim();
                                    //ViewState["community_name"] = dtCommunity_id.Rows[0]["community_name"].ToString().Trim();

                                    //Insert records to service provider db using api-----------------------
                                    SaveToServiceProviderDB();
                                    if(Insert_SP_Status == true)
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMsg();", true);

                                        txtCommunityName.Text = string.Empty;
                                        txtCommunityUrl.Text = string.Empty;

                                        BindSpID();
                                        BindCommunity();
                                        Insert_SP_Status = false;
                                    }
                                    else
                                    {
                                        message_community.InnerText = response.ReasonPhrase.ToString();
                                        message_community.Style.Add("color", "Red");
                                    }
                                    //----------------------------------------------------------------------
                                }
                            }
                            else
                            {
                                message_community.InnerText = response.ReasonPhrase.ToString();
                                message_community.Style.Add("color", "Red");
                            }
                        }
                    }
                    else
                    {
                        //Insert record to DB
                        ServiceUrl = "CRM/AddEditCommunityMaster";
                        response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMsg();", true);

                            txtCommunityName.Text = string.Empty;
                            txtCommunityUrl.Text = string.Empty;

                            BindCommunity();
                        }
                        else
                        {
                            message_community.InnerText = response.ReasonPhrase.ToString();
                            message_community.Style.Add("color", "Red");
                        }
                    }                    
                }
            }
            catch (Exception ex)
            {
                message_community.InnerText = ex.Message.ToString();
                return;
            }
        }        

    }
}