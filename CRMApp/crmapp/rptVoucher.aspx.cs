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
    public partial class rptVoucher : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        string dtStartDate = "", dtEndDate = "",startdate="", enddate="";
        static DataTable FetchData = new DataTable();
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindPurchaseVoucherData();
            }
            if (Session["userid"] != null)
            { /*BindAddToWishlistInfo(); BindAddToCartInfo();*/ }
        }

        protected void LstVoucherTransaction_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (LstVoucherTransaction.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindPurchaseVoucherData();
        }

        //protected void btnExcel_ServerClick(object sender, EventArgs e)
        //{
        //    HttpContext.Current.Response.Clear();
        //    HttpContext.Current.Response.ClearContent();
        //    HttpContext.Current.Response.ClearHeaders();
        //    HttpContext.Current.Response.Buffer = true;
        //    HttpContext.Current.Response.ContentType = "application/ms-excel";
        //    HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
        //    HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=Reports.xls");

        //    HttpContext.Current.Response.Charset = "utf-8";
        //    HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
        //    //sets font
        //    HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Calibri;'>");
        //    HttpContext.Current.Response.Write("<BR><BR><BR>");
        //    //sets the table border, cell spacing, border color, font of the text, background, foreground, font height
        //    HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' " +
        //      "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
        //      "style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");
        //    //am getting my grid's column headers
        //    int columnscount = gvVoucherList.Columns.Count;
            
        //    for (int j = 0; j < columnscount; j++)
        //    {      //write in new column
        //        HttpContext.Current.Response.Write("<Td>");
        //        //Get column headers  and make it as bold in excel columns
        //        HttpContext.Current.Response.Write("<B>");
        //        HttpContext.Current.Response.Write(gvVoucherList.Columns[j].HeaderText.ToString());
        //        HttpContext.Current.Response.Write("</B>");
        //        HttpContext.Current.Response.Write("</Td>");
        //    }
        //    HttpContext.Current.Response.Write("</TR>");
        //    foreach (DataRow row in FetchData.Rows)
        //    {//write in new row
        //        HttpContext.Current.Response.Write("<TR>");
        //        for (int i = 0; i < FetchData.Columns.Count; i++)
        //        {
        //            HttpContext.Current.Response.Write("<Td>");
        //            HttpContext.Current.Response.Write(row[i].ToString());
        //            HttpContext.Current.Response.Write("</Td>");
        //        }

        //        HttpContext.Current.Response.Write("</TR>");
        //    }
        //    HttpContext.Current.Response.Write("</Table>");
        //    HttpContext.Current.Response.Write("</font>");
        //    HttpContext.Current.Response.Flush();
        //    HttpContext.Current.Response.End();
        //}

        protected void btnPdf_ServerClick(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindPurchaseVoucherData();
        }

        protected void BindPurchaseVoucherData()
        {
            string total = string.Empty,searchval=string.Empty;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                searchval = txtSearch.Text.Trim();
            }
            ServiceUrl = "CRM/GetMerchantVoucherPurchased";
            //Split the Date Range
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

            var crm = new crmEntity()
            {
                search_param = searchval,
                start_date = dtStartDate,
                end_date = dtEndDate,
                merchant_id = Convert.ToInt32(Session["merchant_id"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtscount"] = dtChargeType;
                FetchData = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    LstVoucherTransaction.DataSource = dtChargeType;
                    LstVoucherTransaction.DataBind();
                    gvVoucherList.DataSource = dtChargeType;
                    gvVoucherList.DataBind();
                    for (int i = 0; i < dtChargeType.Rows.Count; i++)
                    {
                        total = dtChargeType.Rows[i]["total_transaction"].ToString();
                    }
                    //// decimal tax = Convert.ToDecimal(OrderLists.Rows[0]["total_tax_amount"].ToString());
                    lblSubTotal.Text = total.ToString().Trim();

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
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindPurchaseVoucherData();
        }

    }
}