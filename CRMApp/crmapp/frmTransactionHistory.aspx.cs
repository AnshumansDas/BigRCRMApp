using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmTransactionHistory : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        string dtStartDate = "", dtEndDate = "", startdate = "", enddate = "";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindRedeemPointDetails();               
                BindRetailTransaction();
                //BindRewardPointDetails();
                //BindTollPrepaid();
                //BindPrepaidTopup();
                //BindSeasonTopup();
            }
        }
        public void BindSeasonTopup()
        {
            try
            {
                ServiceUrl = "InfoApi/GetUserTopupTransactionByUser";
                //Param1 = "?site_id=" + siteID;
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var searchValue = new crmEntity()
                {
                    search_value = string.Empty,
                    frdt = string.Empty,
                    todt = string.Empty,
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim())
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, searchValue).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    lvSeason.DataSource = UserLists;
                    lvSeason.DataBind();
                    //totalrecord.InnerText = UserLists.Rows.Count.ToString().Trim();
                    double st = 0.00;
                    double gst = 0.00;
                    double tt = 0.00;
                }
                else
                {
                    //message.InnerText = response.ReasonPhrase.ToString();
                    //message.Style.Add("color", "Red");
                }
            }
            catch (Exception ex)
            {
                //lblMsg.Text = ex.Message.ToString();
                return;
            }
        }

        public void BindRedeemPointDetails()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetRedeemPointDetails";
            var LCValue = new crmEntity();
            #region anshu code
            //if (txtRedeemFrDate.Text.Trim() != "")
            //{
            //    string[] starttokens = txtFromDate.Text.Split('/');//txtdate.Text.Split('/');
            //    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
            //    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            //}
            ////string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            //if (txtRedeemToDate.Text.Trim() != "")
            //{
            //    string[] endtokens = txtToDate.Text.Split('/');//txtdate.Text.Split('/');
            //    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
            //    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            //}
            //if (txtRedeemFrDate.Text.Trim() == string.Empty && txtRedeemToDate.Text.Trim() == string.Empty)
            //{
            //    LCValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRedeemSearch.Text.Trim(),
            //        start_date = "1900-01-01",
            //        end_date = "1900-01-01"
            //    };
            //}
            //if (txtRedeemFrDate.Text.Trim() != string.Empty && txtRedeemToDate.Text.Trim() == string.Empty)
            //{
            //    LCValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRedeemSearch.Text.Trim(),
            //        start_date = dtStartDate,
            //        end_date = "1900-01-01"
            //    };
            //}
            //if (txtRedeemFrDate.Text.Trim() == string.Empty && txtRedeemToDate.Text.Trim() != string.Empty)
            //{
            //    LCValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRedeemSearch.Text.Trim(),
            //        start_date = "1900-01-01",
            //        end_date = dtEndDate
            //    };
            //}
            //if (txtRedeemFrDate.Text.Trim() != string.Empty && txtRedeemToDate.Text.Trim() != string.Empty)
            //{
            //    LCValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRedeemSearch.Text.Trim(),
            //        start_date = dtStartDate,
            //        end_date = dtEndDate
            //    };
            //}
            #endregion
            #region update code
            if (!string.IsNullOrEmpty(txtRedeemFrDate.Text.Trim()))
            {
                string data = txtRedeemFrDate.Text.Trim();
                string[] dates = data.Split('-');
                if (!string.IsNullOrEmpty(dates[0].ToString().Trim()))
                {
                    startdate = dates[0].ToString().Trim();
                    string[] starttokens = startdate.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                else { dtStartDate = "1900-01-01"; }

                if (!string.IsNullOrEmpty(dates[1].ToString().Trim()))
                {
                    enddate = dates[1].ToString().Trim();
                    string[] endtokens = enddate.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                else { dtEndDate = "1900-01-01"; }
            }
            else
            { dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01"; }

            LCValue = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                search_param = txtRetailSearch.Text.Trim(),
                start_date = dtStartDate,
                end_date = dtEndDate
            };
            
            #endregion

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, LCValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RdmPtDetails = response.Content.ReadAsStringAsync().Result;
                var dtRdmPtDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RdmPtDetails);
                if (dtRdmPtDetails.Rows.Count > 0)
                {
                    Lv_MyRedeemPoints.DataSource = dtRdmPtDetails;
                    Lv_MyRedeemPoints.DataBind();
                }
                else
                {
                    Lv_MyRedeemPoints.DataSource = dtRdmPtDetails;
                    Lv_MyRedeemPoints.DataBind();
                }
            }
        }

        public void BindRewardPointDetails()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "InfoApi/GetRewardPointDetails";
            var RwdValue = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RwdPtDetails = response.Content.ReadAsStringAsync().Result;
                var dtRwdPtDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RwdPtDetails);
                if (dtRwdPtDetails.Rows.Count > 0)
                {
                    LvRewardPointDetails.DataSource = dtRwdPtDetails;
                    LvRewardPointDetails.DataBind();
                }
                else
                {
                    LvRewardPointDetails.DataSource = dtRwdPtDetails;
                    LvRewardPointDetails.DataBind();
                }
            }
        }

        public void BindRetailTransaction()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetOrderListRetailDetails";
            var RwdValue = new crmEntity();
            #region anshu code
            //if (txtFromDate.Text.Trim() != "")
            //{
            //    string[] starttokens = txtFromDate.Text.Split('/');//txtdate.Text.Split('/');
            //    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
            //    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
            //}
            ////string strFrmDate = dtFromDate.ToString("dd/MM/yyyy");
            //if (txtToDate.Text.Trim() != "")
            //{
            //    string[] endtokens = txtToDate.Text.Split('/');//txtdate.Text.Split('/');
            //    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
            //    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
            //}

            //if (txtFromDate.Text.Trim() == string.Empty && txtToDate.Text.Trim() == string.Empty)
            //{
            //    RwdValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRetailSearch.Text.Trim(),
            //        start_date = "1900-01-01",
            //        end_date = "1900-01-01"
            //    };
            //}
            //else if (txtFromDate.Text.Trim() != string.Empty && txtToDate.Text.Trim() == string.Empty)
            //{
            //    RwdValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRetailSearch.Text.Trim(),
            //        start_date = dtStartDate,
            //        end_date = "1900-01-01"
            //    };
            //}
            //else if (txtFromDate.Text.Trim() == string.Empty && txtToDate.Text.Trim() != string.Empty)
            //{
            //    RwdValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRetailSearch.Text.Trim(),
            //        start_date = "1900-01-01",
            //        end_date = dtEndDate
            //    };
            //}

            //else if (txtFromDate.Text.Trim() != string.Empty && txtToDate.Text.Trim() != string.Empty)
            //{
            //    RwdValue = new crmEntity()
            //    {
            //        userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
            //        search_param = txtRetailSearch.Text.Trim(),
            //        start_date = dtStartDate,
            //        end_date = dtEndDate
            //    };
            //}
            #endregion

            #region update code
            if (!string.IsNullOrEmpty(txtVoucherDateRange.Text.Trim()))
            {
                string data = txtVoucherDateRange.Text.Trim();
                string[] dates = data.Split('-');
                if (!string.IsNullOrEmpty(dates[0].ToString().Trim()))
                {
                    startdate = dates[0].ToString().Trim();
                    string[] starttokens = startdate.Split('/');
                    string strStartDate = starttokens[2] + "-" + starttokens[1] + "-" + starttokens[0];
                    dtStartDate = Convert.ToDateTime(strStartDate).ToString("yyyy-MM-dd");
                }
                else { dtStartDate = "1900-01-01"; }

                if (!string.IsNullOrEmpty(dates[1].ToString().Trim()))
                {
                    enddate = dates[1].ToString().Trim();
                    string[] endtokens = enddate.Split('/');
                    string strEndDate = endtokens[2] + "-" + endtokens[1] + "-" + endtokens[0];
                    dtEndDate = Convert.ToDateTime(strEndDate).ToString("yyyy-MM-dd");
                }
                else { dtEndDate = "1900-01-01"; }
            }
            else
            { dtStartDate = "1900-01-01"; dtEndDate = "1900-01-01"; }

            RwdValue = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString()),
                search_param = txtRetailSearch.Text.Trim(),
                start_date = dtStartDate,
                end_date = dtEndDate
            };
            #endregion
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RetailDetails = response.Content.ReadAsStringAsync().Result;
                var dtRetailDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RetailDetails);
                if (dtRetailDetails.Rows.Count > 0)
                {
                    lsvRetail.DataSource = dtRetailDetails;
                    lsvRetail.DataBind();
                }
                else
                {
                    lsvRetail.DataSource = dtRetailDetails;
                    lsvRetail.DataBind();
                }
            }
        }

        public void BindTollPrepaid()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "InfoApi/GetTollPrepaidDetails";
            var RwdValue = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var RetailDetails = response.Content.ReadAsStringAsync().Result;
                var dtRetailDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RetailDetails);
                if (dtRetailDetails.Rows.Count > 0)
                {
                    lsvTollPrepaid.DataSource = dtRetailDetails;
                    lsvTollPrepaid.DataBind();
                }
                else
                {
                    lsvTollPrepaid.DataSource = dtRetailDetails;
                    lsvTollPrepaid.DataBind();
                }
            }
        }

        public void BindPrepaidTopup()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "InfoApi/GetTopupDetails";
            var RwdValue = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, RwdValue).Result;
            if (response.IsSuccessStatusCode)
            {
                var TopupDetails = response.Content.ReadAsStringAsync().Result;
                var dtTopupDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(TopupDetails);
                if (dtTopupDetails.Rows.Count > 0)
                {
                    lsvTopup.DataSource = dtTopupDetails;
                    lsvTopup.DataBind();
                }
                else
                {
                    lsvTopup.DataSource = dtTopupDetails;
                    lsvTopup.DataBind();
                }
            }
        }

        protected void txtRetailSearch_TextChanged(object sender, EventArgs e)
        {
            BindRetailTransaction();
        }

        protected void txtRedeemSearch_TextChanged(object sender, EventArgs e)
        {
            BindRedeemPointDetails();
        }

        protected void btnRedeemSearch_Click(object sender, EventArgs e)
        {
            BindRedeemPointDetails();
        }

        protected void lsvRetail_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem voucherItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "View")
            {
                if (voucherItems != null)
                {
                    string order_no = lsvRetail.DataKeys[voucherItems.DisplayIndex][0].ToString();
                    Response.Redirect("frmPurchaseTransactionReciepts.aspx?order_no=" + order_no);
                }
            }
        }

        protected void lsvRetail_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lsvRetail.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindRetailTransaction();
        }

        protected void btnRetailSearch_Click(object sender, EventArgs e)
        {
            BindRetailTransaction();
        }

        protected void lbtnview_Click(object sender, EventArgs e)
        {

        }
    }
}