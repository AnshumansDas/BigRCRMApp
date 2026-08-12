using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
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
    public partial class frmWithdrawDashboard : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "", WithdrawRefID;
        int merchant_id,userid;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                  if (Session["Username"] != null)
                  {
                BindBankList();
                BindWithdrawAvailableAmount();
                   // BindOutlets();
                BindRequestWithdrawList();
                BindDashboardItems();
                 }
                  else
                  {
                      Response.Redirect("../Home.aspx");
                  }
            }
        }

        protected void ddlBankList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            String reqamount = txtReqAmnt.Text;
            String bankname = ddlBankList.Text;

            String accno = txAccountNo.Text;
            int merchant_id = 0;
            if (Convert.ToInt32(hdMerchantId.Value) != 0)
            {
                merchant_id = Convert.ToInt32(hdMerchantId.Value);
            }
            int outlet_id = 0;
           
            decimal availbleAmt = 0;
            if (hdAvailamt.Value != "")
            {
                availbleAmt = Convert.ToDecimal(hdAvailamt.Value);
            }
            //availbleAmt = 100;
            invalidmsg.Style.Remove("color");
            
            if (Convert.ToDecimal(reqamount.Trim()) <= availbleAmt && Convert.ToDecimal(reqamount.Trim())>=100)
            {
                String refno = getWithdrawRef();
                var crm = new crmEntity()
                {
                    merchant_id = merchant_id,
                    outlet_id = outlet_id,
                    available_amount = availbleAmt,
                    requested_amount = Convert.ToDecimal(reqamount.Trim()),
                    bank_name = bankname.Trim(),
                    accno = accno.Trim(),
                    refno = refno,
                    status = 0,
                    verifyflag = 0
                };
                ServiceUrl = "CRM/AddRequestWithdraw";
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;                
                if (response.IsSuccessStatusCode)
                {
                    var withdraw = response.Content.ReadAsStringAsync().Result;
                    invalidmsg.Style.Add("color", "Green");
                    invalidmsg.InnerText = "Data Saved Successfully";
                    BindWithdrawAvailableAmount();
                    BindRequestWithdrawList();
                    BindDashboardItems();
                    txtRefno.Text = string.Empty;
                    txtReqAmnt.Text = string.Empty;
                    txAccountNo.Text = string.Empty;
                    ddlBankList.SelectedIndex = 0;
                    dtStatus.SelectedIndex = 0;
                }
            }else
            {
                invalidmsg.Style.Add("color", "Red");
                invalidmsg.InnerText = "Request amount is more than available amount";
                BindWithdrawAvailableAmount();
            }
        }
        protected void BindBankList()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetBankList";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var BankList = response.Content.ReadAsStringAsync().Result;
                var dtBankList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(BankList);

                if (dtBankList.Rows.Count > 0)
                {
                    ddlBankList.DataSource = dtBankList;
                    ddlBankList.DataBind();
                    ddlBankList.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlBankList.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void LstRecentTransaction_ItemDataBound(object sender, ListViewItemEventArgs e)
       {
           DataTable dt = new DataTable();
           ListViewDataItem dataItem = (ListViewDataItem)e.Item;
           if (e.Item.ItemType == ListViewItemType.DataItem)
           {
               HtmlGenericControl verifyInfo = (HtmlGenericControl)e.Item.FindControl("verifyInfo");
                HtmlGenericControl WithdrawStatus = (HtmlGenericControl)e.Item.FindControl("WithdrawStatus");
                
                HtmlGenericControl verifybtn = (HtmlGenericControl)e.Item.FindControl("verifybtn");
                if (verifyInfo.InnerText == "1")
               { verifyInfo.InnerText = "Verified";
                    verifyInfo.Style.Add("color", "green");
                }
                else if (verifyInfo.InnerText == "2" )
               {
                    verifyInfo.InnerText = "Not Verified";

                    verifyInfo.Style.Add("color", "orange");

                }
                else if(WithdrawStatus.InnerText=="Completed" && verifyInfo.InnerText == "0")
                {
                    verifyInfo.InnerText = "";
                    verifybtn.Style.Remove("display");
                    verifybtn.Style.Add("display", "block");
                }
                else { verifyInfo.InnerText = ""; }

             
           }


       }
        protected void LstRecentTransaction_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem withdrawItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Yes")
            {
                if (withdrawItems != null)
                {
                    int withdrawId = int.Parse(LstRecentTransaction.DataKeys[withdrawItems.DisplayIndex][0].ToString());
                    var crm = new crmEntity()
                    {
                        withdraw_id = withdrawId,
                        status = 0,
                        verifyflag = 1,

                    };
                    ServiceUrl = "CRM/UpdateRequestWithdraw";
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var withdraw = response.Content.ReadAsStringAsync().Result;
                       
                            Response.Redirect("frmWithdrawDashboard.aspx");
                       
                    }
                }
            }
            else if (e.CommandName == "No")
            {
                if (withdrawItems != null)
                {
                    int withdrawId = int.Parse(LstRecentTransaction.DataKeys[withdrawItems.DisplayIndex][0].ToString());
                    var crm = new crmEntity()
                    {
                        withdraw_id = withdrawId,
                        status = 0,
                        verifyflag = 2,

                    };
                    ServiceUrl = "CRM/UpdateRequestWithdraw";
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var withdraw = response.Content.ReadAsStringAsync().Result;
                       // var dtwithdraw = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(withdraw);
                       
                            #region Notifications
                            int merchant_id = 0;
                            if (Convert.ToInt32(hdMerchantId.Value) != 0)
                            {
                                merchant_id = Convert.ToInt32(hdMerchantId.Value);
                            }
                            var crmNotify = new crmEntity()
                            {
                                notification_type = "Not Verified",
                                user_id = Convert.ToInt32(Session["userid"].ToString()),
                                merchant_id = merchant_id,
                                notification_title = "Verify Withdraw",
                                notification_summary = "The withdraw amount requested is not verified by merchant",
                                withdraw_id = withdrawId
                            };
                            ServiceUrl = "CRM/AddWithdrawNotification";
                            HttpResponseMessage Notifyresponse = client.PostAsJsonAsync(ServiceUrl, crmNotify).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                var notify = response.Content.ReadAsStringAsync().Result;
                            }
                            #endregion
                            Response.Redirect("frmWithdrawDashboard.aspx");
                       
                    }
                }

            }
        }
       /* protected void BindOutlets()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherOutlet";
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt32(merchant_id)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Outlet = response.Content.ReadAsStringAsync().Result;
                var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                //ViewState["dtcont"] = dtChargeType;
                if (dtOutlet.Rows.Count > 0)
                {
                    //lblNoRecord.Visible = false;
                    ddlOutlet.DataSource = dtOutlet;
                    ddlOutlet.DataBind();
                    ddlOutlet.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlBankList.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }
        */
        protected void btnSearch_Click(object sender, EventArgs e)
        {

            BindRequestWithdrawList();
            BindWithdrawAvailableAmount();
            BindDashboardItems();
            txtReqAmnt.Text = string.Empty;
            txAccountNo.Text = string.Empty;
            ddlBankList.SelectedIndex = 0;
            invalidmsg.InnerText = string.Empty;
        }
        public void BindWithdrawAvailableAmount()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetWithdrawAvailableAmount";
            var wdparams = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["userid"].ToString()),


            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, wdparams).Result;
            if (response.IsSuccessStatusCode)
            {
                var WDDetails = response.Content.ReadAsStringAsync().Result;
                var dtWDDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(WDDetails);
                if (dtWDDetails.Rows.Count > 0)
                {
                   // lblAvailableAmount.Text = dtWDDetails.Rows[0]["trans_amount"].ToString().Trim();
                    hdAvailamt.Value = dtWDDetails.Rows[0]["trans_amount"].ToString().Trim();
                    hdMerchantId.Value = dtWDDetails.Rows[0]["merchant_id"].ToString().Trim();
                    merchant_id = 0;
                    if (dtWDDetails.Rows[0]["merchant_id"].ToString().Trim() != "")
                    {
                        merchant_id = Convert.ToInt32(dtWDDetails.Rows[0]["merchant_id"].ToString().Trim());
                    }
                    Session["merchant_id"] = dtWDDetails.Rows[0]["merchant_id"].ToString().Trim();
                    userid = Convert.ToInt32(dtWDDetails.Rows[0]["user_id"].ToString().Trim());
                    if (Convert.ToDecimal(dtWDDetails.Rows[0]["trans_amount"].ToString().Trim()) < 100)
                    {
                       btnRequest.Enabled = false;
                        hdAvailamt.Value = "0";
                    }
                }

                

            }
        }
        public void BindDashboardItems()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetWithdrawDashboard";
            if (Session["merchant_id"] != null)
            {
                if (Session["merchant_id"].ToString() != "")
                {
                    merchant_id = Convert.ToInt32(Session["merchant_id"].ToString());
                }
            }
            var wdparams = new crmEntity()
            {
                merchant_id = merchant_id,
                user_id= userid,


            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, wdparams).Result;
            if (response.IsSuccessStatusCode)
            {
                var WDDetails = response.Content.ReadAsStringAsync().Result;
                var dtWDDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(WDDetails);
                if (dtWDDetails.Rows.Count > 0)
                {
                    lblTotalwdTransaction.Text = "RM " + dtWDDetails.Rows[0]["totaltransaction"].ToString().Trim();
                    if (dtWDDetails.Rows[0]["totalCompleted"].ToString().Trim() != "")
                    {
                        lblTotalCompleted.Text = "RM " +dtWDDetails.Rows[0]["totalCompleted"].ToString().Trim();
                    }
                    else
                    {
                        lblTotalCompleted.Text = "RM 0";
                    }
                    lblPending.Text = "RM " + dtWDDetails.Rows[0]["totalPending"].ToString().Trim();
                    //lblwdAvailableAmount.Text = dtWDDetails.Rows[0]["totalAvailableAmount"].ToString().Trim();
                    lblwdAvailableAmount.Text = "RM " + hdAvailamt.Value.Trim();
                }

            }
        }
        public void BindRequestWithdrawList()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetMerchantWithdrawList";

            if (!string.IsNullOrEmpty(txtVoucherDateRange.Text.Trim()))
            {
                string data = txtVoucherDateRange.Text.Trim();
                string[] dates = data.Split('-');
                if (!string.IsNullOrEmpty(dates[0].ToString().Trim()))
                {
                    startdate = dates[0].ToString().Trim();
                    string[] starttokens = startdate.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                else { dtStartDate = ""; }

                if (!string.IsNullOrEmpty(dates[1].ToString().Trim()))
                {
                    enddate = dates[1].ToString().Trim();
                    string[] endtokens = enddate.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                else { dtEndDate = ""; }
            }
            else
            { dtStartDate = ""; dtEndDate = ""; }
            int status = 0;
            if (Convert.ToInt32(dtStatus.SelectedValue) != 0)
            {
                status = Convert.ToInt32(dtStatus.SelectedValue);
            }
            if (Session["merchant_id"] != null)
            {
                if (Session["merchant_id"].ToString() != "")
                {
                    merchant_id = Convert.ToInt32(Session["merchant_id"].ToString());
                }
            }
            var RwdValue = new crmEntity()
            {
                //userlogin_id = Convert.ToInt32(Session["userid"].ToString())
                FromDate = dtStartDate,
                ToDate = dtEndDate,
                refno = txtRefno.Text.Trim(),
                status = status,
                merchant_id= merchant_id

            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RwDetails = response.Content.ReadAsStringAsync().Result;
                var dtRwDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RwDetails);
                if (dtRwDetails.Rows.Count > 0)
                {
                    LstRecentTransaction.DataSource = dtRwDetails;
                    LstRecentTransaction.DataBind();
                }
                else
                {
                    LstRecentTransaction.DataSource = dtRwDetails;
                    LstRecentTransaction.DataBind();
                }
            }
        }

        protected string getWithdrawRef()
        {
            try
            {
                ServiceUrl = "CRM/GetWithdrawRef";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    string[] strVal = response.Content.ReadAsStringAsync().Result.Split('"');
                    var WithdrawRefNo = strVal[0].Replace("[", "").Replace("]", "");
                    var dt = DateTime.Now.ToString("yyyyMMdd");
                    WithdrawRefID = dt + int.Parse(WithdrawRefNo.Remove(WithdrawRefNo.Length - 2, 2)).ToString("000000").Trim();
                }
            }
            catch (Exception ex)
            {
            }
            return WithdrawRefID;
        }

    }
}
