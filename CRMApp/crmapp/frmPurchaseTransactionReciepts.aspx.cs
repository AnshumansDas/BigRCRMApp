using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmPurchaseTransactionReciepts : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["order_no"] != null)
                {
                    string orderNo = Request.QueryString["order_no"].ToString().Trim();
                    BindOrderDetails(orderNo);
                    BindTransactionSummary(orderNo);
                }
            }
        }

        protected void BindOrderDetails(string Order_no)
        {
            try
            {
                ServiceUrl = "CRM/GetOrderDetails";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var wish = new crmEntity()
                {
                    order_no = Order_no
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, wish).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var OrderLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    ViewState["dtcont"] = OrderLists;
                    if (OrderLists.Rows.Count > 0)
                    {
                        decimal grandsubtotal = 0, grandtotal = 0, taxamount;
                        lsvTransSummary.DataSource = OrderLists;
                        lsvTransSummary.DataBind();
                        for (int i = 0; i < OrderLists.Rows.Count; i++)
                        {
                            //decimal subtotal = Convert.ToDecimal(OrderLists.Rows[i]["total_amount"].ToString());
                            decimal subtotal = Convert.ToDecimal(OrderLists.Rows[i]["discount_price"].ToString());
                            grandsubtotal = grandsubtotal + subtotal;
                        }
                        decimal tax = Convert.ToDecimal(OrderLists.Rows[0]["total_tax_amount"].ToString());
                        lblSubTotal.Text = grandsubtotal.ToString("N2").Trim();
                        lblTaxAmount.Text = tax.ToString("N2");
                        taxamount = Convert.ToDecimal(OrderLists.Rows[0]["total_tax_amount"].ToString());
                        grandtotal = grandsubtotal + taxamount;
                        lblGrandTotal.Text = grandtotal.ToString("N2").Trim();
                    }
                }
            }
            catch (Exception ex)
            {
                //message.InnerText = ex.Message.ToString();
                return;
            }
        }


        protected void BindTransactionSummary(string Order_no)
        {
            try
            {
                ServiceUrl = "CRM/GetTransactionSummaryDetails";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var wish = new crmEntity()
                {
                    order_no = Order_no
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, wish).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var TransLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    ViewState["dtcont"] = TransLists;
                    if (TransLists.Rows.Count > 0)
                    {
                        lblName.Text = TransLists.Rows[0]["user_fistname"].ToString().Trim();
                        lblTransactionNo.Text = TransLists.Rows[0]["transaction_id"].ToString().Trim();
                        lblPaymentMode.Text = TransLists.Rows[0]["payment_mode"].ToString().Trim();
                        lblEmail.Text = TransLists.Rows[0]["email_id"].ToString().Trim();
                        lblTransactionAmount.Text = TransLists.Rows[0]["trans_amount"].ToString().Trim();
                        lblPaymentSTatus.Text = TransLists.Rows[0]["transaction_status"].ToString().Trim();
                        lblPhone.Text = TransLists.Rows[0]["mobile_no"].ToString().Trim();
                        lblTransactionDate.Text = TransLists.Rows[0]["transaction_time"].ToString().Trim();
                        lblOrderNo.Text = TransLists.Rows[0]["order_no"].ToString().Trim();

                        lbladress1.Text = TransLists.Rows[0]["address1"].ToString().Trim();
                        lbladdress2.Text = TransLists.Rows[0]["address2"].ToString().Trim();
                        lblcity.Text = TransLists.Rows[0]["city_name"].ToString().Trim();
                        lblPostcode.Text = TransLists.Rows[0]["postcode"].ToString().Trim();
                        lblCountry.Text = TransLists.Rows[0]["country_name"].ToString().Trim();
                        lblState.Text = TransLists.Rows[0]["state_name"].ToString().Trim();
                        lblphoneno.Text = TransLists.Rows[0]["mobile_no"].ToString().Trim();
                        //lblName.Text = TransLists.Rows[0][""].ToString().Trim();
                    }
                }
            }
            catch (Exception ex)
            {
                //message.InnerText = ex.Message.ToString();
                return;
            }
        }
    }
}