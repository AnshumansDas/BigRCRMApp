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
using System.Net.Mail;

namespace CRMApp.crmapp
{
    public partial class frmMerchantAddEdit : System.Web.UI.Page
    {
        #region global declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        string dtStartDate = string.Empty, dtEndDate = string.Empty, strCreatedBy = string.Empty,
            strPerVoucherChargesByPercent = string.Empty, strMDRChargesByPercent = string.Empty;
        double strPerVoucherChargesByRM = 0, strOneTimeChargesByRM = 0, strPremiumFeesByRM = 0, dblMDRChargesByRM = 0,
            dblMDRBankFeesByRM = 0, dblMDRMinimumFeesByRM = 0;
        static string CheckImg; int MerchID = 0;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindState();
                BindMerchCategory();

                if (!string.IsNullOrEmpty(Request.QueryString["m_code"]))
                {
                    GetMerchantDetails();
                }
                else
                {
                    if (Session["merchantRegid"] != null)
                    {
                        SetMerchantData();
                    }
                }
            }
            fuMerchantLogo.Attributes["onchange"] = "UploadFile(this)";
        }

        /// <summary>
        /// Created By Anshuman on 23.01.2019 to get the Preregistration merchant Data to set on the controls
        /// </summary>
        protected void SetMerchantData()
        {
            ServiceUrl = "CRM/GetPreRegisteredMerchantInfo";
            int merchantRegId = Convert.ToInt32(Session["merchantRegid"].ToString().Trim());
            var crm = new crmEntity()
            {
                reg_id = merchantRegId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Merchant = response.Content.ReadAsStringAsync().Result;
                var dtMerchant = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Merchant);
                if (dtMerchant.Rows.Count > 0)
                {
                    txtMerchant.Text = dtMerchant.Rows[0]["merchant_name"].ToString().Trim();
                    txtMerchantRegNo.Text = dtMerchant.Rows[0]["registration_no"].ToString().Trim();
                    txtPersonInCharge.Text = dtMerchant.Rows[0]["person_incharge_name"].ToString().Trim();
                    txtEmail.Text = dtMerchant.Rows[0]["company_email"].ToString().Trim();
                    if (Session["merchantRegid"] != null)
                    { txtMerchantRegNo.Enabled = false; txtEmail.Enabled = false; }
                    else
                    { txtMerchantRegNo.Enabled = true; txtEmail.Enabled = true; }
                    txtOfficeNo.Text = dtMerchant.Rows[0]["phone_no"].ToString().Trim();
                }
            }
        }

        #region merchant
        public void BindState()
        {
            ServiceUrl = "CRM/GetStateDetails";
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
            ServiceUrl = "CRM/GetCityListing";
            ddlCity.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlCity.Items.Insert(0, item);
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
            ddlMerchantCategory.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlMerchantCategory.Items.Insert(0, item);
            ServiceUrl = "CRM/GetMerchantCatByActive";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
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
            ServiceUrl = "CRM/ListMerchantDetails";
            if (!string.IsNullOrEmpty(Request.QueryString["m_code"].Trim()))
            {
                MerchID = Convert.ToInt16(Request.QueryString["m_code"].Trim());
            }

            var crm = new crmEntity()
            {
                merchant_id = MerchID
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
                    if (!string.IsNullOrEmpty(Request.QueryString["m_code"].Trim()))
                    { txtMerchantRegNo.Enabled = false; txtEmail.Enabled = false; }
                    else
                    { txtMerchantRegNo.Enabled = true; txtEmail.Enabled = true; }

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
                    #region PerVoucher
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
                    #endregion
                    #region VoucherSalesProfit
                    if (ddlFeesCategory.SelectedValue == "VoucherSalesProfit")
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
                    #endregion
                    //OnboardingFees
                    else if (ddlFeesCategory.SelectedValue == "OnboardingFees")
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

                    #region MDR fees
                    ddlMDRChargesType.SelectedValue = dtChargeType.Rows[0]["mdr_charges_type"].ToString().Trim();
                    if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["mdr_bank_fees"].ToString().Trim()))
                    {
                        dblMDRBankFeesByRM = Convert.ToDouble(dtChargeType.Rows[0]["mdr_bank_fees"].ToString().Trim());
                        txtMDRBankFees.Text = dblMDRBankFeesByRM.ToString("N2").Trim();
                    }
                    else
                    { txtMDRBankFees.Text = dblMDRBankFeesByRM.ToString("N2").Trim(); }

                    if (ddlMDRChargesType.SelectedValue == "MDRChargesTypeByRM")
                    {
                        dvOr.Visible = false; dvHigher.Visible = false;
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["mdr_chargesby_rm"].ToString().Trim()))
                        {
                            dblMDRChargesByRM = Convert.ToDouble(dtChargeType.Rows[0]["mdr_chargesby_rm"].ToString().Trim());
                            dvMDRChargesbyRM.Visible = true;
                            txtMDRChargesbyRM.Text = dblMDRChargesByRM.ToString("N2").Trim();
                        }
                        else
                        { txtMDRChargesbyRM.Text = dblMDRChargesByRM.ToString("N2").Trim(); }
                    }
                    else if (ddlMDRChargesType.SelectedValue == "MDRChargesTypeByPercent")
                    {
                        dvOr.Visible = false; dvHigher.Visible = false;
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["mdr_chargesby_percent"].ToString().Trim()))
                        {
                            dvMDRChargesbyPercent.Visible = true;
                            txtMDRChargesbyPercent.Text = dtChargeType.Rows[0]["mdr_chargesby_percent"].ToString().Trim();
                        }
                        else
                        { txtMDRChargesbyPercent.Text = string.Empty; }
                    }
                    else if (ddlMDRChargesType.SelectedValue == "MDRBothType")
                    {
                        dvOr.Visible = true; dvHigher.Visible = true;
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["mdr_chargesby_percent"].ToString().Trim()))
                        {
                            dvMDRChargesbyPercent.Visible = true;
                            txtMDRChargesbyPercent.Text = dtChargeType.Rows[0]["mdr_chargesby_percent"].ToString().Trim();
                        }
                        else
                        { txtMDRChargesbyPercent.Text = string.Empty; }

                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["mdr_min_fees"].ToString().Trim()))
                        {
                            dblMDRMinimumFeesByRM = Convert.ToDouble(dtChargeType.Rows[0]["mdr_min_fees"].ToString().Trim());
                            dvMDRMinimumFees.Visible = true;
                            txtMDRMinimumFees.Text = dblMDRMinimumFeesByRM.ToString("N2").Trim();
                        }
                        else
                        { txtMDRMinimumFees.Text = dblMDRMinimumFeesByRM.ToString("N2").Trim(); }
                    }
                    #endregion
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
            Session["merchantRegid"] = null;
            Response.Redirect("frmMerchant.aspx");
        }

        protected void UploadFile(object sender, EventArgs e)
        {
            if (fuMerchantLogo.HasFile)
            {
                string strpath = System.IO.Path.GetExtension(fuMerchantLogo.FileName);
                int maxFileLength = 2000000;
                if (strpath.ToLower() == ".jpg" || strpath.ToLower() == ".jpeg" || strpath.ToLower() == ".png")
                {
                    if (fuMerchantLogo.PostedFile.ContentLength > maxFileLength)
                    {
                        logovalidatemsg.InnerText = String.Format("Your file size has {0:#,##0} bytes which exceeded the limit of 2MB. Please upload a smaller file.", fuMerchantLogo.PostedFile.ContentLength);
                    }
                    else
                    {
                        //fuMerchantLogo.SaveAs(HttpContext.Current.Server.MapPath("~//crmapp//merchant//" + fuMerchantLogo.FileName));
                        //Added By Mani on 18MAr2019 the below code for Replacing the spacing with Underscore (IOS,ANDROID and FB).
                        //CheckImg = fuMerchantLogo.PostedFile.FileName;
                        CheckImg = fuMerchantLogo.PostedFile.FileName.Replace(" ", "_");
                        var filePath = Server.MapPath("~/crmapp/merchant/" + CheckImg);
                        if (File.Exists(filePath))
                        {
                            File.Delete(filePath);

                            fuMerchantLogo.SaveAs(HttpContext.Current.Server.MapPath("~//crmapp//merchant//" + fuMerchantLogo.FileName.Replace(" ", "_")));
                            imgMerchantLogo.ImageUrl = "../crmapp/merchant/" + Path.GetFileName(fuMerchantLogo.FileName.Replace(" ", "_"));
                            uploadmsg.InnerText = "File uploaded!";
                            uploadmsg.Style.Add("color", "DarkGreen");
                            logovalidatemsg.InnerText = string.Empty;
                        }
                        else
                        {
                            fuMerchantLogo.SaveAs(HttpContext.Current.Server.MapPath("~//crmapp//merchant//" + fuMerchantLogo.FileName.Replace(" ", "_")));
                            imgMerchantLogo.ImageUrl = "../crmapp/merchant/" + Path.GetFileName(fuMerchantLogo.FileName.Replace(" ", "_"));
                            uploadmsg.InnerText = "File uploaded!";
                            uploadmsg.Style.Add("color", "DarkGreen");
                            logovalidatemsg.InnerText = string.Empty;
                        }
                    }
                }
                else
                {
                    logovalidatemsg.InnerText = "Invalid file format!";
                }
            }
            else
            {
                uploadmsg.InnerText = "Failed to upload!";
                uploadmsg.Style.Add("color", "Red");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["m_code"]))
            {
                SaveMerchInfo(Request.QueryString["m_code"].ToString().Trim());
            }
            else
            {
                #region check existing merch registration no & email
                if (Session["merchantRegid"] != null)
                {
                    SaveMerchInfo(string.Empty);
                }
                else
                {
                    if (!string.IsNullOrEmpty(txtMerchantRegNo.Text.Trim()))
                    {
                        ServiceUrl = "CRM/ValidateExistingMerchantRegNo";
                        HttpResponseMessage responseregno = new HttpResponseMessage();
                        var validateregno = new crmEntity()
                        {
                            company_reg_number = txtMerchantRegNo.Text.Trim(),
                        };
                        responseregno = client.PostAsJsonAsync(ServiceUrl, validateregno).Result;
                        if (responseregno.IsSuccessStatusCode)
                        {
                            var RegNoList = responseregno.Content.ReadAsStringAsync().Result;
                            var dtRegNo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RegNoList);
                            if (dtRegNo.Rows.Count > 0)
                            {
                                dvRegNoCheck.Visible = true;
                                checkregnomsg.InnerText = "Registration number was existed in system.";
                            }
                            else
                            {
                                dvRegNoCheck.Visible = false;
                                checkregnomsg.InnerText = string.Empty;
                                #region check existing email
                                if (!string.IsNullOrEmpty(txtEmail.Text.Trim()))
                                {
                                    ServiceUrl = "CRM/ValidateExistingMerchantEmail";
                                    HttpResponseMessage responseemail = new HttpResponseMessage();
                                    var validateemail = new crmEntity()
                                    {
                                        email_id = txtEmail.Text.Trim(),
                                    };
                                    responseemail = client.PostAsJsonAsync(ServiceUrl, validateemail).Result;
                                    if (responseemail.IsSuccessStatusCode)
                                    {
                                        var EmailList = responseemail.Content.ReadAsStringAsync().Result;
                                        var dtEmail = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(EmailList);
                                        if (dtEmail.Rows.Count > 0)
                                        {
                                            checkemailmsg.InnerText = "Email was existed & please add new email.";
                                            checkemailmsg.Style.Add("color", "Red");
                                            checkemailmsg.Visible = true;
                                        }
                                        else
                                        {
                                            checkemailmsg.Visible = false;
                                            checkemailmsg.InnerText = string.Empty;
                                            SaveMerchInfo(string.Empty);
                                        }
                                    }
                                    else
                                    {
                                        message.InnerText = responseemail.ReasonPhrase.ToString();
                                        message.Style.Add("color", "Red");
                                    }
                                }
                                #endregion
                            }
                        }
                        else
                        {
                            message.InnerText = responseregno.ReasonPhrase.ToString();
                            message.Style.Add("color", "Red");
                        }
                    }
                }
                #endregion
            }
        }

        public void SaveMerchInfo(string strMerchID)
        {
            try
            {
                if (!string.IsNullOrEmpty(strMerchID))
                {
                    MerchID = Convert.ToInt16(strMerchID.Trim());
                }

                #region value retrieve
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                {
                    strCreatedBy = Session["username"].ToString();
                }
                else { strCreatedBy = "metroadmin123"; }

                #region fees value
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
                else if (ddlFeesCategory.SelectedValue == "VoucherSalesProfit")
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
                else if (ddlFeesCategory.SelectedValue == "OnboardingFees")
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

                if (!string.IsNullOrEmpty(txtEndDate.Text.Trim()))
                {
                    string[] endtokens = txtEndDate.Text.Split('/');
                    dtEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                }
                else
                {
                    dtEndDate = "1900-01-01";
                }
                #endregion

                #region MDR fees value
                if (string.IsNullOrEmpty(txtMDRBankFees.Text.Trim()))
                { dblMDRBankFeesByRM = 0; }
                else { dblMDRBankFeesByRM = Convert.ToDouble(txtMDRBankFees.Text.Trim()); }

                if (ddlMDRChargesType.SelectedValue == "MDRChargesTypeByRM")
                {
                    if (string.IsNullOrEmpty(txtMDRChargesbyRM.Text.Trim()))
                    { dblMDRChargesByRM = 0; }
                    else { dblMDRChargesByRM = Convert.ToDouble(txtMDRChargesbyRM.Text.Trim()); }
                }
                else if (ddlMDRChargesType.SelectedValue == "MDRChargesTypeByPercent")
                {
                    if (string.IsNullOrEmpty(txtMDRChargesbyPercent.Text.Trim()))
                    { strMDRChargesByPercent = string.Empty; }
                    else { strMDRChargesByPercent = txtMDRChargesbyPercent.Text.Trim(); }
                }
                else if (ddlMDRChargesType.SelectedValue == "MDRBothType")
                {
                    if (string.IsNullOrEmpty(txtMDRChargesbyPercent.Text.Trim()))
                    { strMDRChargesByPercent = string.Empty; }
                    else { strMDRChargesByPercent = txtMDRChargesbyPercent.Text.Trim(); }

                    if (string.IsNullOrEmpty(txtMDRMinimumFees.Text.Trim()))
                    { dblMDRMinimumFeesByRM = 0; }
                    else { dblMDRMinimumFeesByRM = Convert.ToDouble(txtMDRMinimumFees.Text.Trim()); }
                }
                #endregion
                #endregion

                ServiceUrl = "CRM/AddEditMerchantDetails";
                var crm = new crmEntity()
                {
                    merchant_id = MerchID,
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
                    state_id = Convert.ToInt16(ddlState.SelectedValue.ToString().Trim()),
                    city_id = Convert.ToInt16(ddlCity.SelectedValue.ToString().Trim()),
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
                    end_date = dtEndDate,
                    mdr_charges_type = ddlMDRChargesType.SelectedValue.Trim(),
                    mdr_bank_fees = Convert.ToDecimal(dblMDRBankFeesByRM.ToString("N2").Trim()),
                    mdr_chargesby_rm = Convert.ToDecimal(dblMDRChargesByRM.ToString("N2").Trim()),
                    mdr_chargesby_percent = strMDRChargesByPercent.Trim(),
                    mdr_min_fees = Convert.ToDecimal(dblMDRMinimumFeesByRM.ToString("N2").Trim())
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    #region Anshuman Pre Registration
                    // Addded By Anshuman to Update the Preregistartion Status to uptate
                    if (Session["merchantRegid"] != null)
                    {
                        UpdatePreRegistrationStatus();
                    }
                    #endregion
                    #region create merch user
                    if (MerchID == 0)
                    {
                        var MerchList = response.Content.ReadAsStringAsync().Result;
                        var dtmerch = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MerchList);
                        if (dtmerch.Rows.Count > 0)
                        {
                            string strMcode = dtmerch.Rows[0]["merchant_code"].ToString().Trim();
                            CreateMerchantUser(strMcode);
                        }
                    }
                    #endregion
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessMsg();", true);
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

        #region create merch user
        protected void CreateMerchantUser(string strVal)
        {
            ServiceUrl = "CRM/CreateMerchantUserByAdmin";
            var crm = new crmEntity()
            {
                merchant_code = strVal.Trim(),
                company_regno = txtMerchantRegNo.Text.Trim(),
                user_name = txtPersonInCharge.Text.Trim(),
                email_id = txtEmail.Text.Trim(),
                created_by = Session["username"].ToString()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Productlist = response.Content.ReadAsStringAsync().Result;
                var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                if (DataTable.Rows.Count > 0)
                {
                    string readUserFile = string.Empty, myStringUser = string.Empty;
                    try
                    {
                        // USER EMAIL
                        StreamReader readerUser = new StreamReader(Server.MapPath("~/crmapp/createmerchuserbyadmin_email.html"));
                        readUserFile = readerUser.ReadToEnd();
                        myStringUser = readUserFile;
                        myStringUser = myStringUser.Replace("$$MemberName$$", DataTable.Rows[0]["user_fistname"].ToString().Trim());
                        myStringUser = myStringUser.Replace("$$UserName$$", DataTable.Rows[0]["user_name"].ToString().Trim());
                        myStringUser = myStringUser.Replace("$$UserPassword$$", DataTable.Rows[0]["user_password"].ToString().Trim());
                        string strEmailID = DataTable.Rows[0]["email_id"].ToString().Trim();
                        SendEmail(strEmailID.Trim(), "BigR - Successful Registration.", myStringUser);
                        readerUser.Close();
                        readerUser.Dispose();
                    }
                    catch (Exception ex)
                    {
                        message.InnerText = ex.Message.ToString();
                        return;
                    }
                }
            }
        }

        protected void SendEmail(string to_sender, string subject, string strmessage)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient();
                string s = string.Empty;
                s = strFromEmail;
                mail.From = new MailAddress(s);
                mail.To.Add(to_sender);
                mail.Subject = subject;
                mail.Body = strmessage;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                message.InnerText = ex.Message.ToString();
                return;
            }
        }
        #endregion

        #region Update Pre Reg
        protected void UpdatePreRegistrationStatus()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/UpdateMerchantRegistrationDetails";
            int merchantRegId = Convert.ToInt32(Session["merchantRegid"].ToString().Trim());
            var crm = new crmEntity()
            {
                reg_id = merchantRegId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
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
            else if (ddlFeesCategory.SelectedValue.Trim() == "VoucherSalesProfit")
            { ddlChargesType.SelectedIndex = 0; dvChargesType.Visible = true; dvChargesbyPercent.Visible = false; dvChargesbyRM.Visible = false; }
            else if (ddlFeesCategory.SelectedValue.Trim() == "OnboardingFees")
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

        #region MDR Fees
        protected void ddlMDRChargesType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlMDRChargesType.SelectedValue.Trim() == "MDRChargesTypeByRM")
            {
                dvMDRChargesbyPercent.Visible = false; dvMDRChargesbyRM.Visible = true; dvMDRMinimumFees.Visible = false;
                dvOr.Visible = false; dvHigher.Visible = false;
            }
            else if (ddlMDRChargesType.SelectedValue.Trim() == "MDRChargesTypeByPercent")
            {
                dvMDRChargesbyPercent.Visible = true; dvMDRChargesbyRM.Visible = false; dvMDRMinimumFees.Visible = false;
                dvOr.Visible = false; dvHigher.Visible = false;
            }
            else if (ddlMDRChargesType.SelectedValue.Trim() == "MDRBothType")
            {
                dvMDRChargesbyPercent.Visible = true; dvMDRChargesbyRM.Visible = false; dvMDRMinimumFees.Visible = true;
                dvOr.Visible = true; dvHigher.Visible = true;
            }
            else
            {
                dvMDRChargesbyPercent.Visible = false; dvMDRChargesbyRM.Visible = false; dvMDRMinimumFees.Visible = false;
                dvOr.Visible = false; dvHigher.Visible = false;
            }
        }
        #endregion
    }
}