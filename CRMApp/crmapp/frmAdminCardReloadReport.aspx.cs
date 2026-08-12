using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;

namespace CRMApp.crmapp
{
    public partial class frmAdminCardReloadReport : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strTID = string.Empty, strAPIKey = string.Empty, strPaymentURL = string.Empty, email = string.Empty;
        #endregion

        #region Control_Events
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindCommunity();
                BindBigRCardList();
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindBigRCardList();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlCardStatus.SelectedValue = "0";
            ddlCardStatus.DataBind();
            ddlCommunity.SelectedValue = "0";
            ddlCommunity.DataBind();
        }

        protected void lnkExportExcel_Click(object sender, EventArgs e)
        {
            ExportReloadReportdataToExcel();
        }

        protected void lnkPrintReport_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintReloadReport();", true);
        }

        protected void lvCard_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvCard_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCard.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindBigRCardList();

        }

        protected void lvCard_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            HtmlGenericControl totalrecord = (HtmlGenericControl)lvCard.FindControl("totalrecord");
            if (ViewState["VS_CardHelpDesk"] != null)
            {
                dt = (DataTable)ViewState["VS_CardHelpDesk"];
                totalrecord.InnerText = dt.Rows.Count.ToString();
            }
            else
            { totalrecord.InnerText = "0"; }
        }
        #endregion

        #region  UD_Methods
        protected void BindCommunity()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityList";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    ddlCommunity.DataSource = dtCommunity;
                    ddlCommunity.DataBind();
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "0"));
                }
                else
                {
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "0"));
                }
            }
        }

        protected void BindBigRCardList()
        {
            message.InnerText = string.Empty;
            ServiceUrl = "CRM/GetCardHelpDesk";
            var ReloadCardEntity = new crmEntity()
            {
                community_id = Convert.ToInt16(ddlCommunity.SelectedValue.ToString()),
                card_status = ddlCardStatus.SelectedValue,
                search_param = string.IsNullOrEmpty(txtSearch.Text.Trim()) ? "" : txtSearch.Text.Trim()
            };
            HttpResponseMessage respReloadCard = client.PostAsJsonAsync(ServiceUrl, ReloadCardEntity).Result;
            if (respReloadCard.IsSuccessStatusCode)
            {
                var vReloadCardResult = respReloadCard.Content.ReadAsStringAsync().Result;
                var dtReloadCard = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(vReloadCardResult);
                ViewState["VS_CardHelpDesk"] = dtReloadCard;
                if (dtReloadCard.Rows.Count > 0)
                {
                    lvCard.DataSource = dtReloadCard;
                    lvCard.DataBind();
                    ExportGridview.DataSource = dtReloadCard;
                    ExportGridview.DataBind();
                }
                else
                {
                    lvCard.DataSource = dtReloadCard;
                    lvCard.DataBind();
                }
            }
            else
            {
                message.InnerText = respReloadCard.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        private void ExportReloadReportdataToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "ReloadReport_" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            ExportGridview.GridLines = GridLines.Both;
            ExportGridview.HeaderStyle.Font.Bold = true;
            ExportGridview.AllowSorting = false;
            ExportGridview.AllowPaging = false;
            //ExportGridview.Columns[0].Visible = false;
            ExportGridview.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;

        }
        #endregion
    }
}