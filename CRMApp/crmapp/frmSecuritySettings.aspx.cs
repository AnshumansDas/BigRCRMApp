using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmSecuritySettings : System.Web.UI.Page
    {
        #region Global declaration
        //SecuritySetting.tbl_user_password_configDataTable configTable = new SecuritySetting.tbl_user_password_configDataTable();
        ////HttpClient client = new HttpClient();
        ////string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), serviceUrl = string.Empty;
        //SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["INFOGATEConnectionString"].ConnectionString);
        //SqlCommand cmd = new SqlCommand();
        //SqlDataAdapter da = new SqlDataAdapter();
        HttpClient client = new HttpClient();
        
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        public static DataTable dtData = new DataTable();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                ShowCo();
            }
        }

        //Update Security Setting Information
        //private void SaveCo()
        //{
        //    bool status = FuncIsSubjExistInSubjDataTable("MAX_PWD_REPEAT");
        //    if (FuncIsSubjExistInSubjDataTable("MAX_PWD_REPEAT"))
        //        configTable[0].password_security_value = password_historyTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 1, "MAX_PWD_REPEAT", "MAX_PWD_REPEAT", password_historyTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("PWD_EXPIRY"))
        //        configTable[1].password_security_value = passwordExpiry_typeRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 2, "PWD_EXPIRY", "PWD_EXPIRY", passwordExpiry_typeRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("PWD_EXPIRY_DAYS"))
        //        configTable[2].password_security_value = password_expirydaysTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 3, "PWD_EXPIRY_DAYS", "PWD_EXPIRY_DAYS", password_expirydaysTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("PWD_CHANGE"))
        //        configTable[3].password_security_value = change_passwordRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 4, "PWD_CHANGE", "PWD_CHANGE", change_passwordRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_LEN"))
        //        configTable[4].password_security_value = password_lengthTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 5, "MIN_LEN", "MIN_LEN", password_lengthTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_NUM_CHAR"))
        //        configTable[5].password_security_value = minimum_numericTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 6, "MIN_NUM_CHAR", "MIN_NUM_CHAR", minimum_numericTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_ALPHA_CHAR"))
        //        configTable[6].password_security_value = minimum_alphaTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 7, "MIN_ALPHA_CHAR", "MIN_ALPHA_CHAR", minimum_alphaTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MAX_REPEAT"))
        //        configTable[7].password_security_value = repeating_charactersTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 8, "MAX_REPEAT", "MAX_REPEAT", repeating_charactersTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_UPPER_CHAR"))
        //        configTable[8].password_security_value = upper_charactersTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 9, "MIN_UPPER_CHAR", "MIN_UPPER_CHAR", upper_charactersTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_LOWER_CHAR"))
        //        configTable[9].password_security_value = lowercase_charactersTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 10, "MIN_LOWER_CHAR", "MIN_LOWER_CHAR", lowercase_charactersTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MIN_PWD_AGE"))
        //        configTable[10].password_security_value = minimum_ageTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 11, "MIN_PWD_AGE", "MIN_PWD_AGE", minimum_ageTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("PWD_CHG_REMINDER"))
        //        configTable[11].password_security_value = password_remainderTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 12, "PWD_CHG_REMINDER", "PWD_CHG_REMINDER", password_remainderTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("MULTI_LOGIN"))
        //        configTable[12].password_security_value = multiple_loginRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 13, "MULTI_LOGIN", "MULTI_LOGIN", multiple_loginRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("SEC_QUES_SET"))
        //        configTable[13].password_security_value = security_queansRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 14, "SEC_QUES_SET", "SEC_QUES_SET", security_queansRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("RETRY_LOGIN"))
        //        configTable[14].password_security_value = maximum_logonretryRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 15, "RETRY_LOGIN", "RETRY_LOGIN", maximum_logonretryRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("MAX_RETRY_LOGIN"))
        //        configTable[15].password_security_value = logonretry_tmesTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 16, "MAX_RETRY_LOGIN", "MAX_RETRY_LOGIN", logonretry_tmesTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("RETRY_SESSION"))
        //        configTable[16].password_security_value = maximum_sessionRd.SelectedValue;
        //    else
        //        configTable.Rows.Add(new object[] { 17, "RETRY_SESSION", "RETRY_SESSION", maximum_sessionRd.SelectedValue });
        //    if (FuncIsSubjExistInSubjDataTable("MAX_RETRY_SESSION"))
        //        configTable[17].password_security_value = maximum_sessiontimeTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 18, "MAX_RETRY_SESSION", "MAX_RETRY_SESSION", maximum_sessiontimeTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("SESSION_TIMEOUT"))
        //        configTable[18].password_security_value = session_timeoutTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 19, "SESSION_TIMEOUT", "SESSION_TIMEOUT", session_timeoutTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("LOCKOUT_DUR"))
        //        configTable[19].password_security_value = user_lockoutTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 20, "LOCKOUT_DUR", "LOCKOUT_DUR", user_lockoutTxt.Text });
        //    if (FuncIsSubjExistInSubjDataTable("INACTIVE_ACC"))
        //        configTable[20].password_security_value = inactive_accountTxt.Text;
        //    else
        //        configTable.Rows.Add(new object[] { 21, "INACTIVE_ACC", "INACTIVE_ACC", inactive_accountTxt.Text });
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/AddEditSecuritySettings";
            var crm = new crmEntity()
            {
                password_history = password_historyTxt.Text.Trim(),
                passwordExpiry_type = passwordExpiry_typeRd.SelectedValue,
                password_expirydays = password_expirydaysTxt.Text.Trim(),
                change_password = change_passwordRd.SelectedValue,
                password_length = password_lengthTxt.Text.Trim(),
                minimum_numeric = minimum_numericTxt.Text.Trim(),
                minimum_alpha = minimum_alphaTxt.Text.Trim(),
                upper_characters = upper_charactersTxt.Text.Trim(),
                lowercase_characters = lowercase_charactersTxt.Text.Trim(),
                minimum_age = minimum_ageTxt.Text.Trim(),
                password_remaind = password_remainderTxt.Text.Trim(),
                multi_login = multiple_loginRd.SelectedValue,
                security_question = security_queansRd.SelectedValue,
                maximum_logonretry = maximum_logonretryRd.SelectedValue,
                maximum_session = maximum_sessionRd.SelectedValue,
                user_lockout = user_lockoutTxt.Text.Trim(),
                inactive_account = inactive_accountTxt.Text.Trim()
            };
            try
            {
                
                //if (dtData.Rows.Count > 0)
                //{
                //    if (dtData.Rows[0][1].ToString() == "MAX_PWD_HISTORY")
                //    {
                //        crm = new crmEntity()
                //        {
                //            search_param = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[1][1].ToString() == "PWD_EXPIRY")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[2][1].ToString() == "PWD_EXPIRY_DAYS")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[3][1].ToString() == "PWD_CHANGE")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[4][1].ToString() == "MIN_PWD_LEN")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[5][1].ToString() == "MIN_NUM_CHAR")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[6][1].ToString() == "MIN_ALPHA_CHAR")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[7][1].ToString() == "MIN_UPPER_CHAR")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[8][1].ToString() == "MIN_LOWER_CHAR")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[9][1].ToString() == "MIN_PWD_AGE")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[10][1].ToString() == "PWD_CHG_REMINDER")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[11][1].ToString() == "MULTI_LOGIN")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[12][1].ToString() == "SEC_QUES_SET")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[13][1].ToString() == "MAX_RETRY_LOGIN")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[14][1].ToString() == "MAX_RETRY_SESSION")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[15][1].ToString() == "LOCKOUT_DUR")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                //    if (dtData.Rows[16][1].ToString() == "INACTIVE_ACC")
                //    {
                //        crm = new crmEntity()
                //        {
                //            password_history = password_historyTxt.Text.Trim()
                //        };
                //        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                //    }
                // }
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Category = response.Content.ReadAsStringAsync().Result;
                    var dtCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Category);
                    if (dtCategory.Rows.Count > 0)
                    {
                        lblerrormsg.Text = "Successfully Saved / Updated";
                        lblerrormsg.ForeColor = System.Drawing.Color.Green;
                        lblerrormsg.Visible = true;
                    }
                    else
                    {
                        lblerrormsg.Text = "Failed to Saved / Updated";
                        lblerrormsg.ForeColor = System.Drawing.Color.Red;
                        lblerrormsg.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                "<script type='text/javascript'>alert('" + ex.ToString() + "');</script>");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }

        private void ShowCo()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListOfSecuritySettings";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Settings = response.Content.ReadAsStringAsync().Result;
                var dtSettings = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Settings);
                dtData = dtSettings;
                if (dtSettings.Rows.Count > 0)
                {
                    password_historyTxt.Text = dtSettings.Rows[0][3].ToString();
                    passwordExpiry_typeRd.Items.FindByValue(dtSettings.Rows[1][3].ToString()).Selected = true;
                    password_expirydaysTxt.Text = dtSettings.Rows[2][3].ToString();
                    change_passwordRd.Items.FindByValue(dtSettings.Rows[3][3].ToString()).Selected = true;
                    password_lengthTxt.Text = dtSettings.Rows[4][3].ToString();
                    minimum_numericTxt.Text = dtSettings.Rows[5][3].ToString();
                    minimum_alphaTxt.Text = dtSettings.Rows[6][3].ToString();
                    upper_charactersTxt.Text = dtSettings.Rows[8][3].ToString();
                    lowercase_charactersTxt.Text = dtSettings.Rows[9][3].ToString();
                    minimum_ageTxt.Text = dtSettings.Rows[10][3].ToString();
                    password_remainderTxt.Text = dtSettings.Rows[11][3].ToString();
                    multiple_loginRd.Items.FindByValue(dtSettings.Rows[12][3].ToString()).Selected = true;
                    security_queansRd.Items.FindByValue(dtSettings.Rows[13][3].ToString()).Selected = true;
                    maximum_logonretryRd.Items.FindByValue(dtSettings.Rows[14][3].ToString()).Selected = true;
                    maximum_sessionRd.Items.FindByValue(dtSettings.Rows[17][3].ToString()).Selected = true;
                    user_lockoutTxt.Text = dtSettings.Rows[19][3].ToString();
                    inactive_accountTxt.Text = dtSettings.Rows[20][3].ToString();
                }
            }
        }
    }
}