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
    public partial class frmFeedback : System.Web.UI.Page
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
                BindFeedbackList();
            }

        }

        protected void ddlReplyStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            message.InnerText = string.Empty;
            if (ddlReplyStatus.SelectedValue == "2")
            {
                BindFeedbackList();
            }
            else
            {
                ServiceUrl = "CRM/SearchFeedbackByReplyStatus";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var FBEntity = new crmEntity()
                {
                    StatusVal = Convert.ToInt16(ddlReplyStatus.SelectedValue)
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ResResult = response.Content.ReadAsStringAsync().Result;
                    var dtFB = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                    ViewState["dtcont"] = dtFB;
                    if (dtFB.Rows.Count > 0)
                    {
                        lvFeedbackList.DataSource = dtFB;
                        lvFeedbackList.DataBind();
                    }
                    else
                    {
                        lvFeedbackList.DataSource = dtFB;
                        lvFeedbackList.DataBind();
                    }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
        }

        protected void lvFeedbackList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (commentItem != null)
                {
                    string feedbackID = (string)lvFeedbackList.DataKeys[commentItem.DisplayIndex][0].ToString();
                    Response.Redirect("frmFeedbackEdit.aspx?id=" + feedbackID);
                }
            }
            else if (e.CommandName == "Delete")
            {
                if (commentItem != null)
                {
                    string FbID = (string)lvFeedbackList.DataKeys[commentItem.DisplayIndex][0].ToString();
                    //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    ServiceUrl = "InfoApi/DeleteFeedback";
                    var FBEntity = new crmEntity()
                    {
                        ID = Convert.ToInt32(FbID)
                    };
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEntity).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        BindFeedbackList();
                        message.InnerText = "Record successfully deleted!";
                        message.Style.Add("color", "DarkGreen");
                    }
                    else
                    {
                        message.InnerText = response.ReasonPhrase.ToString();
                        message.Style.Add("color", "Red");
                    }
                }
            }
        }

        protected void lvFeedbackList_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        protected void lvFeedbackList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            HtmlGenericControl totalrecord = (HtmlGenericControl)lvFeedbackList.FindControl("totalrecord");
            if (ViewState["dtcont"] != null)
            {
                DataTable dt = (DataTable)ViewState["dtcont"];
                totalrecord.InnerText = dt.Rows.Count.ToString();
            }
            else
            { totalrecord.InnerText = "0"; }

        }

        protected void lvFeedbackList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvFeedbackList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindFeedbackList();
        }

        protected void lvFeedbackList_DataBound(object sender, EventArgs e)
        {

        }
        #endregion

        #region UserDefinedMethods
        public void BindFeedbackList()
        {
            message.InnerText = string.Empty;
            ServiceUrl = "CRM/GetFeedBackList";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var FBEntity = new crmEntity()
            {
                ID = 0
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ResResult = response.Content.ReadAsStringAsync().Result;
                var dtFeedback = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                ViewState["dtcont"] = dtFeedback;
                if (dtFeedback.Rows.Count > 0)
                {
                    lvFeedbackList.DataSource = dtFeedback;
                    lvFeedbackList.DataBind();
                }
                else
                {
                    lvFeedbackList.DataSource = dtFeedback;
                    lvFeedbackList.DataBind();
                }
                for (int i = 0; i < lvFeedbackList.Items.Count(); i++)
                {
                    //Get the Label by row
                    HiddenField HdnReplyStatus = (HiddenField)lvFeedbackList.Items[i].FindControl("HdnReplyStatus");
                    LinkButton lnkEdit = (LinkButton)lvFeedbackList.Items[i].FindControl("lnkEdit");
                    LinkButton lnkDelete = (LinkButton)lvFeedbackList.Items[i].FindControl("lnkDelete");
                    if (HdnReplyStatus.Value == "1")
                    {
                        lnkEdit.Visible = false;
                        lnkDelete.Visible = false;
                    }
                    else if (HdnReplyStatus.Value == "0")
                    {
                        lnkEdit.Visible = true;
                        lnkDelete.Visible = true;
                    }

                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        #endregion
    }
}