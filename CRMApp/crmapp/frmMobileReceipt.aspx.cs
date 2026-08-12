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
    public partial class frmMobileReceipt : System.Web.UI.Page
    {
        #region Global Declaration
        string result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, trDate, yr, mm, dt, hh, mi, ss, paydt,
            paydt1, approvalCode, paymentChannel, processorMessage, errorCode;
        DateTime paymentDate;
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            string TransactionStatus = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                result = Request.Form.Get("result").ToString().Trim();
                transactionID = Request.Form.Get("transactionID").ToString().Trim();
                orderNo = Request.Form.Get("orderNo").ToString().Trim();
                transactionStatus = Request.Form.Get("transactionStatus");
                shoppingAmount = Request.Form.Get("amount");
                currency = Request.Form.Get("currency");
                trDate = Request.Form.Get("transactionDateTime");
                yr = trDate.Substring(0, 4);
                mm = trDate.Substring(4, 2);
                dt = trDate.Substring(6, 2);
                hh = trDate.Substring(8, 2);
                mi = trDate.Substring(10, 2);
                ss = trDate.Substring(12, 2);
                paydt = dt + "/" + mm + "/" + yr + " " + hh + ":" + mi + ":" + ss;
                paydt1 = yr + "-" + mm + "-" + dt + " " + hh + ":" + mi + ":" + ss;
                paymentDate = Convert.ToDateTime(paydt1);
                approvalCode = Request.Form.Get("result");
                paymentChannel = Request.Form.Get("bank");
                //Added New Paramters as part of Cancellation by user upon checkout.
                processorMessage = Request.Form.Get("processorMessage");
                errorCode = Request.Form.Get("errorCode");
                //string token = Request.Form.Get("token").ToString().Trim();

                if (result == "0")
                {
                    TransactionStatus = Request.Form.Get("transactionStatus");
                }
                if (result == "1")
                {
                    TransactionStatus = Request.Form.Get("transactionStatus");
                }
                if (result == "2")
                {
                    TransactionStatus = Request.Form.Get("transactionStatus");
                }
                Label1.Text = result;
                Label2.Text = transactionID;
                Label3.Text = orderNo;
                Label4.Text = transactionStatus;
                Label5.Text = shoppingAmount;
                Label6.Text = currency;
                Label7.Text = paydt1;
                //Label10.Text = paydt1;
                Label8.Text = approvalCode;
                //Label9.Text = paymentChannel;
                Label10.Text = processorMessage;
                Label11.Text = errorCode;
                UpdateBankStatus(result, transactionID,orderNo,transactionStatus,shoppingAmount,currency,paydt1,approvalCode,processorMessage,errorCode);
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:success(); ", true);
            }
        }

        protected void UpdateBankStatus(string result, string transactionID, string orderNo, string transactionStatus, string shoppingAmount, string currency, string paydt1, string approvalCode, string processorMessage, string errorCode)
        {
            try
            {
                ServiceUrl = "CRM/UpdateOrderListByBankStatusIos";
                var crm = new crmEntity()
                {
                    order_no = orderNo,
                    payment_mode = "FT",                    
                    transaction_id = transactionID,
                    transaction_status = transactionStatus,
                    trans_date = paydt1
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
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

        protected void btnBacktoHome_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:success(); ", true);
        }
    }
}