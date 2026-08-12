using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
    public partial class frmBannerAddEdit : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty;
        int intContentId = 0;
        #endregion

        #region Control_Events

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindBannerCategoryCode();
                Fu_BannerImage.Attributes["onchange"] = "UploadFile(this)";
                if (Request["ContentId"].ToString() != "0")
                {
                    intContentId = Convert.ToInt16(Request["ContentId"].ToString());
                    GetBannerDetailsById();
                }
            }

        }

        protected void Upload(object sender, EventArgs e)
        {
            if (Fu_BannerImage.HasFile)
            {
                //Get Filename from fileupload control
                string strfilename = Fu_BannerImage.PostedFile.FileName.ToString().Replace(" ","");
                //Save images into Images folder
                string fext = Path.GetExtension(strfilename);
                int flen = Fu_BannerImage.PostedFile.ContentLength;
                fext = fext.ToLower();
                string FileDetailslink = "crmapp//Banner//" + strfilename;   //this link will be stored in database
                ViewState["imagepath"] = FileDetailslink;
                if (flen < 1048576)
                {
                    if (fext == ".jpg" || fext == ".png" || fext == ".gif" || fext == ".bmp")
                    {
                        Fu_BannerImage.SaveAs(Server.MapPath("Banner//" + strfilename));
                        dvImgpreview.Visible = true;
                        lblMessage.Visible = true;
                        imgpreview.ImageUrl = "..//crmapp//Banner//" + strfilename;
                    }
                    else
                    {
                        Response.Write("<script>alert('Only image files are allowed');</script>");
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                ServiceUrl = "CRM/AddEditBannerDetails";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (Session["username"] != null)
                    strCreatedby = Session["username"].ToString();
                string dtStartDate = "", dtEndDate = "";
                if (txtStartDate.Text.Trim() != "")
                {
                    string[] starttokens = txtStartDate.Text.Split('/');//txtdate.Text.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                if (txtEndDate.Text.Trim() != "")
                {
                    string[] endtokens = txtEndDate.Text.Split('/');//txtdate.Text.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                if (Request["ContentId"].ToString() != "0")
                {
                    intContentId = Convert.ToInt16(Request["ContentId"].ToString());
                }
                var memDetValue = new crmEntity()
                {
                    content_id = intContentId,
                    content_code = lblBannerCode.Text.Trim(),
                    content_title = txtBannerTitle.Text.Trim(),
                    content_description = TxtBannerDescription.Text.Trim(),
                    content_category_code = ddlBannerCat.SelectedValue.ToString().Trim(),
                    start_date = dtStartDate.ToString(), //Convert.ToDateTime(dtStartDate),
                    end_date = dtEndDate.ToString(), //Convert.ToDateTime(dtEndDate),
                    created_by = strCreatedby,
                    update_by = strCreatedby,
                    active_status = Convert.ToInt32(ddlActiveStatus.SelectedValue),
                    image_path = ViewState["imagepath"].ToString()
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, memDetValue).Result;
                if (response.IsSuccessStatusCode)
                {
                    message.InnerText = "Member Created Successfully.";
                    message.Style.Add("color", "Green");
                    Response.Redirect("../crmapp/frmBanner.aspx", false);
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
                message.InnerText = ex.Message.ToString();
                return;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmBanner.aspx");
        }

        #endregion

        #region User_Defined_Methods
        public void BindBannerCategoryCode()
        {
            ServiceUrl = "CRM/GetBannerCategoryCode";
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var banCatEntity = new crmEntity()
            {
            };
            HttpResponseMessage responsecat = client.PostAsJsonAsync(ServiceUrl, banCatEntity).Result;
            if (responsecat.IsSuccessStatusCode)
            {
                var BannerCategoryResult = responsecat.Content.ReadAsStringAsync().Result;
                var dtBannerCategory = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(BannerCategoryResult);
                ddlBannerCat.Items.Clear();
                ListItem item = new ListItem("-Select-", "0");
                ddlBannerCat.Items.Insert(0, item);

                if (dtBannerCategory.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtBannerCategory.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow[1].ToString())))
                        { ddlBannerCat.Items.Add(new ListItem(dtRow[2].ToString(), dtRow[0].ToString())); }
                    }
                }
            }
        }

        public void GetBannerDetailsById()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetBannerDetailsById";
            if (!string.IsNullOrEmpty(Request.QueryString["ContentId"].Trim()))
            { intContentId = Convert.ToInt16(Request.QueryString["ContentId"].Trim()); }

            var crm = new crmEntity()
            {
                content_id = intContentId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var BannerListByContentId = response.Content.ReadAsStringAsync().Result;
                var dtBannerListByContentId = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(BannerListByContentId);
                if (dtBannerListByContentId.Rows.Count > 0)
                {
                    lblBannerCode.Text = dtBannerListByContentId.Rows[0]["content_code"].ToString().Trim();
                    TxtBannerDescription.Text = dtBannerListByContentId.Rows[0]["content_description"].ToString().Trim();
                    txtStartDate.Text = dtBannerListByContentId.Rows[0]["startdate"].ToString().Trim();
                    txtEndDate.Text = dtBannerListByContentId.Rows[0]["enddate"].ToString().Trim();
                    txtBannerTitle.Text = dtBannerListByContentId.Rows[0]["content_title"].ToString().Trim();
                    if (dtBannerListByContentId.Rows[0]["content_category_code"].ToString().Trim() != "")
                    {
                        ddlBannerCat.SelectedValue = dtBannerListByContentId.Rows[0]["content_category_code"].ToString().Trim();
                        ddlBannerCat.DataBind();
                    }
                    if (dtBannerListByContentId.Rows[0]["active_status"].ToString().Trim() != "")
                    {
                        ddlActiveStatus.SelectedValue = dtBannerListByContentId.Rows[0]["active_status"].ToString().Trim();
                        ddlActiveStatus.DataBind();
                    }

                    if (!string.IsNullOrEmpty(dtBannerListByContentId.Rows[0]["image_path"].ToString().Trim()))
                    {
                        dvImgpreview.Visible = true;
                        imgpreview.ImageUrl = "..//" + dtBannerListByContentId.Rows[0]["image_path"].ToString().Trim();
                        ViewState["imagepath"] = dtBannerListByContentId.Rows[0]["image_path"].ToString().Trim();
                    }
                    else
                    {
                        dvImgpreview.Visible = false;
                        lblMessage.Text = "No logo";
                        //uploadmsg.Style.Add("color", "Red");
                    }
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        #endregion
    }
}