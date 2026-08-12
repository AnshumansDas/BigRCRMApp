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
using System.Web.UI.HtmlControls;
using System.IO;

namespace CRMApp.crmapp
{
    public partial class frmMerchUserProfile : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        DataTable dtInfo = new DataTable();
        DataTable dtChargeType = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["userid"]!=null)
            {
                client.BaseAddress = new Uri(StrBaseURL);
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (!Page.IsPostBack)
                {
                    if (Session["userid"].ToString().Trim() != "" && Session["Merchant_Code"].ToString().Trim() != "")
                    {
                        GetMerchUserInfo();
                    }
                }
            }
            else
            {
                Response.Redirect("Logout.aspx");
            }
         
        }

        public void GetMerchUserInfo()
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/GetMerchUserDetailsbyMerchCodeAndLoginId";
                var userDetailsEntity = new crmEntity()
                {
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                    merchant_code = Session["Merchant_Code"].ToString().Trim()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, userDetailsEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    var UserDetailsList = response.Content.ReadAsStringAsync().Result;
                    dtInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserDetailsList);
                    if (dtInfo.Rows.Count > 0)
                    {
                        lvProfile.DataSource = dtInfo;
                        lvProfile.DataBind();
                        #region support doc
                        foreach (ListViewItem Item in lvProfile.Items)
                        {
                            #region merch support doc info
                            ListView lvSupportDoc = Item.FindControl("lvSupportDoc") as ListView;
                            ServiceUrl = "CRM/ListMerchantSupportDocumentDetails";
                            var crm = new crmEntity()
                            {
                                merchant_code = Session["Merchant_Code"].ToString().Trim()
                            };
                            HttpResponseMessage responsesupportdoc = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (responsesupportdoc.IsSuccessStatusCode)
                            {
                                var ChargeType = responsesupportdoc.Content.ReadAsStringAsync().Result;
                                dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                                Session["dtcont"] = dtChargeType;
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
                            #endregion
                        }
                        #endregion
                    }
                    else
                    {
                        lvProfile.DataSource = dtInfo;
                        lvProfile.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                trycatchmsg.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void lvProfile_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            try
            {
                if (lvProfile.Items.Count > 0)
                {
                    lvProfile.EditIndex = e.NewEditIndex;
                    GetMerchUserInfo();
                    foreach (ListViewItem Item in lvProfile.Items)
                    {
                        #region merch info
                        HtmlImage photo = Item.FindControl("imgMerchLogo") as HtmlImage;
                        DropDownList City = Item.FindControl("ddlCity") as DropDownList;
                        DropDownList State = Item.FindControl("ddlState") as DropDownList;
                        DropDownList ddlMerchantCategory = Item.FindControl("ddlMerchantCategory") as DropDownList;
                        string strPath = Convert.ToString(dtInfo.Rows[0]["merchant_logo"]);
                        string strCity = Convert.ToString(dtInfo.Rows[0]["city_id"]);
                        string strState = Convert.ToString(dtInfo.Rows[0]["state_id"]);
                        string strMerchCategory = Convert.ToString(dtInfo.Rows[0]["merchant_cat_id"]);
                        if (!string.IsNullOrEmpty(strPath))
                        { photo.Src = strPath; ViewState["imgPath"] = strPath.ToString().Trim(); }
                        else
                        { photo.Src = "img/portfolio/avatar.jpg"; }

                        BindCity(strState.Trim());
                        if (!string.IsNullOrEmpty(strCity))
                        {
                            City.SelectedValue = strCity;
                        }
                        else
                        {
                            City.SelectedIndex = 0;
                        }

                        if (!string.IsNullOrEmpty(strState))
                        {
                            State.SelectedValue = strState;
                        }
                        else
                        {
                            State.SelectedIndex = 0;
                        }

                        if (!string.IsNullOrEmpty(strMerchCategory))
                        {
                            ddlMerchantCategory.SelectedValue = strMerchCategory;
                        }
                        else
                        {
                            ddlMerchantCategory.SelectedIndex = 0;
                        }
                        #endregion
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void lvProfile_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            if (e.CancelMode == ListViewCancelMode.CancelingEdit)
            {
                Response.Redirect("frmMerchUserProfile.aspx");
            }
        }

        protected void lvProfile_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            if (lvProfile.EditIndex == (e.Item as ListViewDataItem).DataItemIndex)
            {
                //HtmlGenericControl totalrecord = (HtmlGenericControl)e.Item.FindControl("totalrecord");
                //if (Session["dtcont"] != null)
                //{
                //    dt = (DataTable)Session["dtcont"];
                //    totalrecord.InnerText = dt.Rows.Count.ToString();
                //}
                //else
                //{ totalrecord.InnerText = "0"; }

                #region state
                DropDownList ddlState = (DropDownList)e.Item.FindControl("ddlState");
                ServiceUrl = "CRM/GetStateDetails";
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                ddlState.Items.Clear();
                ListItem item = new ListItem("-Select-", "0");
                ddlState.Items.Insert(0, item);
                if (response.IsSuccessStatusCode)
                {
                    var varState = response.Content.ReadAsStringAsync().Result;
                    var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(varState);
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
                #endregion

                #region merch category
                DropDownList ddlMerchantCategory = (DropDownList)e.Item.FindControl("ddlMerchantCategory");
                ddlMerchantCategory.Items.Clear();
                ListItem itemmerchcat = new ListItem("-Select-", "0");
                ddlMerchantCategory.Items.Insert(0, itemmerchcat);
                ServiceUrl = "CRM/GetMerchantCatByActive";
                HttpResponseMessage responsemerchcat = client.GetAsync(ServiceUrl).Result;
                if (responsemerchcat.IsSuccessStatusCode)
                {
                    var MerchCat = responsemerchcat.Content.ReadAsStringAsync().Result;
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
                #endregion
            }
        }

        protected void lvProfile_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            UpdateMerchUserInfo();
        }

        private void UpdateMerchUserInfo()
        {
            string strImagePath = string.Empty, strConvertDOB = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            foreach (ListViewItem Item in lvProfile.Items)
            {
                TextBox txtOfficeNo = Item.FindControl("txtOfficeNo") as TextBox;
                DropDownList ddlMerchantCategory = Item.FindControl("ddlMerchantCategory") as DropDownList;
                TextBox txtPIC = Item.FindControl("txtPIC") as TextBox;
                TextBox txtMobileNo = Item.FindControl("txtMobileNo") as TextBox;
                TextBox txtFaxNo = Item.FindControl("txtFaxNo") as TextBox;
                TextBox txtMerchantWebURL = Item.FindControl("txtMerchantWebURL") as TextBox;
                TextBox txtaddress1 = Item.FindControl("txtaddress1") as TextBox;
                TextBox txtaddress2 = Item.FindControl("txtaddress2") as TextBox;
                TextBox txtPostcode = Item.FindControl("txtPostcode") as TextBox;
                DropDownList ddlState = Item.FindControl("ddlState") as DropDownList;
                DropDownList ddlCity = Item.FindControl("ddlCity") as DropDownList;
                try
                {
                    ServiceUrl = "CRM/UpdateMerchUserDetailsbyMerchCode";
                    var UserEntity = new crmEntity()
                    {
                        merchant_code = Session["Merchant_Code"].ToString().Trim(),
                        office_phone = txtOfficeNo.Text.Trim(),
                        merchant_cat_id = Convert.ToInt32(ddlMerchantCategory.SelectedValue.Trim()),
                        person_incharge = txtPIC.Text.Trim(),
                        mobile_no = txtMobileNo.Text.Trim(),
                        fax_no = txtFaxNo.Text.Trim(),
                        website = txtMerchantWebURL.Text.Trim(),
                        address_1 = txtaddress1.Text.Trim(),
                        address_2 = txtaddress2.Text.Trim(),
                        postcode = txtPostcode.Text.Trim(),
                        city_id = Convert.ToInt32(ddlCity.SelectedValue),
                        state_id = Convert.ToInt32(ddlState.SelectedValue),
                        user_by = Session["username"].ToString()
                    };
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, UserEntity).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        GetMerchUserInfo();
                        Response.Redirect("frmMerchUserProfile.aspx");
                        return;
                    }
                    else
                    {
                        Response.Write("<script language='javascript'>window.alert('Failed to Update')</script>");
                    }
                }
                catch (Exception ex)
                {
                    trycatchmsg.InnerText = ex.Message.ToString();
                    return;
                }
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlListFind = (DropDownList)sender;
            ListViewItem item1 = (ListViewItem)ddlListFind.NamingContainer;
            DropDownList ddlState = (DropDownList)item1.FindControl("ddlState");
            BindCity(ddlState.SelectedValue.Trim());
        }

        public void BindCity(string strVal)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            foreach (ListViewItem Item in lvProfile.Items)
            {
                DropDownList ddlCity = Item.FindControl("ddlCity") as DropDownList;
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
        }
    }
}