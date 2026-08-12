using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmSSTReport : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        #region ControlEvents
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindSSTReportList();
            }
        }

        protected void lvSSTReport_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvSSTReport.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindSSTReportList();
        }

        protected void lvSSTReport_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            HtmlGenericControl totalrecord = (HtmlGenericControl)lvSSTReport.FindControl("totalrecord");
            if (ViewState["VS_SSTReport"] != null)
            {
                DataTable dt = (DataTable)ViewState["VS_SSTReport"];
                totalrecord.InnerText = dt.Rows.Count.ToString();
            }
            else
            { totalrecord.InnerText = "0"; }
        }


        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindSSTReportList();
        }

        public void BindSSTReportList()
        {
            message.InnerText = string.Empty;
            ServiceUrl = "CRM/GetSSTReport";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
            string date = txtDateRange.Text.Trim();
            if (date != "")
            {
                string[] dates = date.Split('-');
                startdate = dates[0].ToString().Trim();
                enddate = dates[1].ToString().Trim();
            }
            if (startdate != "")
            {
                string[] starttokens = startdate.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            }
            else
            {
                dtStartDate = "1900-01-01";
            }
            if (enddate != "")
            {
                string[] endtokens = enddate.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            }
            else
            {
                dtEndDate = "1900-01-01";
            }
            var SSTReportEntity = new crmEntity()
            {
                FromDate = dtStartDate,
                ToDate = dtEndDate
            };
            HttpResponseMessage responseSSTReport = client.PostAsJsonAsync(ServiceUrl, SSTReportEntity).Result;
            if (responseSSTReport.IsSuccessStatusCode)
            {
                var SSTReportResult = responseSSTReport.Content.ReadAsStringAsync().Result;
                var dtSSTReport = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(SSTReportResult);
                ViewState["VS_SSTReport"] = dtSSTReport;
                if (dtSSTReport.Rows.Count > 0)
                {
                    lvSSTReport.DataSource = dtSSTReport;
                    lvSSTReport.DataBind();
                }
                else
                {
                    lvSSTReport.DataSource = dtSSTReport;
                    lvSSTReport.DataBind();
                }
            }
            else
            {
                message.InnerText = responseSSTReport.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        #endregion
    }
}