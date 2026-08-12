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
    public partial class frmMyBigrcard : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty,
        StrUsageBaseURL = ConfigurationManager.AppSettings["UsageBaseURL"].ToString();//,StrReloadBaseURL = ConfigurationManager.AppSettings["ReloadBaseURL"].ToString();
        string card_no = string.Empty, url = string.Empty;
        static int sl_id, hasToken;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {

                if (Session["Username"] != null)
                {
                    BindCardRegistrationListing();
                    BindCommunity();
                    GetTokenValue();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                TabName.Value = Request.Form[TabName.UniqueID];
            }
        }

        #region Register BigR Card
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //Check For Membership No Validation.
            ServiceUrl = "CRM/CheckMembershipBigrCardNo";
            var checkMemberInfo = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                card_no = txtCardNo.Text.Trim(),
                promocode_name = txtPromocodeName.Text.Trim()
            };
            HttpResponseMessage response1 = client.PostAsJsonAsync(ServiceUrl, checkMemberInfo).Result;
            if (response1.IsSuccessStatusCode)
            {
                var info = response1.Content.ReadAsStringAsync().Result;
                var dtinfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(info);

                if (dtinfo.Rows.Count > 0)
                {
                    if (dtinfo.Rows[0]["rfid_avino"].ToString().Trim() != string.Empty)
                    {
                        ServiceUrl = "CRM/RegisterBigrCard";
                        if (rbtnPaymentMethod.SelectedValue == "T")
                        {
                            if (hasToken != 1)
                            {
                                lblMsg.Text = "Setup the Token before registered the card as Debit/Credit Card";
                                lblMsg.Visible = true;
                                lblMsg.ForeColor = System.Drawing.Color.Red;
                                txtCardNo.Text = string.Empty;
                                rbtnPaymentMethod.SelectedValue = "W";
                                return;
                            }
                        }

                        var crm = new crmEntity()
                        {
                            user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                            card_no = txtCardNo.Text.Trim(),
                            payment_type = rbtnPaymentMethod.SelectedValue.ToString().Trim(),
                            created_by = Session["User_FirstName"].ToString().Trim(),
                            active_status = 1,
                            promocode_name = txtPromocodeName.Text.Trim()
                        };

                        HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (response.IsSuccessStatusCode)
                        {
                            var UserInfo = response.Content.ReadAsStringAsync().Result;
                            var dtUserInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserInfo);
                            if (dtUserInfo.Rows.Count > 0)
                            {
                                if (dtUserInfo.Rows[0]["pmessage"].ToString().Trim() == "exists" || dtUserInfo.Rows[0]["pmessage"].ToString().Trim() == "not Found")
                                {
                                    lblMsg.Text = "Card cannot be register due to issue either card has been registered or card no was invalid or invalid promo code. Please try again, if same thing happen please contact our administrator by send feedback or call us at +603 2081 2688";
                                    lblMsg.Visible = true;
                                    lblMsg.ForeColor = System.Drawing.Color.Red;
                                    txtCardNo.Text = string.Empty;
                                    txtPromocodeName.Text = string.Empty;
                                    rbtnPaymentMethod.SelectedValue = "W";
                                }
                                //if (dtUserInfo.Rows[0]["pmessage"].ToString().Trim() == "not Found")
                                //{
                                //    lblMsg.Text = "Invalid Card";
                                //    lblMsg.Visible = true;
                                //    lblMsg.ForeColor = System.Drawing.Color.Red;
                                //    txtCardNo.Text = string.Empty;
                                //    rbtnPaymentMethod.SelectedValue = "M";
                                //}
                                else if (dtUserInfo.Rows[0]["pmessage"].ToString().Trim() == "new")
                                {
                                    lblMsg.Text = "Saved Successfully";
                                    lblMsg.Visible = true;
                                    lblMsg.ForeColor = System.Drawing.Color.Green;
                                    txtCardNo.Text = string.Empty;
                                    txtPromocodeName.Text = string.Empty;
                                    rbtnPaymentMethod.SelectedValue = "W";
                                }
                            }
                            else
                            {
                                lblMsg.Text = "Unable to Save";
                                lblMsg.Visible = true;
                            }
                            BindCardRegistrationListing();
                        }
                    }
                    else
                    {
                        //lblMsg.Text = "Invalid Membership No";
                        lblMsg.Text = "Card cannot be register due to issue either card has been registered or card no was invalid or invalid promo code. Please try again, if same thing happen please contact our administrator by send feedback or call us at +603 2081 2688";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        lblMsg.Visible = true;
                    }
                }
                else
                {
                    //lblMsg.Text = "Invalid Membership No";
                    lblMsg.Text = "Card cannot be register due to issue either card has been registered or card no was invalid or invalid promo code. Please try again, if same thing happen please contact our administrator by send feedback or call us at +603 2081 2688";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Visible = true;
                }
            }
        }

        public void BindCardRegistrationListing()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "crm/GetCardRegistrationList";
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvPreRegistrationList.DataSource = dtChargeType;
                    lvPreRegistrationList.DataBind();
                }
                else
                {
                    lvPreRegistrationList.DataSource = dtChargeType;
                    lvPreRegistrationList.DataBind();
                }
            }
        }
        #endregion

        protected void GetTokenValue()
        {
            ServiceUrl = "CRM/GetTokenDetailsByUserId";
            crmEntity crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    hasToken = 1;
                }
                else
                {
                    hasToken = 0;
                }
            }
        }

        #region BigR Card History
        #region Usage
        protected void BindBigUsage()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "Payment/GetUsageHistory";
            if (!string.IsNullOrEmpty(txtSearchHistory.Text))
            { strSendVal = txtSearchHistory.Text; }
            crmEntity crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                community_id = Convert.ToInt32(ddlCommunity.SelectedValue),
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    lsvUsage.DataSource = dtCommunity;
                    lsvUsage.DataBind();
                }
                else
                {
                    lsvUsage.DataSource = dtCommunity;
                    lsvUsage.DataBind();
                }
            }
        }
        protected void lsvUsage_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lsvUsage.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindBigUsage();
        }
        #endregion
        #region Reload
        protected void BindBigReload()
        {
            string strSendVal = string.Empty;
            ServiceUrl = "Payment/GetReloadHistory";
            //if (!string.IsNullOrEmpty(txtSearch.Text))
            //{ strSendVal = txtSearch.Text; }

            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim()),
                community_id = Convert.ToInt32(ddlCommunity.SelectedValue),
                search_param = strSendVal
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeAmt = response.Content.ReadAsStringAsync().Result;
                var dtChargeAmt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeAmt);
                if (dtChargeAmt.Rows.Count > 0)
                {
                    lsvReload.DataSource = dtChargeAmt;
                    lsvReload.DataBind();
                }
                else
                {
                    lsvReload.DataSource = dtChargeAmt;
                    lsvReload.DataBind();
                }
            }
            else
            {
                //message.InnerText = response.ReasonPhrase.ToString();
                //message.Style.Add("color", "Red");
            }
        }
        protected void lsvReload_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lsvReload.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindBigReload();
        }
        #endregion
        #endregion

        protected void BindCommunity()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/BindCommunityList";

            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    ddlCommunity.DataSource = dtCommunity;
                    ddlCommunity.DataBind();
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
                else
                {
                    ddlCommunity.Items.Insert(0, new ListItem("-Select-", "NA"));
                }
            }
        }

        protected void txtSearchHistory_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnHistory_Click(object sender, EventArgs e)
        {
            BindBigUsage();
            BindBigReload();
        }

        protected void lsvReload_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            DataTable dtReload = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lsvReload.FindControl("totalrecord");
                if (ViewState["VSPromotionVoucherList"] != null)
                {
                    dtReload = (DataTable)ViewState["VSPromotionVoucherList"];
                    totalrecord.InnerText = dtReload.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lsvReload.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dtReload.Rows.Count.ToString()))
            {
                (lsvReload.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lsvReload.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lsvUsage_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            DataTable dtUsage = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lsvUsage.FindControl("totalrecord");
                if (ViewState["VSPromotionVoucherList"] != null)
                {
                    dtUsage = (DataTable)ViewState["VSPromotionVoucherList"];
                    totalrecord.InnerText = dtUsage.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lsvUsage.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dtUsage.Rows.Count.ToString()))
            {
                (lsvUsage.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lsvUsage.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void rbtnPaymentType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Update the Payment Type

        }

        protected void lvPreRegistrationList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                Label lblVal = (Label)e.Item.FindControl("lblPayValue");
                Label lblBal = (Label)e.Item.FindControl("lblbalance");
                //Label lblId = (Label)e.Item.FindControl("lblId");
                //sl_id = int.Parse(lblId.Text.Trim());
                Button btnReload = (Button)e.Item.FindControl("btnReloadCard");
                RadioButtonList rbtnPay = (RadioButtonList)e.Item.FindControl("rbtnPaymentType");
                // not sure how to do this from here on. 
                if (lblVal.Text == "W")
                {
                    rbtnPay.SelectedValue = "W";
                    btnReload.Enabled = true;
                    lblVal.Enabled = true;
                }
                if (lblVal.Text == "T")
                {
                    rbtnPay.SelectedValue = "T";
                    btnReload.Enabled = false;
                    lblBal.Enabled = false;
                }
            }
        }

        protected void btnReloadCard_ServerClick(object sender, EventArgs e)
        {
            //Response
        }

        protected void lvPreRegistrationList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem lstReload = (ListViewDataItem)e.Item;
            if (String.Equals(e.CommandName, "reload"))
            {
                if (lstReload != null)
                {
                    //string Voucher_Id = (string)lstReload.DataKeys[lstReload.DisplayIndex][0].ToString().Trim();
                    //Response.Redirect("frmvoucherdetails.aspx?voucher_id=" + Voucher_Id);
                    //return;
                    Label card_no = (Label)e.Item.FindControl("lblcardNo");
                    //Label card_no = (Label)e.Item.FindControl("membership_cardno");
                    Response.Redirect("frmReloadCard.aspx?Membership_no=" + card_no.Text.Trim());
                }
            }
        }

        protected void hasTokenValue()
        {

        }

        protected void ddlCommunity_SelectedIndexChanged(object sender, EventArgs e)
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetCardNoByCommunity";
            crmEntity crm = new crmEntity()
            {
                community_id = Convert.ToInt32(ddlCommunity.SelectedValue),
                user_id = Convert.ToInt32(Session["user_id"].ToString().Trim())
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var Community = response.Content.ReadAsStringAsync().Result;
                var dtCommunity = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Community);

                if (dtCommunity.Rows.Count > 0)
                {
                    Session["card_no"] = dtCommunity.Rows[0]["card_no"].ToString().Trim();
                    Session["url"] = dtCommunity.Rows[0]["community_api_url"].ToString().Trim();
                }
                else
                {
                    Session["card_no"] = null;
                }
            }
        }

        protected void lvBigrCardList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvBigrCardList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

        }

        protected void lvBigrCardList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

        }
    }
}