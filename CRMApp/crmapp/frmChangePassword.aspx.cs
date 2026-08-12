using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmChangePassword : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = "", dtEndDate = "";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void btnPasswordUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtConfirmPassword.Text == txtNewPassword.Text)
                {
                    ServiceUrl = "CRM/UpdatePassword";
                    var crm = new crmEntity()
                    {
                        userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim()),
                        user_password = txtOldPassword.Text.Trim(),
                        user_newpassword = txtNewPassword.Text.Trim()
                    };
                    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                    if (response.IsSuccessStatusCode)
                    {
                        var Productlist = response.Content.ReadAsStringAsync().Result;
                        var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                        if (DataTable.Rows.Count > 0)
                        {
                            lblmsg.Text = "Password Updated Successfully";
                            lblmsg.ForeColor = System.Drawing.Color.Green;
                            lblmsg.Visible = true;
                            //SendEmailNotification();
                        }
                    }
                    else
                    {
                        lblmsg.Text = "Can not Update the Password";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                        lblmsg.Visible = true;
                    }

                }
                else
                {
                    lblmsg.Text = "New Password and the Confirm Password should be Same";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    lblmsg.Visible = true;
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}