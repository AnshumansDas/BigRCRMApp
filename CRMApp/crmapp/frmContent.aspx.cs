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
    public partial class frmContent : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindContentCategory();
                    BindContent();
                }
                //else
                //{
                //    Response.Redirect("../Home.aspx");
                //}
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
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        public void BindSearchContent(string strCatCode)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/SearchByContentCategory";
            var crm = new crmEntity()
            {
                content_catCode = strCatCode.Trim()
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
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void ddlContentCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSearchContent(ddlContentCat.SelectedValue.Trim());
        }

        protected void lvContentList_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvContentList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvContentList.FindControl("dpContentList") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvContentList.FindControl("dpContentList") as DataPager).Visible = true;
            }
            else
            {
                (lvContentList.FindControl("dpContentList") as DataPager).Visible = false;
            }
        }

        protected void lnkAddNewContent_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmContentAddEdit.aspx?cid=0");
        }

        protected void lvContentList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvContentList.FindControl("dpContentList") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindContent();
        }
        
        protected void btnAddNewContent_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmContentAddEdit.aspx?cid=0");
        }

        protected void lvContentList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem ContentItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit_Content")
            {
                if (ContentItems != null)
                {
                    string contentID = (string)lvContentList.DataKeys[ContentItems.DisplayIndex][0].ToString();
                    Response.Redirect("frmContentAddEdit.aspx?cid=" + contentID.Trim());
                }
            }
        }
    }
}