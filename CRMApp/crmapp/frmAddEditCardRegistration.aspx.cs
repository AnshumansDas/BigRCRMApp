using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmAddEditCardRegistration : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        static int reg_id = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindCommunity();
                    if (Request.QueryString["reg_id"] != "0")
                    {
                        reg_id = Convert.ToInt32(Request.QueryString["reg_id"].ToString().Trim());
                        SetData(Convert.ToInt32(Request.QueryString["reg_id"].ToString().Trim()));
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
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
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void SetData(int registration_id)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "Payment/BindRegisteredData";

            HttpResponseMessage response = client.GetAsync(ServiceUrl+"?reg_id"+registration_id).Result;
            if (response.IsSuccessStatusCode)
            {
                var Merchant = response.Content.ReadAsStringAsync().Result;
                var dtMerchant = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Merchant);

                if (dtMerchant.Rows.Count > 0)
                {                    
                    txtUser.Text = "";
                    lblUserName.Text = "";
                    txtCardNo.Text = "";
                    ddlCommunity.Items.FindByValue("").Selected = true;
                    ddlStatus.Items.FindByValue("").Selected = true;
                }
                else
                {
                    txtUser.Text = "";
                    lblUserName.Text = "";
                    txtCardNo.Text = "";
                    ddlCommunity.SelectedIndex = 0;
                    ddlStatus.SelectedIndex = 0;
                }
            }
        }

        protected void txtUser_TextChanged(object sender, EventArgs e)
        {
            //Get the User Info and set to the label and hidden field
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetUserDetailsbyId";
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(txtUser.Text.Trim().Remove(0,4))
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var UserInfo = response.Content.ReadAsStringAsync().Result;
                var dtUserInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserInfo);

                if (dtUserInfo.Rows.Count > 0)
                {
                    lblUserName.Text = dtUserInfo.Rows[0]["user_fistname"].ToString().Trim();
                    hdnfuserId.Value = dtUserInfo.Rows[0]["user_id"].ToString().Trim();
                }
                else
                {                    
                    lblUserName.Text = "";
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ServiceUrl = "CRM/RegisterBigrCard";
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(hdnfuserId.Value),
                community_id=Convert.ToInt32(ddlCommunity.SelectedValue),
                card_no=txtCardNo.Text.Trim(),
                created_by= Session["User_FirstName"].ToString().Trim(),
                active_status= Convert.ToInt32(ddlStatus.SelectedValue)
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var UserInfo = response.Content.ReadAsStringAsync().Result;
                var dtUserInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserInfo);

                if (dtUserInfo.Rows.Count > 0)
                {
                    Response.Redirect("frmCardRegistration.aspx");
                }
                else
                {
                    message.InnerText="Unable to Save";
                    message.Visible = true;                    
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }
    }
}