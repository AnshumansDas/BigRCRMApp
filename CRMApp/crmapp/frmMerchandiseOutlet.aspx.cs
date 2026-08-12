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
    public partial class frmMerchandiseOutlet : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, voucherCode = string.Empty;
        static int OutletId = 0;
        HttpResponseMessage response = null;
        ListItem v_lst1, v_lst2, v_lst3;
        int City, State, ActiveStatus;
        static int branchaId;
        #endregion

        protected void lvMerchandiseOutletList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem outlet = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (outlet != null)
                {
                    branchaId = int.Parse(lvMerchandiseOutletList.DataKeys[outlet.DisplayIndex][0].ToString());
                    SetData(branchaId);
                }
            }
        }

        protected void lvMerchandiseOutletList_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMerchandiseOutletList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvMerchandiseOutletList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvMerchandiseOutletList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvMerchandiseOutletList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvMerchandiseOutletList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchandiseOutlet();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    branchaId = 0;
                    BindMerchandiseOutlet();
                    BindState();
                    BindCity();                    
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void BindState()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetStateDetails";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var StateList = response.Content.ReadAsStringAsync().Result;
                var pDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(StateList);
                if (pDataTable.Rows.Count > 0)
                {
                    ddlState.DataSource = pDataTable;
                    ddlState.DataBind();
                    ddlState.Items.Insert(0, new ListItem("-Select-", ""));
                }
                else
                {
                    ddlState.Items.Insert(0, new ListItem("-Select-", ""));
                }
            }
        }

        protected void BindCity()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetCityListing";
            if (ddlState.SelectedIndex == 0)
            {
                ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
            }
            else
            {
                var crm = new crmEntity()
                {
                    state_id = Convert.ToInt32(ddlState.SelectedValue)
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var CityList = response.Content.ReadAsStringAsync().Result;
                    var dtCityList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CityList);
                    if (dtCityList.Rows.Count > 0)
                    {
                        ddlCity.DataSource = dtCityList;
                        ddlCity.DataBind();
                        ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
                    }
                    else
                    {
                        ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
                    }
                }
            }
        }

        protected void BindMerchandiseOutlet()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetOutletDetails";
            var crm = new crmEntity()
            {
                search_param=txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var StateList = response.Content.ReadAsStringAsync().Result;
                var pDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(StateList);
                if (pDataTable.Rows.Count > 0)
                {
                    lvMerchandiseOutletList.DataSource = pDataTable;
                    lvMerchandiseOutletList.DataBind();
                }
                else
                {
                    lvMerchandiseOutletList.DataSource = pDataTable;
                    lvMerchandiseOutletList.DataBind();
                }
            }
        }

        protected void SetData(int BranchID)
        {
            try
            {
                ServiceUrl = "CRM/GetMerchandiseBranchDetailsById";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl + "?branchId=" + BranchID).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Productlist = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                    if (DataTable.Rows.Count > 0)
                    {
                        v_lst1 = ddlState.Items.FindByText(DataTable.Rows[0]["state_name"].ToString().Trim());
                        State = ddlState.Items.IndexOf(v_lst1);
                        ddlState.ClearSelection();
                        ddlState.SelectedIndex = State;

                        v_lst2 = ddlCity.Items.FindByText(DataTable.Rows[0]["city_name"].ToString().Trim());
                        City = ddlCity.Items.IndexOf(v_lst2);
                        ddlCity.ClearSelection();
                        ddlCity.SelectedIndex = City;

                        v_lst3 = ddlActiveStatus.Items.FindByValue(DataTable.Rows[0]["active_status"].ToString().Trim());
                        ActiveStatus = ddlActiveStatus.Items.IndexOf(v_lst3);
                        ddlActiveStatus.ClearSelection();
                        ddlActiveStatus.SelectedIndex = ActiveStatus;
                        
                        //txtProductId.Text = ddlProductList.SelectedItem.Value.ToString().Trim();
                        txtBranchName.Text = DataTable.Rows[0]["voucher_name"].ToString().Trim();
                        txtPersonInCharge.Text = DataTable.Rows[0]["descriptions"].ToString().Trim();
                        txtAddress1.Text = DataTable.Rows[0]["redeem_offer"].ToString().Trim();
                        txtAddress2.Text = DataTable.Rows[0]["reservation"].ToString().Trim();
                        txtPostCode.Text = DataTable.Rows[0]["redeem_instruction"].ToString().Trim();
                        txtRemarks.Text = DataTable.Rows[0]["original_price"].ToString().Trim();                        
                    }                    
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtRemarks.Text = string.Empty;
            txtBranchName.Text = string.Empty;
            txtPersonInCharge.Text = string.Empty;
            txtAddress1.Text = string.Empty;
            txtAddress2.Text = string.Empty;

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/SaveMerchandiseBranchDetails";
            var crm = new crmEntity()
            {
                branch_id= branchaId,
                branch_name=txtBranchName.Text.Trim(),
                person_incharge=txtPersonInCharge.Text.Trim(),
                address1=txtAddress1.Text.Trim(),
                address_2=txtAddress2.Text.Trim(),
                postcode=txtPostCode.Text.Trim(),
                state_id=Convert.ToInt32(ddlState.SelectedValue),
                city_id =Convert.ToInt32(ddlCity.SelectedValue),
                remark=txtRemarks.Text.TrimEnd()
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl,crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var StateList = response.Content.ReadAsStringAsync().Result;
                var pDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(StateList);
                if (pDataTable.Rows.Count > 0)
                {
                    BindMerchandiseOutlet();                    
                }
            }
        }
    }
}