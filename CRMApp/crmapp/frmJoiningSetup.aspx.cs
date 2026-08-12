using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmJoiningSetup : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, voucherCode = string.Empty;
        ListItem v_lst1, v_lst2;
        static int CategoryID, joiningID, ActiveStatus, startdate, enddate, points;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindJoiningCategory();
                    if (Request.QueryString["joining_id"] != "0")
                    {
                        joiningID = Convert.ToInt32(Request.QueryString["joining_id"].ToString().Trim());
                        SetData(Convert.ToInt32(Request.QueryString["joining_id"].ToString().Trim()));
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void BindJoiningCategory()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetJoiningCategory";
            var crm = new crmEntity()
            {
                search_param = string.Empty
            };
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Category = response.Content.ReadAsStringAsync().Result;
                var dtCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Category);
                if (dtCategory.Rows.Count > 0)
                {
                    ddlJoiningCategory.DataSource = dtCategory;
                    ddlJoiningCategory.DataBind();
                    ddlJoiningCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlJoiningCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void SetData(int joiningId)
        {
            try
            {
                ServiceUrl = "CRM/GetJoiningSetupDetailsById";
                var crm = new crmEntity()
                {
                    joining_id = joiningID
                };
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Productlist = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                    if (DataTable.Rows.Count > 0)
                    {
                        v_lst1 = ddlJoiningCategory.Items.FindByText(DataTable.Rows[0]["joining_category"].ToString().Trim());
                        CategoryID = ddlJoiningCategory.Items.IndexOf(v_lst1);
                        ddlJoiningCategory.ClearSelection();
                        ddlJoiningCategory.SelectedIndex = CategoryID;

                        v_lst2 = ddlActiveStatus.Items.FindByText(DataTable.Rows[0]["active_status"].ToString().Trim());
                        ActiveStatus = ddlActiveStatus.Items.IndexOf(v_lst2);
                        ddlActiveStatus.ClearSelection();
                        ddlActiveStatus.SelectedIndex = ActiveStatus;
                        txtPoint.Text = DataTable.Rows[0]["point"].ToString().Trim();
                        txtStartDate.Text = DataTable.Rows[0]["startdate"].ToString().Trim();
                        txtEndDate.Text = DataTable.Rows[0]["enddate"].ToString().Trim();
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmJoingSetupList.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string dtStartDate = "", dtEndDate = "";
            if (txtStartDate.Text.Trim() != "")
            {
                string[] starttokens = txtStartDate.Text.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            }
            //string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            if (txtEndDate.Text.Trim() != "")
            {
                string[] endtokens = txtEndDate.Text.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            }

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/AddEditJoiningSetup";
            var crm = new crmEntity()
            {
                joining_id = joiningID,
                joining_category_id = Convert.ToInt32(ddlJoiningCategory.SelectedValue),
                start_date = dtStartDate,
                end_date = dtEndDate,
                point = Convert.ToInt32(txtPoint.Text.Trim()),
                active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue),
                created_by = Session["username"].ToString().Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var JoiningCategory = response.Content.ReadAsStringAsync().Result;
                var dtJoiningCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(JoiningCategory);
                if (dtJoiningCategory.Rows.Count > 0)
                {
                    Response.Redirect("frmJoingSetupList.aspx");
                }
            }
            else
            {

            }
        }
    }
}