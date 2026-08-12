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
    public partial class frmQrPayMerchNormalUserReport : System.Web.UI.Page
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
                { BindMerchantOutletListReport(); }
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

            ServiceUrl = "Payment/GetMerchantNormalUserQRPayReport";
            var PVRptEntity = new crmEntity()
            {
                FromDate = dtStartDate,
                ToDate = dtEndDate,
                transaction_status = ddlTransactionStatus.SelectedValue.Trim(),
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var PVListRptDetails = response.Content.ReadAsStringAsync().Result;
                var dtPromotionVoucherList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PVListRptDetails);
                ViewState["VSPromotionVoucherList"] = dtPromotionVoucherList;
                if (dtPromotionVoucherList.Rows.Count > 0)
                {
                    lvMerchOutletReport.DataSource = dtPromotionVoucherList;
                    lvMerchOutletReport.DataBind();
                    ExportGrdPromotionVoucher.DataSource = dtPromotionVoucherList;
                    ExportGrdPromotionVoucher.DataBind();
                }
                else
                {
                    lvMerchOutletReport.DataSource = dtPromotionVoucherList;
                    lvMerchOutletReport.DataBind();
                }
            }
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
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "SUCCESSFUL")
                {
                    colorstatus.Style.Add("color", "green");
                }
                else
                {
                    colorstatus.Style.Add("color", "red");
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMerchOutletReport.FindControl("totalrecord");
                if (ViewState["VSPromotionVoucherList"] != null)
                {
                    dt = (DataTable)ViewState["VSPromotionVoucherList"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
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

        protected void lnkExportExcel_Click(object sender, EventArgs e)
        {
            ExportPromotiondataToExcel();
        }

        private void ExportPromotiondataToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "QR pay User Report" + DateTime.Now + ".xls";
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlTransactionStatus.SelectedIndex = 0;
        }
    }
}