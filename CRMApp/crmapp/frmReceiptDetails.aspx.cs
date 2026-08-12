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
    public partial class frmReceiptDetails : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //crmEntity cartData = new crmEntity();
            //cartData = (crmEntity)Session["cartdata"];
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
                #region CartData
                if (Session["cartdata"] != null)
                {
                    var cart = new crmEntity()
                    {
                        user_id = Convert.ToInt16(Session["userid"].ToString()),
                        trans_result = Request.Form.Get("result").ToString().Trim(),
                        trans_no = Request.Form.Get("transactionID"),
                        transaction_id = Request.Form.Get("transactionID"),
                        order_no = Request.Form.Get("orderNo"),
                        trans_status = Request.Form.Get("transactionStatus"),
                        transaction_amount = Request.Form.Get("amount"),
                        currency = Request.Form.Get("currency"),
                        //trans_date = Convert.ToDateTime(paydt1).ToString(),
                        trans_date = paydt1,
                        app_Code = Request.Form.Get("result"),
                        bank = Request.Form.Get("bank"),
                        trans_mode = Request.Form.Get("paymentMethod"),
                        payment_mode = Request.Form.Get("paymentMethod"),
                        transaction_status = Request.Form.Get("transactionStatus"),
                        //transaction_time = Convert.ToDateTime(paydt1).ToString(),
                        transaction_time = paydt1.ToString(),
                        userloginid = Session["userid"].ToString()

                    };
                    if (cart.trans_result == "0")
                    {

                        lblPaymentStatus.Text = "PAYMENT RECEIVED !";
                        lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                        setCartData(cart);
                        //SendEmailNotification();
                    }
                    if (cart.trans_result == "1")
                    {
                        lblPaymentStatus.Text = "PAYMENT DECLINED !";
                        lblPaymentStatus.ForeColor = System.Drawing.Color.Red;
                        lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                        setCartData(cart);
                        //SendEmailNotification();
                    }
                    if (cart.trans_result == "2")
                    {
                        lblPaymentStatus.Text = "PAYMENT PENDING !";
                        lblPaymentStatus.ForeColor = System.Drawing.Color.Red;
                        lblTransactionStatus.Text = Request.Form.Get("transactionStatus");
                        setCartData(cart);
                        //SendEmailNotification();
                    }
                }
                #endregion
            }
        }

        protected void setCartData(crmEntity cart)
        {
            lblTransactionID.Text = cart.trans_no;
            if (!string.IsNullOrEmpty(cart.transaction_amount))
            {
                lblTotalAmount.Text = cart.transaction_amount.ToString().Trim();
                //rfid.TokenAmt = lblTotalAmount.Text.Trim();
            }
            else
            {
                lblTotalAmount.Text = string.Empty;
                cart.transaction_amount = lblTotalAmount.Text.Trim();
                cart.order_no = Request.Form.Get("orderNo").ToString().Trim();
                lblOrderNo.Text = Request.Form.Get("orderNo").ToString().Trim();
            }
            //lblPaymentMode.Text = payment.transaction_mode;

            if (!string.IsNullOrEmpty(Request.Form.Get("bank")))
            {
                lblPaymentMode.Text = Request.Form.Get("bank");
                cart.bank = lblPaymentMode.Text;
            }
            else
            {
                lblPaymentMode.Text = string.Empty;
                cart.bank = string.Empty;
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
            lblOrderNo.Text = cart.order_no;
            lblTransactionDate.Text = cart.trans_date.ToString();
            lblEmail.Text = Session["EmailId"].ToString().Trim();
            //lblTokenNo.Text = rfid.TokenNo.ToString().Trim();

            if (Request.Form.Get("orderDescription") == "CART")
            {
                UpdatePurchaseTransaction(cart);
            }
        }

        public void UpdatePurchaseTransaction(crmEntity cart)
        {
            DataTable dtTokenMapping = new DataTable();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/UpdateOrderListByBankStatus";
            var crmtest = new crmEntity()
            {
                userloginid = cart.userloginid,
                order_no = cart.order_no,
                payment_mode = cart.payment_mode,
                transaction_id = cart.transaction_id,
                transaction_status = cart.trans_status,
                transaction_time = cart.transaction_time
            };

            try
            {
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, cart).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Token = response.Content.ReadAsStringAsync().Result;
                    dtTokenMapping = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Token);
                    if (dtTokenMapping.Rows.Count > 0)
                    {
                        //
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void GetTransactionDetails(crmEntity cart)
        {
            DataTable dtTransactionDetails = new DataTable();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetTransactionDetailsByOrderNo";
            var crmtest = new crmEntity()
            {
               order_no = cart.order_no
            };

            try
            {
                HttpResponseMessage respTransDetails = client.PostAsJsonAsync(ServiceUrl, cart).Result;
                if (respTransDetails.IsSuccessStatusCode)
                {
                    var TransDetails = respTransDetails.Content.ReadAsStringAsync().Result;
                    dtTransactionDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(TransDetails);
                    if (dtTransactionDetails.Rows.Count > 0)
                    {
                        LblName.Text = dtTransactionDetails.Rows[0]["user_fistname"].ToString();
                        LblAddr1.Text = dtTransactionDetails.Rows[0]["address1"].ToString();
                        LblAddr2.Text = dtTransactionDetails.Rows[0]["address2"].ToString();
                        LblState.Text = dtTransactionDetails.Rows[0]["address2"].ToString();
                        LblPinCode.Text = dtTransactionDetails.Rows[0]["address2"].ToString();
                        LblCountry.Text = dtTransactionDetails.Rows[0]["country"].ToString();
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