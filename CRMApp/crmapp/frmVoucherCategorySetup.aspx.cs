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
    public partial class frmVoucherCategorySetup : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        static int voucherCatId = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindVoucherCategoryCode();
                    BindVoucherCategoryListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                //BindVoucherCategoryCode();
                //BindVoucherCategoryListing();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetField();
            BindVoucherCategoryCode();
            BindVoucherCategoryListing();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var crm = new crmEntity();
            if (ddlActiveStatus.SelectedValue.ToString().Trim() == "0")
            {
                //check for the voucher is there under this category or not
                ServiceUrl = "CRM/GetVoucherCategoryUsed";
                crm = new crmEntity()
                {
                    voucher_cat_id = voucherCatId
                };
                HttpResponseMessage vresponse = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (vresponse.IsSuccessStatusCode)
                {
                    var CatType = vresponse.Content.ReadAsStringAsync().Result;
                    var dtCatType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CatType);
                    //ViewState["dtcont"] = dtChargeType;
                    if (dtCatType.Rows.Count > 0)
                    {
                        //Return Error message
                        message.InnerText = "Unable to make Inactive!VFew Voucher is using this category";
                        message.Visible = true;
                        message.Style.Add("color", "Red");
                    }
                    else
                    {
                        //Save/Update
                        ServiceUrl = "CRM/SaveVoucherCategory";
                        crm = new crmEntity()
                        {
                            voucher_cat_id = voucherCatId,
                            voucher_code = lblCategoryCode.Text.Trim(),
                            voucher_name = txtCategory.Text.Trim(),
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
                                message.InnerText = "Voucher Category Saved/Updated Successfully";
                                message.Visible = true;
                                message.Style.Add("color", "Green");
                                BindVoucherCategoryListing();
                                ResetField();
                            }
                        }
                    }
                }

            }
            else
            {
                ServiceUrl = "CRM/SaveVoucherCategory";
                crm = new crmEntity()
                {
                    voucher_cat_id = voucherCatId,
                    voucher_code = lblCategoryCode.Text.Trim(),
                    voucher_name = txtCategory.Text.Trim(),
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
                        message.InnerText = "Voucher Category Saved/Updated Successfully";
                        message.Visible = true;
                        message.Style.Add("color", "Green");
                        BindVoucherCategoryListing();
                        ResetField();
                    }
                }
            }
        }

        protected void ResetField()
        {
            txtCategory.Text = string.Empty;
            ddlActiveStatus.SelectedIndex = 0;
            voucherCatId = 0;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "hidepopupdata();", true);
        }

        protected void lvVoucherCategoy_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "Edit"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                voucherCatId = Convert.ToInt32(lvVoucherCategoy.DataKeys[dataItem.DisplayIndex].Value.ToString());
                getCategoryDetails();
            }
        }

        protected void getCategoryDetails()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherCategoryDetails";
            var crm = new crmEntity()
            {
                voucher_cat_id = voucherCatId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                //ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lblCategoryCode.Text = dtChargeType.Rows[0]["voucher_main_category_code"].ToString().Trim();
                    txtCategory.Text = dtChargeType.Rows[0]["voucher_main_category"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtChargeType.Rows[0]["active_status"].ToString().Trim();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "showpopupdata();", true);
                }
            }
        }

        protected void lvVoucherCategoy_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvVoucherCategoy.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindVoucherCategoryListing();
        }

        protected void lvVoucherCategoy_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindVoucherCategoryListing();
        }

        protected void lvVoucherCategoy_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Active")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherCategoy.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    DataTable dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
                Label LblMainCatId = (Label)e.Item.FindControl("LblMainCatId");
                LinkButton lnkEdit = (LinkButton)e.Item.FindControl("lnkEdit");
                lnkEdit.Enabled = true;
                if (LblMainCatId.Text == "5" || LblMainCatId.Text == "2" || LblMainCatId.Text == "10" || LblMainCatId.Text == "15" || LblMainCatId.Text == "1" || LblMainCatId.Text == "4")
                {
                    lnkEdit.Enabled = false;
                }
            }
        }

        public void BindVoucherCategoryCode()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetCategoryCode";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                ChargeType = ChargeType.Substring(1, ChargeType.Length - 2);
                ChargeType = ChargeType.Substring(1, ChargeType.Length - 2);
                lblCategoryCode.Text = ChargeType;
            }
        }

        public void BindVoucherCategoryListing()
        {
            string strSendVal = string.Empty;
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherCategoryListing";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            var crm = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvVoucherCategoy.DataSource = dtChargeType;
                    lvVoucherCategoy.DataBind();
                    HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherCategoy.FindControl("totalrecord");
                    totalrecord.InnerText = dtChargeType.Rows.Count.ToString().Trim();
                }
                else
                {
                    lvVoucherCategoy.DataSource = dtChargeType;
                    lvVoucherCategoy.DataBind();
                    //HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherCategoy.FindControl("totalrecord");
                    //totalrecord.InnerText = "0";
                }

            }
        }

        protected void btnaddnew_click(object sender, EventArgs e)
        {
            lblCategoryCode.Text = "";
            BindVoucherCategoryCode();
            ddlActiveStatus.SelectedIndex = 0;
            txtCategory.Text = "";
            message.InnerText = "";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "showpopupdata();", true);
        }
    }
}