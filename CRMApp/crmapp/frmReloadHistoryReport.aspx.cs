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
    public partial class frmReloadHistoryReport : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        #endregion

        #region PageEvent_Methods
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindReloadHistoryReport();
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindReloadHistoryReport();
        }

        protected void LBExportReloadHist_Click(object sender, EventArgs e)
        {
            ExportReloadRptdataToExcel();
        }

        protected void LbPrintReloadHist_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintReloadHistoryRptList();", true);

        }

        protected void Lv_ReloadHistoryReport_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void Lv_ReloadHistoryReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_ReloadHistoryReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            if (ViewState["VSReloadRptList"] != null)
            {
                Lv_ReloadHistoryReport.DataSource = ViewState["VSReloadRptList"];
                Lv_ReloadHistoryReport.DataBind();
                GVReloadHistory.DataSource = ViewState["VSReloadRptList"];
                GVReloadHistory.DataBind();
            }
            else
            {
                Lv_ReloadHistoryReport.DataSource = ViewState["VSReloadRptList"];
                Lv_ReloadHistoryReport.DataBind();
            }
        }

        protected void Lv_ReloadHistoryReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            decimal totaltransamt = 0;
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_ReloadHistoryReport.FindControl("totalrecord");
                HtmlGenericControl totaltransactionAmount = (HtmlGenericControl)Lv_ReloadHistoryReport.FindControl("totaltransactionAmount");
                if (ViewState["VSReloadRptList"] != null)
                {
                    DataTable dt = (DataTable)ViewState["VSReloadRptList"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (dt.Rows[i]["TRANSACTION_AMOUNT"].ToString() != "")
                        {
                            totaltransamt += Convert.ToDecimal(dt.Rows[i]["TRANSACTION_AMOUNT"].ToString());
                        }
                    }
                }
                else
                { totalrecord.InnerText = "0"; }
                totaltransactionAmount.InnerText = totaltransamt.ToString("###,###.00");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            TxtSearchBy.Text = "";
        }
        #endregion

        #region UD_Methods
        public void BindReloadHistoryReport()
        {
            try
            {
                string dtStartDate = "", dtEndDate = "";
                if (!string.IsNullOrEmpty(txtReloadHistoryDateRange.Text.Trim()))
                {
                    string data = txtReloadHistoryDateRange.Text.Trim();
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

                ServiceUrl = "Payment/GetReloadHistorySummaryReport";
                var reloadRptEntity = new crmEntity()
                {
                    FromDate = dtStartDate,
                    ToDate = dtEndDate,
                    search_param = TxtSearchBy.Text.Trim()
                };
                HttpResponseMessage respreloadRpt = client.PostAsJsonAsync(ServiceUrl, reloadRptEntity).Result;
                if (respreloadRpt.IsSuccessStatusCode)
                {
                    var ReloadListRptDetails = respreloadRpt.Content.ReadAsStringAsync().Result;
                    var dtReloadRptList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ReloadListRptDetails);
                    ViewState["VSReloadRptList"] = dtReloadRptList;
                    if (dtReloadRptList.Rows.Count > 0)
                    {
                        Lv_ReloadHistoryReport.DataSource = dtReloadRptList;
                        Lv_ReloadHistoryReport.DataBind();
                        GVReloadHistory.DataSource = dtReloadRptList;
                        GVReloadHistory.DataBind();
                    }
                    else
                    {
                        Lv_ReloadHistoryReport.DataSource = dtReloadRptList;
                        Lv_ReloadHistoryReport.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
            }
        }

        private void ExportReloadRptdataToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "ReloadHistoryReport" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            GVReloadHistory.GridLines = GridLines.Both;
            GVReloadHistory.HeaderStyle.Font.Bold = true;
            GVReloadHistory.AllowSorting = false;
            GVReloadHistory.AllowPaging = false;
            GVReloadHistory.Columns[0].Visible = false;
            GVReloadHistory.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();

        }

        //This is very important to excel upload time
        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;

        }
        #endregion

    }
}