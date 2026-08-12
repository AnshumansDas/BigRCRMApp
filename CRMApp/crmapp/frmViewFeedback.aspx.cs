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
    public partial class frmViewFeedback : System.Web.UI.Page
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
                Bindnotificationdetails();
            }

        }

        protected void Bindnotificationdetails()
        {
            string id = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetFeedbackDetailsByfeedbackid";
            if (Request.QueryString["id"].Trim() != null)
            {
                id = Request.QueryString["id"].Trim();
            }
            var feedback = new crmEntity()
            {
                feedback_id = Convert.ToInt32(id)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, feedback).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    // lblMerchantCode.Text = dtChargeType.Rows[0]["merchant_code"].ToString().Trim();
                    lblsubject.Text = dtChargeType.Rows[0]["subject"].ToString().Trim();
                    lblmessage.Text = dtChargeType.Rows[0]["message"].ToString().Trim();
                    lblReplyby.Text = dtChargeType.Rows[0]["reply_by"].ToString().Trim();
                    lblReplyMsg.Text = dtChargeType.Rows[0]["reply_msg"].ToString().Trim();
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
            Response.Redirect("~/crmapp/frmMyFeedback.aspx");
        }

    }
}
