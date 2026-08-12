using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Data;

namespace CRMApp.crmapp
{
    public partial class frmVoucherPurcRedeemByUser : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        #region ControlEvents
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindVoucherPurchaseRedeemStatus();
            }
        }

        protected void Lv_PurRedeemVoucherReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_PurRedeemVoucherReport.FindControl("totalrecord");
                if (ViewState["VSVoucherPurcRedeem"] != null)
                {
                    DataTable dtVpurchRedeem = (DataTable)ViewState["VSVoucherPurcRedeem"];
                    totalrecord.InnerText = dtVpurchRedeem.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        protected void Lv_PurRedeemVoucherReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_PurRedeemVoucherReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindVoucherPurchaseRedeemStatus();
        }
        #endregion

        #region UserDefinedEvents
        public void BindVoucherPurchaseRedeemStatus()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherPurchaseRedeemListByUser";
            int userid = 0;
            try
            {
                if (Session["user_id"] != null)
                {
                    userid = Convert.ToInt32(Session["user_id"].ToString());
                }
                var vouPurRed = new crmEntity()
                {
                    user_id = userid
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, vouPurRed).Result;
                if (response.IsSuccessStatusCode)
                {
                    var varVouPurchRed = response.Content.ReadAsStringAsync().Result;
                    var dtvarVouPurchRed = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(varVouPurchRed);
                    ViewState["VSVoucherPurcRedeem"] = dtvarVouPurchRed;
                    if (dtvarVouPurchRed.Rows.Count > 0)
                    {
                        Lv_PurRedeemVoucherReport.DataSource = dtvarVouPurchRed;
                        Lv_PurRedeemVoucherReport.DataBind();
                    }
                    else
                    {
                        Lv_PurRedeemVoucherReport.DataSource = dtvarVouPurchRed;
                        Lv_PurRedeemVoucherReport.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}