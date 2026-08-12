using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
	public partial class frmAdminWithdrawStatus : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, voucherCode = string.Empty;
        int withdrawId, ActiveStatus;
        ListItem v_lst1;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {

                    if (Request.QueryString["withdraw_id"] != "0")
                    {
                        withdrawId = Convert.ToInt32(Request.QueryString["withdraw_id"].ToString().Trim());
                        SetData(Convert.ToInt32(Request.QueryString["withdraw_id"].ToString().Trim()));
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }
        protected void SetData(int voucherId)
        {
            try
            {
                ServiceUrl = "CRM/GetWithdrawDetailsById";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl + "?withdrawId=" + withdrawId).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Productlist = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                    if (DataTable.Rows.Count > 0)
                    {


                        v_lst1 = ddlActiveStatus.Items.FindByValue(DataTable.Rows[0]["status"].ToString().Trim());
                        ActiveStatus = ddlActiveStatus.Items.IndexOf(v_lst1);
                        ddlActiveStatus.ClearSelection();
                        ddlActiveStatus.SelectedIndex = ActiveStatus;

                        lblDateRequested.Text = DataTable.Rows[0]["requested_date"].ToString().Trim();
                        lblAvailableAmount.Text = DataTable.Rows[0]["available_amount"].ToString().Trim();
                        lblReqAmount.Text = DataTable.Rows[0]["requested_amount"].ToString().Trim();
                        lblBank.Text = DataTable.Rows[0]["bankname"].ToString().Trim();
                        lblAccno.Text = DataTable.Rows[0]["accno"].ToString().Trim();

                    }

                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Request.QueryString["withdraw_id"] != "0")
            {
                withdrawId = Convert.ToInt32(Request.QueryString["withdraw_id"].ToString().Trim());
            }
                var crm = new crmEntity()
            {
                withdraw_id = withdrawId,
                status = Convert.ToInt32(ddlActiveStatus.SelectedValue),
                verifyflag = 0,



            };
            ServiceUrl = "CRM/UpdateRequestWithdraw";
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var withdraw = response.Content.ReadAsStringAsync().Result;
               
                    Response.Redirect("frmAdminWithdrawDashboard.aspx");
               
            }
        }
    }
}