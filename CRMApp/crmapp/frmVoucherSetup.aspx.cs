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
    public partial class frmVoucherSetup : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, voucherCode = string.Empty;
        static int voucherCatId = 0, sstinclude = 0;
        static decimal sst = 0;
        HttpResponseMessage response = null;
        HttpResponseMessage responseoutlet = null;
        ListItem v_lst1, v_lst2, v_lst3, v_lst4, v_lst5, v_lst6, v_lst7;
        int Product, Company, Type, Category, ImagePath, voucherID, ActiveStatus, subCategoryID;
        static string generatedBy = string.Empty, VoucherImg, VoucherImg2, VoucherImg3, VoucherImg4, VoucherImg5, voucherRefID,
            vrNo, vrNo2, vrNo3, vrNo4, vrNo5, extension;
        string ckfinder = ConfigurationManager.AppSettings["ckfinder"].ToString();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindMerchant();
                    BindVoucherCategory();
                    BindSstValue();
                    if (Request.QueryString["voucher_id"] != "0")
                    {
                        voucherID = Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim());
                        SetData(Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim()));
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
            CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser();
            _FileBrowser.BasePath = ckfinder;
            _FileBrowser.SetupCKEditor(txtVoucherDescription);
            _FileBrowser.SetupCKEditor(TxtRedeemOffer);
            _FileBrowser.SetupCKEditor(Reservation);
            _FileBrowser.SetupCKEditor(RedeemInstruction);
        }

        protected void SetData(int voucherId)
        {
            try
            {
                ServiceUrl = "CRM/GetVoucherDetailsById";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl + "?voucherId=" + voucherId).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Productlist = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                    if (DataTable.Rows.Count > 0)
                    {
                        v_lst2 = ddlMerchant.Items.FindByText(DataTable.Rows[0]["merchant_name"].ToString().Trim());
                        Company = ddlMerchant.Items.IndexOf(v_lst2);
                        ddlMerchant.ClearSelection();
                        ddlMerchant.SelectedIndex = Company;
                        BindOutlets();
                        GetFeeCategory();

                        v_lst4 = ddlCategory.Items.FindByText(DataTable.Rows[0]["voucher_main_category"].ToString().Trim());
                        Category = ddlCategory.Items.IndexOf(v_lst4);
                        ddlCategory.ClearSelection();
                        ddlCategory.SelectedIndex = Category;
                        BindVoucherSubCategory();

                        v_lst5 = ddlSubCategory.Items.FindByText(DataTable.Rows[0]["voucher_sub_category"].ToString().Trim());
                        subCategoryID = ddlSubCategory.Items.IndexOf(v_lst5);
                        ddlSubCategory.ClearSelection();
                        ddlSubCategory.SelectedIndex = subCategoryID;

                        v_lst6 = ddlActiveStatus.Items.FindByValue(DataTable.Rows[0]["active_status"].ToString().Trim());
                        ActiveStatus = ddlActiveStatus.Items.IndexOf(v_lst6);
                        ddlActiveStatus.ClearSelection();
                        ddlActiveStatus.SelectedIndex = ActiveStatus;
                        if (Convert.ToInt32(DataTable.Rows[0]["is_sst"].ToString().Trim()) == 1)
                        {
                            included.Checked = true;
                            excluded.Checked = false;
                        }
                        else
                        {
                            excluded.Checked = true;
                            included.Checked = false;
                        }
                        if (DataTable.Rows[0]["generatedby"].ToString().Trim() == "System")
                        {
                            rbtnvoucher1.Checked = true;
                            rbtnUpload.Checked = false;
                        }
                        else
                        {
                            rbtnUpload.Checked = true;
                            rbtnvoucher1.Checked = false;
                        }
                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image"].ToString().Trim()))
                        {
                            Imagev1.ImageUrl = "../crmapp/images/voucher/" + DataTable.Rows[0]["promotion_image"].ToString().Trim();
                            simg1.InnerText = "Voucher Image1";
                            simg1.Style.Add("color", "Black");
                        }
                        else
                        {
                            simg1.InnerText = "No Image";
                            simg1.Style.Add("color", "Red");
                        }
                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image2"].ToString().Trim()))
                        {
                            Imagev2.ImageUrl = "../crmapp/images/voucher/" + DataTable.Rows[0]["promotion_image2"].ToString().Trim();
                            simg2.InnerText = "Voucher Image2";
                            simg2.Style.Add("color", "Black");
                        }
                        else
                        {
                            simg2.InnerText = "No Image";
                            simg2.Style.Add("color", "Red");
                        }
                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image3"].ToString().Trim()))
                        {
                            Imagev3.ImageUrl = "../crmapp/images/voucher/" + DataTable.Rows[0]["promotion_image3"].ToString().Trim();
                            simg3.InnerText = "Voucher Image3";
                            simg3.Style.Add("color", "Black");
                        }
                        else
                        {
                            simg3.InnerText = "No Image";
                            simg3.Style.Add("color", "Red");
                        }
                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image4"].ToString().Trim()))
                        {
                            Imagev4.ImageUrl = "../crmapp/images/voucher/" + DataTable.Rows[0]["promotion_image4"].ToString().Trim();
                            simg4.InnerText = "Voucher Image4";
                            simg4.Style.Add("color", "Black");
                        }
                        else
                        {
                            simg4.InnerText = "No Image";
                            simg4.Style.Add("color", "Red");
                        }
                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image5"].ToString().Trim()))
                        {
                            Imagev5.ImageUrl = "../crmapp/images/voucher/" + DataTable.Rows[0]["promotion_image5"].ToString().Trim();
                            simg5.InnerText = "Voucher Imag51";
                            simg5.Style.Add("color", "Black");
                        }
                        else
                        {
                            simg5.InnerText = "No Image";
                            simg5.Style.Add("color", "Red");
                        }


                        VoucherImg = DataTable.Rows[0]["promotion_image"].ToString().Trim();
                        VoucherImg2 = DataTable.Rows[0]["promotion_image2"].ToString().Trim();
                        VoucherImg3 = DataTable.Rows[0]["promotion_image3"].ToString().Trim();
                        VoucherImg4 = DataTable.Rows[0]["promotion_image4"].ToString().Trim();
                        VoucherImg5 = DataTable.Rows[0]["promotion_image5"].ToString().Trim();
                        voucherID = Convert.ToInt32(Request.QueryString["voucher_id"]);
                        //txtProductId.Text = ddlProductList.SelectedItem.Value.ToString().Trim();
                        txtVoucherName.Text = DataTable.Rows[0]["voucher_name"].ToString().Trim();
                        txtVoucherDescription.Text = DataTable.Rows[0]["descriptions"].ToString().Trim();
                        TxtRedeemOffer.Text = DataTable.Rows[0]["redeem_offer"].ToString().Trim();
                        Reservation.Text = DataTable.Rows[0]["reservation"].ToString().Trim();
                        RedeemInstruction.Text = DataTable.Rows[0]["redeem_instruction"].ToString().Trim();
                        txtOriginalPrice.Text = DataTable.Rows[0]["original_price"].ToString().Trim();
                        txtDiscountPrice.Text = DataTable.Rows[0]["discount_price"].ToString().Trim();
                        txtSaving.Text = DataTable.Rows[0]["saving_price"].ToString().Trim();
                        txtTotal.Text = DataTable.Rows[0]["total_price"].ToString().Trim();
                        txtQty.Text = DataTable.Rows[0]["qty"].ToString().Trim();
                        txtBought.Text = DataTable.Rows[0]["bought"].ToString().Trim();
                        txtPoint.Text = DataTable.Rows[0]["point"].ToString().Trim();
                        //txtFees.Text = DataTable.Rows[0]["voucher_fee"].ToString().Trim();
                        txtStartDate.Text = DataTable.Rows[0]["startdate"].ToString().Trim();
                        txtEndDate.Text = DataTable.Rows[0]["enddate"].ToString().Trim();
                    }
                    ServiceUrl = "CRM/GetVoucherOutletsById";

                    HttpResponseMessage outletresponse = client.GetAsync(ServiceUrl + "?voucherId=" + voucherId).Result;
                    if (outletresponse.IsSuccessStatusCode)
                    {
                        var Outletlist = outletresponse.Content.ReadAsStringAsync().Result;
                        var dtOutletlist = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outletlist);
                        if (dtOutletlist.Rows.Count > 0)
                        {
                            for (int i = 0; i < dtOutletlist.Rows.Count; i++)
                            {
                                cblstOutlet.Items.FindByValue(dtOutletlist.Rows[i]["branch_id"].ToString().Trim()).Selected = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindVoucherSubCategory();
        }

        protected void BindMerchant()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindMerchantList";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Merchant = response.Content.ReadAsStringAsync().Result;
                var dtMerchant = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Merchant);

                if (dtMerchant.Rows.Count > 0)
                {
                    ddlMerchant.DataSource = dtMerchant;
                    ddlMerchant.DataBind();
                    ddlMerchant.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlMerchant.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void ddlMerchant_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindOutlets();
            GetFeeCategory();
        }

        protected void GetFeeCategory()
        {
            int MerchID = Convert.ToInt32(ddlMerchant.SelectedValue);
            //double strPerVoucherChargesByRM = 0;
            //double strOneTimeChargesByRM = 0;
            //double strPremiumFeesByRM = 0;
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListMerchantDetails";
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
                    lblFeeCategory.Text = dtChargeType.Rows[0]["fees_category"].ToString().Trim();
                    #region PerVoucher
                    if (dtChargeType.Rows[0]["fees_category"].ToString().Trim() == "PerVoucher")
                    {
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim()))
                        {
                            lblFeeCategory.Text = "PerVoucher(%)";
                            txtFees.Text = dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim();
                        }
                        else if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim()))
                        {
                            lblFeeCategory.Text = "PerVoucher(RM)";
                            double var = Convert.ToDouble(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim());                            
                            txtFees.Text = var.ToString("N2").Trim();
                        }
                    }
                    #endregion
                    #region VoucherSalesProfit
                    if (dtChargeType.Rows[0]["fees_category"].ToString().Trim() == "VoucherSalesProfit")
                    {
                        if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim()))
                        {
                            lblFeeCategory.Text = "VoucherSalesProfit(%)";
                            txtFees.Text = dtChargeType.Rows[0]["per_voucher_chargesby_percent"].ToString().Trim();
                        }
                        else if (!string.IsNullOrEmpty(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim()))
                        {
                            lblFeeCategory.Text = "VoucherSalesProfit(RM)";
                            double var = Convert.ToDouble(dtChargeType.Rows[0]["per_voucher_chargesby_rm"].ToString().Trim());
                            txtFees.Text = var.ToString("N2").Trim();
                        }
                    }
                    #endregion
                    #region OnboardingFees
                    else if (dtChargeType.Rows[0]["fees_category"].ToString().Trim() == "OnboardingFees")
                    {
                        lblFeeCategory.Text = "OnboardingFees";
                        double var = Convert.ToDouble(dtChargeType.Rows[0]["yearly_one_time_charges_rm"].ToString().Trim());
                        txtFees.Text = var.ToString("N2").Trim();
                    }
                    #endregion
                }
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
                if (dtCategory.Rows.Count > 0)
                {
                    ddlCategory.DataSource = dtCategory;
                    ddlCategory.DataBind();
                    ddlCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void BindVoucherSubCategory()
        {
            ddlSubCategory.Items.Clear();
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherSubCategoryListing";
            var crm = new crmEntity()
            {
                search_param = ddlCategory.SelectedValue.ToString().Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var SubCategory = response.Content.ReadAsStringAsync().Result;
                var dtSubCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(SubCategory);
                if (dtSubCategory.Rows.Count > 0)
                {
                    ddlSubCategory.DataSource = dtSubCategory;
                    ddlSubCategory.DataBind();
                    ddlSubCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlSubCategory.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void included_CheckedChanged(object sender, EventArgs e)
        {
            if (included.Checked == true)
            {
                excluded.Checked = false;
                sstinclude = 1;
                if(!string.IsNullOrEmpty(txtOriginalPrice.Text) && !string.IsNullOrEmpty(txtDiscountPrice.Text.Trim()))
                {
                    txtDiscountPrice_TextChanged(sender, e);
                }
            }
        }

        protected void excluded_CheckedChanged(object sender, EventArgs e)
        {
            if (excluded.Checked == true)
            {
                included.Checked = false;
                sstinclude = 0;
                if (!string.IsNullOrEmpty(txtOriginalPrice.Text) && !string.IsNullOrEmpty(txtDiscountPrice.Text.Trim()))
                {
                    txtDiscountPrice_TextChanged(sender, e);
                }
            }
        }

        protected void rbtnvoucher1_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnvoucher1.Checked == true)
            {
                rbtnUpload.Checked = false;
                fuvoucher.Enabled = false;
                generatedBy = "System";
            }
        }

        protected void rbtnUpload_CheckedChanged(object sender, EventArgs e)
        {
            if (rbtnUpload.Checked == true)
            {
                rbtnvoucher1.Checked = false;
                fuvoucher.Enabled = true;
                generatedBy = "Vendor";
            }
        }

        protected void txtDiscountPrice_TextChanged(object sender, EventArgs e)
        {
            txtSaving.Text = (Convert.ToDecimal(txtOriginalPrice.Text.Trim()) - Convert.ToDecimal(txtDiscountPrice.Text.Trim())).ToString().Trim();
            if (included.Checked)
            {
                txtTotal.Text = txtDiscountPrice.Text.Trim();
            }
            if (excluded.Checked)
            {
                decimal sstamount = (Convert.ToDecimal(txtDiscountPrice.Text.Trim()) * sst) / 100;
                txtTotal.Text = (Convert.ToDecimal(txtDiscountPrice.Text.Trim()) + sstamount).ToString("N2").Trim();
            }
        }

        protected void txtQty_TextChanged(object sender, EventArgs e)
        {
            if (txtOriginalPrice.Text != string.Empty && txtDiscountPrice.Text != string.Empty)
            {
                txtDiscountPrice_TextChanged(sender, e);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmVoucherList.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DateTime dtStart = new DateTime();
            DateTime dtEnd = new DateTime();
            string dtStartDate = "", dtEndDate = "";
            if (txtStartDate.Text.Trim() != "")
            {
                string[] starttokens = txtStartDate.Text.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                //dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                dtStart = Convert.ToDateTime(strStartDate);
                dtStartDate = dtStart.ToString("yyyy-MM-dd");
            }
            //string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            if (txtEndDate.Text.Trim() != "")
            {
                string[] endtokens = txtEndDate.Text.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                //dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                dtEnd = Convert.ToDateTime(strEndDate);
                dtEndDate = dtEnd.ToString("yyyy-MM-dd");
            }

            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/AddEditVoucherSetup";
            var crm = new crmEntity();
            if (Request.QueryString["voucher_id"].ToString().Trim() != "0")
            {
                if (fuPromoImage.HasFile)
                {
                    string VoucherRef = voucherRefID;
                    VoucherImg = fuPromoImage.PostedFile.FileName.Replace(" ","_");
                    var filePath = Server.MapPath("~/crmapp/Images/voucher/" + VoucherImg);
                    //vrNo = filePath.Substring(filePath.Length - 2);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        string extension = Path.GetExtension(fuPromoImage.PostedFile.FileName.Replace(" ","_"));
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherRef);
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage12.HasFile)
                {
                    string VoucherRef = voucherRefID;
                    VoucherImg2 = fuPromoImage12.PostedFile.FileName.Replace(" ", "_");
                    var filePath = Server.MapPath("~/crmapp/Images/voucher/" + VoucherImg2);
                    //vrNo2 = filePath.Substring(filePath.Length - 2);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        string extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherRef);
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage3.HasFile)
                {
                    string VoucherRef = voucherRefID;
                    VoucherImg3 = fuPromoImage3.PostedFile.FileName.Replace(" ", "_");
                    var filePath = Server.MapPath("~/crmapp/Images/voucher/" + VoucherImg3);
                    //vrNo3 = filePath.Substring(filePath.Length - 2);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        string extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherRef);
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage4.HasFile)
                {
                    string VoucherRef = voucherRefID;
                    VoucherImg4 = fuPromoImage4.PostedFile.FileName.Replace(" ", "_");
                    var filePath = Server.MapPath("~/crmapp/Images/voucher/" + VoucherImg4);
                    //vrNo4 = filePath.Substring(filePath.Length - 2);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        string extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherRef);
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage5.HasFile)
                {
                    string VoucherRef = voucherRefID;
                    VoucherImg5 = fuPromoImage5.PostedFile.FileName.Replace(" ", "_");
                    var filePath = Server.MapPath("~/crmapp/Images/voucher/" + VoucherImg5);
                    //vrNo5 = filePath.Substring(filePath.Length - 2);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        string extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherRef);
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                crm = new crmEntity()
                {
                    voucher_id = Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim()),
                    voucher_code = voucherCode,
                    voucher_name = txtVoucherName.Text.Trim(),
                    merchant_id = Convert.ToInt16(ddlMerchant.SelectedValue),
                    voucher_cat_id = Convert.ToInt32(ddlCategory.SelectedValue),
                    voucher_sub_cat_id = Convert.ToInt32(ddlSubCategory.SelectedValue),
                    voucher_desc = txtVoucherDescription.Text.Trim(),
                    redeem_offer = TxtRedeemOffer.Text.Trim(),
                    reservation = Reservation.Text.Trim(),
                    redeem_instruction = RedeemInstruction.Text.Trim(),
                    isSst = sstinclude,
                    voucher_image = VoucherImg,
                    voucher_image2 = VoucherImg2,
                    voucher_image3 = VoucherImg3,
                    voucher_image4 = VoucherImg4,
                    voucher_image5 = VoucherImg5,
                    original_price = Convert.ToDecimal(txtOriginalPrice.Text.Trim()),
                    discount_price = Convert.ToDecimal(txtDiscountPrice.Text.Trim()),
                    saving_price = Convert.ToDecimal(txtSaving.Text.Trim()),
                    total_price = Convert.ToDecimal(txtTotal.Text.Trim()),
                    qty = Convert.ToInt32(txtQty.Text.Trim()),
                    bought = Convert.ToInt32(txtBought.Text.Trim()),
                    start_date = dtStartDate,
                    end_date = dtEndDate,
                    //start_dt = DateTime.ParseExact(txtStartDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture),
                    //end_dt = DateTime.ParseExact(txtEndDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture),
                    point = Convert.ToInt32(txtPoint.Text.Trim()),
                    voucher_fee = Convert.ToDecimal(txtFees.Text.Trim()),
                    user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue),
                    generated_by = generatedBy
                };
                response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    
                    foreach (ListItem li in cblstOutlet.Items)
                    {
                        if (li.Selected)
                        {
                            ServiceUrl = "CRM/AddEditVoucherRedeemOutletSetup";
                            crm = new crmEntity()
                            {
                                redeem_offer_at = Convert.ToInt32(li.Value),
                                voucher_id = Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim()),
                                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
                            };
                            responseoutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;                            
                        }
                        else
                        {
                            ServiceUrl = "CRM/RemoveVoucherRedeemOutletSetup";
                            crm = new crmEntity()
                            {
                                redeem_offer_at = Convert.ToInt32(li.Value),
                                voucher_id = Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim()),
                                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
                            };
                            HttpResponseMessage responseRemoveoutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            //if (responseRemoveoutlet.IsSuccessStatusCode)
                            //{
                            //    var Outlet = response.Content.ReadAsStringAsync().Result;
                            //    var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                            //    if (dtOutlet.Rows.Count > 0)
                            //    {
                            //        extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                            //        if (fuPromoImage.HasFile)
                            //        {
                            //            fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                            //        }
                            //        Response.Redirect("frmVoucherList.aspx");
                            //    }
                            //}
                        }
                    }
                    //if (responseoutlet.IsSuccessStatusCode)
                    //{
                    //    var Outlet = response.Content.ReadAsStringAsync().Result;
                    //    var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                    //    if (dtOutlet.Rows.Count > 0)
                    //    {

                    //        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessVoucherMsg();", true);

                    //    }
                    //}

                    if (fuPromoImage.HasFile)
                    {
                        extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //vrNo = "VR" + voucherID + "_1";
                        //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                        fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + fuPromoImage.PostedFile.FileName.Replace(" ", "_"));
                    }
                    if (fuPromoImage12.HasFile)
                    {
                        extension = Path.GetExtension(fuPromoImage12.PostedFile.FileName);
                        //vrNo = "VR" + voucherID + "_2";
                        fuPromoImage12.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + fuPromoImage12.PostedFile.FileName.Replace(" ", "_"));
                    }
                    if (fuPromoImage3.HasFile)
                    {
                        extension = Path.GetExtension(fuPromoImage3.PostedFile.FileName);
                        //vrNo = "VR" + voucherID + "_3";
                        fuPromoImage3.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + fuPromoImage3.PostedFile.FileName.Replace(" ", "_"));
                    }
                    if (fuPromoImage4.HasFile)
                    {
                        extension = Path.GetExtension(fuPromoImage4.PostedFile.FileName);
                        //vrNo = "VR" + voucherID + "_4";
                        fuPromoImage4.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + fuPromoImage4.PostedFile.FileName.Replace(" ", "_"));
                    }
                    if (fuPromoImage5.HasFile)
                    {
                        extension = Path.GetExtension(fuPromoImage5.PostedFile.FileName);
                        //vrNo = "VR" + voucherID + "_5";
                        fuPromoImage5.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + fuPromoImage5.PostedFile.FileName.Replace(" ", "_"));
                    }
                    Response.Redirect("frmVoucherList.aspx");
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessVoucherMsg();", true);
                }
            }
            else
            {
                if (fuPromoImage.HasFile)
                {
                    vrNo = "VR" + getVoucherRef() + "_1";
                    //string VoucherRef = "VR2";
                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                        //VoucherImg = vrNo + extension;
                        //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                        VoucherImg = fuPromoImage.PostedFile.FileName.Replace(" ","_");
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage12.HasFile)
                {
                    vrNo2 = "VR" + getVoucherRef()+"_2";
                    //string VoucherRef = "VR2";
                    if (fuPromoImage.PostedFile.ContentLength < 10240000)
                    {
                        extension = Path.GetExtension(fuPromoImage12.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                        //VoucherImg2 = vrNo2 + extension;
                        //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                        VoucherImg2 = fuPromoImage12.PostedFile.FileName.Replace(" ", "_");
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage3.HasFile)
                {
                    vrNo3 = "VR" + getVoucherRef() + "_3";
                    //string VoucherRef = "VR2";
                    if (fuPromoImage3.PostedFile.ContentLength < 10240000)
                    {
                        extension = Path.GetExtension(fuPromoImage3.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                        //VoucherImg3 = vrNo3 + extension;
                        VoucherImg3 = fuPromoImage3.PostedFile.FileName.Replace(" ", "_");
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage4.HasFile)
                {
                    vrNo4 = "VR" + getVoucherRef() + "_4";
                    //string VoucherRef = "VR2";
                    if (fuPromoImage4.PostedFile.ContentLength < 10240000)
                    {
                        extension = Path.GetExtension(fuPromoImage4.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                        //VoucherImg4 = vrNo4 + extension;
                        VoucherImg4 = fuPromoImage4.PostedFile.FileName.Replace(" ", "_");
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }
                if (fuPromoImage5.HasFile)
                {
                    vrNo5 = "VR" + getVoucherRef() + "_5";
                    //string VoucherRef = "VR2";
                    if (fuPromoImage5.PostedFile.ContentLength < 10240000)
                    {
                        extension = Path.GetExtension(fuPromoImage5.PostedFile.FileName);
                        //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                        //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                        //VoucherImg5 = vrNo5 + extension;
                        VoucherImg5 = fuPromoImage5.PostedFile.FileName.Replace(" ", "_");
                    }
                    else
                    {
                        //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                        return;
                    }
                }

                //int pt = 0;int fee = 0;int bgt = 0;
                int pt = 0; int bgt = 0;  string fee = string.Empty;
                if (txtPoint.Text.Trim()!="")
                {
                    pt = Convert.ToInt32(txtPoint.Text.Trim());
                }
                if (txtFees.Text.Trim() != "")
                {
                    fee = txtFees.Text.Trim();
                }
                if (txtBought.Text.Trim() != "")
                {
                    bgt = Convert.ToInt32(txtBought.Text.Trim());
                }


                ServiceUrl = "CRM/AddEditVoucherSetup";
                crm = new crmEntity()
                {
                    voucher_id = 0,
                    voucher_code = voucherCode,
                    voucher_name = txtVoucherName.Text.Trim(),
                    merchant_id = Convert.ToInt16(ddlMerchant.SelectedValue),
                    voucher_cat_id = Convert.ToInt32(ddlCategory.SelectedValue),
                    voucher_sub_cat_id = Convert.ToInt32(ddlSubCategory.SelectedValue),
                    voucher_desc = txtVoucherDescription.Text.Trim(),
                    redeem_offer = TxtRedeemOffer.Text.Trim(),
                    reservation = Reservation.Text.Trim(),
                    redeem_instruction = RedeemInstruction.Text.Trim(),
                    isSst = sstinclude,
                    voucher_image = VoucherImg,
                    voucher_image2 = VoucherImg2,
                    voucher_image3 = VoucherImg3,
                    voucher_image4 = VoucherImg4,
                    voucher_image5 = VoucherImg5,
                    original_price = Convert.ToDecimal(txtOriginalPrice.Text.Trim()),
                    discount_price = Convert.ToDecimal(txtDiscountPrice.Text.Trim()),
                    saving_price = Convert.ToDecimal(txtSaving.Text.Trim()),
                    total_price = Convert.ToDecimal(txtTotal.Text.Trim()),
                    qty = Convert.ToInt32(txtQty.Text.Trim()),
                    //bought = Convert.ToInt32(txtBought.Text.Trim()),
                    bought = bgt,
                    start_date = dtStartDate,
                    end_date = dtEndDate,
                    //start_dt = DateTime.ParseExact(txtStartDate.Text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture),
                    //end_dt = DateTime.ParseExact(txtEndDate.Text.Trim(), "yyyy-MM-dd", CultureInfo.InvariantCulture),
                    //point = Convert.ToInt32(txtPoint.Text.Trim()),
                    //voucher_fee = Convert.ToDecimal(txtFees.Text.Trim()),
                    point=pt,
                    //voucher_fee= Convert.ToDecimal(fee),
                    voucher_fee = decimal.Parse(fee),
                    user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue),
                    generated_by = generatedBy
                };
                response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    ServiceUrl = "CRM/AddEditVoucherRedeemOutletSetup";
                    foreach (ListItem li in cblstOutlet.Items)
                    {
                        if (li.Selected)
                        {
                            crm = new crmEntity()
                            {
                                redeem_offer_at = Convert.ToInt32(li.Value),
                                voucher_id = Convert.ToInt32(Request.QueryString["voucher_id"].ToString().Trim()),
                                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
                            };
                            HttpResponseMessage responseoutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (responseoutlet.IsSuccessStatusCode)
                            {
                                var Outlet = response.Content.ReadAsStringAsync().Result;
                                var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                                if (dtOutlet.Rows.Count > 0)
                                {
                                    //extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                                    //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                                    //fuPromoImage12.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo2 + extension);
                                    //fuPromoImage3.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo3 + extension);
                                    //fuPromoImage4.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                                    //fuPromoImage5.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                                    //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                                    if (fuPromoImage.HasFile)
                                    {
                                        fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherImg);
                                    }
                                    if (fuPromoImage12.HasFile)
                                    {
                                        fuPromoImage12.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherImg2);
                                    }
                                    if (fuPromoImage3.HasFile)
                                    {
                                        fuPromoImage3.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherImg3);
                                    }
                                    if (fuPromoImage4.HasFile)
                                    {
                                        fuPromoImage4.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherImg4);
                                    }
                                    if (fuPromoImage5.HasFile)
                                    {
                                        fuPromoImage5.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + VoucherImg5);
                                    }
                                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessVoucherMsg();", true);
                                    Response.Redirect("frmVoucherList.aspx");
                                }
                                else
                                {
                                }
                            }
                        }
                    }
                }
            }
        }

        protected string getVoucherRef()
        {
            try
            {
                ServiceUrl = "CRM/GetVoucherRef";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    string[] strVal = response.Content.ReadAsStringAsync().Result.Split('"');
                    var voucherRefNo = strVal[0].Replace("[", "").Replace("]", "");
                    //var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(voucherRefNo);
                    //voucherRefID = DataTable.Rows[0]["ref"].ToString().Trim();
                    voucherRefID = int.Parse(voucherRefNo.Remove(voucherRefNo.Length - 2, 2)).ToString().Trim();
                }
            }
            catch (Exception ex)
            {
            }
            return voucherRefID;
        }

        protected void BindOutlets()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherOutlet";
            var crm = new crmEntity()
            {
                merchant_id = Convert.ToInt32(ddlMerchant.SelectedValue)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Outlet = response.Content.ReadAsStringAsync().Result;
                var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                //ViewState["dtcont"] = dtChargeType;
                if (dtOutlet.Rows.Count > 0)
                {
                    lblNoRecord.Visible = false;
                    cblstOutlet.DataSource = dtOutlet;
                    cblstOutlet.DataBind();
                }
                else
                {
                    lblNoRecord.Visible = true;
                    cblstOutlet.DataSource = dtOutlet;
                    cblstOutlet.DataBind();
                }
            }
        }

        protected void BindSstValue()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetSstValue";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var sstValue = response.Content.ReadAsStringAsync().Result;
                //var dtsstValue = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(sstValue);

                if (!string.IsNullOrEmpty(sstValue))
                {
                    string sstvar = sstValue.Replace("[", "").Replace("]", "");
                    if (!string.IsNullOrEmpty(sstvar))
                    {
                        sst = Convert.ToDecimal(sstvar);
                    }
                }
                else
                {
                    sst = 0;
                }
            }
        }
    }
}