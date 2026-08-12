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
    public partial class frmJoingSetupList : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, voucherCode = string.Empty;        
        ListItem v_lst1, v_lst2;
        int Category, joiningID, ActiveStatus;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindJoiningCategoryList();                    
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void BindJoiningCategoryList()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetJoiningSetup";
            var crm = new crmEntity()
            {                
                search_param=txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var JoiningList = response.Content.ReadAsStringAsync().Result;
                var dtJoiningList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(JoiningList);
                if (dtJoiningList.Rows.Count > 0)
                {
                    lvJoiningSetupList.DataSource = dtJoiningList;
                    lvJoiningSetupList.DataBind();
                    HtmlGenericControl totalrecord = (HtmlGenericControl)lvJoiningSetupList.FindControl("totalrecord");
                    totalrecord.InnerText = dtJoiningList.Rows.Count.ToString().Trim();
                }
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindJoiningCategoryList();
        }

        protected void btnAddSetup_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmJoiningSetup.aspx?joining_id=0");
        }

        protected void lvJoiningSetupList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem voucherItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (voucherItems != null)
                {
                    int joiningid = int.Parse(lvJoiningSetupList.DataKeys[voucherItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmJoiningSetup.aspx?joining_id=" + joiningid);
                }
            }
        }

        protected void lvJoiningSetupList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvJoiningSetupList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindJoiningCategoryList();
        }

        protected void lvJoiningSetupList_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvJoiningSetupList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvJoiningSetupList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvJoiningSetupList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvJoiningSetupList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
    }
}