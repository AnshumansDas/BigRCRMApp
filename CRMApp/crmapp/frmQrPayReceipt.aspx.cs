using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmQrPayReceipt : System.Web.UI.Page
    {
        #region Global Declaration
        string result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, trDate, yr, mm, dt, hh, mi, ss, paydt,
            paydt1, approvalCode, paymentChannel, processorMessage, errorCode, cardtype, membername, outlet, paymentMode;
        DateTime paymentDate;
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            string TransactionStatus = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                result = Request.Form.Get("result").ToString().Trim();
                orderNo = Request.Form.Get("orderNo").ToString().Trim();
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
                transactionID = Request.Form.Get("transactionID").ToString().Trim();
                shoppingAmount = Request.Form.Get("amount");
                transactionStatus = Request.Form.Get("transactionStatus");
                cardtype = Request.Form.Get("cardType");
                //membername = Request.Form.Get("membername");
                //outlet = Request.Form.Get("outlet");
                currency = Request.Form.Get("currency");
                approvalCode = Request.Form.Get("result");
                //paymentChannel = Request.Form.Get("paymentChannel");
                paymentMode = Request.Form.Get("paymentMethod");
                ////Added New Paramters as part of Cancellation by user upon checkout.
                processorMessage = Request.Form.Get("processorMessage");
                errorCode = Request.Form.Get("errorCode");
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
                //payment Method
                if (Request.Form.Get("paymentMethod") == "CC")
                {
                    paymentMode = "Credit Card";
                }
                if (Request.Form.Get("paymentMethod") == "DC")
                {
                    paymentMode = "Debit Card";
                }
                if (Request.Form.Get("paymentMethod") == "FT")
                {
                    paymentMode = "Credit Card";
                }
                Label9.Text = paymentMode;
                Label8.Text = approvalCode;
                Label10.Text = processorMessage;
                Label11.Text = errorCode;
                Label12.Text = cardtype;

                lblMemberName.Text = membername;
                lblOutlet.Text = outlet;                
                UpdateQRpayByBankStatus(result, transactionID, orderNo, transactionStatus, paymentMode, paydt1, cardtype);
                PushNotification();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);
                
            }
        }

        protected void PushNotification()
        {
            //Call Get_Notification_Details_New
            ServiceUrl = "CRM/Get_Notification_Details_New";
            var crm = new crmEntity()
            {
                order_no = orderNo.Trim()
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
            }
        }

        protected void UpdateQRpayByBankStatus(string result, string transactionID, string orderNo, string transactionStatus, string paymentMode, string paydt1, string cardtype)
        {
            try
            {
                lblMsg.Text = string.Empty;

                if (paymentMode == "FT")
                {
                    cardtype = "Bank";
                }
                if (paymentMode == "CC")
                {
                    cardtype = "Visa/Master";
                }
                if (paymentMode == "DC")
                {
                    cardtype = "Debit";
                }
                ServiceUrl = "Payment/UpdateQRpayByBankStatus";
                var crm = new crmEntity()
                {
                    //userlogin_id = Convert.ToInt16(Session["userid"].ToString()),
                    order_no = orderNo.Trim(),
                    payment_mode = paymentMode.Trim(),
                    transaction_id = transactionID.Trim(),
                    transaction_status = transactionStatus.Trim(),
                    transaction_time = paydt1.Trim(),
                    card_type = cardtype.Trim()
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    ValidateControl();
                    if (paymentMode == "FT")
                    {
                        trPayType.Visible = false;
                    }
                    if (paymentMode == "CC")
                    {
                        trPayType.Visible = true;
                    }
                    if (paymentMode == "DC")
                    {
                        trPayType.Visible = true;
                    }
                }
                else
                {
                    lblMsg.Text = response.ReasonPhrase.ToString();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
                return;
            }
        }

        protected void ValidateControl()
        {
            //trTransResult.Visible = false;
            trOrderNo.Visible = false;
            trCurrency.Visible = false;
            trApprovalStatus.Visible = false;
            trPaymentMode.Visible = false;
            trProcessorMsg.Visible = false;
            trErrorCode.Visible = false;
        }

        protected void UpdateQRpayByBankStatusIOS(string result, string transactionID, string orderNo, string transactionStatus, string shoppingAmount, string currency, string paydt1, string approvalCode, string processorMessage, string errorCode)
        {
            try
            {
                lblMsg.Text = string.Empty;
                ServiceUrl = "CRM/UpdateQRpayByBankStatusIos";
                var crm = new crmEntity()
                {
                    order_no = orderNo,
                    payment_mode = "FT",
                    transaction_id = transactionID,
                    transaction_status = transactionStatus,
                    transaction_time = paydt1
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                }
                else
                {
                    lblMsg.Text = response.ReasonPhrase.ToString();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
                return;
            }
        }

        protected void btnBacktoHome_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "success();", true);
        }
    }
}