using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;

namespace CRMApp.crmapp
{
    public partial class frmVoucherList : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        static int voucherCatId = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindVoucherListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                //BindVoucherCategoryCode();
                //BindVoucherCategoryListing();
            }
        }

        protected void lvVoucherList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem voucherItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (voucherItems != null)
                {
                    int voucherId = int.Parse(lvVoucherList.DataKeys[voucherItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmVoucherSetup.aspx?voucher_id=" + voucherId);
                }
            }
        }

        protected void lvVoucherList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvVoucherList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindVoucherListing();
        }

        protected void lvVoucherList_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvVoucherList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvVoucherList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvVoucherList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindVoucherListing();
        }

        public void BindVoucherListing()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherList";
            var crm = new crmEntity()
            {
                search_param = txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvVoucherList.DataSource = dtChargeType;
                    lvVoucherList.DataBind();
                }
                else
                {
                    lvVoucherList.DataSource = dtChargeType;
                    lvVoucherList.DataBind();
                }
            }
        }

        protected void btnAddVoucher_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmVouchersetup.aspx?voucher_id=0");
        }
    }
}