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
    public partial class frmNormalUserProfile : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        DateTime dtdob = new DateTime();
        DataTable dtUserinfo = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["userid"] != null)
                {
                    GetUserInfo();
                }
            }
        }

        public void GetUserInfo()
        {
            try
            {
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/GetNormalUserDetailsbyLoginId";
                var userDetailsEntity = new crmEntity()
                {
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString())
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, userDetailsEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    var UserDetailsList = response.Content.ReadAsStringAsync().Result;
                    dtUserinfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserDetailsList);
                    if (dtUserinfo.Rows.Count > 0)
                    {
                        lvProfile.DataSource = dtUserinfo;
                        lvProfile.DataBind();
                    }
                    else
                    {
                        lvProfile.DataSource = dtUserinfo;
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

        public void BindCity(string strVal)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
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

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlListFind = (DropDownList)sender;
            ListViewItem item1 = (ListViewItem)ddlListFind.NamingContainer;
            DropDownList ddlState = (DropDownList)item1.FindControl("ddlState");
            BindCity(ddlState.SelectedValue.Trim());
        }

        //protected void UploadFile(object sender, EventArgs e)
        //{
        //    foreach (ListViewItem Item in lvProfile.Items)
        //    {
        //        FileUpload fuUserPhoto = Item.FindControl("fuUserPhoto") as FileUpload;
        //        HtmlImage imgUserPhoto = Item.FindControl("imgUserPhoto") as HtmlImage;
        //        if (IsPostBack && fuUserPhoto.PostedFile != null)
        //        {
        //            if (fuUserPhoto.PostedFile.FileName.Length > 0)
        //            {
        //                //fuUserPhoto.SaveAs(Server.MapPath("~/Images/") + fuUserPhoto.PostedFile.FileName);
        //                fuUserPhoto.SaveAs(HttpContext.Current.Server.MapPath("img/portfolio/" + fuUserPhoto.FileName));
        //                imgUserPhoto.Src = "img/portfolio/" + Path.GetFileName(fuUserPhoto.FileName);
        //            }
        //        }
        //    }
        //}
        protected void lvProfile_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            try
            {
                if (lvProfile.Items.Count > 0)
                {
                    //lvProfile.Items.Remove(lvProfile.Items[0]);
                    lvProfile.EditIndex = e.NewEditIndex;
                    GetUserInfo();
                    foreach (ListViewItem Item in lvProfile.Items)
                    {
                        #region user info
                        HtmlImage photo = Item.FindControl("imgUserPhoto") as HtmlImage;
                        DropDownList City = Item.FindControl("ddlCity") as DropDownList;
                        DropDownList State = Item.FindControl("ddlState") as DropDownList;
                        DropDownList Country = Item.FindControl("ddlCountry") as DropDownList;
                        string strPath = Convert.ToString(dtUserinfo.Rows[0]["image_path"]);
                        string strCity = Convert.ToString(dtUserinfo.Rows[0]["city_id"]);
                        string strState = Convert.ToString(dtUserinfo.Rows[0]["state_id"]);
                        string strCountry = Convert.ToString(dtUserinfo.Rows[0]["country_id"]);
                        if (!string.IsNullOrEmpty(strPath))
                        { photo.Src = strPath; ViewState["imgPath"] = strPath.ToString().Trim(); }
                        else
                        { photo.Src = "img/portfolio/avatar.jpg"; }

                        if (!string.IsNullOrEmpty(strState))
                        {
                            State.SelectedValue = strState;
                            BindCity(strState.Trim());
                            if (!string.IsNullOrEmpty(strCity))
                            {
                                City.SelectedValue = strCity;
                            }
                            else
                            {
                                City.SelectedIndex = 0;
                            }
                        }
                        else
                        {
                            State.SelectedIndex = 0;
                        }

                        if (!string.IsNullOrEmpty(strCountry))
                        {
                            Country.SelectedValue = strCountry;
                        }
                        else
                        {
                            Country.SelectedIndex = 0;
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
                Response.Redirect("frmNormalUserProfile.aspx");
            }
        }

        protected void lvProfile_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (lvProfile.EditIndex == (e.Item as ListViewDataItem).DataItemIndex)
            {
                #region state
                DropDownList ddlState = (DropDownList)e.Item.FindControl("ddlState");
                ServiceUrl = "CRM/GetStateDetails";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
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
            }
        }

        protected void lvProfile_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            UpdateUserInfo();
        }

        private void UpdateUserInfo()
        {
            string strDOB = string.Empty, strImagePath = string.Empty, strConvertDOB = string.Empty;
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            foreach (ListViewItem Item in lvProfile.Items)
            {
                FileUpload fuUserPhoto = Item.FindControl("fuUserPhoto") as FileUpload;
                HtmlGenericControl logovalidatemsg = Item.FindControl("logovalidatemsg") as HtmlGenericControl;
                HtmlImage imgUserPhoto = Item.FindControl("imgUserPhoto") as HtmlImage;
                #region image validate
                if (fuUserPhoto.HasFile)
                {
                    string strpath = System.IO.Path.GetExtension(fuUserPhoto.FileName);
                    int maxFileLength = 2000000;
                    if (strpath.ToLower() == ".jpg" || strpath.ToLower() == ".jpeg" || strpath.ToLower() == ".png")
                    {
                        if (fuUserPhoto.PostedFile.ContentLength > maxFileLength)
                        {
                            logovalidatemsg.InnerText = String.Format("Your file size has {0:#,##0} bytes which exceeded the limit of 2MB. Please upload a smaller file.", fuUserPhoto.PostedFile.ContentLength);
                            logovalidatemsg.Style.Add("color", "Red");
                            ViewState["photoerrmsg"] = logovalidatemsg.InnerText.Trim();
                            strImagePath = "img/portfolio/avatar.jpg";
                        }
                        else
                        {
                            fuUserPhoto.SaveAs(HttpContext.Current.Server.MapPath("img/portfolio/" + fuUserPhoto.FileName));
                            imgUserPhoto.Src = "img/portfolio/" + Path.GetFileName(fuUserPhoto.FileName);
                            strImagePath = "img/portfolio/" + Path.GetFileName(fuUserPhoto.FileName);
                            logovalidatemsg.InnerText = "accept";
                            ViewState["photoerrmsg"] = logovalidatemsg.InnerText.Trim();
                        }
                    }
                    else
                    {
                        logovalidatemsg.InnerText = "Invalid file format (accepted format: jpg,png,jpeg,bmp)";
                        logovalidatemsg.Style.Add("color", "Red");
                        ViewState["photoerrmsg"] = logovalidatemsg.InnerText.Trim();
                        strImagePath = "img/portfolio/avatar.jpg";
                    }
                }
                else
                { strImagePath = ViewState["imgPath"].ToString().Trim(); ViewState["photoerrmsg"] = "accept"; }
                #endregion

                TextBox txtName = Item.FindControl("txtName") as TextBox;
                TextBox txtDob = Item.FindControl("txtDob") as TextBox;
                TextBox txtMobileNo = Item.FindControl("txtMobileNo") as TextBox;
                TextBox txtaddress1 = Item.FindControl("txtaddress1") as TextBox;
                TextBox txtaddress2 = Item.FindControl("txtaddress2") as TextBox;
                TextBox txtPostcode = Item.FindControl("txtPostcode") as TextBox;
                DropDownList ddlCity = Item.FindControl("ddlCity") as DropDownList;
                DropDownList ddlState = Item.FindControl("ddlState") as DropDownList;
                DropDownList ddlCountry = Item.FindControl("ddlCountry") as DropDownList;
                if (!string.IsNullOrEmpty(txtDob.Text.Trim()))
                {
                    string[] starttokens = txtDob.Text.Split('/');
                    strDOB = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtdob = Convert.ToDateTime(strDOB);
                    strConvertDOB = dtdob.ToString("yyyy-MM-dd");
                }

                try
                {
                    ServiceUrl = "CRM/UpdateNormalUserDetailsbyLoginId";
                    var UserEntity = new crmEntity()
                    {
                        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                        user_name = txtName.Text.Trim(),
                        user_dateofbirth = strConvertDOB.Trim(),
                        mobile_no = txtMobileNo.Text.Trim(),
                        address1 = txtaddress1.Text.Trim(),
                        address2 = txtaddress2.Text.Trim(),
                        city_id = Convert.ToInt32(ddlCity.SelectedValue),
                        state_id = Convert.ToInt32(ddlState.SelectedValue),
                        postcodeid = txtPostcode.Text.Trim(),
                        country_id = Convert.ToInt32(ddlCountry.SelectedValue),
                        image_path = strImagePath.Trim(),
                        update_by = Session["username"].ToString()
                    };
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, UserEntity).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        if (ViewState["photoerrmsg"].ToString().Trim() == "accept")
                        {
                            //GetUserInfo();
                            Response.Redirect("frmNormalUserProfile.aspx");
                            //return;
                        }
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
    }
}