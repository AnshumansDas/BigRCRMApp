using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmReloadCard : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strTID = string.Empty, strAPIKey = string.Empty, strPaymentURL = string.Empty, email = string.Empty;
        static string totalAmount = string.Empty;
        double subtotal = 0.00;
        static decimal transactionfee = 0.00M;
        static string randomnumber;
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindReloadList();
                GetTransactionFees();
            }
        }

        public void BindReloadList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "Payment/GetReloadHistoryBycard";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                card_no = Request.QueryString["Membership_no"].ToString().Trim(),
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeAmt = response.Content.ReadAsStringAsync().Result;
                var dtChargeAmt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeAmt);
                if (dtChargeAmt.Rows.Count > 0)
                {
                    lvBigrReload.DataSource = dtChargeAmt;
                    lvBigrReload.DataBind();
                }
                else
                {
                    lvBigrReload.DataSource = dtChargeAmt;
                    lvBigrReload.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }

        protected void lvBigrReload_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvBigrReload_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

        }

        protected void lvBigrReload_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvBigrReload.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindReloadList();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindReloadList();
        }

        protected void d10_Click(object sender, ImageClickEventArgs e)
        {

            txtReloadAmount.Text = string.Format("{0:N2}", Convert.ToDecimal("10"));
        }

        protected void d30_Click(object sender, ImageClickEventArgs e)
        {
            txtReloadAmount.Text = string.Format("{0:N2}", Convert.ToDecimal("30"));
        }

        protected void d50_Click(object sender, ImageClickEventArgs e)
        {
            txtReloadAmount.Text = string.Format("{0:N2}", Convert.ToDecimal("50"));
        }

        protected void d100_Click(object sender, ImageClickEventArgs e)
        {
            txtReloadAmount.Text = string.Format("{0:N2}", Convert.ToDecimal("100"));
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }

        protected void GenerateRandomNumber()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[8];
            var random = new Random();
            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }
            randomnumber = "BIGR" + new String(stringChars);
        }

        protected string Hash(string sendData)
        {
            using (SHA1Managed sha1 = new SHA1Managed())
            {
                var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(sendData));
                var sb = new StringBuilder(hash.Length * 2);

                foreach (byte b in hash)
                {
                    // can be "x2" if you want lowercase
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string
                //orderNo = string.Empty, 
                PaymentType = string.Empty;
            decimal totalValue = Convert.ToDecimal(txtReloadAmount.Text.Trim()) + Convert.ToDecimal(lbltransactionFee.Text.Trim());
            totalAmount = string.Format("{0:N2}", totalValue);
            GenerateRandomNumber();
            if (ddlPaymentMode.SelectedValue == "FPX")
            {
                PaymentType = "FT";
            }
            if (ddlPaymentMode.SelectedValue == "CC")
            {
                PaymentType = "CC";
            }
            if (Session["EmailId"] != null)
            { email = Session["EmailId"].ToString().Trim(); }
            #region Save to DB 
            //orderNo= randomnumber;

            ServiceUrl = "Payment/InsertVirtualTopupAccount";

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var reloadCheckoutData = new crmEntity
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                order_no = randomnumber,
                card_no = Request.QueryString["Membership_no"].ToString().Trim(),
                transaction_amount = txtReloadAmount.Text.Trim(),
                transaction_point = 0,
                orderDescription = "Reload"
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, reloadCheckoutData).Result;
            if (response.IsSuccessStatusCode)
            {
                try
                {
                    #region AbseccPayment
                    //web
                    strTID = ConfigurationManager.AppSettings["ReloadTID"].ToString();
                    strAPIKey = ConfigurationManager.AppSettings["ReloadAPIKey"].ToString();
                    strPaymentURL = ConfigurationManager.AppSettings["PaymentURL"].ToString();
                    string checksum = Hash(strAPIKey + strTID + randomnumber + reloadCheckoutData.orderDescription + "MYR" + totalAmount + PaymentType + "SALE" + "" + email);
                    //MOBILE
                    //string checksum = Hash("93704aec1d3846b7" + "METROCRM02" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + rbtnPaymentMode.SelectedValue + "SALE" + "" + txtEmail.Text.Trim());
                    if (randomnumber != string.Empty)
                    {
                        #region Absec Payment Gateway
                        //Send Information in Hidden field to the Payment gateway            
                        Response.Clear();
                        StringBuilder sb = new StringBuilder();
                        sb.Append("<html>");
                        sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
                        sb.AppendFormat("<form name='form' action='{0}' method='post'>", strPaymentURL);
                        //WEB
                        sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", strTID);
                        // Mobile
                        //sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", "METROCRM02");
                        sb.AppendFormat("<input type='hidden' name='orderNo' value='{0}'>", reloadCheckoutData.order_no);
                        sb.AppendFormat("<input type='hidden' name='orderDescription' value='{0}'>", reloadCheckoutData.orderDescription);
                        sb.AppendFormat("<input type='hidden' name='currency' value='{0}'>", "MYR");
                        sb.AppendFormat("<input type='hidden' name='amount' value='{0}'>", totalAmount);
                        sb.AppendFormat("<input type='hidden' name='email' value='{0}'>", email);
                        sb.AppendFormat("<input type='hidden' name='method' value='{0}'>", PaymentType);
                        sb.AppendFormat("<input type='hidden' name='apiOperation' value='{0}'>", "SALE");
                        sb.AppendFormat("<input type='hidden' name='cardType' value='{0}'>", "");
                        sb.AppendFormat("<input type='hidden' name='checksum' value='{0}'>", checksum);
                        // Other params go here
                        sb.Append("</form>");
                        sb.Append("</body>");
                        sb.Append("</html>");
                        Response.Write(sb.ToString());
                        Response.End();




                        #endregion
                    }
                    #endregion
                }
                catch (Exception ex)
                {

                }
            }
            else
            {

            }
            #endregion
        }

        public void GetTransactionFees()
        {
            ServiceUrl = "Payment/GetTransactionFee";
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                card_no = Request.QueryString["Membership_no"].ToString().Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    transactionfee = Convert.ToDecimal(dtChargeType.Rows[0]["fee_amount"].ToString().Trim());
                    lbltransactionFee.Text = string.Format("{0:N2}", transactionfee);
                }
                else
                {
                    transactionfee = 0;
                    lbltransactionFee.Text = string.Format("{0:N2}", transactionfee);
                }
            }
            else
            {
                lbltransactionFee.Text = "0.00";
            }
        }
    }
}