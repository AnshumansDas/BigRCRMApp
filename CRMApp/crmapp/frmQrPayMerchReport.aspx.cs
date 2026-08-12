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
    public partial class frmQrPayMerchReport : System.Web.UI.Page
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
                BindMerchantOutletListReport();
                BindMerchantList();
            }
        }

        public void BindMerchantOutletListReport()
        {
            string dtStartDate = "", dtEndDate = "";
            if (!string.IsNullOrEmpty(txtQrPayDateRange.Text.Trim()))
            {
                string data = txtQrPayDateRange.Text.Trim();
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

            ServiceUrl = "Payment/GetMerchantOutletQRPayReport";
            var PVRptEntity = new crmEntity()
            {
                organization_name = ddlMerchName.SelectedValue.Trim(),
                FromDate = dtStartDate,
                ToDate = dtEndDate,
                transaction_status = ddlTransactionStatus.SelectedValue.Trim(),
                branch_name = ddlOutlet.SelectedValue.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var vQrPayMerOutlet = response.Content.ReadAsStringAsync().Result;
                var dtQrPayMerOutletList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(vQrPayMerOutlet);
                ViewState["VSQrPayMerchOutletList"] = dtQrPayMerOutletList;
                if (dtQrPayMerOutletList.Rows.Count > 0)
                {
                    lvMerchOutletReport.DataSource = dtQrPayMerOutletList;
                    lvMerchOutletReport.DataBind();
                    ExportGrdPromotionVoucher.DataSource = dtQrPayMerOutletList;
                    ExportGrdPromotionVoucher.DataBind();
                }
                else
                {
                    lvMerchOutletReport.DataSource = dtQrPayMerOutletList;
                    lvMerchOutletReport.DataBind();
                }
            }
        }

        public void BindMerchantList()
        {
            ServiceUrl = "CRM/BindMerchantList";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlMerchName.Items.Clear();
            ListItem item = new ListItem("-Select-", "");
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
            ListItem item = new ListItem("-Select-", "");
            ddlOutlet.Items.Insert(0, item);
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt16(strVal.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var City = response.Content.ReadAsStringAsync().Result;
                var dtCity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(City);
                if (dtCity.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtCity.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["branch_name"].ToString())))
                        {
                            ddlOutlet.Items.Add(new ListItem(dtRow["branch_name"].ToString(), dtRow["branch_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlMerchName.SelectedIndex = 0;
            ddlTransactionStatus.SelectedIndex = 0;
        }

        protected void ddlMerchName_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMerchantOutletList(ddlMerchName.SelectedValue.Trim());
        }

        protected void lnkExportExcel_Click(object sender, EventArgs e)
        {
            //Microsoft.Office.Interop.Excel.Application app = new Microsoft.Office.Interop.Excel.Application();
            //Workbook wb = app.Workbooks.Add(XlSheetType.xlWorksheet);
            //Worksheet ws = (Worksheet)app.ActiveSheet;
            //app.Visible = false;
            //ws.Cells[1, 1] = "transaction_date";
            //ws.Cells[1, 2] = "membership_no";
            //ws.Cells[1, 3] = "member_name";
            //ws.Cells[1, 4] = "organization_name";
            //ws.Cells[1, 5] = "branch_name";
            //ws.Cells[1, 6] = "transaction_id";
            //ws.Cells[1, 7] = "trans_amount";
            //ws.Cells[1, 8] = "transaction_status";
            //int i = 2;
            //foreach (ListViewItem item in lvMerchOutletReport.Items)
            //{
            //    ws.Cells[i,1]=item.
            //}
            ExportPromotiondataToExcel();
        }

        private void ExportPromotiondataToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "Merchant Outlet Report" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            ExportGrdPromotionVoucher.GridLines = GridLines.Both;
            ExportGrdPromotionVoucher.HeaderStyle.Font.Bold = true;
            ExportGrdPromotionVoucher.AllowSorting = false;
            ExportGrdPromotionVoucher.AllowPaging = false;
            ExportGrdPromotionVoucher.Columns[0].Visible = false;
            ExportGrdPromotionVoucher.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }

        //This is very important to excel upload time
        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;

        }

        protected void lnkPrintQrPayReport_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintPromotionVoucherList();", true);
        }

        protected void lvMerchOutletReport_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvMerchOutletReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMerchOutletReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantOutletListReport();
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindMerchantOutletListReport();
        }

        protected void lvMerchOutletReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                decimal totaltransamt = 0,totMdrCollAmt = 0,totMdrSetAmt =0;
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMerchOutletReport.FindControl("totalrecord");
                HtmlGenericControl totaltransactionAmount = (HtmlGenericControl)lvMerchOutletReport.FindControl("totaltransactionAmount");
                HtmlGenericControl totalMDRCollectionAmt = (HtmlGenericControl)lvMerchOutletReport.FindControl("totalMDRCollectionAmt");
                HtmlGenericControl totalMDRSettlmtAmt = (HtmlGenericControl)lvMerchOutletReport.FindControl("totalMDRSettlmtAmt");
                
                if (ViewState["VSQrPayMerchOutletList"] != null)
                {
                    dt = (DataTable)ViewState["VSQrPayMerchOutletList"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (dt.Rows[i]["trans_amount"].ToString() != "")
                        {
                            totaltransamt += Convert.ToDecimal(dt.Rows[i]["trans_amount"].ToString());
                        }
                        if (dt.Rows[i]["mdr_collection_amount"].ToString() != "")
                        {
                            totMdrCollAmt += Convert.ToDecimal(dt.Rows[i]["mdr_collection_amount"].ToString());
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
                totalMDRCollectionAmt.InnerText = totMdrCollAmt.ToString("###,###.00");
                totalMDRSettlmtAmt.InnerText = totMdrSetAmt.ToString("###,###.00");
            }

            if ((lvMerchOutletReport.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvMerchOutletReport.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvMerchOutletReport.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
    }
}