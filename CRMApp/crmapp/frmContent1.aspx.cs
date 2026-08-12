using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmContent1 : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindContentCategory();
                BindContent();
            }
        }

        public void BindContentCategory()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetContentCategory";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var ResResult = response.Content.ReadAsStringAsync().Result;
                var dtContentCategories = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                ddlContentCat.Items.Clear();
                ListItem item = new ListItem("ALL", "0");
                ddlContentCat.Items.Insert(0, item);

                if (dtContentCategories.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtContentCategories.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow[2].ToString())))
                        { ddlContentCat.Items.Add(new ListItem(dtRow[2].ToString(), dtRow[0].ToString())); }
                    }
                }
            }
        }

        public void BindContent()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetContentList";
            var crm = new crmEntity()
            {
                content_id = 0
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvContentList.DataSource = dtChargeType;
                    lvContentList.DataBind();
                }
                else
                {
                    lvContentList.DataSource = dtChargeType;
                    lvContentList.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }

        protected void lnkAddNewContent_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmContentAddEdit.aspx?cid=0");
        }

        protected void lvContentList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvContentList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

        }

        protected void lvContentList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

        }

        protected void ddlContentCat_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}