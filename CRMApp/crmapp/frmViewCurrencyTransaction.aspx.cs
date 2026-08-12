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
using System.IO;
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmViewCurrencyTransaction : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindTransactiondetails();
            }

        }
        public void BindTransactiondetails()
        {
            string redeemid = string.Empty;
            
            ServiceUrl = "CRM/GetCurrencyTransactionsusers";
            if (Request.QueryString["redeem_id"].Trim() != null)
            {                
                redeemid = Request.QueryString["redeem_id"].Trim();
            }
            var crm = new crmEntity()
            {
                redeem_id = Convert.ToInt32(redeemid),
                search_param="",
                user_id = Convert.ToInt16(Session["user_id"].ToString())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {                 
                    lblstatus.Text = dtChargeType.Rows[0]["status"].ToString().Trim();
                    lblCurrency.Text = dtChargeType.Rows[0]["currency_type"].ToString().Trim();
                    lblPoints.Text = dtChargeType.Rows[0]["redeem_points"].ToString().Trim();                    
                    lblamount.Text = dtChargeType.Rows[0]["amount"].ToString().Trim();
                    lblcreateddate.Text = dtChargeType.Rows[0]["created_date"].ToString().Trim();
                    lblupdateddate.Text = dtChargeType.Rows[0]["updated_date"].ToString().Trim();
                    lblRemarks.Text= dtChargeType.Rows[0]["remarks"].ToString().Trim();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/crmapp/frmRedeemCurrency.aspx");
        }
    }
}