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
    public partial class frmAdminWithdrawDashboard : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
        int merchant_id, userid;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindMerchantList();
                    BindRequestWithdrawList();
                   
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void BindMerchantList()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListOfMerchant";
            var RwdValue = new crmEntity()
            {

                search_param = String.Empty

            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            //HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var MerchantList = response.Content.ReadAsStringAsync().Result;
                var dtMerchantList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MerchantList);

                if (dtMerchantList.Rows.Count > 0)
                {
                    ddlMerchantList.DataSource = dtMerchantList;
                    ddlMerchantList.DataBind();
                    ddlMerchantList.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlMerchantList.Items.Insert(0, new ListItem("-Select-", "NA"));
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
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Completed")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }
                verifyInfo.Style.Remove("color");
                if (verifyInfo.InnerText == "1")
                {
                    verifyInfo.InnerText = "Verified";
                    verifyInfo.Style.Add("color", "green");
                }
                else if (verifyInfo.InnerText == "2")
                {
                    verifyInfo.InnerText = "Not Verified";

                    verifyInfo.Style.Add("color", "orange");

                }
                else if (verifyInfo.InnerText == "0")
                {
                    verifyInfo.InnerText = "Pending Verification";

                    verifyInfo.Style.Add("color","red");

                }
                HtmlGenericControl totalrecord = (HtmlGenericControl)LstRecentTransaction.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    // totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { //totalrecord.InnerText = "0"; 
                }
            }


        }
        protected void LstRecentTransaction_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem withdrawItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (withdrawItems != null)
                {
                    int withdrawId = int.Parse(LstRecentTransaction.DataKeys[withdrawItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmAdminWithdrawStatus.aspx?withdraw_id=" + withdrawId);
                }
            }
           
          
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            BindRequestWithdrawList();
        }
       
        public void BindRequestWithdrawList()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetAdminWithdrawList";

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
            int status=0;
            if (Convert.ToInt32(dtStatus.SelectedIndex) != 0)
            {
                status = Convert.ToInt32(dtStatus.SelectedValue);
            }
            int merchant_id=0;
            if (ddlMerchantList.SelectedIndex != 0)
            {
                if (Convert.ToInt32(ddlMerchantList.SelectedValue) != 0)
                {
                    merchant_id = Convert.ToInt32(ddlMerchantList.SelectedValue);
                }
            }
            var RwdValue = new crmEntity()
            {
                //userlogin_id = Convert.ToInt32(Session["userid"].ToString())
                FromDate = dtStartDate,
                ToDate = dtEndDate,
                refno = txtRefno.Text.Trim(),
                status = status,
                merchant_id= merchant_id,

            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RwDetails = response.Content.ReadAsStringAsync().Result;
                var dtRwDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RwDetails);
                ViewState["dtcont"] = dtRwDetails;
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


    }
}
