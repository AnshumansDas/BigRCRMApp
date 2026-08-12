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
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

namespace CRMApp.crmapp
{
    public partial class frmMerchantHelpdesk : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantList();
            }
        }

        public void BindMerchantList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/ListOfMerchantHelpdesk";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    Lv_Merchant.DataSource = dtChargeType;
                    Lv_Merchant.DataBind();
                    ExportGrdMerchanthelpdesc.DataSource = dtChargeType;
                    ExportGrdMerchanthelpdesc.DataBind();
                }
                else
                {
                    Lv_Merchant.DataSource = dtChargeType;
                    Lv_Merchant.DataBind();
                    ExportGrdMerchanthelpdesc.DataSource = dtChargeType;
                    ExportGrdMerchanthelpdesc.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void Lv_Merchant_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Merchant.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((Lv_Merchant.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_Merchant.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (Lv_Merchant.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void Lv_Merchant_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Merchant.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantList();
        }

        protected void Lv_Merchant_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem MerchantItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (MerchantItems != null)
                {
                    string MerchantCode = (string)Lv_Merchant.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                    string strEmailID = (string)Lv_Merchant.DataKeys[MerchantItems.DisplayIndex][1].ToString().Trim();
                    Response.Redirect("../frmResetPassword.aspx?m_code=" + MerchantCode.Trim() + "&meid=" + strEmailID.Trim());
                }
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchantList();
        }

        protected void lnkMerchantdescexport_click(object sender, EventArgs e)
        {
            ExportMerchantGridToExcel();
        }


        private void ExportMerchantGridToExcel()
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
            ExportGrdMerchanthelpdesc.GridLines = GridLines.Both;
            ExportGrdMerchanthelpdesc.HeaderStyle.Font.Bold = true;
            ExportGrdMerchanthelpdesc.AllowSorting = false;
            ExportGrdMerchanthelpdesc.AllowPaging = false;
            //ExportGrdMerchanthelpdesc.Columns[0].Visible = false;
            ExportGrdMerchanthelpdesc.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();

        }

        //This is very important to excel upload time
        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;

        }

        //click on print function
        protected void lnkMerchantdescPrint_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintMerchantHelpdesc();", true);

        }

        #region p
        protected void ExportToPDF(object sender, EventArgs e)
        {
            //DataTable dt = (DataTable)ViewState["dtcont"];
            ////Create a dummy GridView
            //GridView GridView1 = new GridView();
            //GridView1.AllowPaging = false;
            //GridView1.DataSource = dt;
            //GridView1.DataBind();

            //Response.ContentType = "application/pdf";
            //Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //StringWriter sw = new StringWriter();
            //HtmlTextWriter hw = new HtmlTextWriter(sw);
            //GridView1.RenderControl(hw);
            //StringReader sr = new StringReader(sw.ToString());
            //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            //pdfDoc.Open();
            //htmlparser.Parse(sr);
            //pdfDoc.Close();
            //Response.Write(pdfDoc);
            //Response.End();
        }
        #endregion
    }
}