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
    public partial class frmOutletRedeemVoucher : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindMerchantList();
            }
        }

        protected void BindMerchantList()
        {
            lblMessage.Text = "";
            string strSendVal = string.Empty;
            ServiceUrl = "CRM/ListOfOutletRedeemVouchers";
            if (!string.IsNullOrEmpty(txtSearch.Text))
            { strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim()),
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
                    Lv_RedeemVoucher.DataSource = dtChargeType;
                    Lv_RedeemVoucher.DataBind();
                }
                else
                {
                    Lv_RedeemVoucher.DataSource = dtChargeType;
                    Lv_RedeemVoucher.DataBind();
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindMerchantList();
        }

        protected void Lv_RedeemVoucher_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl colorstatus = (HtmlGenericControl)e.Item.FindControl("colorstatus");
                LinkButton lnkEdit = (LinkButton)e.Item.FindControl("lnkEdit");
                if (colorstatus.InnerText == "Already Redeemed")
                {
                    colorstatus.Style.Add("color", "green");
                    lnkEdit.Enabled = false;
                    lnkEdit.Style.Add("background", "red");
                }
                else
                {
                    //colorstatus.Style.Add("color", "red");
                }

                HtmlGenericControl totalrecord = (HtmlGenericControl)Lv_RedeemVoucher.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((Lv_RedeemVoucher.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (Lv_RedeemVoucher.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (Lv_RedeemVoucher.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lnkPopup_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            ListViewItem clickedRow = ((LinkButton)sender).NamingContainer as ListViewItem;
            //Memberid,merchantid,id,memberName,voucherCode,voucher_id,
            //id=order_id ==== merchant_id,voucherCode,Memberid,id
            string vouchercode = (string)Lv_RedeemVoucher.DataKeys[clickedRow.DisplayIndex][1].ToString().Trim();
            string merchantid = (string)Lv_RedeemVoucher.DataKeys[clickedRow.DisplayIndex][0].ToString().Trim();
            string userid = (string)Lv_RedeemVoucher.DataKeys[clickedRow.DisplayIndex][2].ToString().Trim();
            string orderid = (string)Lv_RedeemVoucher.DataKeys[clickedRow.DisplayIndex][3].ToString().Trim();
            HdnTxtvouchercode.Value = vouchercode;
            HdnMerchantid.Value = merchantid;
            Hdnuserid.Value = userid;
            Hdnorderid.Value = orderid;

            //ServiceUrl = "CRM/getbranchdetailbymerchantid";
            //var crm = new crmEntity()
            //{
            //    merchant_id = Convert.ToInt32(merchantid)/* Convert.ToInt32(Session["userid"].ToString().Trim()),*/

            //};
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            //ddlbranchName.Items.Clear();
            //ListItem item = new ListItem("-Select-", "0");
            //ddlbranchName.Items.Insert(0, item);
            //if (response.IsSuccessStatusCode)
            //{
            //    var State = response.Content.ReadAsStringAsync().Result;
            //    var dtState = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(State);
            //    if (dtState.Rows.Count > 0)
            //    {
            //        foreach (DataRow dtRow in dtState.Rows)
            //        {
            //            if (!string.IsNullOrEmpty((dtRow["branch_name"].ToString())))
            //            {
            //                ddlbranchName.Items.Add(new ListItem(dtRow["branch_name"].ToString(), dtRow["branch_id"].ToString()));
            //            }
            //        }
            //    }
            //}


            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Popup", "showpopupmsg();", true);

        }

        protected void Lv_RedeemVoucher_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (Lv_RedeemVoucher.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindMerchantList();
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            ServiceUrl = "CRM/insertVoucherwithvalidation";
            var crm = new crmEntity()
            {
                order_id = Convert.ToInt32(Hdnorderid.Value),
                user_id = Convert.ToInt32(Hdnuserid.Value),
                voucher_code = Txtvouchercode.Text,
                merchant_id = Convert.ToInt32(HdnMerchantid.Value),
                branch_id = Convert.ToInt32(Session["branchID"].ToString().Trim())//ddlbranchName.SelectedValue.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var getResponse = response.Content.ReadAsStringAsync().Result;
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Popup", "hidepopupmsg();", true);
                string strtest = getBetween(getResponse, "[\"", "\"]");
                //lblMessage.Text = getBetween(getResponse, "[\"", "\"]");                           
                lblMessage.Text = strtest;
                lblMessage.Style.Add("color", "red");
                Txtvouchercode.Text = "";
                if (lblMessage.Text == "Successfully Inserted")
                {
                    lblMessage.Style.Add("color", "green");
                    Response.Redirect("~/crmapp/frmRedeemVoucher.aspx");
                }
            }
            else
            {
                lblMessage.Text = " Invalid Voucher code";
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
    }
}