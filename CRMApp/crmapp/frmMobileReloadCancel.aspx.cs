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
    public partial class frmMobileReloadCancel : System.Web.UI.Page
    {
        #region Global Declaration
        string result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, trDate, yr, mm, dt, hh, mi, ss, paydt,
            paydt1, approvalCode, paymentChannel, processorMessage, errorCode, payment_mode;
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
                Label8.Text = approvalCode;
                Label9.Text = paymentChannel;
                //Label10.Text = payment_mode;
                Label11.Text = payment_mode;
                //Label12.Text = payment_mode;
                Label13.Text = string.Empty;
            }
        }
    }
}