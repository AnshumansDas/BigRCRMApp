using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace CRMApp.crmapp
{
    public partial class frmDirectPurchaseReport : System.Web.UI.Page
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
                if (Session["userid"] != null)
                {
                    BindMerchantList();
                    BindDirectPurchaseReport();
                    if (Session["roleid"].ToString() == "5")
                    {
                        ddlMerchName.SelectedValue = Session["merchant_id"].ToString();
                        ddlMerchName.DataBind();
                        ddlMerchName.Enabled = false;
                        ddlMerchName_SelectedIndexChanged(this, null);
                    }
                }
            }
        }

        protected void ddlMerchName_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMerchantOutletList(ddlMerchName.SelectedValue.Trim());
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindDirectPurchaseReport();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {

        }

        protected void lnkExportExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "QRPay_Merchant_Report_" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            GVDirectPurRpt.GridLines = GridLines.Both;
            GVDirectPurRpt.HeaderStyle.Font.Bold = true;
            GVDirectPurRpt.AllowSorting = false;
            GVDirectPurRpt.AllowPaging = false;
            GVDirectPurRpt.Columns[0].Visible = false;
            GVDirectPurRpt.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }

        protected void lnkPrintQrPayReport_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintDirectPurchaseReportList();", true);
        }

        protected void lvDirectPurchReport_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvDirectPurchReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvDirectPurchReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindDirectPurchaseReport();
        }

        protected void lvDirectPurchReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            DataTable dt = new DataTable();
            decimal totaltransamt = 0, totMdrSetAmt = 0;

            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "SUCCESSFUL")
                {
                    colorstatus.Style.Add("color", "green");
                }
                else
                {
                    colorstatus.Style.Add("color", "red");
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvDirectPurchReport.FindControl("totalrecord");
                HtmlGenericControl totaltransactionAmount = (HtmlGenericControl)lvDirectPurchReport.FindControl("totaltransactionAmount");
                HtmlGenericControl totalMDRSettlmtAmt = (HtmlGenericControl)lvDirectPurchReport.FindControl("totalMDRSettlmtAmt");
                if (ViewState["VSDirectPurchaseReportList"] != null)
                {
                    dt = (DataTable)ViewState["VSDirectPurchaseReportList"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (dt.Rows[i]["trans_amount"].ToString() != "")
                        {
                            totaltransamt += Convert.ToDecimal(dt.Rows[i]["trans_amount"].ToString());
                        }
                        if (dt.Rows[i]["mdr_settlement_amount"].ToString() != "")
                        {
                            totMdrSetAmt += Convert.ToDecimal(dt.Rows[i]["mdr_settlement_amount"].ToString());
                        }
                    }
                }
                else
                { totalrecord.InnerText = "0"; }
                totaltransactionAmount.InnerText = totaltransamt.ToString("###,###.00");
                totalMDRSettlmtAmt.InnerText = totMdrSetAmt.ToString("###,###.00");
            }

            if ((lvDirectPurchReport.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvDirectPurchReport.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvDirectPurchReport.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        public void BindDirectPurchaseReport()
        {
            string dtStartDate = "", dtEndDate = "";
            message.InnerText = string.Empty;
            ViewState["VSDirectPurchaseReportList"] = null;
            int userid = 0, merchantid = 0, outletid = 0;
            try
            {
                if (Session["roleid"].ToString() == "3")//Business Admin
                {
                    userid = 0;
                    merchantid = 0;
                    if (ddlMerchName.SelectedValue != "0")
                        merchantid = Convert.ToInt16(ddlMerchName.SelectedValue);
                    if (ddlOutlet.SelectedValue != "")
                        outletid = Convert.ToInt16(ddlOutlet.SelectedValue);
                }
                else if (Session["roleid"].ToString() == "2") //User
                {
                    userid = Convert.ToInt16(Session["user_id"].ToString());
                    merchantid = 0;
                }
                else if (Session["roleid"].ToString() == "5") // Merchant Admin
                {
                    userid = 0;
                    merchantid = Convert.ToInt16(Session["merchant_id"].ToString());
                    if (merchantid != 0)
                    {
                        if (ddlMerchName.SelectedValue != "0")
                            merchantid = Convert.ToInt16(ddlMerchName.SelectedValue);
                        if (ddlOutlet.SelectedValue != "")
                            outletid = Convert.ToInt16(ddlOutlet.SelectedValue);
                    }
                }
                if (!string.IsNullOrEmpty(txtDirectPurchDateRange.Text.Trim()))
                {
                    string data = txtDirectPurchDateRange.Text.Trim();
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
                    DateTime dtstart = DateTime.Now;
                    DateTime dtend = DateTime.Now;
                    dtStartDate = dtstart.ToString("yyyy-MM-dd");
                    dtEndDate = dtend.ToString("yyyy-MM-dd");
                    //dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01";
                }

                ServiceUrl = "Payment/GetDirectPurchaseReport";
                var DirPurRptEntity = new crmEntity()
                {
                    FromDate = dtStartDate,
                    ToDate = dtEndDate,
                    transaction_status = ddlTransactionStatus.SelectedValue.Trim(),
                    user_id = userid,
                    merchant_id = merchantid,
                    branch_id = outletid
                };
                HttpResponseMessage respDirPurcRpt = client.PostAsJsonAsync(ServiceUrl, DirPurRptEntity).Result;
                if (respDirPurcRpt.IsSuccessStatusCode)
                {
                    var DirPurchRptList = respDirPurcRpt.Content.ReadAsStringAsync().Result;
                    var dtDirPurchRptList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(DirPurchRptList);
                    ViewState["VSDirectPurchaseReportList"] = dtDirPurchRptList;
                    if (dtDirPurchRptList.Rows.Count > 0)
                    {
                        lvDirectPurchReport.DataSource = dtDirPurchRptList;
                        lvDirectPurchReport.DataBind();
                        GVDirectPurRpt.DataSource = dtDirPurchRptList;
                        GVDirectPurRpt.DataBind();
                    }
                    else
                    {
                        lvDirectPurchReport.DataSource = dtDirPurchRptList;
                        lvDirectPurchReport.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }

        public void BindMerchantList()
        {
            ServiceUrl = "CRM/BindMerchantList";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlMerchName.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlMerchName.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["organization_name"].ToString())))
                        {
                            ddlMerchName.Items.Add(new ListItem(dtRow["organization_name"].ToString(), dtRow["merchant_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindMerchantOutletList(string strVal)
        {
            ServiceUrl = "CRM/GetVoucherOutlet";
            ddlOutlet.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlOutlet.Items.Insert(0, item);
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt16(strVal.Trim())
            };
            HttpResponseMessage respOutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (respOutlet.IsSuccessStatusCode)
            {
                var vOutlet = respOutlet.Content.ReadAsStringAsync().Result;
                var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(vOutlet);
                if (dtOutlet.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtOutlet.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["branch_name"].ToString())))
                        {
                            ddlOutlet.Items.Add(new ListItem(dtRow["branch_name"].ToString(), dtRow["branch_id"].ToString()));
                        }
                    }
                }
            }
        }

        //This is very important to excel upload time
        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;
        }
    }
}