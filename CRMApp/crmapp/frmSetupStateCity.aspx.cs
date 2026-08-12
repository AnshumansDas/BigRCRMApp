using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;
using System.Net.Http;
using System.Configuration;
using System.Net.Http.Headers;
using System.Web.UI.HtmlControls;

namespace CRMApp.crmapp
{
    public partial class frmSetupStateCity : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindState();
                BindStateCityListing(string.Empty);               
            }           
        }
        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            message.InnerText = string.Empty;
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

        public void BindStateCityListing(string strVal)
        {
            string strSendVal = string.Empty;
            //ddlActiveStatus.SelectedValue = "";
            //txtCity.Text = "";
            //ddlState.SelectedValue = null;            
            ServiceUrl = "CRM/GetStateCityListing";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "0";
                var crm = new crmEntity()
                {
                    city_id = Convert.ToInt16(strVal),
                   search_param = strSendVal
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    ViewState["dtcont"] = dtChargeType;
                    if (dtChargeType.Rows.Count > 0)
                    {
                        lvStateCity.DataSource = dtChargeType;
                        lvStateCity.DataBind();
                    }
                    else
                    {
                        lvStateCity.DataSource = dtChargeType;
                        lvStateCity.DataBind();
                    }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
            else
            {
                var crm = new crmEntity()
                {
                    city_id = Convert.ToInt16(strVal),
                    search_param=""
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    if (dtChargeType.Rows.Count > 0)
                    {
                        ddlState.SelectedValue = dtChargeType.Rows[0]["state_id"].ToString().Trim();
                        txtCity.Text = dtChargeType.Rows[0]["city_name"].ToString().Trim();
                        if (dtChargeType.Rows[0]["active_status"].ToString().Trim() == "Active")
                        { ddlActiveStatus.SelectedValue = "1"; }
                        else { ddlActiveStatus.SelectedValue = "0"; }
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "popupopen();", true);
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupopen();", true);
                       
                    }
                    else
                    {
                        message.InnerText = response.ReasonPhrase.ToString();
                        message.Style.Add("color", "Red");
                    }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
        }

        public void Clear()
        {
            txtCity.Text = string.Empty;
            ddlState.SelectedIndex = 0;
            ddlActiveStatus.SelectedIndex = 0;
            ViewState["chargetype_id"] = null;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
            message.InnerText = string.Empty;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if ((ViewState["chargetype_id"]) == null)
                { ViewState["chargetype_id"] = 0; }

                string strCreatedBy = string.Empty;
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = "metroadmin123"; }

                ServiceUrl = "CRM/AddEditStateCityDetails";
                var crm = new crmEntity()
                {
                    city_id = Convert.ToInt16(ViewState["chargetype_id"]),
                    state_id = Convert.ToInt16(ddlState.SelectedValue.Trim()),
                    city_name = txtCity.Text,
                    postcode = string.Empty,
                    active_status = Convert.ToInt16(ddlActiveStatus.SelectedValue.Trim()),
                    created_by = strCreatedBy
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    message.InnerText = "Record save successfully!";
                    message.Style.Add("color", "DarkGreen");
                    Clear();
                    BindStateCityListing(string.Empty);
                    ddlActiveStatus.SelectedValue = "";
                    txtCity.Text = "";
                    ddlState.SelectedIndex = 0;
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopup();", true);
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void lvStateCity_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvStateCity.DataKeys[commentItem.DisplayIndex][0].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        BindStateCityListing(contentID);
                        ViewState["chargetype_id"] = contentID;
                        message.InnerText = string.Empty;
                    }
                }
            }
        }

        protected void lvStateCity_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvStateCity.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindStateCityListing(string.Empty);
            //if (Session["userid"] == null)
            //{
            //    Response.Redirect("../default.aspx", false);
            //    Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //    return;
            //}
            //else
            //{
            //    (lvStateCity.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            //    BindStateCityListing(string.Empty);
            //}
        }

        protected void lvStateCity_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            ddlState.SelectedIndex = 0;
            txtCity.Text = "";
            ddlState.SelectedIndex = 0;
            message.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupopen();", true);
        }

        protected void lvStateCity_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Active")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvStateCity.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvStateCity.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvStateCity.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvStateCity.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindStateCityListing("");
        }
    }
}