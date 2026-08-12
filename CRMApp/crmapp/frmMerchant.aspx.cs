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
    public partial class frmMerchant : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantList();
            }
        }

        public void BindMerchantList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/ListOfMerchant";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
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
                    Lv_Merchant.DataSource = dtChargeType;
                    Lv_Merchant.DataBind();
                }
                else
                {
                    Lv_Merchant.DataSource = dtChargeType;
                    Lv_Merchant.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void Lv_Merchant_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Merchant.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }

                HtmlGenericControl doc_status = (HtmlGenericControl)e.Item.FindControl("doc_status");
                if (doc_status.InnerText == "Yes")
                { doc_status.Style.Add("color", "green"); }
                else
                { doc_status.Style.Add("color", "red"); }
            }

            if ((Lv_Merchant.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_Merchant.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (Lv_Merchant.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void Lv_Merchant_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            Session["merchantRegid"] = null;
            Response.Redirect("frmMerchantAddEdit.aspx");
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchantList();
        }

        protected void Lv_Merchant_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Merchant.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantList();
        }

        protected void Lv_Merchant_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem MerchantItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (MerchantItems != null)
                {
                    string MerchantCode = (string)Lv_Merchant.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmMerchantAddEdit.aspx?m_code=" + MerchantCode);
                }
            }
            else if (e.CommandName == "AddEditSptDoc")
            {
                if (MerchantItems != null)
                {
                    string MerchantCode = (string)Lv_Merchant.DataKeys[MerchantItems.DisplayIndex][1].ToString().Trim();
                    string MerchantName = (string)Lv_Merchant.DataKeys[MerchantItems.DisplayIndex][2].ToString().Trim();
                    Response.Redirect("frmMerchAddSupportDoc.aspx?m_code=" + MerchantCode + "&m_name=" + MerchantName);
                }
            }
        }
    }
}