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

namespace CRMApp.crmapp
{
   
    public partial class frmSstSetup : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty;
       #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindSstDetails();
            }

        }
        protected void BindSstDetails()
        {
           
            string strSendVal = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetSSTList";          
            var crm = new crmEntity()
            {
                
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcount"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    Lv_sst.DataSource = dtChargeType;
                    Lv_sst.DataBind();
                }
                else
                {
                    Lv_sst.DataSource = dtChargeType;
                    Lv_sst.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }

        }
        protected void Lv_sst_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                if (colorstatus.InnerText == "True")
                {
                   // colorstatus.Style.Add("color", "green");
                    colorstatus.InnerText="Active";
                }
                else
                {
                    //colorstatus.Style.Add("color", "red");
                    colorstatus.InnerText = "In-Active";
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_sst.FindControl("totalrecord");
                if (ViewState["dtcount"] != null)
                {
                    dt = (DataTable)ViewState["dtcount"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((Lv_sst.FindControl("DataPager2") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_sst.FindControl("DataPager2") as DataPager).Visible = true;
            }
            else
            {
                (Lv_sst.FindControl("DataPager2") as DataPager).Visible = false;
            }
        }
       

        protected void lnkAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmSstSetupAddEdit.aspx?id=''", false);
        }

        protected void Lv_sst_SelectedIndexChanged(object sender, EventArgs e)
        {

        }        

        protected void Lv_sst_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_sst.FindControl("DataPager2") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindSstDetails();
        }

        protected void Lv_sst_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem MerchantItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (MerchantItems != null)
                {
                    string id = (string)Lv_sst.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("frmSstSetupAddEdit.aspx?id=" + id);
                }
            }
            else if(e.CommandName=="Status")
            {
                string id = (string)Lv_sst.DataKeys[MerchantItems.DisplayIndex][0].ToString().Trim();
                HtmlGenericControl colorstatus = (HtmlGenericControl)MerchantItems.FindControl("colorstatus");   
                    if (colorstatus.InnerText == "Active")
                    {                       
                        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        ServiceUrl = "CRM/UpdateStatus";
                        var crm = new crmEntity()
                        {
                            tax_id = Convert.ToInt32(id),
                            active_status = 0
                        };
                        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            Response.Redirect("~/crmapp/frmSstSetup.aspx");
                        }

                    }
                    else
                    {                       
                        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                        ServiceUrl = "CRM/UpdateStatus";
                        var crm = new crmEntity()
                        {
                            tax_id = Convert.ToInt32(id),
                            active_status = 1
                        };
                        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            Response.Redirect("~/crmapp/frmSstSetup.aspx");
                        }                    
                     }
            }
        }
    }
}