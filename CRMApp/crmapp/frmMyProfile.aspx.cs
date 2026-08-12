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
    public partial class frmMyProfile : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        DateTime dtdob = new DateTime();
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["userid"].ToString() != "")
                {
                    BindState();
                    LoadProfileDetails();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string strConvertDOB = string.Empty;
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/UpdateUserProfileByUserloginId";
                if(!string.IsNullOrEmpty(txtDob.Text.Trim()))
                {
                    string[] starttokens = txtDob.Text.Split('/');//txtdate.Text.Split('/');
                    string strDOB = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtdob = Convert.ToDateTime(strDOB);
                    //strConvertDOB = dtdob.ToString("MM/dd/yyyy");
                }
                if (StrBaseURL == "http://192.168.0.98/crmApi/api/")//bosley localhost
                {
                    strConvertDOB = dtdob.ToString("MM/dd/yyyy");//98 server date format
                }
                else
                {
                    strConvertDOB = dtdob.ToString("dd/MM/yyyy");//localhost date format
                }


                var UserEntity = new crmEntity()
                {
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                    identification_id = txtNricNo.Text.Trim(),
                    user_dateofbirth = strConvertDOB.Trim(),
                    user_gendercode = ddlGender.SelectedValue,
                    //product_oriprice = Convert.ToDecimal(txtOriginal_Price.Text.Trim()),
                    email_id = txtEmailId.Text.Trim(),
                    mobile_no = txtMobileNo.Text.Trim(),
                    address1 = txtAddress1.Text.Trim(),
                    address2 = txtAddress2.Text.Trim(),
                    country_id = Convert.ToInt32(ddlcountry.SelectedValue),
                    state_id = Convert.ToInt32(ddlState.SelectedValue),
                    postcodeid = txtPostCode.Text.Trim(),
                    update_by = Session["username"].ToString()
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, UserEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    lblMsg.Text = "Saved Successfully";
                    return;
                }
                else
                {
                    lblMsg.Text = response.ReasonPhrase.ToString();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
                return;
            }
        }

        protected void BindState()
        {
            ServiceUrl = "CRM/GetStateDetails";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
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

            //ServiceUrl = "InfoAPI/GetStateList";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            //ddlState.Items.Clear();
            //ListItem item = new ListItem("-Select-", "0");
            //ddlState.Items.Insert(0, item);
            //if (response.IsSuccessStatusCode)
            //{
            //    var Merchant = response.Content.ReadAsStringAsync().Result;
            //    var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Merchant);
            //    if (dtState.Rows.Count > 0)
            //    {
            //        foreach (DataRow dtRow in dtState.Rows)
            //        {
            //            if (!string.IsNullOrEmpty((dtRow["state_name"].ToString())))
            //            {
            //                ddlState.Items.Add(new ListItem(dtRow["state_name"].ToString(), dtRow["state_id"].ToString()));
            //            }
            //        }
            //    }
            //}
        }

        public void LoadProfileDetails()
        {
            try
            {
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/GetUserDetailsbyLoginId";
                var userDetailsEntity = new crmEntity ()
                {
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString())
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, userDetailsEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    var UserDetailsList = response.Content.ReadAsStringAsync().Result;
                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserDetailsList);
                    if (DataTable.Rows.Count > 0)
                    {
                        txtuserName.Text = DataTable.Rows[0]["user_fistname"].ToString();
                        txtNricNo.Text = DataTable.Rows[0]["identification_id"].ToString();
                        if (DataTable.Rows[0]["user_dateofbirth"].ToString() != string.Empty)
                        {
                            txtDob.Text = Convert.ToDateTime(DataTable.Rows[0]["user_dateofbirth"]).ToString("dd/MM/yyyy");
                        }
                        if (DataTable.Rows[0]["user_gendercode"].ToString() != string.Empty)
                        {
                            ddlGender.SelectedValue = DataTable.Rows[0]["user_gendercode"].ToString();
                            ddlGender.DataBind();
                        }
                        txtEmailId.Text = DataTable.Rows[0]["email_id"].ToString();
                        txtMobileNo.Text = DataTable.Rows[0]["mobile_no"].ToString();
                        txtAddress1.Text = DataTable.Rows[0]["address1"].ToString();
                        txtAddress2.Text = DataTable.Rows[0]["address2"].ToString();
                        if (DataTable.Rows[0]["country_id"].ToString() != string.Empty)
                        {
                            ddlcountry.SelectedValue = DataTable.Rows[0]["country_id"].ToString();
                            ddlcountry.DataBind();
                        }
                        if (DataTable.Rows[0]["state_id"].ToString() != string.Empty)
                        {
                            ddlState.SelectedValue = DataTable.Rows[0]["state_id"].ToString();
                            ddlState.DataBind();
                        }
                        txtPostCode.Text = DataTable.Rows[0]["postcode_id"].ToString();
                    }
                    else
                    {
                    }
                }
            }
            catch (Exception ex)
            {
                //LblMessage.Text = ex.Message.ToString();
                return;
            }
        }
    }
}