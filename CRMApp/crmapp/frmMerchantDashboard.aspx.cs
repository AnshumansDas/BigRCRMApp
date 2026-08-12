using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmMerchantDashboard : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantData();
                BindDashboardItems();
                BindTransactionData();
            }
            if (Session["userid"] != null)
            { /*BindAddToWishlistInfo(); BindAddToCartInfo();*/ }
        }
        /// <summary>
        /// Created By Anshuman on 24.01.2019 to get the session and merchant Info
        /// </summary>
        protected void BindMerchantData()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetMerchantDetailsByMerchantCode";
            string merchantCode = Session["Merchant_Code"].ToString().Trim();
            HttpResponseMessage response = client.GetAsync(ServiceUrl+ "?merchant_code="+merchantCode).Result;
            if (response.IsSuccessStatusCode)
            {
                var MerchantListDetails = response.Content.ReadAsStringAsync().Result;
                var dtMerchantListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MerchantListDetails);
                if (dtMerchantListDetails.Rows.Count > 0)
                {
                    //Session value set for Merchant Id
                    Session["merchant_id"] = dtMerchantListDetails.Rows[0]["merchant_id"].ToString().Trim();
                }
            }
        }

        /// <summary>
        /// Created by naveen on 24.01.2019 to get the dashboard data value
        /// </summary>
        protected void BindDashboardItems()
        {
            try
            {
                ServiceUrl = "CRM/GetMerchantDetailsForDashboard";
                //Param1 = "?site_id=" + siteID;
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var crm = new crmEntity()
                {
                    merchant_id = Convert.ToInt32(Session["merchant_id"].ToString().Trim())
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    //lblTotalonlinepoints.Text = UserLists.Rows[0]["totalponts"].ToString().Trim();
                    lblTotalRedeempoints.Text = UserLists.Rows[0]["totalRedeempoint"].ToString().Trim();
                    lblTotalPurchaseVoucher.Text = UserLists.Rows[0]["totalpurchasevoucher"].ToString().Trim();
                    lblTotalTransaction.Text = UserLists.Rows[0]["totalTransaction"].ToString().Trim();
                    lblRedeemVoucher.Text = UserLists.Rows[0]["totalRedeemVoucher"].ToString().Trim();
                    lblMerchantStatus.Text = UserLists.Rows[0]["Merchantstatus"].ToString().Trim();
                }
                else
                {
                    //message.InnerText = response.ReasonPhrase.ToString();
                    //message.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                //lblMsg.Text = ex.Message.ToString();
                return;
            }
        }

        protected void BindTransactionData()
        {
            string strSendVal = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetMerchantDetailsbyMerchantId";
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt32(Session["merchant_id"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtscount"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    LstRecentTransaction.DataSource = dtChargeType;
                    LstRecentTransaction.DataBind();
                }
                else
                {
                    LstRecentTransaction.DataSource = dtChargeType;
                    LstRecentTransaction.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void LstRecentTransaction_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText != "success")
                {
                    colorstatus.Style.Add("color", "red");
                    //colorstatus.InnerText = "Success";
                }
                else if (colorstatus.InnerText != "failed")
                {
                    colorstatus.Style.Add("color", "green");
                    //colorstatus.InnerText = "Failed";
                }
                HtmlGenericControl totalrecords = (HtmlGenericControl)LstRecentTransaction.FindControl("totalrecords");
                if (ViewState["dtscount"] != null)
                {
                    dt = (DataTable)ViewState["dtscount"];
                    totalrecords.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecords.InnerText = "0"; }
            }

            if ((LstRecentTransaction.FindControl("DataPager2") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (LstRecentTransaction.FindControl("DataPager2") as DataPager).Visible = true;
            }
            else
            {
                (LstRecentTransaction.FindControl("DataPager2") as DataPager).Visible = false;
            }
        }
    }
}