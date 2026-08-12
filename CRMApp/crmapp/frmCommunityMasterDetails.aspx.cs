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
    public partial class frmCommunityMasterDetails : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {
                BindCommunityMasterList();
                BindSpID();
                Insert_SP_Status = false; ViewState["community_id"] = string.Empty; ViewState["community_name"] = string.Empty; ViewState["community_url"] = string.Empty;
            }

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindCommunityMasterList();
        }

        protected void Lv_Community_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem CommunityItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (CommunityItems != null)
                {
                    string Commmunity_id = (string)Lv_Community.DataKeys[CommunityItems.DisplayIndex][0].ToString().Trim();
                    if (!string.IsNullOrEmpty(Commmunity_id))
                    {
                        GetCommunityMasterDetails(Commmunity_id);
                        ViewState["community_id"] = Commmunity_id;
                        message.InnerText = string.Empty;
                    }
                }
            }
        }

        protected void Lv_Community_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Community.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindCommunityMasterList();
        }

        protected void Lv_Community_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl activestatus = (HtmlGenericControl)e.Item.FindControl("activestatus");
                if (activestatus.InnerText == "Active")
                { activestatus.Style.Add("color", "green"); }
                else
                { activestatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Community.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((Lv_Community.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_Community.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (Lv_Community.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void Lv_Community_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            //ddlSPid.SelectedValue = "0";
            txtCommunityName.Text = string.Empty;
            txtCommunityUrl.Text = string.Empty;
            ddlActiveStatus_Community.SelectedValue = "1";

            message_community.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupopen();", true);
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                if (!string.IsNullOrEmpty(ViewState["community_id"].ToString()))
                {
                    com_id = Convert.ToInt32(ViewState["community_id"].ToString());
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

                                        //Insert records to service provider db using api-----------------------
                                        SaveToServiceProviderDB();
                                        if (Insert_SP_Status == true)
                                        {
                                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCommunityMstgMaster();", true);

                                            ddlSPid.SelectedValue = "0";
                                            txtCommunityName.Text = string.Empty;
                                            txtCommunityUrl.Text = string.Empty;
                                            ddlActiveStatus_Community.SelectedValue = "1";

                                            BindCommunityMasterList();
                                            Insert_SP_Status = false;
                                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopup();", true);
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

                                        ddlSPid.SelectedValue = "0";
                                        txtCommunityName.Text = string.Empty;
                                        txtCommunityUrl.Text = string.Empty;
                                        ddlActiveStatus_Community.SelectedValue = "1";

                                        BindCommunityMasterList();
                                        Insert_SP_Status = false;
                                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopup();", true);
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

                            ddlSPid.SelectedValue = "0";
                            txtCommunityName.Text = string.Empty;
                            txtCommunityUrl.Text = string.Empty;
                            ddlActiveStatus_Community.SelectedValue = "1";
                            BindCommunityMasterList();
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopup();", true);
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

        protected void BindSpID()
        {
            try
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
                                if (ddlSPid.Items.FindByText("BIGR") != null)
                                {
                                    ddlSPid.SelectedValue = dtRow["sp_id"].ToString(); ddlSPid.Enabled = false; return;
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message.ToString();
            }

        }

        protected void BindCommunityMasterList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/BindCommunityMaster";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                communityparams = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);
                ViewState["dtcont"] = dtCommunity;
                if (dtCommunity.Rows.Count > 0)
                {
                    Lv_Community.DataSource = dtCommunity;
                    Lv_Community.DataBind();
                }
                else
                {
                    Lv_Community.DataSource = dtCommunity;
                    Lv_Community.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void GetCommunityMasterDetails(string strComId)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityMaster_by_Id";

            if (strComId == string.Empty) { strComId = "0"; }
            var crm = new crmEntity()
            {
                community_id = Convert.ToInt32(strComId)
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

                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupopen();", true);
                }
            }
            else
            {
                message_community.InnerText = response.ReasonPhrase.ToString();
                message_community.Style.Add("color", "Red");
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
    }
}