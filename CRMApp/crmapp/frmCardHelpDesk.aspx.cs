using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Data;
using System.Web.UI.HtmlControls;

namespace CRMApp.crmapp
{
    public partial class frmCardHelpDesk : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
            strTID = string.Empty, strAPIKey = string.Empty, strPaymentURL = string.Empty, email = string.Empty;
        #endregion


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindBigRCardList();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindCommunity();
                BindBigRCardList();
            }
        }

        protected void BindCommunity()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityList";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    ddlCommunity.DataSource = dtCommunity;
                    ddlCommunity.DataBind();
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "0"));
                }
                else
                {
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "0"));
                }
            }
        }

        protected void BindBigRCardList()
        {
            string strSendVal = string.Empty;
            int intCommId = 0;
            string strStatus = "0";
            ServiceUrl = "CRM/GetCardHelpDesk";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            if (ddlCommunity.SelectedIndex!=0)
            { intCommId = int.Parse(ddlCommunity.SelectedValue.ToString().Trim()); }
            if (ddlCardStatus.SelectedIndex!=0)
            { strStatus = ddlCardStatus.SelectedValue.ToString().Trim(); }

            var crm = new crmEntity()
            {
                community_id=intCommId,
                card_status = strStatus,
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeAmt = response.Content.ReadAsStringAsync().Result;
                var dtCardListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeAmt);
                ViewState["dtcont"] = dtCardListDetails;
                if (dtCardListDetails.Rows.Count > 0)
                {
                    lvCard.DataSource = dtCardListDetails;
                    lvCard.DataBind();
                }
                else
                {
                    lvCard.DataSource = dtCardListDetails;
                    lvCard.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }


        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void lvCard_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();            
            HtmlGenericControl totalrecord = (HtmlGenericControl)lvCard.FindControl("totalrecord");
            if (ViewState["dtcont"] != null)
            {
                dt = (DataTable)ViewState["dtcont"];
                totalrecord.InnerText = dt.Rows.Count.ToString();
            }
            else
            { totalrecord.InnerText = "0"; }
        }

        protected void lvCard_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCard.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindBigRCardList();
        }
    }
}