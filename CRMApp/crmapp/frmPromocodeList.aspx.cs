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
    public partial class frmPromocodeList : System.Web.UI.Page
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
                BindPromoCodeDetailsList();
            }
        }

        protected void LV_PromocodeList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem PromoCdItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (PromoCdItems != null)
                {
                    string PromocodeId = (string)LV_PromocodeList.DataKeys[PromoCdItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmPromocodeAddEdit.aspx?Promocode_Id=" + PromocodeId);
                }
            }
        }

        protected void LV_PromocodeList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LV_PromocodeList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindPromoCodeDetailsList();
        }

        protected void LV_PromocodeList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            HtmlGenericControl totalrecord = (HtmlGenericControl)LV_PromocodeList.FindControl("totalrecord");
            if (ViewState["VSPromocodeList"] != null)
            {
                dt = (DataTable)ViewState["VSPromocodeList"];
                totalrecord.InnerText = dt.Rows.Count.ToString();
            }
            else
            { totalrecord.InnerText = "0"; }
        }

        protected void lnkAddNewPromoCode_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmPromocodeAddEdit.aspx?Promocode_Id=0", false);
        }

        protected void TxtSearchKey_TextChanged(object sender, EventArgs e)
        {
            BindPromoCodeDetailsList();
        }

        public void BindPromoCodeDetailsList()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetPromocodeDetailsList";
            var PromoCodeListEntity = new crmEntity()
            {
                search_key = TxtSearchKey.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, PromoCodeListEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var PromocodeListDetails = response.Content.ReadAsStringAsync().Result;
                var dtPromocodeListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PromocodeListDetails);
                ViewState["VSPromocodeList"] = dtPromocodeListDetails;
                if (dtPromocodeListDetails.Rows.Count > 0)
                {
                    LV_PromocodeList.DataSource = dtPromocodeListDetails;
                    LV_PromocodeList.DataBind();
                }
                else
                {
                    LV_PromocodeList.DataSource = dtPromocodeListDetails;
                    LV_PromocodeList.DataBind();
                }
            }
        }
    }
}