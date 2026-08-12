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
    public partial class frmVoucherSubCategorySetup : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        static int voucherCatId = 0, voucherSubCatId = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindVoucherCategory();
                    BindVoucherSubCategoryListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                //BindVoucherCategoryCode();
                //BindVoucherCategoryListing();
            }
        }

        protected void BindVoucherCategory()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherCategoryListing";
            var crm = new crmEntity()
            {
                search_param = string.Empty
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Category = response.Content.ReadAsStringAsync().Result;
                var dtCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Category);
                ViewState["dtcont"] = Category;
                if (dtCategory.Rows.Count > 0)
                {
                    ddlCategory.DataSource = dtCategory;
                    ddlCategory.DataBind();
                    ddlCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void BindVoucherSubCategoryListing()
        {            
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherSubCatListing";
            var crm = new crmEntity()
            {
                search_param = txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvVoucherSubCategoy.DataSource = dtChargeType;
                    lvVoucherSubCategoy.DataBind();
                    HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherSubCategoy.FindControl("totalrecord");
                    totalrecord.InnerText = dtChargeType.Rows.Count.ToString().Trim();
                }
                else
                {
                    lvVoucherSubCategoy.DataSource = dtChargeType;
                    lvVoucherSubCategoy.DataBind();
                }

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/SaveVoucherSubCategory";
                var crm = new crmEntity()
                {
                    voucher_sub_cat_id= voucherSubCatId,
                    voucher_cat_id = Convert.ToInt32(ddlCategory.SelectedValue),
                    voucher_sub_category = txtSubCategory.Text.Trim(),
                    remark=string.Empty,
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue)
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    //ViewState["dtcont"] = dtChargeType;
                    if (dtChargeType.Rows.Count > 0)
                    {
                         message.InnerText = "Voucher Sub Category Saved/Updated Successfully";
                         message.Visible = true;
                         message.Style.Add("color", "Green");                       
                         BindVoucherSubCategoryListing();
                        ResetField();

                    }
                }
            }
            catch(Exception ex)
            {

            }
        }

        protected void ResetField()
        {
            ddlCategory.SelectedIndex = 0;
            txtSubCategory.Text = string.Empty;
            ddlActiveStatus.SelectedIndex = 0;
            voucherSubCatId = 0;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopupwithdata();", true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetField();
        }
        protected void btnadd_Click(object sender,EventArgs e)
        {
            ddlCategory.SelectedIndex = 0;
            txtSubCategory.Text = "";
            ddlActiveStatus.SelectedIndex = 0;
            message.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupdetails();", true);

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindVoucherSubCategoryListing();
        }

        protected void lvVoucherSubCategoy_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "Edit"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                voucherCatId = Convert.ToInt32(lvVoucherSubCategoy.DataKeys[dataItem.DisplayIndex].Value.ToString());
                voucherSubCatId = voucherCatId;
                getSubCategoryDetails();
            }
        }

        protected void getSubCategoryDetails()
        {           
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherSubCategoryDetails";
            var crm = new crmEntity()
            {
                voucher_sub_cat_id = voucherCatId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                //ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    ddlCategory.SelectedValue= dtChargeType.Rows[0]["voucher_main_cat_id"].ToString().Trim();                    
                    txtSubCategory.Text = dtChargeType.Rows[0]["voucher_sub_category"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtChargeType.Rows[0]["active_status"].ToString().Trim();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupdetails();", true);

                }
            }
        }

        protected void lvVoucherSubCategoy_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvVoucherSubCategoy.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindVoucherSubCategoryListing();
        }

        protected void lvVoucherSubCategoy_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherSubCategoy.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvVoucherSubCategoy.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvVoucherSubCategoy.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvVoucherSubCategoy.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvVoucherSubCategoy_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }
    }
}