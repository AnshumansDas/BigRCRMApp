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
    public partial class frmSetupMerchantCategory : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantCategory(string.Empty);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            try
            {
                if ((ViewState["contentID"]) == null)
                { ViewState["contentID"] = 0; }

                string strCreatedBy = string.Empty;
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = "metroadmin123"; }

                ServiceUrl = "CRM/AddEditMerchantCategory";
                var crm = new crmEntity()
                {
                    merchant_cat_id = Convert.ToInt16(ViewState["contentID"]),
                    merchant_category = txtCategoryName.Text.Trim(),
                    active_status = Convert.ToInt16(ddlActiveStatus.SelectedValue.Trim()),
                    created_by = strCreatedBy
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    message.InnerText = "Record save successfully!";
                    message.Style.Add("color", "DarkGreen");
                    Clear();
                    BindMerchantCategory(string.Empty);
                    txtCategoryName.Text = "";
                    ddlActiveStatus.SelectedValue = "";
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

        public void BindMerchantCategory(string strVal)
        {
            string strSendVal = string.Empty;            
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListOfMerchantCategory";
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "0";
                if (!string.IsNullOrEmpty(txtSearch.Text))
                { strSendVal = txtSearch.Text; }
                var crm = new crmEntity()
                {
                    merchant_cat_id = Convert.ToInt16(strVal),
                    search_param= strSendVal
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    ViewState["dtcont"] = dtChargeType;
                    if (dtChargeType.Rows.Count > 0)
                    {
                        //DataView dv = dtChargeType.DefaultView;
                        //dv.Sort = "created_date desc";
                        //DataTable sortedDT = dv.ToTable();
                        lvMerchCategory.DataSource = dtChargeType;
                        lvMerchCategory.DataBind();
                    }
                    else
                    {
                        lvMerchCategory.DataSource = dtChargeType;
                        lvMerchCategory.DataBind();
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
                    merchant_cat_id = Convert.ToInt16(strVal),
                    search_param=""
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    if (dtChargeType.Rows.Count > 0)
                    {
                        txtCategoryName.Text = dtChargeType.Rows[0]["merchant_category"].ToString().Trim();
                        if (dtChargeType.Rows[0]["active_status"].ToString().Trim() == "Active")
                        { ddlActiveStatus.SelectedValue = "1"; }
                        else { ddlActiveStatus.SelectedValue = "0"; }
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "showpopupWithdata();", true);

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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchantCategory("");
        }

        protected void lvMerchCategory_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvMerchCategory.DataKeys[commentItem.DisplayIndex][0].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        BindMerchantCategory(contentID);
                        ViewState["contentID"] = contentID;
                        message.InnerText = string.Empty;
                        ValidateActiveStatus();
                    }
                }
            }
        }

        protected void lvMerchCategory_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMerchCategory.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantCategory(string.Empty);
        }

        protected void lvMerchCategory_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void lvMerchCategory_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMerchCategory.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvMerchCategory.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvMerchCategory.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvMerchCategory.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void txtCategoryName_TextChanged(object sender, EventArgs e)
        {
            message.InnerText = string.Empty;
        }

        public void ValidateActiveStatus()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ValidateMerchantCategoryActiveStatus";
            var crm = new crmEntity()
            {
                merchant_cat_id = Convert.ToInt16(ViewState["contentID"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    message.InnerText = "This merchant category is in use !";
                    message.Style.Add("color", "Red");
                    ddlActiveStatus.Enabled = false;
                    btnSave.Enabled = false;
                }
                else
                {
                    message.InnerText = string.Empty;
                    ddlActiveStatus.Enabled = true;
                    btnSave.Enabled = true;
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
            message.InnerText = string.Empty;
        }

        public void Clear()
        {
            txtCategoryName.Text = string.Empty;
            ddlActiveStatus.SelectedIndex = 0;
            ViewState["contentID"] = null;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopupwithdata();", true);
        }

        protected void btnadd_click(object sender, EventArgs e)
        {
            ddlActiveStatus.SelectedIndex = 0;
            txtCategoryName.Text = "";
            message.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "showpopupWithdata();", true);

        }
    }
}