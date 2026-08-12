using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Data;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using Newtonsoft.Json.Linq;

namespace CRMApp.crmapp
{
    public partial class frmMerchantProfile : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = string.Empty;
        string dtEndDate = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (Session["roleid"].ToString() == "5")
            {
                if (!Page.IsPostBack)
                {
                    BindState();
                    BindMerchCategory();
                    GetMerchantDetails();
                    BindSupportDocument();

                }
                fuMerchantLogo.Attributes["onchange"] = "UploadFile(this)";
                FileUploadDoc.Attributes["onchange"] = "UploadFile1(this)";
            }
        }

        #region merchant
        public void BindState()
        {
            ServiceUrl = "CRM/GetStateDetails";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlState.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlState.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["State_name"].ToString())))
                        {
                            ddlState.Items.Add(new ListItem(dtRow["state_name"].ToString(), dtRow["state_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindCity(string strVal)
        {
            string strStateID = string.Empty;
            ServiceUrl = "CRM/GetCityListing";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlCity.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlCity.Items.Insert(0, item);
            //if(ddlState.SelectedIndex != 0)
            //{ strStateID = ddlState.SelectedValue; }
            //else
            //{ strStateID = "0"; }

            var crm = new crmEntity()
            {
                state_id = Convert.ToInt16(strVal.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var City = response.Content.ReadAsStringAsync().Result;
                var dtCity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(City);
                if (dtCity.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtCity.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["city_name"].ToString())))
                        {
                            ddlCity.Items.Add(new ListItem(dtRow["city_name"].ToString(), dtRow["city_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity(ddlState.SelectedValue.Trim());
        }

        public void BindMerchCategory()
        {
            string strMerchCatID = string.Empty;
            ServiceUrl = "CRM/ListOfMerchantCategory";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ddlMerchantCategory.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlMerchantCategory.Items.Insert(0, item);
            if (ddlMerchantCategory.SelectedIndex != 0)
            { strMerchCatID = ddlMerchantCategory.SelectedValue; }
            else
            { strMerchCatID = "0"; }

            var crm = new crmEntity()
            {
                merchant_cat_id = Convert.ToInt16(strMerchCatID.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var MerchCat = response.Content.ReadAsStringAsync().Result;
                var dtMerchCat = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MerchCat);
                if (dtMerchCat.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtMerchCat.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["merchant_category"].ToString())))
                        {
                            ddlMerchantCategory.Items.Add(new ListItem(dtRow["merchant_category"].ToString(), dtRow["merchant_cat_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void GetMerchantDetails()
        {
            string strMerchCode = string.Empty;
            double strPerVoucherChargesByRM = 0;
            double strOneTimeChargesByRM = 0;
            double strPremiumFeesByRM = 0;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListMerchantDetails";
            if (Session["Merchant_Code"].ToString().Trim() != null)
            { strMerchCode = Session["Merchant_Code"].ToString().Trim(); }

            var crm = new crmEntity()
            {
                merchant_code = strMerchCode.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    lblMerchantCode.Text = dtChargeType.Rows[0]["merchant_code"].ToString().Trim();
                    txtMerchant.Text = dtChargeType.Rows[0]["organization_name"].ToString().Trim();
                    ddlMerchantCategory.SelectedValue = dtChargeType.Rows[0]["merchant_cat_id"].ToString().Trim();
                    txtMerchantRegNo.Text = dtChargeType.Rows[0]["merchant_number"].ToString().Trim();
                    txtPersonInCharge.Text = dtChargeType.Rows[0]["person_incharge"].ToString().Trim();
                    txtMobileNo.Text = dtChargeType.Rows[0]["mobile_phone"].ToString().Trim();
                    txtOfficeNo.Text = dtChargeType.Rows[0]["office_phone"].ToString().Trim();
                    txtFaxNo.Text = dtChargeType.Rows[0]["fax_no"].ToString().Trim();
                    txtAddress1.Text = dtChargeType.Rows[0]["address_1"].ToString().Trim();
                    txtAddress2.Text = dtChargeType.Rows[0]["address_2"].ToString().Trim();
                    txtPostcode.Text = dtChargeType.Rows[0]["postcode"].ToString().Trim();
                    ddlState.SelectedValue = dtChargeType.Rows[0]["state_id"].ToString().Trim();
                    BindCity(ddlState.SelectedValue.Trim());
                    ddlCity.SelectedValue = dtChargeType.Rows[0]["city_id"].ToString().Trim();
                    txtEmail.Text = dtChargeType.Rows[0]["email"].ToString().Trim();
                    txtMerchantWebURL.Text = dtChargeType.Rows[0]["website"].ToString().Trim();
                    if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["merchant_logo"].ToString().Trim()))
                    {
                        imgMerchantLogo.ImageUrl = dtChargeType.Rows[0]["merchant_logo"].ToString().Trim();
                    }
                    else
                    {
                        uploadmsg.InnerText = "No logo";
                        uploadmsg.Style.Add("color", "Red");
                    }
                    ddlActiveStatus.SelectedValue = dtChargeType.Rows[0]["status"].ToString().Trim();

                    ddlFeesCategory.SelectedValue = dtChargeType.Rows[0]["fees_category"].ToString().Trim();
                    if (ddlFeesCategory.SelectedValue == "PerVoucher")
                    {
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim()))
                        {
                            dvChargesType.Visible = true;
                            ddlChargesType.SelectedValue = "ChargesTypeByPercent";
                            dvChargesbyPercent.Visible = true;
                            txtChargesbyPercent.Text = dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim();
                        }
                        else if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim()))
                        {
                            strPerVoucherChargesByRM = Convert.ToDouble(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim());
                            dvChargesType.Visible = true;
                            ddlChargesType.SelectedValue = "ChargesTypeByRM";
                            dvChargesbyRM.Visible = true;
                            txtChargesbyRM.Text = strPerVoucherChargesByRM.ToString("N2").Trim();
                        }
                    }
                    else if (ddlFeesCategory.SelectedValue == "OneTimeCharges")
                    {
                        strOneTimeChargesByRM = Convert.ToDouble(dtChargeType.Rows[0]["yearly_one_time_charges_rm"].ToString().Trim());
                        dvChargesbyRM.Visible = true;
                        txtChargesbyRM.Text = strOneTimeChargesByRM.ToString("N2").Trim();
                    }

                    if (dtChargeType.Rows[0]["is_premium_merchant"].ToString().Trim() == "1")
                    {
                        chkPremiumStatus.Checked = true;
                        strPremiumFeesByRM = Convert.ToDouble(dtChargeType.Rows[0]["premium_fees"].ToString().Trim());
                        txtPremiumFees.Text = strPremiumFeesByRM.ToString("N2").Trim();
                    }
                    else if (dtChargeType.Rows[0]["is_premium_merchant"].ToString().Trim() == "0")
                    {
                        chkPremiumStatus.Checked = false;
                        strPremiumFeesByRM = Convert.ToDouble(dtChargeType.Rows[0]["premium_fees"].ToString().Trim());
                        txtPremiumFees.Text = strPremiumFeesByRM.ToString("N2").Trim();
                    }

                    if (dtChargeType.Rows[0]["startdate"].ToString().Trim() != "01/01/1900")
                    { txtStartDate.Text = dtChargeType.Rows[0]["startdate"].ToString().Trim(); }
                    else { txtStartDate.Text = string.Empty; }

                    if (dtChargeType.Rows[0]["enddate"].ToString().Trim() != "01/01/1900")
                    { txtEndDate.Text = dtChargeType.Rows[0]["enddate"].ToString().Trim(); }
                    else { txtEndDate.Text = string.Empty; }
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Session["roleid"].ToString() == "5")
            { Response.Redirect("frmMerchantDashboard.aspx"); }
            else { Response.Redirect("frmMerchant.aspx"); }
        }

        protected void UploadFile(object sender, EventArgs e)
        {
            if (fuMerchantLogo.HasFile)
            {
                fuMerchantLogo.SaveAs(HttpContext.Current.Server.MapPath("~//crmapp//merchant//" + fuMerchantLogo.FileName));
                imgMerchantLogo.ImageUrl = "/crmapp/merchant/" + Path.GetFileName(fuMerchantLogo.FileName);
                uploadmsg.InnerText = "File uploaded!";
                uploadmsg.Style.Add("color", "DarkGreen");
            }
            else
            {
                uploadmsg.InnerText = "Failed to upload!";
                uploadmsg.Style.Add("color", "Red");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string strCreatedBy = string.Empty;
                string strPerVoucherChargesByPercent = string.Empty;
                double strPerVoucherChargesByRM = 0;
                double strOneTimeChargesByRM = 0;
                double strPremiumFeesByRM = 0;
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = "metroadmin123"; }

                if (ddlFeesCategory.SelectedValue == "PerVoucher")
                {
                    if (ddlChargesType.SelectedValue == "ChargesTypeByRM")
                    {
                        if (string.IsNullOrEmpty(txtChargesbyRM.Text.Trim()))
                        { strPerVoucherChargesByRM = 0; }
                        else { strPerVoucherChargesByRM = Convert.ToDouble(txtChargesbyRM.Text.Trim()); }
                    }
                    else if (ddlChargesType.SelectedValue == "ChargesTypeByPercent")
                    {
                        if (string.IsNullOrEmpty(txtChargesbyPercent.Text.Trim()))
                        { strPerVoucherChargesByPercent = string.Empty; }
                        else { strPerVoucherChargesByPercent = txtChargesbyPercent.Text.Trim(); }
                    }
                }
                else if (ddlFeesCategory.SelectedValue == "OneTimeCharges")
                {
                    if (string.IsNullOrEmpty(txtChargesbyRM.Text.Trim()))
                    { strOneTimeChargesByRM = 0; }
                    else { strOneTimeChargesByRM = Convert.ToDouble(txtChargesbyRM.Text.Trim()); }
                }

                if (string.IsNullOrEmpty(txtPremiumFees.Text.Trim()))
                { strPremiumFeesByRM = 0; }
                else { strPremiumFeesByRM = Convert.ToDouble(txtPremiumFees.Text.Trim()); }

                if (!string.IsNullOrEmpty(txtStartDate.Text.Trim()))
                {
                    string[] starttokens = txtStartDate.Text.Split('/');
                    dtStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                }
                else
                {
                    dtStartDate = "1900-01-01";
                }

                if (!string.IsNullOrEmpty(txtStartDate.Text.Trim()))
                {
                    string[] endtokens = txtEndDate.Text.Split('/');
                    dtEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                }
                else
                {
                    dtEndDate = "1900-01-01";
                }

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/AddEditMerchantDetails";
                var crm = new crmEntity()
                {
                    merchant_code = lblMerchantCode.Text,
                    organization_name = txtMerchant.Text,
                    company_reg_number = txtMerchantRegNo.Text,
                    merchant_cat_id = Convert.ToInt16(ddlMerchantCategory.SelectedValue.Trim()),
                    person_incharge = txtPersonInCharge.Text,
                    mobile_no = txtMobileNo.Text,
                    office_phone = txtOfficeNo.Text,
                    fax_no = txtFaxNo.Text,
                    address_1 = txtAddress1.Text,
                    address_2 = txtAddress2.Text,
                    postcode = txtPostcode.Text,
                    state_id = Convert.ToInt16(ddlState.SelectedValue.Trim()),
                    city_id = Convert.ToInt16(ddlCity.SelectedValue.Trim()),
                    email = txtEmail.Text,
                    website = txtMerchantWebURL.Text,
                    merchant_logo = imgMerchantLogo.ImageUrl,
                    active_status = Convert.ToInt16(ddlActiveStatus.SelectedValue.Trim()),
                    user_by = strCreatedBy,
                    fees_category = ddlFeesCategory.SelectedValue.Trim(),
                    per_voucher_chargesby_percent = strPerVoucherChargesByPercent.Trim(),
                    per_voucher_chargesby_rm = Convert.ToDecimal(strPerVoucherChargesByRM.ToString("N2").Trim()),
                    yearly_one_time_charges_rm = Convert.ToDecimal(strOneTimeChargesByRM.ToString("N2").Trim()),
                    is_premium_merchant = Convert.ToInt16(chkPremiumStatus.Checked ? "1" : "0"),
                    premium_fees = Convert.ToDecimal(strPremiumFeesByRM.ToString("N2").Trim()),
                    start_date = dtStartDate,
                    end_date = dtEndDate
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    if (Session["roleid"].ToString() == "5")
                    { ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "MerchUserSuccessMsg();", true); }
                    else { ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessMsg();", true); }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }
        #endregion

        #region fees
        protected void ddlChargesType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlChargesType.SelectedValue.Trim() == "ChargesTypeByPercent")
            { dvChargesbyPercent.Visible = true; dvChargesbyRM.Visible = false; }
            else if (ddlChargesType.SelectedValue.Trim() == "ChargesTypeByRM")
            { dvChargesbyPercent.Visible = false; dvChargesbyRM.Visible = true; }
            else { dvChargesbyPercent.Visible = false; dvChargesbyRM.Visible = false; }
        }

        protected void ddlFeesCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFeesCategory.SelectedValue.Trim() == "PerVoucher")
            { ddlChargesType.SelectedIndex = 0; dvChargesType.Visible = true; dvChargesbyPercent.Visible = false; dvChargesbyRM.Visible = false; }
            else if (ddlFeesCategory.SelectedValue.Trim() == "OneTimeCharges")
            { dvChargesbyRM.Visible = true; dvChargesType.Visible = false; dvChargesbyPercent.Visible = false; }
            else { dvChargesType.Visible = false; dvChargesbyPercent.Visible = false; dvChargesbyRM.Visible = false; }
        }

        protected void chkPremiumStatus_CheckedChanged(object sender, EventArgs e)
        {
            if (chkPremiumStatus.Checked == true)
            { txtPremiumFees.Enabled = true; }
            else { txtPremiumFees.Enabled = false; }
        }
        #endregion

        #region support document
        protected void UploadDoc(object sender, EventArgs e)
        {
            if (FileUploadDoc.HasFile)
            {
                try
                {
                    FileUploadDoc.SaveAs(HttpContext.Current.Server.MapPath("/crmapp/merchant_doc/" + FileUploadDoc.FileName));
                    ViewState["doc_file_path"] = "/crmapp/merchant_doc/" + Path.GetFileName(FileUploadDoc.FileName);
                    uploaddocmsg.InnerText = "File uploaded :" + FileUploadDoc.FileName;
                    uploaddocmsg.Style.Add("color", "DarkGreen");
                }
                catch (Exception ex)
                {
                    uploaddocmsg.InnerText = "Error occured: " + ex.Message;
                    uploaddocmsg.Style.Add("color", "Red");
                }
            }
            else
            { ViewState["doc_file_path"] = string.Empty; }
        }

        protected void lnkAddSupportDoc_Click(object sender, EventArgs e)
        {
            try
            {
                string strCreatedBy = string.Empty;
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = "metroadmin123"; }

                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/AddEditMerchantSupportDocument";
                var crm = new crmEntity()
                {
                    merchant_code = lblMerchantCode.Text,
                    user_by = strCreatedBy,
                    document_name = txtDocName.Text,
                    doc_file_path = ViewState["doc_file_path"].ToString().Trim(),
                    doc_date = DateTime.Now
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    txtDocName.Text = string.Empty;
                    BindSupportDocument();
                }
                else
                {
                    adddocmsg.InnerText = response.ReasonPhrase.ToString();
                    adddocmsg.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                adddocmsg.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void lvSupportDoc_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvSupportDoc.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    DataTable dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }
        }

        protected void lvSupportDoc_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Delete")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvSupportDoc.DataKeys[commentItem.DisplayIndex][0].ToString();
                    string strFilePath = (string)lvSupportDoc.DataKeys[commentItem.DisplayIndex][1].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        string path = Server.MapPath(strFilePath);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                            try
                            {
                                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                ServiceUrl = "CRM/DeleteMerchantSupportDocument";
                                var crm = new crmEntity()
                                {
                                    doc_id = Convert.ToInt16(contentID.Trim())
                                };
                                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    BindSupportDocument();
                                }
                                else
                                {
                                    adddocmsg.InnerText = response.ReasonPhrase.ToString();
                                    adddocmsg.Style.Add("color", "Red");
                                }
                            }
                            catch (Exception ex)
                            {
                                adddocmsg.InnerText = ex.Message.ToString();
                                return;
                            }
                        }
                        else
                        {
                            try
                            {
                                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                ServiceUrl = "CRM/DeleteMerchantSupportDocument";
                                var crm = new crmEntity()
                                {
                                    doc_id = Convert.ToInt16(contentID.Trim())
                                };
                                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    BindSupportDocument();
                                }
                                else
                                {
                                    adddocmsg.InnerText = response.ReasonPhrase.ToString();
                                    adddocmsg.Style.Add("color", "Red");
                                }
                            }
                            catch (Exception ex)
                            {
                                adddocmsg.InnerText = ex.Message.ToString();
                                return;
                            }
                        }
                    }
                }
            }
        }

        protected void lvSupportDoc_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        public void BindSupportDocument()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListMerchantSupportDocumentDetails";
            var crm = new crmEntity()
            {
                merchant_code = lblMerchantCode.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvSupportDoc.DataSource = dtChargeType;
                    lvSupportDoc.DataBind();
                }
                else
                {
                    lvSupportDoc.DataSource = dtChargeType;
                    lvSupportDoc.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void lvSupportDoc_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvSupportDoc.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindSupportDocument();
        }
        #endregion
    }
}