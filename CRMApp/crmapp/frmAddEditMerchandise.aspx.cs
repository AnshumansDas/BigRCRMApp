using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmAddEditMerchandise : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty, MerchandiseCode = string.Empty;
        static int voucherCatId = 0;
        HttpResponseMessage response = null;
        ListItem v_lst1, v_lst2;
        int CategoryID, ImagePath, MerchandiseID, ActiveStatus;
        static string generatedBy = string.Empty, MerchandiseImg, vrNo, extension, MerchandiseRefID;
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
                    BindMerchantCategory();
                    BindOutlets();
                    if (Request.QueryString["merchandise_id"] != "0")
                    {
                        MerchandiseID = Convert.ToInt32(Request.QueryString["merchandise_id"].ToString().Trim());
                        SetData(MerchandiseID);
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void SetData(int MerchandiseID)
        {
            try
            {
                ServiceUrl = "CRM/GetMerchandiseDetailsById";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var crm = new crmEntity()
                {
                    merchandise_id = MerchandiseID
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var Productlist = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                    if (DataTable.Rows.Count > 0)
                    {
                        v_lst1 = ddlCategory.Items.FindByText(DataTable.Rows[0]["merchandise_category"].ToString().Trim());
                        CategoryID = ddlCategory.Items.IndexOf(v_lst1);
                        ddlCategory.ClearSelection();
                        ddlCategory.SelectedIndex = CategoryID;

                        v_lst2 = ddlActiveStatus.Items.FindByValue(DataTable.Rows[0]["active_status"].ToString().Trim());
                        ActiveStatus = ddlActiveStatus.Items.IndexOf(v_lst2);
                        ddlActiveStatus.ClearSelection();
                        ddlActiveStatus.SelectedIndex = ActiveStatus;

                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image"].ToString().Trim()))
                        {
                            imgMerchandiseLogo.ImageUrl = "../crmapp/images/merchandise/" + DataTable.Rows[0]["promotion_image"].ToString().Trim();
                            //simg1.InnerText = "Merchandise Logo";
                            //simg1.Style.Add("color", "Black");
                        }
                        else
                        {
                            //simg1.InnerText = "No Image";
                            //simg1.Style.Add("color", "Red");
                        }

                        MerchandiseImg = DataTable.Rows[0]["promotion_image"].ToString().Trim();
                        txtMerchandiseName.Text = DataTable.Rows[0]["merchandise_name"].ToString().Trim();
                        MerchandiseCode = DataTable.Rows[0]["merchandise_code"].ToString().Trim();
                        txtMerchandiseDescription.Text = DataTable.Rows[0]["descriptions"].ToString().Trim();
                        TxtRedeemOffer.Text = DataTable.Rows[0]["redeem_offer"].ToString().Trim();
                        RedeemInstruction.Text = DataTable.Rows[0]["redeem_instruction"].ToString().Trim();
                        txtQty.Text = DataTable.Rows[0]["quantity"].ToString().Trim();
                        txtRedeemed.Text = DataTable.Rows[0]["redeemed"].ToString().Trim();
                        txtPointsRedeem.Text = DataTable.Rows[0]["points_to_redeem"].ToString().Trim();
                        txtStartDate.Text = DataTable.Rows[0]["start_date"].ToString().Trim();
                        txtEndDate.Text = DataTable.Rows[0]["end_date"].ToString().Trim();
                    }
                    ServiceUrl = "CRM/GetMerchandiseOutletsById";

                    HttpResponseMessage outletresponse = client.PostAsJsonAsync(ServiceUrl, crm).Result;
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

        protected void BindOutlets()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetMerchandiseOutlet";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Outlet = response.Content.ReadAsStringAsync().Result;
                var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                //ViewState["dtcont"] = dtChargeType;
                if (dtOutlet.Rows.Count > 0)
                {
                    cblstOutlet.DataSource = dtOutlet;
                    cblstOutlet.DataBind();
                }
                else
                {
                    cblstOutlet.DataSource = dtOutlet;
                    cblstOutlet.DataBind();
                }
            }
        }

        protected void BindMerchantCategory()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetMerchandiseCategory";
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
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
                ServiceUrl = "CRM/AddEditMerchandiseSetup";
                var crm = new crmEntity();
                if (Request.QueryString["merchandise_id"].ToString().Trim() != "0")
                {
                    if (fuPromoImage.HasFile)
                    {
                        //string VoucherRef = voucherRefID;
                        MerchandiseImg = fuPromoImage.PostedFile.FileName;
                        var filePath = Server.MapPath("~/crmapp/Images/merchandise/" + MerchandiseImg);
                        //vrNo = filePath.Substring(filePath.Length - 2);
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
                    ServiceUrl = "CRM/AddEditMerchandiseSetup";
                    crm = new crmEntity()
                    {
                        merchandise_id = Convert.ToInt32(Request.QueryString["merchandise_id"].ToString().Trim()),
                        merchandise_code = MerchandiseCode,
                        merchandise_name = txtMerchandiseName.Text.Trim(),
                        merchandise_cat_id = Convert.ToInt32(ddlCategory.SelectedValue),
                        merchandise_desc = txtMerchandiseDescription.Text.Trim(),
                        redeem_offer = TxtRedeemOffer.Text.Trim(),
                        redeem_instruction = RedeemInstruction.Text.Trim(),
                        merchandise_logo = MerchandiseImg,
                        qty = Convert.ToInt32(txtQty.Text.Trim()),
                        redeemed = Convert.ToInt32(txtRedeemed.Text.Trim()),
                        start_date = dtStartDate,
                        end_date = dtEndDate,
                        point_to_redeem = Convert.ToInt32(txtPointsRedeem.Text.Trim()),
                        user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                        active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue)
                    };
                    response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        ServiceUrl = "CRM/AddEditMerchandiseRedeemOutletSetup";
                        foreach (ListItem li in cblstOutlet.Items)
                        {
                            if (li.Selected)
                            {
                                crm = new crmEntity()
                                {
                                    redeem_offer_at = Convert.ToInt32(li.Value),
                                    user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
                                };
                                HttpResponseMessage responseoutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (responseoutlet.IsSuccessStatusCode)
                                {
                                    var Outlet = response.Content.ReadAsStringAsync().Result;
                                    var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                                    if (dtOutlet.Rows.Count > 0)
                                    {
                                        if (fuPromoImage.HasFile)
                                        {
                                            MerchandiseImg = fuPromoImage.PostedFile.FileName;
                                            extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                                            //MerchandiseImg = "MD_" + Request.QueryString["merchandise_id"].ToString().Trim() + extension;
                                            fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/merchandise/") + MerchandiseImg);
                                        }
                                        Response.Redirect("frmMerchandiseList.aspx");
                                    }
                                    else
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (fuPromoImage.HasFile)
                    {
                        vrNo = "MD" + getMerchandiseRef() + "_1";
                        //string VoucherRef = "VR2";
                        if (fuPromoImage.PostedFile.ContentLength < 10240000)
                        {
                            //extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                            //VoucherImg = Path.GetFileName(fuPromoImage.FileName);
                            //fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/voucher/") + vrNo + extension);
                            //MerchandiseImg = vrNo + extension;
                            MerchandiseImg = fuPromoImage.PostedFile.FileName;
                        }
                        else
                        {
                            //LblResult.Text = "Upload status: The file has to be less than 1 MB! for File No 1";
                            return;
                        }
                    }
                    ServiceUrl = "CRM/AddEditMerchandiseSetup";
                    crm = new crmEntity()
                    {
                        merchandise_id = 0,
                        merchandise_code = MerchandiseCode,
                        merchandise_name = txtMerchandiseName.Text.Trim(),
                        merchandise_cat_id = Convert.ToInt32(ddlCategory.SelectedValue),
                        merchandise_desc = txtMerchandiseDescription.Text.Trim(),
                        redeem_offer = TxtRedeemOffer.Text.Trim(),
                        redeem_instruction = RedeemInstruction.Text.Trim(),
                        merchandise_logo = MerchandiseImg,
                        qty = Convert.ToInt32(txtQty.Text.Trim()),
                        redeemed = Convert.ToInt32(txtRedeemed.Text.Trim()),
                        start_date = dtStartDate,
                        end_date = dtEndDate,
                        point_to_redeem = Convert.ToInt32(txtPointsRedeem.Text.Trim()),
                        user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                        active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue)
                    };
                    response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        ServiceUrl = "CRM/AddEditMerchandiseRedeemOutletSetup";
                        foreach (ListItem li in cblstOutlet.Items)
                        {
                            if (li.Selected)
                            {
                                crm = new crmEntity()
                                {
                                    redeem_offer_at = Convert.ToInt32(li.Value),
                                    user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
                                };
                                HttpResponseMessage responseoutlet = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (responseoutlet.IsSuccessStatusCode)
                                {
                                    var Outlet = response.Content.ReadAsStringAsync().Result;
                                    var dtOutlet = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Outlet);
                                    if (dtOutlet.Rows.Count > 0)
                                    {
                                        if (fuPromoImage.HasFile)
                                        {
                                            //extension = Path.GetExtension(fuPromoImage.PostedFile.FileName);
                                            MerchandiseImg = fuPromoImage.PostedFile.FileName;
                                            fuPromoImage.SaveAs(Server.MapPath("~/crmapp/Images/merchandise/") + MerchandiseImg);
                                        }
                                        Response.Redirect("frmMerchandiseList.aspx");
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
            catch (Exception ex)
            {

            }
        }

        protected string getMerchandiseRef()
        {
            try
            {
                ServiceUrl = "CRM/GetMerchandiseRef";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    string[] strVal = response.Content.ReadAsStringAsync().Result.Split('"');
                    var MerchndiseRefNo = strVal[0].Replace("[", "").Replace("]", "");
                    //var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(voucherRefNo);
                    //voucherRefID = DataTable.Rows[0]["ref"].ToString().Trim();
                    MerchandiseRefID = int.Parse(MerchndiseRefNo.Remove(MerchndiseRefNo.Length - 2, 2)).ToString().Trim();
                }
            }
            catch (Exception ex)
            {
            }
            return MerchandiseRefID;
        }
    }
}