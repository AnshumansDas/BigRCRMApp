using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmAdminDashboard : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindDashboardItems();
                BindTransactionData();
            }
        }

        public void BindDashboardItems()
        {
            try
            {
                ServiceUrl = "CRM/GetAdminDashboardItems";
                //Param1 = "?site_id=" + siteID;
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                //var searchValue = new crmEntity()
                //{
                //    userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim())
                //};

                //HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, searchValue).Result;
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    lblMembers.Text = UserLists.Rows[0]["users"].ToString().Trim();
                    lblQrPay.Text = Convert.ToDecimal(UserLists.Rows[0]["QrPay"]).ToString("###,###.00").Trim();
                    lblRedeemVoucher.Text = UserLists.Rows[0]["redeem"].ToString().Trim();
                    lblVoucherPurchase.Text = Convert.ToDecimal(UserLists.Rows[0]["voucher"]).ToString("###,###.00").Trim();
                    lblTotalmerchant.Text = UserLists.Rows[0]["merchant"].ToString().Trim();
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
            ServiceUrl = "CRM/GetTransactionData";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var transaction = response.Content.ReadAsStringAsync().Result;
                var dttransaction = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(transaction);
                if (dttransaction.Rows.Count > 0)
                {
                    LstRecentTransaction.DataSource = dttransaction;
                    LstRecentTransaction.DataBind();
                }
                else
                {
                    LstRecentTransaction.DataSource = dttransaction;
                    LstRecentTransaction.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }

        protected void LstRecentTransaction_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LstRecentTransaction.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindTransactionData();
        }
    }
}