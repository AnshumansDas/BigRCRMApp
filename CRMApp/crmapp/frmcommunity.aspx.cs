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
    public partial class frmcommunity : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindCommunityList();
            }
        }

        public void BindCommunityList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/BindCommunityDetails";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                communityparams = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);
                ViewState["dtcont"] = dtCommunity;
                if (dtCommunity.Rows.Count > 0)
                {
                    Lv_Community.DataSource = dtCommunity;
                    Lv_Community.DataBind();
                }
                else
                {
                    Lv_Community.DataSource = dtCommunity;
                    Lv_Community.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void Lv_Community_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl activestatus = (HtmlGenericControl)e.Item.FindControl("activestatus");
                if (activestatus.InnerText == "Active")
                { activestatus.Style.Add("color", "green"); }
                else
                { activestatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_Community.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((Lv_Community.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_Community.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (Lv_Community.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void Lv_Community_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        protected void Lv_Community_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_Community.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindCommunityList();
        }

        protected void Lv_Community_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem CommunityItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (CommunityItems != null)
                {
                    string Commmunity_det_id = (string)Lv_Community.DataKeys[CommunityItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmCommunityAddEdit.aspx?c_det_id=" + Commmunity_det_id);
                }
            }
        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmCommunityAddEdit.aspx");
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindCommunityList();
        }
    }
}