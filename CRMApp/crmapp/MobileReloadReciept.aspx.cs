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
    public partial class MobileReloadReciept : System.Web.UI.Page
    {
        #region Global Declaration
        string result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, trDate, yr, mm, dt, hh, mi, ss, paydt,
            paydt1, approvalCode, paymentChannel, processorMessage, errorCode, payment_mode, strTokenNo = string.Empty, strCardIssuer = string.Empty, strCardNo = string.Empty;
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
                payment_mode = Request.Form.Get("paymentMethod");
                //PnlToken.Visible = false;
                if (Request.Form.Get("orderDescription").ToUpper() == "GENERATETOKEN" && Request.Form.Get("transactionStatus").ToUpper() != "DECLINED")
                {
                    strTokenNo = Request.Form.Get("token").ToString();
                    strCardIssuer = Request.Form.Get("cardIssuer").ToString();
                    strCardNo = Request.Form.Get("maskCardNo");
                    //PnlToken.Visible = true;
                }
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
                Label10.Text = errorCode;
                //Label8.Text = approvalCode;
                //Label9.Text = paymentChannel;
                //Label10.Text = payment_mode;
                Label11.Text = payment_mode;
                //Label12.Text = payment_mode;
                Label13.Text = Request.Form.Get("cardType");
                lblToken.Text = strTokenNo;
                lblBankName.Text = strCardIssuer;

                if (Request.Form.Get("orderDescription") == "Reload")
                {
                    UpdateBankStatus(orderNo, Label13.Text.Trim(), transactionID, paydt1, payment_mode, transactionStatus, paymentChannel);
                    PnlToken.Visible = false;
                    //Pnl_Receipt.Visible = true;
                }
                else if (Request.Form.Get("orderDescription").ToUpper() == "GENERATETOKEN")
                {
                    UpdateTokenTransaction(orderNo, strTokenNo, transactionID, paydt1, payment_mode, transactionStatus, paymentChannel, result, strCardNo);
                    PnlToken.Visible = true;
                    //Pnl_Receipt.Visible = false;
                }




                //UpdateBankStatus(result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, paydt1, approvalCode, processorMessage, errorCode);
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:success(); ", true);
            }
        }

        protected void UpdateBankStatus(string orderNo, string cardType,string transactionID, string paydt1, string payment_mode, string transactionStatus,string paymentChannel)
        {
            try
            {
                ServiceUrl = "Payment/UpdateVirtualTopUpAccountByBankStatus";
                var crm = new crmEntity()
                {
                    user_id = 0,
                    order_no = orderNo,
                    card_type = cardType,
                    transaction_no = transactionID,
                    transaction_time = paydt1,
                    transaction_mode = payment_mode,
                    transaction_status = transactionStatus,
                    bank_name = paymentChannel
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

        protected void UpdatePoints()
        {
            DataTable dtTokenMapping = new DataTable();
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetTransactionRewardPoint";
            try
            {
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeAmt = response.Content.ReadAsStringAsync().Result;
                    var dtChargeAmt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeAmt);
                    if (dtChargeAmt.Rows.Count > 0)
                    {
                        var crmSave = new crmEntity()
                        {
                            user_id = Convert.ToInt16(Session["user_id"].ToString()),
                            rewardPoint = Convert.ToInt32(dtChargeAmt.Rows[0]["reward_points"].ToString().Trim()),
                            order_no = Request.Form.Get("orderNo")
                        };
                        ServiceUrl = "CRM/InsertTransactionRewardPoint";
                        HttpResponseMessage saveresponse = client.PostAsJsonAsync(ServiceUrl, crmSave).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            //var SaveAmt = response.Content.ReadAsStringAsync().Result;
                            //var dtSaveAmt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(SaveAmt);
                            //if (dtSaveAmt.Rows.Count > 0)
                            //{

                            //}
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateTokenTransaction(string orderNo, string tokenNo, string transactionID, string paydt1, string payment_mode, string transactionStatus, string paymentChannel,string result,string cardNo)
        {
            ServiceUrl = "Payment/UpdateTokenDetailsByBankStatus";
            var upTokenEntity = new crmEntity()
            {
                order_no = orderNo,
                token_no = tokenNo,
                transaction_no = transactionID,
                transaction_mode = payment_mode,
                transaction_status = transactionStatus,
                result = result,
                bank_name = paymentChannel,
                user_id = 0,
                card_no = cardNo
            };

            try
            {
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, upTokenEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    if (upTokenEntity.transaction_status == "SUCCESSFUL")
                    {
                        lblMsg.Text = "Tokenization Successful";
                        lblMsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMsg.Text = "Tokenization Failed";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}