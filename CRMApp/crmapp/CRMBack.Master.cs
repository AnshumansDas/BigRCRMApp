using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static CRMApp.crmEntity;

namespace CRMApp.crmapp
{
    public partial class CRMBack : System.Web.UI.MasterPage
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        int roleID;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!IsPostBack)
            {
                #region ajax script mapping handler
                //ScriptManager.ScriptResourceMapping.AddDefinition("WebResource.js", new ScriptResourceDefinition
                //{
                //    Path = "~/crmapp/js/WebResource.js",
                //    CdnSupportsSecureConnection = true
                //});

                //ScriptManager.ScriptResourceMapping.AddDefinition("ScriptResource.js", new ScriptResourceDefinition
                //{
                //    Path = "~/crmapp/js/ScriptResource.js",
                //    CdnSupportsSecureConnection = true
                //});

                ScriptManager.ScriptResourceMapping.AddDefinition("MicrosoftAjaxWebForms.js", new ScriptResourceDefinition
                {
                    Path = "~/crmapp/js/scriptresource1.js",
                    //CdnPath = "http://ajax.aspnetcdn.com/ajax/4.5.1/1/MicrosoftAjaxWebForms.js",
                    //LoadSuccessExpression = "window.Sys && Sys.WebForms",
                    CdnSupportsSecureConnection = true
                });

                ScriptManager.ScriptResourceMapping.AddDefinition("MicrosoftAjax.js", new ScriptResourceDefinition
                {
                    Path = "~/crmapp/js/scriptresource2.js",
                    //CdnPath = "http://ajax.aspnetcdn.com/ajax/4.5.1/1/MicrosoftAjax.js",
                    //LoadSuccessExpression = "window.Sys && Sys._Application && Sys.Observer",
                    CdnSupportsSecureConnection = true
                });
                #endregion
                BindContactUs();
                if (Session["username"] != null)
                {
                    lblWelcomeUser.Text = Session["username"].ToString();
                    BindMenu();
                    BindAddToWishlistInfo(); BindAddToCartInfo();
                    if (Session["roleid"].ToString().Trim() == "3")
                    {
                        BindAddToNotificationInfo();
                        Notify.Visible = true;
                    }
                    CheckSessionTimeout();
                    if (Session["User_FirstName"] != null)
                    {
                        TxtPersonName.Text = Session["User_FirstName"].ToString();
                        TxtPersonName.Enabled = false;
                    }
                    if (Session["Mobile_No"] != null)
                    {
                        txtHpNo.Text = Session["Mobile_No"].ToString();
                        txtHpNo.Enabled = false;
                    }
                    if (Session["EmailId"] != null)
                    {
                        txtEmail.Text = Session["EmailId"].ToString();
                        txtEmail.Enabled = false;
                    }
                    if (Session["lastlogin"] != null)
                    {
                        lblLastLogin.Text = Session["lastlogin"].ToString();
                        //lblLastLogin.Enabled = false;
                    }
                }
            }
        }

        public void BindAddToWishlistInfo()
        {
            #region cart information
            //====================== count cart items=============
            //Label lblWishCount = (Label)this.Master.FindControl("lblWishCount");
            try
            {
                if (Session["userid"] != null)
                {
                    ServiceUrl = "CRM/GetCountAddToWishlistByUser";
                    var cartValue = new crmEntity()
                    {
                        user_id = Convert.ToInt16(Session["user_id"].ToString())
                    };

                    HttpResponseMessage responsecart = client.PostAsJsonAsync(ServiceUrl, cartValue).Result;
                    if (responsecart.IsSuccessStatusCode)
                    {
                        var CartDetails = responsecart.Content.ReadAsStringAsync().Result;
                        var dtCart = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CartDetails);
                        if (dtCart.Rows.Count > 0)
                        {
                            lblWishCount.Text = dtCart.Rows.Count.ToString();
                        }
                        else
                        { lblWishCount.Text = ""; }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return;
            }
            #endregion
        }

        public void BindAddToCartInfo()
        {
            #region cart information
            //====================== count cart items=============
            //Label lblCartCount = Master.FindControl("lblCartCount") as Label;
            try
            {
                if (Session["UserId"] != null)
                {
                    ServiceUrl = "CRM/GetOLCountByUserloginId";
                    var cartValue = new crmEntity()
                    {
                        user_id = Convert.ToInt16(Session["userid"].ToString())
                    };

                    HttpResponseMessage responsecart = client.PostAsJsonAsync(ServiceUrl, cartValue).Result;
                    if (responsecart.IsSuccessStatusCode)
                    {
                        var CartDetails = responsecart.Content.ReadAsStringAsync().Result;
                        var dtCart = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CartDetails);
                        if (dtCart.Rows.Count > 0)
                        {
                            lblCartCount.Text = dtCart.Rows[0]["product_qty"].ToString().Trim();// dtCart.Rows.Count.ToString();
                        }
                        else
                        {
                            lblCartCount.Text = "";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return;
            }
            #endregion
        }

        void BindMenu()
        {
            if (Session["roleid"] != null)
            {
                roleID = Convert.ToInt16(Session["roleid"]);
                ServiceUrl = "CRM/GetModuleList?role_id=" + roleID;
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ResResult = response.Content.ReadAsStringAsync().Result;
                    var dtMenu = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                    if (dtMenu.Rows.Count > 0)
                    {
                        rptMenu.DataSource = dtMenu;
                        rptMenu.DataBind();
                        Session.Add("dtMenu", dtMenu);
                    }
                    else
                    {
                        rptMenu.DataSource = dtMenu;
                        rptMenu.DataBind();
                    }
                }
            }
        }

        protected void rptMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptChildMenu = e.Item.FindControl("rptChildMenu") as Repeater;
                roleID = Convert.ToInt16(Session["roleid"]);
                ServiceUrl = "CRM/GetModuleBySub?role_id=" + roleID + "&parent_id=" + Convert.ToInt16(((System.Data.DataRowView)(e.Item.DataItem)).Row[0]);
                HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ResResult = response.Content.ReadAsStringAsync().Result;
                    var dtSubMenu = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                    if (dtSubMenu.Rows.Count > 0)
                    {
                        rptChildMenu.DataSource = dtSubMenu;
                        rptChildMenu.DataBind();
                    }
                }
            }
        }

        protected void rptMobileMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    Repeater rpMobileChildMenu = e.Item.FindControl("rpMobileChildMenu") as Repeater;
            //    roleID = Convert.ToInt16(Session["roleid"]);
            //    ServiceUrl = "InfoApi/GetModuleBySub?role_id=" + roleID + "&parent_id=" + Convert.ToInt16(((System.Data.DataRowView)(e.Item.DataItem)).Row[0]);
            //    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //    HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            //    if (response.IsSuccessStatusCode)
            //    {
            //        var ResResult = response.Content.ReadAsStringAsync().Result;
            //        var dtMobileSubMenu = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
            //        if (dtMobileSubMenu.Rows.Count > 0)
            //        {
            //            rpMobileChildMenu.DataSource = dtMobileSubMenu;
            //            rpMobileChildMenu.DataBind();
            //        }

            //    }
            //}
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string strUserId = string.Empty;
                int roleid = 0, userloginid = 0;
                if (Session["roleid"] != null)
                    roleid = Convert.ToInt16(Session["roleid"].ToString());
                if (Session["userid"] != null)
                    userloginid = Convert.ToInt16(Session["userid"].ToString());

                ServiceUrl = "CRM/AddFeedback";
                if (Session["user_id"] != null)
                {
                    strUserId = Session["user_id"].ToString();
                }
                var FBEntity = new crmEntity()
                {
                    name = TxtPersonName.Text.Trim(),
                    hp_no = txtHpNo.Text.Trim(),
                    email = txtEmail.Text.Trim(),
                    subject = txtSubject.Text.Trim(),
                    message = txtMessage.Text,
                    created_by = strUserId,
                    role_id = roleid,
                    userlogin_id = userloginid
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    TxtPersonName.Text = string.Empty;
                    txtHpNo.Text = string.Empty;
                    txtEmail.Text = string.Empty;
                    txtSubject.Text = string.Empty;
                    txtMessage.Text = string.Empty;
                    ScriptManager.RegisterStartupScript(UpFeedBack, UpFeedBack.GetType(), "Pop", "SuccessFeedbackshowMsg();", true);
                    return;
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

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Logout.aspx");
        }

        protected void lnkTotalCartItem_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmCart.aspx");
        }

        protected void lnkTotalWishListItem_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmWishList.aspx");
        }
        
        public void BindContactUs()
        {
            ServiceUrl = "CRM/GetContentList";
            var crm = new crmEntity()
            {
                content_id = 5
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                    lvFrontContent.DataSource = dtChargeType;
                    lvFrontContent.DataBind();
                }
                else
                {
                    lvFrontContent.DataSource = dtChargeType;
                    lvFrontContent.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        private void CheckSessionTimeout()
        {
            //string msgSession = "Warning: Within next 3 minutes, if you do not do anything, " +
            //    " our system will redirect to the home page. Please save changed data.";
            string msgSession = "Your session is expired, our system will redirect to the home page.";

            //time to remind, 3 minutes before session ends
            int int_MilliSecondsTimeReminder = (this.Session.Timeout * 200);


            //time to redirect, 5 milliseconds before session ends
            int int_MilliSecondsTimeOut = (this.Session.Timeout * 200) - 5;


            string str_Script = @" var myTimeReminder, myTimeOut; " +
                " clearTimeout(myTimeReminder); " +
                " clearTimeout(myTimeOut); " +
                "var sessionTimeReminder = " + int_MilliSecondsTimeReminder.ToString() + "; " +
                "var sessionTimeout = " + int_MilliSecondsTimeOut.ToString() + ";" +
                "function doReminder(){ alert('" + msgSession + "'); }" +
                //"function doRedirect(){ window.location.href='../Logout.aspx'; }" +
                "function doRedirect(){ window.location.href='../Home.aspx'; }" +
                " myTimeReminder=setTimeout('doReminder()', sessionTimeReminder); myTimeOut=setTimeout('doRedirect()',sessionTimeout); ";


            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "CheckSessionOut", str_Script, true);
        }

        #region Notification Count
        public void BindAddToNotificationInfo()
        {
            #region wishlist count information
            //====================== count wishlist items=============
            try
            {
                if (Session["userid"] != null)
                {
                    ServiceUrl = "CRM/GetCountAddToNotificationByUser";
                    var NotificationValue = new crmEntity()
                    {
                        user_id = Convert.ToInt16(Session["user_id"].ToString())
                    };

                    HttpResponseMessage responsecart = client.PostAsJsonAsync(ServiceUrl, NotificationValue).Result;
                    if (responsecart.IsSuccessStatusCode)
                    {
                        var NotificationDetails = responsecart.Content.ReadAsStringAsync().Result;
                        var dtNotification = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(NotificationDetails);
                        if (dtNotification.Rows.Count > 0)
                        {
                            lblNotificationCount.Text = dtNotification.Rows.Count.ToString();
                        }
                        else
                        { lblNotificationCount.Text = ""; }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return;
            }
            #endregion
        }
        protected void lnkTotalNotificationItem_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAdminWithdrawNotification.aspx");
        }
        #endregion
    }
}