using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmPromoCodeAddEdit : System.Web.UI.Page
    {
        #region GLOBAL_DECLARATION
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
            strCreatedby = string.Empty, strPercentage = string.Empty;
        int intPromocodeId = 0;
        decimal decAmount;

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindPromocodeType();
                BindMerchant();
                BindPromocodeCategory();
                if (Request["Promocode_Id"].ToString() != "0")
                {
                    intPromocodeId = Convert.ToInt16(Request["Promocode_Id"].ToString());
                    BindPromocodeDetailsById(intPromocodeId);
                }
            }
        }

        protected void ddlPromocodeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPromocodeType.SelectedValue == "1")
            {
                lblAmountPercentage.InnerText = "Pay By Amount";
                txtAmountPercentage.Style.Add("placeholder", "Pay By Amount");
                //txtAmountPercentage.placeholder = "Pay By Amount";
            }
            else if (ddlPromocodeType.SelectedValue == "2")
            {
                lblAmountPercentage.InnerText = "Pay By Percentage";
                txtAmountPercentage.Style.Add("placeholder", "Pay By Percentage");
            }
        }
        public void BindPromocodeType()
        {
            ServiceUrl = "CRM/GetPromocodeType";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlPromocodeType.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlPromocodeType.Items.Insert(0, item);
            //if(ddlState.SelectedIndex != 0)
            //{ strStateID = ddlState.SelectedValue; }
            //else
            //{ strStateID = "0"; }

            var crm = new crmEntity()
            {
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var PromocodeType = response.Content.ReadAsStringAsync().Result;
                var dtPromocodeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PromocodeType);
                if (dtPromocodeType.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtPromocodeType.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["promocode_type"].ToString())))
                        {
                            ddlPromocodeType.Items.Add(new ListItem(dtRow["promocode_type"].ToString(), dtRow["promocode_type_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindPromocodeCategory()
        {
            ServiceUrl = "CRM/GetPromocodeCategory";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlPromocodeCategory.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlPromocodeCategory.Items.Insert(0, item);
            //if(ddlState.SelectedIndex != 0)
            //{ strStateID = ddlState.SelectedValue; }
            //else
            //{ strStateID = "0"; }

            var crm = new crmEntity()
            {
            };
            HttpResponseMessage resppromoCat = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (resppromoCat.IsSuccessStatusCode)
            {
                var PromocodeCategory = resppromoCat.Content.ReadAsStringAsync().Result;
                var dtPromocodeCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PromocodeCategory);
                if (dtPromocodeCategory.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtPromocodeCategory.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["promocode_Category"].ToString())))
                        {
                            ddlPromocodeCategory.Items.Add(new ListItem(dtRow["promocode_Category"].ToString(), dtRow["promocode_Category_id"].ToString()));
                        }
                    }
                }
            }
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmPromocodeList.aspx", false);
            return;
        }

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            try
            {
                int pCodeId = 0;
                if (Request["Promocode_Id"].ToString() != "0")
                    pCodeId = Convert.ToInt16(Request["Promocode_Id"].ToString());
                ServiceUrl = "CRM/AddEditPromocode";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (Session["username"] != null)
                    strCreatedby = Session["username"].ToString();

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
                if (ddlPromocodeType.SelectedValue == "1")
                {
                    decAmount = Convert.ToDecimal(txtAmountPercentage.Text.Trim());
                    strPercentage = "";
                }
                if (ddlPromocodeType.SelectedValue == "2")
                {
                    decAmount = Convert.ToDecimal(0.00);
                    strPercentage = txtAmountPercentage.Text.Trim();
                }
                var promoCodeValue = new crmEntity()
                {
                    promocode_id = pCodeId,
                    promocode_name = txtPromocodeName.Text.Trim(),
                    promocode_category_id = Convert.ToInt16(ddlPromocodeCategory.SelectedValue),
                    promocode_type_id = Convert.ToInt16(ddlPromocodeType.SelectedValue),
                    amount = decAmount,
                    percentage = strPercentage,
                    merchant_id = Convert.ToInt16(ddlOrganizationName.SelectedValue),
                    voucher_id = Convert.ToInt16(ddlVoucherName.SelectedValue),
                    start_date = dtStartDate.ToString(), //Convert.ToDateTime(dtStartDate),
                    end_date = dtEndDate.ToString(), //Convert.ToDateTime(dtEndDate),
                    created_by = strCreatedby,
                    updated_by = strCreatedby
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, promoCodeValue).Result;
                if (response.IsSuccessStatusCode)
                {
                    ScriptManager.RegisterStartupScript(up2, up2.GetType(), "Pop", "SuccessPromocodeMsg();", true);
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void ddlOrganizationName_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindVoucher();
        }


        public void BindMerchant()
        {
            ServiceUrl = "CRM/ListOfMerchant";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlOrganizationName.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlOrganizationName.Items.Insert(0, item);
            //if(ddlState.SelectedIndex != 0)
            //{ strStateID = ddlState.SelectedValue; }
            //else
            //{ strStateID = "0"; }

            var crm = new crmEntity()
            {
                search_param = ""
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var OrganizationName = response.Content.ReadAsStringAsync().Result;
                var dtOrganization = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(OrganizationName);
                if (dtOrganization.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtOrganization.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["merchant_id"].ToString())))
                        {
                            ddlOrganizationName.Items.Add(new ListItem(dtRow["organization_name"].ToString(), dtRow["merchant_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindVoucher()
        {
            ServiceUrl = "CRM/ListVoucherByMerchant";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlVoucherName.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlVoucherName.Items.Insert(0, item);
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt16(ddlOrganizationName.SelectedValue)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var VoucherName = response.Content.ReadAsStringAsync().Result;
                var dtVoucherName = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(VoucherName);
                if (dtVoucherName.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtVoucherName.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["voucher_id"].ToString())))
                        {
                            ddlVoucherName.Items.Add(new ListItem(dtRow["voucher_name"].ToString(), dtRow["voucher_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindPromocodeDetailsById(int PromocodeId)
        {
            ServiceUrl = "CRM/GetPromocodeDetailsById";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var promoCodeDetEntity = new crmEntity()
            {
                promocode_id = PromocodeId
            };
            HttpResponseMessage responsePromoCodeDet = client.PostAsJsonAsync(ServiceUrl, promoCodeDetEntity).Result;
            if (responsePromoCodeDet.IsSuccessStatusCode)
            {
                var varPcDet = responsePromoCodeDet.Content.ReadAsStringAsync().Result;
                var dtPCDet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(varPcDet);
                if (dtPCDet.Rows.Count > 0)
                {
                    txtPromocodeName.Text = dtPCDet.Rows[0]["promocode_name"].ToString();
                    if (dtPCDet.Rows[0]["promocode_type_id"].ToString() != "0")
                    {
                        ddlPromocodeType.SelectedValue = dtPCDet.Rows[0]["promocode_type_id"].ToString();
                        ddlPromocodeType.DataBind();
                    }
                    if (dtPCDet.Rows[0]["promocode_category_id"].ToString() != "0")
                    {
                        ddlPromocodeCategory.SelectedValue = dtPCDet.Rows[0]["promocode_category_id"].ToString();
                        ddlPromocodeCategory.DataBind();
                    }
                    if (dtPCDet.Rows[0]["merchant_id"].ToString() != "0")
                    {
                        ddlOrganizationName.SelectedValue = dtPCDet.Rows[0]["merchant_id"].ToString();
                        ddlOrganizationName.DataBind();
                    }
                    ddlOrganizationName_SelectedIndexChanged(this, null);
                    if (dtPCDet.Rows[0]["voucher_id"].ToString() != "0")
                    {
                        ddlVoucherName.SelectedValue = dtPCDet.Rows[0]["voucher_id"].ToString();
                        ddlVoucherName.DataBind();
                    }
                    if (ddlPromocodeType.SelectedValue == "1")
                    {
                        txtAmountPercentage.Text = dtPCDet.Rows[0]["amount"].ToString();
                        lblAmountPercentage.InnerText = "Pay By Amount";
                    }
                    if (ddlPromocodeType.SelectedValue == "2")
                    {
                        txtAmountPercentage.Text = dtPCDet.Rows[0]["percentage"].ToString();
                        lblAmountPercentage.InnerText = "Pay By Percentage";
                    }
                    txtStartDate.Text = dtPCDet.Rows[0]["start_date"].ToString();
                    txtEndDate.Text = dtPCDet.Rows[0]["end_date"].ToString();
                }
            }
        }

    }
}