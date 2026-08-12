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
	public partial class frmAdminWithdrawNotification : System.Web.UI.Page
	{

        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
        #endregion
        protected void Page_Load(object sender, EventArgs e)
		{
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            BindNotificationList();
		}

        protected void btnSearch_Click(object sender, EventArgs e)
        {


            BindNotificationList();

        }
        //Withdraw List
        public void BindNotificationList()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetNotificationList";

            if (!string.IsNullOrEmpty(txtNotifyDateRange.Text.Trim()))
            {
                string data = txtNotifyDateRange.Text.Trim();
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
          
            var RwdValue = new crmEntity()
            {
                //userlogin_id = Convert.ToInt32(Session["userid"].ToString())
                FromDate = dtStartDate,
                ToDate = dtEndDate

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

        //end Notification list
    }
}