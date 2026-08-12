using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Web.UI.HtmlControls;
using Newtonsoft.Json.Linq;
using System.IO;

namespace CRMApp.crmapp
{
    public partial class frmContentAddEdit : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string ckfinder = ConfigurationManager.AppSettings["ckfinder"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindContentCategory();
                    if (Request.QueryString["cid"] != "0")
                    {
                        BindData(Convert.ToInt32(Request.QueryString["cid"].ToString().Trim()));
                    }
                    else
                    {
                        if (ddlContentCat.SelectedValue.Trim() == "2" || ddlContentCat.SelectedValue.Trim() == "3")
                        {
                            lblTitleDescription.Text = "Summary";
                            dvDescription1.Visible = true;
                        }
                        else
                        {
                            lblTitleDescription.Text = "Description";
                            dvDescription1.Visible = false;
                        }
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }

            CKFinder.FileBrowser _FileBrowser = new CKFinder.FileBrowser();
            _FileBrowser.BasePath = ckfinder;
            _FileBrowser.SetupCKEditor(txtContentDescription);
            _FileBrowser.SetupCKEditor(txtContentDescription1);
        }

        public void BindContentCategory()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetContentCategory";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var ResResult = response.Content.ReadAsStringAsync().Result;
                var dtContentCategories = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                ddlContentCat.Items.Clear();
                ListItem item = new ListItem("-Select-", "0");
                ddlContentCat.Items.Insert(0, item);

                if (dtContentCategories.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtContentCategories.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow[2].ToString())))
                        { ddlContentCat.Items.Add(new ListItem(dtRow[2].ToString(), dtRow[0].ToString())); }
                    }
                }
            }
        }

        public void BindData(int contentID)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetContentList";
            var crm = new crmEntity()
            {
                content_id = contentID
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtContent = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtContent;
                if (dtContent.Rows.Count > 0)
                {
                    lblContentCode.Text = dtContent.Rows[0]["content_code"].ToString();
                    ddlContentCat.SelectedValue = dtContent.Rows[0]["content_category_code"].ToString();
                    if (dtContent.Rows[0]["content_category_code"].ToString().Trim() == "2" ||
                        dtContent.Rows[0]["content_category_code"].ToString().Trim() == "3")
                    {
                        lblTitleDescription.Text = "Summary";
                        dvDescription1.Visible = true;
                    }
                    else
                    {
                        lblTitleDescription.Text = "Description";
                        dvDescription1.Visible = false;
                    }
                    txtContentTitle.Text = dtContent.Rows[0]["content_title"].ToString();
                    txtContentDescription.Text = dtContent.Rows[0]["content_description"].ToString();
                    txtContentDescription1.Text = dtContent.Rows[0]["content_description1"].ToString();
                    ddlActiveStatus.SelectedValue = dtContent.Rows[0]["active_status"].ToString();
                    ddlContentCat.Enabled = false;
                }
                else
                {
                    message.InnerText = "Content not found";
                    message.Style.Add("color", "Red");
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void ddlContentCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlContentCat.SelectedValue.Trim() == "2" || ddlContentCat.SelectedValue.Trim() == "3")
            {
                lblTitleDescription.Text = "Summary";
                dvDescription1.Visible = true;
            }
            else
            {
                lblTitleDescription.Text = "Description";
                dvDescription1.Visible = false;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmContent.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int contID;
            string strImagePath = string.Empty;
            try
            {
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/AddEditContent";
                if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
                { contID = Convert.ToInt32(Request.QueryString["cid"].ToString().Trim()); }
                else
                { contID = 0; }

                var crm = new crmEntity()
                {
                    content_id = contID,
                    content_code = lblContentCode.Text,
                    content_category_code = ddlContentCat.SelectedValue,
                    content_title = txtContentTitle.Text,
                    content_description = txtContentDescription.Text.Trim(),
                    content_description1 = txtContentDescription1.Text.Trim(),
                    active_status = Convert.ToInt16(ddlActiveStatus.SelectedValue.Trim()),
                    image_path = strImagePath,
                    created_by = Session["username"].ToString(),
                    update_by = Session["username"].ToString()
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessContentMsg();", true);
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
    }
}