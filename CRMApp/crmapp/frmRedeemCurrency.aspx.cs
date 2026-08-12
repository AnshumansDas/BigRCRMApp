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
using Newtonsoft.Json.Linq;
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmRedeemCurrency : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
               if(Session["username"] !=null)
                {
                    AvailablePoints();
                    Bindcurrencychart();
                    BindCurrencyType();
                    BindRedeemTransaction();
                }
                else
                {                    
                    Response.Redirect("Home.aspx");
                }
               
            }
        }

        protected void AvailablePoints()
        {
            ServiceUrl = "CRM/GetRewardpoints";           
            var entity = new crmEntity()
            {
                user_id = Convert.ToInt16(Session["user_id"].ToString())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, entity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    lblTotalPts.Text = dtChargeType.Rows[0]["Totalpoints"].ToString().Trim();
                    lblAvailablePts.Text= dtChargeType.Rows[0]["AvailablePoints"].ToString().Trim();
                }
                else
                {
                    TxtCoin.Text = "";
                }
            }
        }

        public void Bindcurrencychart()
        {          
            ServiceUrl = "CRM/GetcurrencyDisplaybyDate";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var RwdPtDetails = response.Content.ReadAsStringAsync().Result;
                var dtRwdPtDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RwdPtDetails);
                if (dtRwdPtDetails.Rows.Count > 0)
                {
                    Lv_Bindcurrencychart.DataSource = dtRwdPtDetails;
                    Lv_Bindcurrencychart.DataBind();
                }
                else
                {
                    Lv_Bindcurrencychart.DataSource = dtRwdPtDetails;
                    Lv_Bindcurrencychart.DataBind();
                }
            }
        }

        public void BindRedeemTransaction()
        {
           string strSendVal = string.Empty;
            ServiceUrl = "CRM/GetCurrencyTransactionsusers";           
            if (!string.IsNullOrEmpty(txtRetailSearch.Text))
            { strSendVal = txtRetailSearch.Text; }
            var entity = new crmEntity()
            {
                redeem_id = 0,
                search_param = strSendVal,
                user_id = Convert.ToInt16(Session["user_id"].ToString())
            };
           HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, entity).Result;
            if (response.IsSuccessStatusCode)
            {
                var RetailDetails = response.Content.ReadAsStringAsync().Result;
                var dtRetailDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RetailDetails);
                ViewState["dtcont"] = dtRetailDetails;
                if (dtRetailDetails.Rows.Count > 0)
                {
                    lsvRetail.DataSource = dtRetailDetails;
                    lsvRetail.DataBind();
                }
                else
                {
                    lsvRetail.DataSource = dtRetailDetails;
                    lsvRetail.DataBind();
                }
            }
        }

        public void BindCurrencyType()
        {
            ServiceUrl = "CRM/GetcurrencyDetails";
           HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlCurrency.Items.Clear();
            ListItem item = new ListItem();
           // ddlCurrency.Items.Insert(item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["currency_type"].ToString())))
                        {
                            ddlCurrency.Items.Add(new ListItem(dtRow["currency_type"].ToString(), dtRow["currency_type_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void ddlCurrency_SelectedIndexChanged(object sender, EventArgs e)
        {
         // message.InnerText = string.Empty;
        }

        protected void lsvRetail_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem TransactionItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "View")
            {
                if (TransactionItems != null)
                {
                    string redeem_id = lsvRetail.DataKeys[TransactionItems.DisplayIndex][0].ToString();
                    Response.Redirect("frmViewCurrencyTransaction.aspx?redeem_id=" + redeem_id);
                }
            }
        }

        protected void btnRetailSearch_Click(object sender, EventArgs e)
        {
            BindRedeemTransaction();
        }

        protected void txtRetailSearch_TextChanged(object sender, EventArgs e)
        {
            BindRedeemTransaction();
        }

        public void btnSave_Click(object sender,EventArgs e)
        {
            ServiceUrl = "CRM/CalculateCurrency";
            var entity = new crmEntity();
            entity = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                Point = Convert.ToDecimal(Txtpoint.Text.Trim()),
                currency_id = Convert.ToInt32(ddlCurrency.SelectedValue.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, entity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    TxtCoin.Text = dtChargeType.Rows[0]["coinvalue"].ToString().Trim();
                    lblerror.Text = dtChargeType.Rows[0]["returnval"].ToString().Trim();
                    lblerror.Style.Add("Color", "Red");
                    if (lblerror.Text == "")
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Popup", "alertforconfirm();", true);
                    }
                }
                else
                {
                    TxtCoin.Text = "";

                }
            }
          
        }
       
        public void btnCalculate_Click(object sender,EventArgs e)
        {
            ServiceUrl = "CRM/CalculateCurrency";
            var entity = new crmEntity();
            entity = new crmEntity()
            {
                userlogin_id=Convert.ToInt32(Session["userid"].ToString()),
                Point = Convert.ToDecimal(Txtpoint.Text.Trim()),
                currency_id =Convert.ToInt32(ddlCurrency.SelectedValue.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, entity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    TxtCoin.Text = dtChargeType.Rows[0]["coinvalue"].ToString().Trim();
                    lblerror.Text= dtChargeType.Rows[0]["returnval"].ToString().Trim();
                    lblerror.Style.Add("Color", "Red");
                }
                else
                {
                    TxtCoin.Text = "";

                }
            }
        }

        public void btnRedeem_Click(object sender, EventArgs e)
        {
           ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Popup", "alertforconfirmhide();", true);
            int redeem_val = 0;string remarkval = string.Empty;
            ServiceUrl = "CRM/SaveRedeemedValues";            
            var entity = new crmEntity();
            entity = new crmEntity()
            {
                
                userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                address1 = Convert.ToString(TxtReciveaddress.Text.Trim()),
                Point = Convert.ToDecimal(Txtpoint.Text.Trim()),
                currency_type_id = Convert.ToInt32(ddlCurrency.SelectedValue.Trim()),
                Amount = Convert.ToDecimal(TxtCoin.Text.Trim()),
                redeem_id = redeem_val,
                remarks= remarkval,
                StatusVal=0
            };           
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, entity).Result;
            if (response.IsSuccessStatusCode)
            {
               var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                   // Response.Redirect("~/crmapp/frmRedeemCurrency.aspx");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessReddemMsg();", true);
                    string readUserFile = string.Empty, myStringUser = string.Empty;
                    try
                    {                       
                        StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/crmcurrencytransactionstatus.html"));
                        readUserFile = readerUser.ReadToEnd();
                        myStringUser = readUserFile;
                        myStringUser = myStringUser.Replace("$$MemberName$$", dtChargeType.Rows[0]["membername"].ToString().Trim());
                        myStringUser = myStringUser.Replace("$$AdminName$$", "Admin");
                        string strEmailID = dtChargeType.Rows[0]["email"].ToString().Trim();                       
                        SendEmail(strEmailID.Trim(), "BigR - New Request for Crypto", myStringUser);
                        readerUser.Close();
                        readerUser.Dispose();
                    }
                    catch (Exception ex)
                    {
                       // message.InnerText = ex.Message.ToString();
                        return;
                    }
                }
                else
                {

                }
            }
        }
       
        protected void SendEmail(string to_sender, string subject, string strmessage)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient();
                string s = string.Empty;
                s = strFromEmail;
                mail.From = new MailAddress(s);
                mail.To.Add(to_sender);
                mail.Subject = subject;
                mail.Body = strmessage;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                //message.InnerText = ex.Message.ToString();
                return;
            }
        }

        public void btnRedeemCancel_Click(object sender,EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Popup", "alertforconfirmhide();", true);
        }

        protected void lsvRetail_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lsvRetail.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindRedeemTransaction();
        }

        protected void lsvRetail_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Approve")
                { colorstatus.Style.Add("color", "green");
                }
                else if (colorstatus.InnerText == "Reject")
                { colorstatus.Style.Add("color", "black");
                }
                else
                {
                    colorstatus.Style.Add("color", "red");
                }
                    HtmlGenericControl totalrecord = (HtmlGenericControl)lsvRetail.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }


        }
    }