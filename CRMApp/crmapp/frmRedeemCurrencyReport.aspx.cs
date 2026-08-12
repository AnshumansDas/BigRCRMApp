using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmRedeemCurrencyReport : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
         strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
         strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
         strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
         strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        #endregion
        //page_load function
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindTransactionList();
            }

        }

        //Binding Data to Listview 
        public void BindTransactionList()
        {
            string dtStartDate = "", dtEndDate = "", strSendVal = string.Empty;
            if (!string.IsNullOrEmpty(txtTransactionDateRange.Text.Trim()))
            {
                string data = txtTransactionDateRange.Text.Trim();
                string[] dates = data.Split('-');
                if (!string.IsNullOrEmpty(dates[0].ToString().Trim()))
                {
                    dtStartDate = dates[0].ToString().Trim();
                    string[] starttokens = dtStartDate.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                else { dtStartDate = "1900-01-01"; }

                if (!string.IsNullOrEmpty(dates[1].ToString().Trim()))
                {
                    dtEndDate = dates[1].ToString().Trim();
                    string[] endtokens = dtEndDate.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                else { dtEndDate = "1900-01-01"; }
            }
            else
            {
                dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01";
            }
            if (!string.IsNullOrEmpty(txtTransactionsearch.Text))
            { strSendVal = txtTransactionsearch.Text; }
            ServiceUrl = "CRM/GetCurrencyTransactionsAdminReport";
            var PVRptEntity = new crmEntity()
            {
                //merchant_id = Convert.ToInt16(1),
                redeem_id = 0,
                search_param = strSendVal,
                FromDate = dtStartDate,
                ToDate = dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var RedeemRptDetails = response.Content.ReadAsStringAsync().Result;
                var RedeemReportlist = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RedeemRptDetails);
                ViewState["RedeemCurrencyReportlist"] = RedeemReportlist;
                if (RedeemReportlist.Rows.Count > 0)
                {
                    Lv_Transaction.DataSource = RedeemReportlist;
                    Lv_Transaction.DataBind();
                }
                else
                {
                    Lv_Transaction.DataSource = RedeemReportlist;
                    Lv_Transaction.DataBind();
                }
            }
        }

        // click on Transaction Action button with status 
        protected void Lv_Transaction_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            btnSave.Enabled = true;
            ddlstatus.Enabled = true;
            TxtRemarks.Enabled = true;
            ListViewDataItem TransactionItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Approved")
            {
                if (TransactionItems != null)
                {
                    string redeem_id = Lv_Transaction.DataKeys[TransactionItems.DisplayIndex][0].ToString();
                    popupmethod(redeem_id);
                    blockEnabled();
                }
            }
            if (e.CommandName == "Reject")
            {
                if (TransactionItems != null)
                {
                    string redeem_id = Lv_Transaction.DataKeys[TransactionItems.DisplayIndex][0].ToString();
                    popupmethod(redeem_id);
                    blockEnabled();
                }
            }
            if (e.CommandName == "Pending")
            {
                if (TransactionItems != null)
                {
                    string redeem_id = Lv_Transaction.DataKeys[TransactionItems.DisplayIndex][0].ToString();
                    popupmethod(redeem_id);

                }
            }
        }

        //calling this method from Itemcommand with redeem_id and commandname
        public void popupmethod(string redeemid)
        {
            string dtStartDate = "", dtEndDate = "", strSendVal = string.Empty;
            dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01";
            if (!string.IsNullOrEmpty(txtTransactionsearch.Text))
            { strSendVal = txtTransactionsearch.Text; }
            ServiceUrl = "CRM/GetCurrencyTransactionsAdminReport";
            var PVRptEntity = new crmEntity()
            {
                redeem_id = Convert.ToInt32(redeemid),
                search_param = strSendVal,
                FromDate = dtStartDate,
                ToDate = dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var RedeemReportlist = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (RedeemReportlist.Rows.Count > 0)
                {
                    ddlstatus.Enabled = true;
                    ddlstatus.SelectedValue = RedeemReportlist.Rows[0]["valofstatus"].ToString().Trim();
                    txtCoin.Text = RedeemReportlist.Rows[0]["amount"].ToString().Trim();
                    TxtcurrencyType.Text = RedeemReportlist.Rows[0]["currency_type"].ToString().Trim();
                    TxtEmail.Text = RedeemReportlist.Rows[0]["email_id"].ToString().Trim();
                    TxtPhone.Text = RedeemReportlist.Rows[0]["mobile_no"].ToString().Trim();
                    txtPoint.Text = RedeemReportlist.Rows[0]["redeem_points"].ToString().Trim();
                    TxtReceiveAddress.Text = RedeemReportlist.Rows[0]["Receive_address"].ToString().Trim();
                    TxtRemarks.Text = RedeemReportlist.Rows[0]["remarks"].ToString().Trim();
                    TxtName.Text = RedeemReportlist.Rows[0]["created_by"].ToString().Trim();
                    TxtRedeemid.Text = RedeemReportlist.Rows[0]["redeem_id"].ToString().Trim();
                    disable();
                }
                else
                {
                    message.InnerText = "";
                }
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "ShowStatuspopup();", true);

            }
        }

        //save button,status,remarks will disabled after Reject or Accept
        public void blockEnabled()
        {
            btnSave.Enabled = false;
            ddlstatus.Enabled = false;
            TxtRemarks.Enabled = false;
        }

        //popup all details disabled status
        public void disable()
        {
            txtCoin.Enabled = false;
            TxtcurrencyType.Enabled = false;
            TxtEmail.Enabled = false;
            TxtName.Enabled = false;
            TxtPhone.Enabled = false;
            txtPoint.Enabled = false;
            TxtReceiveAddress.Enabled = false;
        }

        //ItemDatabound method for pagination and status colour
        protected void Lv_Transaction_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                LinkButton lnkbutton = (LinkButton)e.Item.FindControl("lnkEdit");
                if (lnkbutton.CommandName == "Approved")
                {
                    lnkbutton.Style.Add("color", "white");
                    lnkbutton.Style.Add("background", "green");
                }
                else if (lnkbutton.CommandName == "Reject")
                {
                    lnkbutton.Style.Add("color", "white");
                    lnkbutton.Style.Add("background", "black");
                }
                else
                {
                    lnkbutton.Style.Add("color", "white");
                    lnkbutton.Style.Add("background", "red");
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Transaction.FindControl("totalrecord");
                if (ViewState["RedeemCurrencyReportlist"] != null)
                {
                    DataTable dt = (DataTable)ViewState["RedeemCurrencyReportlist"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        //search button click operation for search
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindTransactionList();
        }

        //search transaction 
        protected void txtTransactionsearch_TextChanged(object sender, EventArgs e)
        {
            BindTransactionList();
        }

        //pagination code
        protected void Lv_Transaction_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Transaction.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            //BindTransactionList();
            if (ViewState["RedeemCurrencyReportlist"] != null)
            {
                Lv_Transaction.DataSource = ViewState["RedeemCurrencyReportlist"];
                Lv_Transaction.DataBind();
            }
        }

        //save button click operation
        protected void btnsave_click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "HideStatuspopup();", true);
            int userloginid = Convert.ToInt32(Session["userid"].ToString());
            ServiceUrl = "CRM/SaveRedeemedValues";
            var PVRptEntity = new crmEntity()
            {
                redeem_id = Convert.ToInt32(TxtRedeemid.Text),
                address1 = TxtReceiveAddress.Text,
                currency_type = TxtcurrencyType.Text,
                Point = Convert.ToDecimal(txtPoint.Text),
                Amount = Convert.ToDecimal(txtCoin.Text),
                userlogin_id = userloginid,
                remarks = TxtRemarks.Text,
                StatusVal = Convert.ToInt32(ddlstatus.SelectedValue.Trim())
            };           
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessReddemReportMsg();", true);
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var RedeemReportlist = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (RedeemReportlist.Rows.Count > 0)
                {                   
                    string readUserFile = string.Empty, myStringUser = string.Empty;
                    try
                    {
                        StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/crmcurrencytransactionstatustouser.html"));
                        readUserFile = readerUser.ReadToEnd();
                        myStringUser = readUserFile;
                        myStringUser = myStringUser.Replace("$$MemberName$$", RedeemReportlist.Rows[0]["membername"].ToString().Trim());
                        myStringUser = myStringUser.Replace("$$status$$", RedeemReportlist.Rows[0]["status"].ToString().Trim());
                        string strEmailID = RedeemReportlist.Rows[0]["email"].ToString().Trim();
                        SendEmail(strEmailID.Trim(), "BigR - Status for Your Transaction", myStringUser);
                        readerUser.Close();
                        readerUser.Dispose();
                    }
                    catch (Exception ex)
                    {
                        message.InnerText = ex.Message.ToString();
                        return;
                    }
                }
                else
                {
                    message.InnerText = "";
                }                

            }
        }

        //sent email code
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

    }
}