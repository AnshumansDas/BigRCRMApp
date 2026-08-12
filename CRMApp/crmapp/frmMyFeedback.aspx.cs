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
    public partial class frmMyFeedback : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        #region ControlEvents
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindFbStatus();
            }
        }

        

        protected void lvFeedbackList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvFeedbackList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindFbStatus();
        }

        protected void lvFeedbackList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                LinkButton lnkview = (LinkButton)e.Item.FindControl("lnkView");
                if (colorstatus.InnerText == "1")
                {
                    lnkview.Enabled = true;
                    colorstatus.InnerText = "Replied";
                    lnkview.Style.Add("Background", "green");
                }
                else
                {                 
                    lnkview.Enabled = false;
                    colorstatus.InnerText = "Not reply";
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvFeedbackList.FindControl("totalrecord");
                if (ViewState["VSFbStatus"] != null)
                {
                    dt = (DataTable)ViewState["VSFbStatus"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }
        #endregion

        #region UserDefinedEvents
        public void BindFbStatus()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetFeedbackListByUser";
            int userid = 0;
            try
            {
                if (Session["user_id"] != null)
                {
                    userid = Convert.ToInt32(Session["user_id"].ToString());
                }
                var FbStatus = new crmEntity()
                {
                    user_id = userid
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FbStatus).Result;
                if (response.IsSuccessStatusCode)
                {
                    var varFbStatus = response.Content.ReadAsStringAsync().Result;
                    var dtvarFbStatus = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(varFbStatus);
                    ViewState["VSFbStatus"] = dtvarFbStatus;
                    if (dtvarFbStatus.Rows.Count > 0)
                    {
                        lvFeedbackList.DataSource = dtvarFbStatus;
                        lvFeedbackList.DataBind();
                    }
                    else
                    {
                        lvFeedbackList.DataSource = dtvarFbStatus;
                        lvFeedbackList.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void lvFeedbackList_ItemCommand(object sender, ListViewCommandEventArgs e)
        { 
            ListViewDataItem Items = (ListViewDataItem)e.Item;
            if (e.CommandName == "View")
            {
                if (Items != null)
                {
                    string id = (string)lvFeedbackList.DataKeys[Items.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmViewFeedback.aspx?id=" + id);
                }
            }
        }


        #endregion
    }
}