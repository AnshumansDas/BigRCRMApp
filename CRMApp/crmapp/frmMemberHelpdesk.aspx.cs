using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Data;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Text;

namespace CRMApp.crmapp
{
    public partial class frmMemberHelpdesk : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMemberList();
            }
        }

        public void BindMemberList()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/ListOfMemberHelpdesk";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvMember.DataSource = dtChargeType;
                    lvMember.DataBind();
                    ExportGridview.DataSource = dtChargeType;
                    ExportGridview.DataBind();
                   
                }
                else
                {
                    lvMember.DataSource = dtChargeType;
                    lvMember.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }

        protected void lvMember_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem MerchantItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (MerchantItems != null)
                {
                    string user_id = (string)lvMember.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                    string email_id = (string)lvMember.DataKeys[MerchantItems.DisplayIndex][1].ToString().Trim();
                    Response.Redirect("../frmResetPassword.aspx?uid=" + user_id.Trim() + "&eid=" + email_id.Trim());
                }
            }
        }

        protected void lvMember_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvMember.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvMember.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvMember.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvMember.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvMember_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMember.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMemberList();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMemberList();
        }

        // click on export to excel function
        protected void lnkexport_click(object sender,EventArgs e)
        {
            ExportGridToExcel();
        }


        private void ExportGridToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "Report" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            ExportGridview.GridLines = GridLines.Both;
            ExportGridview.HeaderStyle.Font.Bold = true;
            ExportGridview.AllowSorting = false;
            ExportGridview.AllowPaging = false;
            //ExportGridview.Columns[0].Visible = false;
            ExportGridview.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();

        }

        //This is very important to excel upload time
        public override void VerifyRenderingInServerForm(Control control)
        {
            //return;
           
        }

        //click on print function
        protected void lnkPrint_Click(object sender, EventArgs e)
        {
           ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Print", "PrintMemberHelpDesc();", true);

        }
    }
  }
