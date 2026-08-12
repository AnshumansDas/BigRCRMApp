using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmMerchandiseList : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        string dtStartDate = "", dtEndDate = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchandiseList();
            }
        }

        public void BindMerchandiseList()
        {
            string strSendVal = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListOfMerchandise";
            if (txtStartDate.Text.Trim() != "")
            {
                string[] starttokens = txtStartDate.Text.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            }
            //string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            if (txtEndDate.Text.Trim() != "")
            {
                string[] endtokens = txtEndDate.Text.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            }
            if (!string.IsNullOrEmpty(txtMerchandiseName.Text))
            { strSendVal = txtMerchandiseName.Text; }

            var crm = new crmEntity()
            {
                search_param = strSendVal,
                start_date= dtStartDate,
                end_date=dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var merchandise = response.Content.ReadAsStringAsync().Result;
                var dtmerchandise = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(merchandise);
                ViewState["dtcont"] = dtmerchandise;
                if (dtmerchandise.Rows.Count > 0)
                {
                    lvMerchandiseList.DataSource = dtmerchandise;
                    lvMerchandiseList.DataBind();
                }
                else
                {
                    lvMerchandiseList.DataSource = dtmerchandise;
                    lvMerchandiseList.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnAddMerchandise_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAddEditMerchandise.aspx?merchandise_id=0");
        }

        protected void lvMerchandiseList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem merchandiseItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (merchandiseItems != null)
                {
                    int merchandiseId = int.Parse(lvMerchandiseList.DataKeys[merchandiseItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmAddEditMerchandise.aspx?merchandise_id=" + merchandiseId);
                }
            }
        }

        protected void lvMerchandiseList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

        }

        protected void lvMerchandiseList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMerchandiseList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchandiseList();
        }
    }
}