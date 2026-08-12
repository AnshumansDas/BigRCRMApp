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
    public partial class frmRewardPointManagement : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        int userloginid = 0;
        static int rew_id = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {               
                BindRewardPointSetupList();
                userloginid = Convert.ToInt16(Session["userid"].ToString());
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblMsg.InnerText = string.Empty;
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/AddEditRewardPoints";

                string[] starttokens = txtStartDate.Text.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                DateTime dtStartDate = Convert.ToDateTime(strStartDate);
                //string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");

                string[] endtokens = txtEndDate.Text.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                DateTime dtEndDate = Convert.ToDateTime(strEndDate);

                var rewardEnt = new crmEntity()
                {
                    reward_id = rew_id,
                    user_id = Convert.ToInt16(Session["userid"].ToString().Trim()),
                    created_by = Session["username"].ToString().Trim(),
                    modified_by = Session["username"].ToString().Trim(),
                    trans_amount = Convert.ToDecimal(txtTransAmt.Text.Trim()),
                    rewardPoint = Convert.ToInt32(txtReward.Text.Trim()),
                    start_date = strStartDate,
                    end_date = strEndDate,
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue)
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, rewardEnt).Result;
                if (response.IsSuccessStatusCode)
                {
                    lblMsg.InnerText = "Reward Point Saved Successfully";
                    lblMsg.Style.Add("color", "green");
                    reSetAllFields();
                }
                else
                {
                    lblMsg.InnerText = response.ReasonPhrase.ToString();
                    lblMsg.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                lblMsg.InnerText = ex.Message.ToString();
                return;
            }
            BindRewardPointSetupList();
        }

        protected void reSetAllFields()
        {
            txtTransAmt.Text = string.Empty;
            txtReward.Text = string.Empty;
            txtStartDate.Text = string.Empty;
            txtEndDate.Text = string.Empty;
            ddlActiveStatus.SelectedIndex = 0;
            rew_id = 0;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopupReward();", true);
        }

        protected void BindRewardPointSetupList()
        {
            string dtStartDate = "", dtEndDate = "", strSendVal=string.Empty;
            if (!string.IsNullOrEmpty(txtVoucherDateRange.Text.Trim()))
            {
                string data = txtVoucherDateRange.Text.Trim();
                string[] dates = data.Split('-');
                if (!string.IsNullOrEmpty(dates[0].ToString().Trim()))
                {
                    dtStartDate = dates[0].ToString().Trim();
                    string[] starttokens = dtStartDate.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                else { dtStartDate = "1900-01-01"; }

                if (!string.IsNullOrEmpty(dates[1].ToString().Trim()))
                {
                    dtEndDate = dates[1].ToString().Trim();
                    string[] endtokens = dtEndDate.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                else { dtEndDate = "3000-01-01"; }
            }
            else
            {
                dtStartDate = "1900-01-01"; dtEndDate = "3000-01-01";
            }
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetRewardSetupList";
            var entity = new crmEntity()
            {
                search_param = strSendVal,
                FromDate = dtStartDate,
                ToDate = dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,entity).Result;
            if (response.IsSuccessStatusCode)
            {
                var recPurDetails = response.Content.ReadAsStringAsync().Result;
                var dtrecPurDet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(recPurDetails);
                ViewState["dtcont"] = dtrecPurDet;
                if (dtrecPurDet.Rows.Count > 0)
                {                    
                    lsvReward.DataSource = dtrecPurDet;
                    lsvReward.DataBind();
                }
                else
                {
                    lsvReward.DataSource = dtrecPurDet;
                    lsvReward.DataBind();
                }
            }
        }
        protected void BtnSearch_Click(object sender,EventArgs e)
        {
            BindRewardPointSetupList();
        }

        protected void lsvReward_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "Edit"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                rew_id = Convert.ToInt32(lsvReward.DataKeys[dataItem.DisplayIndex].Value.ToString());
                getRewardDetails(rew_id);
            }
        }

        protected void getRewardDetails(int rewardId)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetRewardPointsById";
            var rewardEnt = new crmEntity()
            {
                reward_id = rewardId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, rewardEnt).Result;
            if (response.IsSuccessStatusCode)
            {
                var Reward = response.Content.ReadAsStringAsync().Result;
                var dtReward = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Reward);
                //ViewState["dtcont"] = dtChargeType;
                if (dtReward.Rows.Count > 0)
                {
                    txtTransAmt.Text = dtReward.Rows[0]["transaction_amount"].ToString().Trim();
                    txtReward.Text = dtReward.Rows[0]["reward_points"].ToString().Trim();
                    txtStartDate.Text = dtReward.Rows[0]["effective_start_dt"].ToString().Trim();
                    txtEndDate.Text = dtReward.Rows[0]["effective_end_dt"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtReward.Rows[0]["active_status"].ToString().Trim();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupReward();", true);
                }
            }
        }

        protected void lsvReward_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void lsvReward_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lsvReward.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindRewardPointSetupList();
        }

        protected void lsvReward_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lsvReward.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lsvReward.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lsvReward.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lsvReward.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtTransAmt.Text = string.Empty;
            txtReward.Text = string.Empty;
            txtStartDate.Text = string.Empty;
            txtEndDate.Text = string.Empty;
            ddlActiveStatus.SelectedIndex = 0;
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindRewardPointSetupList();
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            ddlActiveStatus.SelectedIndex = 0;
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtReward.Text = "";
            txtTransAmt.Text = "";
            lblMsg.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupReward();", true);
        }
    }
}