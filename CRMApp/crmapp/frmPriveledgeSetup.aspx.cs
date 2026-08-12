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

namespace CRMApp.crmapp
{
    public partial class frmPriveledgeSetup : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        static DataTable dtList = new DataTable();
        HttpResponseMessage response = null;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    int role_id =Convert.ToInt32(Request.QueryString["role_id"].ToString().Trim());
                    BindPriveledgeListing(role_id);
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                //BindVoucherCategoryCode();
                //BindVoucherCategoryListing();
            }
        }

        public void BindPriveledgeListing(int RoleId)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetPreviledgesListByRoleId";
            var crm = new crmEntity()
            {
                role_id = RoleId
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvPageList.DataSource = dtChargeType;
                    lvPageList.DataBind();
                }
                else
                {
                    lvPageList.DataSource = dtChargeType;
                    lvPageList.DataBind();
                }
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmPreviledgesList.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/AddEditPreveledgeSetup";

            foreach (ListViewItem item in lvPageList.Items)
            {
                int checkStatus = 0;
                CheckBox chk = (CheckBox)item.FindControl("chkpage");
                if (chk != null)
                {
                    if (chk.Checked == true)
                    {
                        checkStatus = 1;
                    }
                    else
                    {
                        checkStatus = 0;
                    }
                }
                Label PriveledgeId =(Label) item.FindControl("lblPreId");
                var crm = new crmEntity()
                {
                    role_id = Convert.ToInt32(Request.QueryString["role_id"].ToString().Trim()),
                    prev_id = Convert.ToInt32(PriveledgeId.Text.Trim()),
                    active_status = checkStatus
                };
            response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
        }
            if (response.IsSuccessStatusCode)
            {
                lblmsg.Text = "Updated Successfully";
                lblmsg.ForeColor = System.Drawing.Color.Green;
                lblmsg.Visible = true;
            }
            else
            {
                lblmsg.Text = "Unable to Update";
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Visible = true;
            }
        }

        protected void lvPageList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            //Get the label Control and based on the value make the chk bok tick and untick
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataTable dt = new DataTable();
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvPageList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }

                Label priveledge_Status =(Label)e.Item.FindControl("lblStatus");
                CheckBox ckp = (CheckBox)e.Item.FindControl("chkpage");
                if(priveledge_Status.Text=="0")
                {
                    ckp.Checked = false;
                }
                else
                {
                    ckp.Checked = true;
                }
            }

        }
    }
}