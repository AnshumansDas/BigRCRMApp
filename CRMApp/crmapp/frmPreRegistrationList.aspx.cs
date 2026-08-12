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
    public partial class frmPreRegistrationList : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;        
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindPreRegistrationListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void lvPreRegistrationList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem registerItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (registerItems != null)
                {
                    int merchantRegId = int.Parse(lvPreRegistrationList.DataKeys[registerItems.DisplayIndex][0].ToString());
                    Session["merchantRegid"] = merchantRegId;
                    //Response.Redirect("frmMerchantAddEdit.aspx?m_code=''");
                    Response.Redirect("frmMerchantAddEdit.aspx");
                }
            }
        }

        protected void lvPreRegistrationList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvPreRegistrationList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindPreRegistrationListing();
        }

        protected void lvPreRegistrationList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                LinkButton btnView = (LinkButton)e.Item.FindControl("lnkEdit");
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Registered")
                {
                    colorstatus.Style.Add("color", "green");
                    btnView.Enabled = false;
                }
                else
                { colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvPreRegistrationList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvPreRegistrationList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvPreRegistrationList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvPreRegistrationList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        public void BindPreRegistrationListing()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetPreRegistrationList";
            var crm = new crmEntity()
            {
                search_param = txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvPreRegistrationList.DataSource = dtChargeType;
                    lvPreRegistrationList.DataBind();
                }
                else
                {
                    lvPreRegistrationList.DataSource = dtChargeType;
                    lvPreRegistrationList.DataBind();
                }

            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindPreRegistrationListing();
        }
    }
}