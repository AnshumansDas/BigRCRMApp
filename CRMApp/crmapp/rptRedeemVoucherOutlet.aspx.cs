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
    public partial class rptRedeemVoucherOutlet : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["branchID"] != null)
                { BindRedeemVoucherData(); }
            }
        }

        protected void BindRedeemVoucherData()
        {
            string data = txtDateRange.Text.Trim();
            if (data != "")
            {
                string[] dates = data.Split('-');
                startdate = dates[0].ToString().Trim();
                enddate = dates[1].ToString().Trim();
            }

            if (startdate != "")
            {
                string[] starttokens = startdate.Split('/');//txtdate.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            }
            else
            {
                dtStartDate = "1900-01-01";
            }
            //string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            if (enddate != "")
            {
                string[] endtokens = enddate.Split('/');//txtdate.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            }
            else
            {
                dtEndDate = "1900-01-01";
            }

            ServiceUrl = "CRM/GetMerchantOutletVoucherRedeemed";
            var crm = new crmEntity()
            {
                branch_id = Convert.ToInt32(Session["branchID"].ToString().Trim()),
                start_date = dtStartDate,
                end_date = dtEndDate
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtscount"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    LstVoucherTransaction.DataSource = dtChargeType;
                    LstVoucherTransaction.DataBind();
                }
                else
                {
                    LstVoucherTransaction.DataSource = dtChargeType;
                    LstVoucherTransaction.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }

        protected void LstVoucherTransaction_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                //HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                //if (colorstatus.InnerText == "Active")
                //{ colorstatus.Style.Add("color", "green"); }
                //else
                //{ colorstatus.Style.Add("color", "red"); }

                HtmlGenericControl totalrecord = (HtmlGenericControl)LstVoucherTransaction.FindControl("totalrecord");
                if (ViewState["dtscount"] != null)
                {
                    dt = (DataTable)ViewState["dtscount"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((LstVoucherTransaction.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (LstVoucherTransaction.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (LstVoucherTransaction.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindRedeemVoucherData();
        }

        protected void LstVoucherTransaction_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LstVoucherTransaction.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindRedeemVoucherData();
        }
    }
}