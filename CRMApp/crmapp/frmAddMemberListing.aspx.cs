using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;
using System.Net.Http;
using System.Configuration;
using System.Net.Http.Headers;
using System.Web.UI.HtmlControls;

namespace CRMApp.crmapp
{
    public partial class frmAddMemberListing : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            if (!Page.IsPostBack)
            {
                BindMemberListing();
            }
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public void BindMemberListing()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/ListOfMemberHelpdesk";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            var crm = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvAddmember.DataSource = dtChargeType;
                    lvAddmember.DataBind();
                }
                else
                {
                    lvAddmember.DataSource = dtChargeType;
                    lvAddmember.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void lvAddmember_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }
        
        protected void lvAddmember_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvAddmember.DataKeys[commentItem.DisplayIndex][0].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        Response.Redirect("frmAddMember.aspx?userlogin_id=" + contentID);
                    }
                }
            }
        }
        protected void lvAddmember_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvAddmember.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMemberListing();
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAddMember.aspx");
        }

        protected void lvAddmember_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvAddmember.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvAddmember.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvAddmember.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvAddmember.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMemberListing();
        }

    }
}