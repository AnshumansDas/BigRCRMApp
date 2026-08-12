using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Data;
using System.Net.Http;
using System.Configuration;
using System.Net.Http.Headers;
using System.Web.UI.HtmlControls;

namespace CRMApp.crmapp
{
    public partial class frmCurrencyList : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            if (!Page.IsPostBack)
            {
                BindCurrencyType();
                BindCurrencyListing(string.Empty);
            }
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }
        protected void ddlCurrency_SelectedIndexChanged(object sender, EventArgs e)
        {
            message.InnerText = string.Empty;
        }
        public void BindCurrencyType()
        {
            ServiceUrl = "CRM/GetcurrencyDetails";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            ddlCurrency.Items.Clear();
            ListItem item = new ListItem();
            // ddlCurrency.Items.Insert(0, item);
            if (response.IsSuccessStatusCode)
            {
                var State = response.Content.ReadAsStringAsync().Result;
                var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
                if (dtState.Rows.Count > 0)
                {
                    foreach (DataRow dtRow in dtState.Rows)
                    {
                        if (!string.IsNullOrEmpty((dtRow["currency_type"].ToString())))
                        {
                            ddlCurrency.Items.Add(new ListItem(dtRow["currency_type"].ToString(), dtRow["currency_type_id"].ToString()));
                        }
                    }
                }
            }
        }

        public void BindCurrencyListing(string strVal)
        {
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/Getcurrencylist";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "0";
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
                        lvCurrency.DataSource = dtChargeType;
                        lvCurrency.DataBind();
                    }
                    else
                    {
                        lvCurrency.DataSource = dtChargeType;
                        lvCurrency.DataBind();
                    }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
            else
            {
                var crm = new crmEntity()
                {
                    currency_id = Convert.ToInt16(strVal),
                    search_param = ""
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var ChargeType = response.Content.ReadAsStringAsync().Result;
                    var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                    if (dtChargeType.Rows.Count > 0)
                    {
                        ddlCurrency.SelectedValue = dtChargeType.Rows[0]["currency_type_id"].ToString().Trim();
                        txtAmount.Text = dtChargeType.Rows[0]["point"].ToString().Trim();
                        txtConvert.Text = dtChargeType.Rows[0]["amount"].ToString().Trim();
                        Txtmin.Text = dtChargeType.Rows[0]["min_point"].ToString().Trim();
                        Txtmax.Text = dtChargeType.Rows[0]["max_point"].ToString().Trim();
                        TxtStart.Text = dtChargeType.Rows[0]["startdate"].ToString().Trim();
                        //TxtStart.Enabled = false;
                        TxtEnd.Text = dtChargeType.Rows[0]["enddate"].ToString().Trim();
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Show", "popupcurrencyshow();", true);
                    }
                    else
                    {
                        message.InnerText = response.ReasonPhrase.ToString();
                        message.Style.Add("color", "Red");
                    }
                }
                else
                {
                    message.InnerText = response.ReasonPhrase.ToString();
                    message.Style.Add("color", "Red");
                }
            }
        }
        protected void lvCurrency_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }
        public void Clear()
        {
            txtAmount.Text = "";
            txtConvert.Text = "";
            TxtEnd.Text = "";
            Txtmax.Text = "";
            TxtStart.Text = "";
            Txtmin.Text = "";
            ddlCurrency.SelectedIndex = 0;
            ViewState["currency_id"] = null;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Show", "hidepopup();", true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string dtStartDate = "", dtEndDate = ""; int currencyid = 0;
                string[] starttokens = TxtStart.Text.Split('/');
                string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");


                string[] endtokens = TxtEnd.Text.Split('/');
                string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");

                if ((ViewState["currency_id"]) != null)
                { currencyid = Convert.ToInt16(ViewState["currency_id"]); }

                string strCreatedBy = string.Empty;
                if (!string.IsNullOrEmpty(Session["username"].ToString()))
                { strCreatedBy = Session["username"].ToString(); }
                else { strCreatedBy = ""; }

                ServiceUrl = "CRM/Postcurrencysetupdetails";
                var crm = new crmEntity()
                {
                    currency_id = currencyid,
                    currency_type_id = Convert.ToInt32(ddlCurrency.SelectedValue.Trim()),
                    start_dt = Convert.ToDateTime(dtStartDate),
                    end_dt = Convert.ToDateTime(dtEndDate),
                    Point = Convert.ToDecimal(txtConvert.Text),
                    Amount = Convert.ToDecimal(txtAmount.Text),
                    minimum_point = Convert.ToInt32(Txtmin.Text),
                    maximum_point = Convert.ToInt32(Txtmax.Text),
                    created_by = strCreatedBy,
                    email_id = Convert.ToString(Session["EmailId"].ToString().Trim())
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    string strMsg = getBetween(getResponse, "[\"", "\"]");
                    message.InnerText = strMsg;
                    if (strMsg == "inserted successfully" || strMsg == "updated succesfully")
                    {
                        message.Style.Add("color", "green");
                        txtAmount.Text = "";
                        txtConvert.Text = "";
                        TxtEnd.Text = "";
                        Txtmax.Text = "";
                        TxtStart.Text = "";
                        Txtmin.Text = "";
                        TxtStart.Enabled = true;
                        ddlCurrency.SelectedIndex = 0;
                        ViewState["currency_id"] = null;
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Show", "hidepopup();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessCurrencyMsg();", true);                      
                        BindCurrencyListing(string.Empty);
                    }
                    else
                    {
                        message.Style.Add("color", "red");
                    }
                    //BindCurrencyListing(string.Empty);
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

        protected void lvCurrency_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvCurrency.DataKeys[commentItem.DisplayIndex][0].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        BindCurrencyListing(contentID);
                        ViewState["currency_id"] = contentID;
                        message.InnerText = string.Empty;
                    }
                }
            }
        }

        protected void lvCurrency_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCurrency.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindCurrencyListing(string.Empty);
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            ddlCurrency.SelectedIndex = 0;
            txtAmount.Text = "";
            txtConvert.Text = "";
            TxtEnd.Text = "";
            Txtmax.Text = "";
            TxtStart.Text = "";
            Txtmin.Text = "";
            TxtStart.Enabled = true;
            message.InnerText = "";
            ViewState["currency_id"] = null;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Pop", "popupcurrencyshow();", true);
        }

        protected void lvCurrency_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvCurrency.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvCurrency.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvCurrency.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvCurrency.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindCurrencyListing("");
        }
    }
}