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

namespace CRMApp.crmapp
{
    public partial class frmCommunityMasterAddEdit : System.Web.UI.Page
    {
        #region global declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;       
        
        int com_id; Boolean Insert_SP_Status;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                Insert_SP_Status = false; ViewState["community_id"] = string.Empty; ViewState["community_name"] = string.Empty; ViewState["community_url"] = string.Empty;
                BindSpID();
                if (!string.IsNullOrEmpty(Request.QueryString["c_id"]))
                {
                    GetCommunityMasterDetails();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            {
                try
                {
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    if (!string.IsNullOrEmpty(Request.QueryString["c_id"]))
                    {
                        com_id = Convert.ToInt16(Request.QueryString["c_id"]);
                    }
                    else
                    {
                        com_id = 0;
                    }

                    var crm = new crmEntity()
                    {
                        community_id = com_id,
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
                                if (txtCommunityName.Text.Trim().ToUpper().Replace(" ", "") != ViewState["community_name"].ToString().ToUpper().Replace(" ", ""))
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
                                            if (Insert_SP_Status == true)
                                            {
                                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMstgMaster();", true);

                                                txtCommunityName.Text = string.Empty;
                                                txtCommunityUrl.Text = string.Empty;

                                                //BindSpID();
                                                Insert_SP_Status = false;
                                                Response.Redirect("frmCommunityMasterDetails.aspx");
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
                                    var Community_id = response.Content.ReadAsStringAsync().Result;
                                    var dtCommunity_id = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community_id);
                                    if (dtCommunity_id.Rows.Count > 0)
                                    {
                                        ViewState["community_id"] = dtCommunity_id.Rows[0]["community_id"].ToString().Trim();
                                        //ViewState["community_name"] = dtCommunity_id.Rows[0]["community_name"].ToString().Trim();

                                        //Insert records to service provider db using api-----------------------
                                        SaveToServiceProviderDB();
                                        if (Insert_SP_Status == true)
                                        {
                                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMstgMaster();", true);

                                            txtCommunityName.Text = string.Empty;
                                            txtCommunityUrl.Text = string.Empty;

                                            //BindSpID();
                                            Insert_SP_Status = false;
                                            Response.Redirect("frmCommunityMasterDetails.aspx");
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
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMstgMaster();", true);

                                txtCommunityName.Text = string.Empty;
                                txtCommunityUrl.Text = string.Empty;
                                Response.Redirect("frmCommunityMasterDetails.aspx");
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

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmCommunityMasterDetails.aspx");
        }

        protected void BindSpID()
        {
            ServiceUrl = ConfigurationManager.AppSettings["AevisAPIURL"].ToString() + "/GetServiceProviderDetails";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var crm = new crmEntity();

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
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
                        }
                    }
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

        protected void GetCommunityMasterDetails()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityMaster_by_Id";
            if (!string.IsNullOrEmpty(Request.QueryString["c_id"]))
            {
                com_id = Convert.ToInt16(Request.QueryString["c_id"]);
            }

            var crm = new crmEntity()
            {
                community_id = com_id
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);
                if (dtCommunity.Rows.Count > 0)
                {
                    ddlSPid.SelectedValue = dtCommunity.Rows[0]["sp_id"].ToString().Trim();
                    txtCommunityName.Text = dtCommunity.Rows[0]["community_name"].ToString().Trim(); ViewState["community_name"] = dtCommunity.Rows[0]["community_name"].ToString().Trim();
                    txtCommunityUrl.Text = dtCommunity.Rows[0]["community_url"].ToString().Trim(); ViewState["community_url"] = dtCommunity.Rows[0]["community_url"].ToString().Trim();
                    if (dtCommunity.Rows[0]["active_status"].ToString() == "1") { ddlActiveStatus_Community.SelectedValue = "1"; } else { ddlActiveStatus_Community.SelectedValue = "0"; }                    
                }
            }
            else
            {
                message_community.InnerText = response.ReasonPhrase.ToString();
                message_community.Style.Add("color", "Red");
            }
        }
    }
}