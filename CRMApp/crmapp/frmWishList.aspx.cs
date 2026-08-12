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
    public partial class frmWishList : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["userid"] != null)
                {
                    BindWishList();
                    BindAddToWishlistInfo();
                    //BindAddToCartInfo(); 
                }
            }
        }

        public void BindAddToWishlistInfo()
        {
            #region cart information
            //====================== count cart items=============
            Label lblWishCount = (Label)this.Master.FindControl("lblWishCount");
            try
            {
                if (Session["userid"] != null)
                {
                    ServiceUrl = "CRM/GetCountAddToWishlistByUser";
                    var cartValue = new crmEntity()
                    {
                        user_id = Convert.ToInt16(Session["user_id"].ToString())
                    };

                    HttpResponseMessage responsecart = client.PostAsJsonAsync(ServiceUrl, cartValue).Result;
                    if (responsecart.IsSuccessStatusCode)
                    {
                        var CartDetails = responsecart.Content.ReadAsStringAsync().Result;
                        var dtCart = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CartDetails);
                        if (dtCart.Rows.Count > 0)
                        {
                            lblWishCount.Text = dtCart.Rows.Count.ToString();
                        }
                        else
                        { lblWishCount.Text = ""; }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return;
            }
            #endregion
        }

        protected void BindWishList()
        {
            try
            {
                ServiceUrl = "CRM/GetWishListDetails";
                var wish = new crmEntity()
                {
                    userlogin_id = Convert.ToInt32(Session["userid"].ToString().Trim())
                };

                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, wish).Result;
                if (response.IsSuccessStatusCode)
                {
                    var getResponse = response.Content.ReadAsStringAsync().Result;
                    var UserLists = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(getResponse);
                    ViewState["dtcont"] = UserLists;
                    if (UserLists.Rows.Count > 0)
                    {
                        lvWishList.DataSource = UserLists;
                        lvWishList.DataBind();
                    }
                    else
                    {
                        lvWishList.DataSource = UserLists;
                        lvWishList.DataBind();
                    }
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

        protected void lvWishList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Delete")
            {
                if (commentItem != null)
                {
                    string voucher_id = (string)lvWishList.DataKeys[commentItem.DisplayIndex][0].ToString().Trim();
                    string wl_id = (string)lvWishList.DataKeys[commentItem.DisplayIndex][1].ToString().Trim();
                    if (!string.IsNullOrEmpty(wl_id))
                    {
                        try
                        {
                            ServiceUrl = "CRM/DeleteWishListDetails";
                            var crm = new crmEntity()
                            {
                                content_id = Convert.ToInt16(wl_id.Trim())
                            };
                            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                BindWishList();
                                BindAddToWishlistInfo();
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
                }
            }
            else if (e.CommandName == "View")
            {
                if (commentItem != null)
                {
                    string voucher_id = (string)lvWishList.DataKeys[commentItem.DisplayIndex][0].ToString().Trim();
                    Response.Redirect("../frmVoucherDetails.aspx?voucher_id=" + voucher_id);
                }
            }
        }

        protected void lvWishList_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        protected void lvWishList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvWishList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvWishList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvWishList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvWishList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvWishList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvWishList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindWishList();
        }
    }
}