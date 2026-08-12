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
    public partial class frmUserDashboard : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, createdby = string.Empty;
        int userloginid = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                #region ajax script mapping handler
                ScriptManager.ScriptResourceMapping.AddDefinition("MicrosoftAjaxWebForms.js", new ScriptResourceDefinition
                {
                    Path = "~/crmapp/js/scriptresource1.js",
                    CdnSupportsSecureConnection = true
                });

                ScriptManager.ScriptResourceMapping.AddDefinition("MicrosoftAjax.js", new ScriptResourceDefinition
                {
                    Path = "~/crmapp/js/scriptresource2.js",
                    CdnSupportsSecureConnection = true
                });
                #endregion
                if (Session["userid"] != null)
                {
                    userloginid = Convert.ToInt16(Session["userid"].ToString());
                    BindRecentPurchaseDetails();
                    BindDahsboardData(userloginid);
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void LstRecentTransaction_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

        }

        protected void BindDahsboardData(int userloginId)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetUserDashboardData";
            var recPurValue = new crmEntity()
            {
                userlogin_id = userloginid
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, recPurValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var DashboardData = response.Content.ReadAsStringAsync().Result;
                var dtDashBoard = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(DashboardData);
                if (dtDashBoard.Rows.Count > 0)
                {
                    lblPoints.Text = dtDashBoard.Rows[0]["rewardPoint"].ToString().Trim();
                    divlblOnlinePoint.Style.Add("width", lblPoints.Text + "px");
                    //lblPurchaseVoucher.Text = dtDashBoard.Rows[0]["rewardPoint"].ToString().Trim();
                    lblPurchaseVoucher.Text = dtDashBoard.Rows[0]["no_of_voucher"].ToString().Trim();
                    divlblPurchaseVoucher.Style.Add("width", lblPurchaseVoucher.Text + "px");
                    RedeemVoucher.Text = dtDashBoard.Rows[0]["no_of_redeem_voucher"].ToString().Trim();
                    divlblRedeemVoucher.Style.Add("width", RedeemVoucher.Text + "px");
                    lblRedeemPoint.Text = dtDashBoard.Rows[0]["redeemPoints"].ToString().Trim();
                    divlblRedeemPoints.Style.Add("width", lblRedeemPoint.Text + "px");
                    lblActive.Text = dtDashBoard.Rows[0]["active_status"].ToString().Trim();
                    lblTransaction.Text = string.Format("{0:N2}", Convert.ToDecimal(dtDashBoard.Rows[0]["trans_amount"].ToString().Trim()));
                    divlblTransaction.Style.Add("width", lblTransaction.Text + "px");
                }
            }
        }
        public void BindRecentPurchaseDetails()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetRecentPurchaseDetails";
            var recPurValue = new crmEntity()
            {
                userlogin_id = userloginid
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, recPurValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var recPurDetails = response.Content.ReadAsStringAsync().Result;
                var dtrecPurDet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(recPurDetails);
                LstRecentTransaction.DataSource = dtrecPurDet;
                LstRecentTransaction.DataBind();
                //if (dtrecPurDet.Rows.Count > 0)
                //{
                //    LstRecentTransaction.DataSource = dtrecPurDet;
                //    LstRecentTransaction.DataBind();
                //    //lv_re.DataSource = dtrecPurDet;
                //    //LV_RecentlyPurchased.DataBind();
                //}
            }
        }

        protected void lbtnviewall_Click(object sender, EventArgs e)
        {

        }
    }
}