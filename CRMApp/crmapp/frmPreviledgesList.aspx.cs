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
    public partial class frmPreviledgesList : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        //static int voucherCatId = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindRoleListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void LstUserCategory_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                //HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                //if (colorstatus.InnerText == "Active")
                //{ colorstatus.Style.Add("color", "green"); }
                //else
                //{ colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)LstUserCategory.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        public void BindRoleListing()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetUserCategory";            
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    LstUserCategory.DataSource = dtChargeType;
                    LstUserCategory.DataBind();
                }
                else
                {
                    LstUserCategory.DataSource = dtChargeType;
                    LstUserCategory.DataBind();
                }
            }
        }

        protected void LstUserCategory_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem roleItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (roleItems != null)
                {
                    int roleId = int.Parse(LstUserCategory.DataKeys[roleItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmPriveledgeSetup.aspx?role_id=" + roleId);
                }
            }
        }
    }
}