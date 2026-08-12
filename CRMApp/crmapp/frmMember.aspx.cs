using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.IO;

namespace CRMApp.crmapp
{
    public partial class frmMember : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();
        int user_id = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {           
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMemberList();
                Bindroles();
            }
        }

        protected void Bindroles()
        {
            ServiceUrl = "CRM/GetRoleDetails";           
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlRole.Items.Clear();
            ListItem item = new ListItem("-Select-", "0");
            ddlRole.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var Role = response.Content.ReadAsStringAsync().Result;
                var dtRole = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Role);
                if (dtRole.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtRole.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["user_role"].ToString())))
                        {
                            ddlRole.Items.Add(new ListItem(dtRow["user_role"].ToString(), dtRow["role_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void lnkAddNewMember_Click(object sender, EventArgs e)
        {
            ddlRole.SelectedIndex = 0;
            txtName.Text = string.Empty;
            txtName.Enabled=true;
            txtUsername.Text = string.Empty;
            txtUsername.Enabled=true;
            txtEmailAddress.Text = string.Empty;
            txtEmailAddress.Enabled=true;
            ddlActiveStatus.SelectedIndex = 0;
            invalidmsg.InnerText = string.Empty;
            lblPopUpTitle.Text = "Add New User";          
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "PopupAddEditUserModal();", true);
        }

        protected void LV_Member_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LV_Member.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMemberList();
        }

        protected void LV_Member_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
          
            ListViewDataItem Items = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (Items != null)
                {
                    string strUserID = (string)LV_Member.DataKeys[Items.DisplayIndex][0].ToString().Trim();
                    GetMemberByID(strUserID.Trim());
                    ViewState["user_id"] = strUserID.Trim();
                }
            }
        }

        protected void LV_Member_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void LV_Member_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "Active")
                { colorstatus.Style.Add("color", "green"); }
                else
                { colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)LV_Member.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((LV_Member.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (LV_Member.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (LV_Member.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMemberList();
        }

        public void GetMemberByID(string strVal)
        {
            invalidmsg.InnerText = string.Empty;
            Bindroles();
            ServiceUrl = "CRM/GetUserDetailsToEdit";
            var MemberEntity = new crmEntity()
            {
                user_id = Convert.ToInt32(strVal.Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, MemberEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var MemberListDetails = response.Content.ReadAsStringAsync().Result;
                var dtMemberListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MemberListDetails);
                if (dtMemberListDetails.Rows.Count > 0)
                {
                    ddlRole.SelectedValue = dtMemberListDetails.Rows[0]["role_id"].ToString().Trim();
                    txtName.Text = dtMemberListDetails.Rows[0]["name"].ToString().Trim();
                    txtUsername.Text = dtMemberListDetails.Rows[0]["user_name"].ToString().Trim();
                    txtEmailAddress.Text = dtMemberListDetails.Rows[0]["email_id"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtMemberListDetails.Rows[0]["active_status"].ToString().Trim();
                    txtName.Enabled = false;
                    txtUsername.Enabled = false;
                    txtEmailAddress.Enabled = false;
                    lblPopUpTitle.Text = "Edit User Information";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "PopupAddEditUserModal();", true);
                }
            }
        }

        public void BindMemberList()
        {
            string strSendVal = string.Empty;          
            ServiceUrl = "CRM/GetMemerListDetails";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            var MemberEntity = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, MemberEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var MemberListDetails = response.Content.ReadAsStringAsync().Result;
                var dtMemberListDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(MemberListDetails);
                ViewState["dtcont"] = dtMemberListDetails;
                if (dtMemberListDetails.Rows.Count > 0)
                {
                    LV_Member.DataSource = dtMemberListDetails;
                    LV_Member.DataBind();
                }
                else
                {
                    LV_Member.DataSource = dtMemberListDetails;
                    LV_Member.DataBind();
                }
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
          HttpResponseMessage responseemail = new HttpResponseMessage();
            if (ViewState["user_id"] != null)
            { SaveUserInfo(); }
            else
            {
                if (!string.IsNullOrEmpty(txtEmailAddress.Text.Trim()))
                {
                    ServiceUrl = "CRM/ValidateExistingMerchantEmail";
                    var validateemail = new crmEntity()
                    {
                        email_id = txtEmailAddress.Text.Trim(),
                    };
                    responseemail = client.PostAsJsonAsync(ServiceUrl, validateemail).Result;
                    if (responseemail.IsSuccessStatusCode)
                    {
                        var EmailList = responseemail.Content.ReadAsStringAsync().Result;
                        var dtEmail = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(EmailList);
                        if (dtEmail.Rows.Count > 0)
                        {
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "Hidepopup();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "Hidepopup();", true);
                            invalidmsg.InnerText = "Email was already existed";
                            invalidmsg.Style.Add("color", "Red");
                        }
                        else
                        {                           
                            invalidmsg.InnerText = string.Empty;
                            SaveUserInfo();
                            BindMemberList();
                        }
                    }
                }
                else
                {
                    invalidmsg.InnerText = responseemail.ReasonPhrase.ToString();
                    invalidmsg.Style.Add("color", "Red");
                }
            }
        }

        public void SaveUserInfo()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            try
            {
                ServiceUrl = "CRM/CreateBusinessUserBySystemAdmin";
                if (ViewState["user_id"] != null)
                { user_id = Convert.ToInt32(ViewState["user_id"].ToString()); }
                var MemberEntity = new crmEntity()
                {
                    user_id = user_id,
                    role_id = Convert.ToInt32(ddlRole.SelectedValue.Trim()),
                    user_fistname = txtName.Text.Trim(),
                    user_name = txtUsername.Text.Trim(),
                    email_id = txtEmailAddress.Text.Trim(),
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue.Trim()),
                    created_by = Session["username"].ToString()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, MemberEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    invalidmsg.InnerText = "Record save successfully!";
                    invalidmsg.Style.Add("color", "DarkGreen");
                    ddlRole.SelectedIndex = 0;
                    txtName.Text = string.Empty;
                    txtUsername.Text = string.Empty;
                    txtEmailAddress.Text = string.Empty;
                    ddlActiveStatus.SelectedIndex = 0;
                   //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "Hidepopup();", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "SuccessFBMsg('frmMember.aspx')", true);                   
                    if (user_id == 0)
                    {
                        var Productlist = response.Content.ReadAsStringAsync().Result;
                        var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                        if (DataTable.Rows.Count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "SuccessFBMsg('frmMember.aspx')", true);
                            string readUserFile = string.Empty, myStringUser = string.Empty, myStringAdmin = string.Empty;
                            try
                            {
                                StreamReader readAdminFile = new StreamReader(Server.MapPath("~/crmadminemail.html"));
                                myStringAdmin = readAdminFile.ReadToEnd();
                                myStringAdmin = myStringAdmin.Replace("$$MemberName$$", DataTable.Rows[0]["user_fistname"].ToString().Trim());
                                SendEmail(strAdminEmail, "User has Registered his/her account Successfully.", myStringAdmin);

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
                                invalidmsg.InnerText = ex.Message.ToString();
                                invalidmsg.Style.Add("color", "Red");
                                return;
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "SuccessFBMsg('frmMember.aspx')", true);
                    }
                }
                else
                {
                    invalidmsg.InnerText = response.ReasonPhrase.ToString();
                    invalidmsg.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                invalidmsg.InnerText = ex.Message.ToString();
                invalidmsg.Style.Add("color", "Red");
                return;
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
                invalidmsg.InnerText = ex.Message.ToString();
                invalidmsg.Style.Add("color", "Red");
                return;
            }
        }
    }
}
