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
using Newtonsoft.Json.Linq;

namespace CRMApp.crmapp
{
    public partial class frmSstSetupAddEdit : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                     
                if (Request.QueryString["id"].Trim() == "''")
                {
                    //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    //ServiceUrl = "CRM/GetSstid";
                    //HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
                    //if (response.IsSuccessStatusCode)
                    //{
                    //    var Branch = response.Content.ReadAsStringAsync().Result;
                    //    //Txtid.Text = getBetween(Branch, "[\"", "\"]");
                        Txtid.Text = null;


                    //}                  
                }
                else
                {
                    EditDataBind();
                }
            }
        }
        protected void EditDataBind()
        {
            string id = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetSSTList";
            if (Request.QueryString["id"].Trim()!= null)
            {
                id = Request.QueryString["id"].Trim();
                
            }
             var crm = new crmEntity()
            {
                ID = Convert.ToInt32(id)
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                if (dtChargeType.Rows.Count > 0)
                {
                   // lblMerchantCode.Text = dtChargeType.Rows[0]["merchant_code"].ToString().Trim();
                    Txtid.Text= dtChargeType.Rows[0]["id"].ToString().Trim();
                    txtSST.Text = dtChargeType.Rows[0]["sst_value"].ToString().Trim();
                    TxtAreaRemark.InnerText = dtChargeType.Rows[0]["Remarks"].ToString().Trim();
                    ddlActiveStatus.SelectedValue = dtChargeType.Rows[0]["Status"].ToString().Trim();
                    TxtTaxName.Text= dtChargeType.Rows[0]["tax_name"].ToString().Trim();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    int id = 0;
            //    string sessionname = string.Empty;
            //    bool type = true;
            //    int typevalue = 0;
            //    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //    ServiceUrl = "CRM/AddEditSstValues";
            //    if(typevalue == Convert.ToInt32(ddlActiveStatus.SelectedValue.Trim()))
            //    {
            //        type = false;
            //    }                
            //    if (Txtid.Text != "")
            //    {
            //        id = Convert.ToInt32(Txtid.Text);
            //    }
            //    if(Session["username"]!=null)
            //    {
            //        sessionname = "";
            //    }
            //    var crm = new crmEntity()
            //    {
            //        tax_id = Convert.ToInt32(id),
            //        sst = Convert.ToDecimal(txtSST.Text),
            //        remarks = TxtAreaRemark.InnerText,
            //        active_status = type,
            //        created_by = sessionname,
            //        updated_by = sessionname,
            //        tax_name = TxtTaxName.Text
            //    };
            //    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            //    if (response.IsSuccessStatusCode)
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessMsg();", true);
            //        Response.Redirect("~/crmapp/frmSstSetup.aspx");
            //    }
            //    else
            //    {
            //        message.InnerText = response.ReasonPhrase.ToString();
            //        message.Style.Add("color", "Red");
            //    }
            //}
            //catch(Exception ex)
            //{
            //    message.InnerText = ex.Message.ToString();
            //    return;
            //}

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/crmapp/frmSstSetup.aspx");
        }
        public static string getBetween(string strSource, string strStart, string strEnd)
        {
            int Start, End;
            if (strSource.Contains(strStart) && strSource.Contains(strEnd))
            {
                Start = strSource.IndexOf(strStart, 0) + strStart.Length;
                End = strSource.IndexOf(strEnd, Start);
                return strSource.Substring(Start, End - Start);
            }
            else
            {
                return "";
            }
        }
    }
}