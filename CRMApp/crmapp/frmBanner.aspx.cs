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
    public partial class frmBanner : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        #region Control_Events
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindBannerCategoryCode();
                BindBannerListDetailsByCCCode();
            }
        }

        protected void LV_Banner_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Active")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }
                HtmlGenericControl totalrecord = (HtmlGenericControl)LV_Banner.FindControl("totalrecord");
                if (ViewState["dtBannerListDetails"] != null)
                {
                    DataTable dt = (DataTable)ViewState["dtBannerListDetails"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        protected void lnkAddNewBanner_Click(object sender, EventArgs e)
        {
            Response.Redirect("../crmapp/frmBannerAddEdit.aspx?ContentId=0", false);
        }

        protected void LV_Banner_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LV_Banner.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindBannerListDetailsByCCCode();
        }

        protected void ddlBannerCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBannerListDetailsByCCCode();
        }
        #endregion

        #region UserDefinedEvents
        public void BindBannerCategoryCode()
        {
            ServiceUrl = "CRM/GetBannerCategoryCode";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var banCatEntity = new crmEntity()
            {
            };
            HttpResponseMessage responsecat = client.PostAsJsonAsync(ServiceUrl, banCatEntity).Result;
            if (responsecat.IsSuccessStatusCode)
            {
                var BannerCategoryResult = responsecat.Content.ReadAsStringAsync().Result;
                var dtBannerCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(BannerCategoryResult);
                ddlBannerCat.Items.Clear();
                ListItem item = new ListItem("-Select Banner Category-", "0");
                ddlBannerCat.Items.Insert(0, item);

                if (dtBannerCategory.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtBannerCategory.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow[1].ToString())))
                        { ddlBannerCat.Items.Add(new ListItem(dtRow[2].ToString(), dtRow[0].ToString())); }
                    }
                }
            }
        }

        protected void LV_Banner_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem BannerItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (BannerItems != null)
                {
                    string ContentId = (string)LV_Banner.DataKeys[BannerItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmBannerAddEdit.aspx?ContentId=" + ContentId);
                }
            }
        }

        public void BindBannerListDetailsByCCCode()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetBannerDetailsByCategoryCode";
            var BannerListEntity = new crmEntity()
            {
                content_category_code = ddlBannerCat.SelectedValue
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, BannerListEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var BannerListDetails = response.Content.ReadAsStringAsync().Result;
                var dtBannerListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(BannerListDetails);
                ViewState["dtBannerListDetails"] = dtBannerListDetails;
                if (dtBannerListDetails.Rows.Count > 0)
                {
                    LV_Banner.DataSource = dtBannerListDetails;
                    LV_Banner.DataBind();
                }
                else if (dtBannerListDetails.Rows.Count == 0)
                {
                    LV_Banner.DataSource = dtBannerListDetails;
                    LV_Banner.DataBind();
                }
            }
        }
        #endregion
    }
}