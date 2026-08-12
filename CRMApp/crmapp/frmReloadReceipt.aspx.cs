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
    public partial class frmReloadReceipt : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strTokenNo = string.Empty,strCardIssuer = string.Empty, strCardNo=string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                string trDate = Request.Form.Get("transactionDateTime");
                string yr = trDate.Substring(0, 4);
                string mm = trDate.Substring(4, 2);
                string dt = trDate.Substring(6, 2);
                string hh = trDate.Substring(8, 2);
                string mi = trDate.Substring(10, 2);
                string ss = trDate.Substring(12, 2);
                string paydt = dt + "/" + mm + "/" + yr + " " + hh + ":" + mi + ":" + ss;
                string paydt1 = yr + "-" + mm + "-" + dt + " " + hh + ":" + mi + ":" + ss;
                if (Request.Form.Get("orderDescription").ToUpper() == "GENERATETOKEN" && Request.Form.Get("transactionStatus").ToUpper() != "DECLINED")
                {
                    strTokenNo = Request.Form.Get("token").ToString();
                    strCardIssuer = Request.Form.Get("cardIssuer").ToString();
                    strCardNo = Request.Form.Get("maskCardNo");
                }
                #region ReloadData
                var reload = new crmEntity()
                {
                    user_id = Convert.ToInt16(Session["user_id"].ToString()),
                    trans_result = Request.Form.Get("result").ToString().Trim(),
                    transaction_id = Request.Form.Get("transactionID"),
                    order_no = Request.Form.Get("orderNo"),
                    transaction_amount = Request.Form.Get("amount"),
                    currency = Request.Form.Get("currency"),
                    trans_date = paydt1,
                    bank = Request.Form.Get("bank"),
                    payment_mode = Request.Form.Get("paymentMethod"),
                    transaction_status = Request.Form.Get("transactionStatus"),
                    //transaction_time = Convert.ToDateTime(paydt1).ToString(),
                    transaction_time = paydt1.ToString(),
                    userloginid = Session["userid"].ToString(),
                    token_no = strTokenNo,
                    bank_name = strCardIssuer
                };
                if (reload.trans_result == "0")
                {

                    lblPaymentStatus.Text = "PAYMENT RECEIVED !";
                    lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                    setCartData(reload);
                    //SendEmailNotification();
                }
                if (reload.trans_result == "1")
                {
                    lblPaymentStatus.Text = "PAYMENT DECLINED !";
                    lblPaymentStatus.ForeColor = System.Drawing.Color.Red;
                    lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                    setCartData(reload);
                    //SendEmailNotification();
                }
                if (reload.trans_result == "2")
                {
                    lblPaymentStatus.Text = "PAYMENT PENDING !";
                    lblPaymentStatus.ForeColor = System.Drawing.Color.Red;
                    lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                    setCartData(reload);
                    //SendEmailNotification();
                }
                #endregion
            }
        }
        protected void setCartData(crmEntity reload)
        {
            lblTransactionID.Text = reload.transaction_id;
            if (!string.IsNullOrEmpty(reload.transaction_amount))
            {
                lblTotalAmount.Text = reload.transaction_amount.ToString().Trim();
            }
            else
            {
                lblTotalAmount.Text = string.Empty;
                reload.transaction_amount = lblTotalAmount.Text.Trim();
                reload.order_no = Request.Form.Get("orderNo").ToString().Trim();
                lblOrderNo.Text = Request.Form.Get("orderNo").ToString().Trim();
            }
            if (!string.IsNullOrEmpty(Request.Form.Get("bank")))
            {
                lblPaymentMode.Text = Request.Form.Get("bank");
                reload.bank = lblPaymentMode.Text;
            }
            else
            {
                lblPaymentMode.Text = string.Empty;
                reload.bank = string.Empty;
            }
            if (Request.Form.Get("paymentMethod") == "FT")
            {
                lblPaymentMode.Text = Request.Form.Get("bank");
            }
            if (Request.Form.Get("paymentMethod") == "CC")
            {
                lblPaymentMode.Text = "CREDIT CARD";
            }
            if (Request.Form.Get("paymentMethod") == "DC")
            {
                lblPaymentMode.Text = "DEBIT CARD";
            }
            lblOrderNo.Text = reload.order_no;
            lblTransactionDate.Text = reload.trans_date.ToString();
            lblEmail.Text = Session["EmailId"].ToString().Trim();
            lblToken.Text = reload.token_no.ToString();
            if (lblToken.Text.Trim() != "")
            {
                var input = lblToken.Text;
                var length = input.Length;
                var result = new String('X', length - 4) + input.Substring(length - 4);
                lblToken.Text = result;
            }
            //lblTokenNo.Text = rfid.TokenNo.ToString().Trim();

            if (Request.Form.Get("orderDescription") == "Reload")
            {
                UpdatePurchaseTransaction(reload);
                Pnl_Token.Visible = false;
                Pnl_Receipt.Visible = true;
            }
            else if (Request.Form.Get("orderDescription").ToUpper() == "GENERATETOKEN")
            {
                UpdateTokenTransaction(reload);
                Pnl_Token.Visible = true;
                Pnl_Receipt.Visible = false;
            }
        }

        public void UpdatePurchaseTransaction(crmEntity cart)
        {
            DataTable dtTokenMapping = new DataTable();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "Payment/UpdateVirtualTopUpAccountByBankStatus";
            var Reload = new crmEntity()
            {
                user_id = cart.user_id,
                order_no = cart.order_no,
                card_type=cart.card_type,
                transaction_no = cart.transaction_id,
                transaction_date = cart.transaction_time,
                transaction_mode = cart.payment_mode,
                transaction_status = cart.transaction_status,
                bank_name = cart.bank
            };

            try
            {
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, Reload).Result;
                if (response.IsSuccessStatusCode)
                {
                    if (cart.transaction_status == "SUCCESSFUL")
                    {
                        lblmsg.Text = "Reload Successful";
                        lblmsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblmsg.Text = "Reload Failed";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                    //var Token = response.Content.ReadAsStringAsync().Result;
                    //dtTokenMapping = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Token);
                    //if (dtTokenMapping.Rows.Count > 0)
                    //{
                    //    //
                    //}
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateTokenTransaction(crmEntity tokenParams)
        {
            ServiceUrl = "Payment/UpdateTokenDetailsByBankStatus";
            var upTokenEntity = new crmEntity()
            {
                order_no = tokenParams.order_no,
                token_no = tokenParams.token_no,
                transaction_no = tokenParams.transaction_id,
                transaction_mode = tokenParams.payment_mode,
                transaction_status = tokenParams.transaction_status,
                result = tokenParams.trans_result,
                bank_name = tokenParams.bank_name,
                user_id = Convert.ToInt16(Session["user_id"].ToString()),
                card_no = strCardNo
            };

            try
            {
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, upTokenEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    if (upTokenEntity.transaction_status == "SUCCESSFUL")
                    {
                        lblmsg.Text = "Tokenization Successful";
                        lblmsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblmsg.Text = "Tokenization Failed";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
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