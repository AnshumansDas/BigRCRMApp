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
    public partial class frmPromotionVoucherReport : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindPromotionVoucherListReport();
            }
        }

        protected void Lv_PrVoucherReport_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void Lv_PrVoucherReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_PrVoucherReport.FindControl("totalrecord");
                if (ViewState["VSPromotionVoucherList"] != null)
                {
                    DataTable dt = (DataTable)ViewState["VSPromotionVoucherList"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindPromotionVoucherListReport();
        }

        protected void Lv_PrVoucherReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_PrVoucherReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            //BindPromotionVoucherListReport();
            //ViewState["VSPromotionVoucherList"] = dtPromotionVoucherList;
            if (ViewState["VSPromotionVoucherList"] != null)
            {
                Lv_PrVoucherReport.DataSource = ViewState["VSPromotionVoucherList"];
                Lv_PrVoucherReport.DataBind();
                ExportGrdPromotionVoucher.DataSource = ViewState["VSPromotionVoucherList"];
                ExportGrdPromotionVoucher.DataBind();
                //totalrecord.InnerText = dtMemberListDetails.Rows.Count.ToString();
            }
            else
            {
                Lv_PrVoucherReport.DataSource = ViewState["VSPromotionVoucherList"];
                Lv_PrVoucherReport.DataBind();
            }
        }
        public void BindPromotionVoucherListReport()
        {
            string dtStartDate = "", dtEndDate = "";
            if (!string.IsNullOrEmpty(txtVoucherDateRange.Text.Trim()))
            {
                string data = txtVoucherDateRange.Text.Trim();
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
            { dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01";
            }

            ServiceUrl = "CRM/GetPromotionalVoucherReport";
            var PVRptEntity = new crmEntity()
            {
                //merchant_id = Convert.ToInt16(1),
                organization_name = txtMerchantName.Text.Trim(),
                FromDate = dtStartDate,
                ToDate = dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PVRptEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var PVListRptDetails = response.Content.ReadAsStringAsync().Result;
                var dtPromotionVoucherList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PVListRptDetails);
                ViewState["VSPromotionVoucherList"] = dtPromotionVoucherList;
                if (dtPromotionVoucherList.Rows.Count > 0)
                {
                    Lv_PrVoucherReport.DataSource = dtPromotionVoucherList;
                    Lv_PrVoucherReport.DataBind();
                    ExportGrdPromotionVoucher.DataSource = dtPromotionVoucherList;
                    ExportGrdPromotionVoucher.DataBind();
                    //totalrecord.InnerText = dtMemberListDetails.Rows.Count.ToString();
                }
                else
                {
                    Lv_PrVoucherReport.DataSource = dtPromotionVoucherList;
                    Lv_PrVoucherReport.DataBind();
                }
            }
        }

        protected void txtVoucherSearch_TextChanged(object sender, EventArgs e)
        {
            BindPromotionVoucherListReport();
        }


        // click on export to excel function
        protected void lnkexportpromotions_Click(object sender, EventArgs e)
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
            string FileName = "Report" + DateTime.Now + ".xls";
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

        //click on print function
        protected void lnkPrintpromotions_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintPromotionVoucherList();", true);

        }

    }
}