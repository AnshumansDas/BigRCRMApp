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
    public partial class frmNotification : System.Web.UI.Page
    {

        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindNotificationList();
            }
        }

        protected void BindNotificationList()
        {
            string strSendVal = string.Empty;
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetemailblastingList";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            var crm = new crmEntity()
            {
                role_id = Convert.ToInt32(Session["roleid"].ToString().Trim()),
                notification_id = 0,
                id=9,
                search_param= strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcount"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    Lv_Notification.DataSource = dtChargeType;
                    Lv_Notification.DataBind();
                    DataTable dt = new DataTable();
                    HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Notification.FindControl("totalrecord");
                    if (ViewState["dtcont"] != null)
                    {
                        dt = (DataTable)ViewState["dtcont"];
                        totalrecord.InnerText = dt.Rows.Count.ToString();
                    }
                    else
                    { totalrecord.InnerText = "0"; }
                    totalrecord.InnerText = dtChargeType.Rows.Count.ToString();
                }
                else
                {
                    Lv_Notification.DataSource = dtChargeType;
                    Lv_Notification.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {

            Response.Redirect("frmNotificationAddEdit.aspx?id=''", false);
        }

        protected void Lv_Notification_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            ListViewDataItem EmailItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "View")
            {
                if (EmailItems != null)
                {
                    string id = (string)Lv_Notification.DataKeys[EmailItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmViewNotification.aspx?id=" + id);
                }
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindNotificationList();
        }

        protected void Lv_Notification_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Notification.FindControl("DataPager2") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindNotificationList();
        }

    }
}
