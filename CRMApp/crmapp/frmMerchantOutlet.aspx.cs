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
    public partial class frmMerchantOutlet : System.Web.UI.Page
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
            string merchantCode = string.Empty;
            if (Session["roleid"].ToString() == "5" || Session["roleid"].ToString() == "15")
            { merchantCode = Session["Merchant_Code"].ToString().Trim(); }

            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            ServiceUrl = "CRM/ListnSearchMerchantOutletDetails";
            var crm = new crmEntity()
            {
                search_param = strSendVal,
                merchant_code = merchantCode
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvMerchantOutlet.DataSource = dtChargeType;
                    lvMerchantOutlet.DataBind();
                    Session["MerchID"] = dtChargeType.Rows[0]["merchant_id"].ToString().Trim();
                }
                else
                {
                    lvMerchantOutlet.DataSource = dtChargeType;
                    lvMerchantOutlet.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void lvMerchantOutlet_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMerchantOutlet.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvMerchantOutlet.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvMerchantOutlet.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvMerchantOutlet.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvMerchantOutlet_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem MerchantItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (MerchantItems != null)
                {
                    string strBranchID = (string)lvMerchantOutlet.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmMerchantAddEditOutlet.aspx?bID=" + strBranchID);
                }
            }
        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmMerchantAddEditOutlet.aspx?bID=-1", false);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchantList();
        }

        protected void lvMerchantOutlet_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMerchantOutlet.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantList();
        }
    }
}