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
    public partial class frmMerchantOutletDashboard : System.Web.UI.Page
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
                GetMerchOutletInfoById();
                BindDashboardItems();
                BindTransactionData();
            }
        }

        protected void GetMerchOutletInfoById()
        {
            ServiceUrl = "CRM/GetMerchantOutletDetailsByUserLoginID";
            var crm = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim())
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var MerchantListDetails = response.Content.ReadAsStringAsync().Result;
                var dtMerchantListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MerchantListDetails);
                if (dtMerchantListDetails.Rows.Count > 0)
                {
                    Session["merchID"] = dtMerchantListDetails.Rows[0]["merchant_id"].ToString().Trim();
                    Session["branchID"] = dtMerchantListDetails.Rows[0]["branch_id"].ToString().Trim();
                    if(dtMerchantListDetails.Rows[0]["active_status"].ToString().Trim()=="1")
                    { lblMerchantStatus.Text = "Active"; }
                    else { lblMerchantStatus.Text = "In-Active"; }
                }
            }
        }

        protected void BindDashboardItems()
        {
            try
            {
                ServiceUrl = "CRM/GetMerchantOutletDashboard";
                var crm = new crmEntity()
                {
                    merchant_id = Convert.ToInt32(Session["merchID"].ToString().Trim()),
                    branch_id = Convert.ToInt32(Session["branchID"].ToString().Trim())
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    string[] getResponse = response.Content.ReadAsStringAsync().Result.Split('"');
                    var UserLists = getResponse[0].Replace("[", "").Replace("]", "");

                        ////lblTotalonlinepoints.Text = UserLists.Rows[0]["totalponts"].ToString().Trim();
                        //lblTotalRedeempoints.Text = UserLists.Rows[0]["totalRedeempoint"].ToString().Trim();
                        //lblTotalPurchaseVoucher.Text = UserLists.Rows[0]["totalpurchasevoucher"].ToString().Trim();
                        lblTotalTransaction.Text = "RM "+ string.Format("{0:N2}", Convert.ToDecimal(UserLists.Remove(UserLists.Length - 2, 2).ToString().Trim()));
                        //lblRedeemVoucher.Text = UserLists.Rows[0]["totalRedeemVoucher"].ToString().Trim();
                        //lblMerchantStatus.Text = UserLists.Rows[0]["Merchantstatus"].ToString().Trim();
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
            ServiceUrl = "CRM/GetMerchantOutletTransactionList";
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt32(Session["merchID"].ToString().Trim()),
                branch_id = Convert.ToInt32(Session["branchID"].ToString().Trim())
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
                if (colorstatus.InnerText == "SUCCESSFUL")
                {
                    colorstatus.Style.Add("color", "green");
                }
                else
                {
                    colorstatus.Style.Add("color", "red");
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

            if ((LstRecentTransaction.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (LstRecentTransaction.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (LstRecentTransaction.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
    }
}