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


namespace CRMApp.crmapp
{
    public partial class rltSecuritySetting : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindSecurityReportDetails();
            }
        }
        protected void BindSecurityReportDetails()
        {
            string strSendVal = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetSecurityReportList";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            var crm = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var settingsType = response.Content.ReadAsStringAsync().Result;
                var dtsettingsType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(settingsType);
                ViewState["dtcount"] = dtsettingsType;
                if (dtsettingsType.Rows.Count > 0)
                {
                    Lv_security_report.DataSource = dtsettingsType;
                    Lv_security_report.DataBind();
                }
                else
                {
                    Lv_security_report.DataSource = dtsettingsType;
                    Lv_security_report.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        protected void Lv_security_report_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Active")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_security_report.FindControl("totalrecord");
                if (ViewState["dtcount"] != null)
                {
                    dt = (DataTable)ViewState["dtcount"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }          
        }
       
      
       protected void Lv_security_report_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
          (Lv_security_report.FindControl("DataPager2") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
          BindSecurityReportDetails();
        }


        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindSecurityReportDetails();
        }

    }
}