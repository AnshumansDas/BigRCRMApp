using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmCartDetails : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty;
        static string totalAmount = string.Empty;
        double subtotal = 0.00;
        static string randomnumber;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindState();
                BindCartDetails();
                LoadProfileDetails();
            }
        }
        protected void BindCartDetails()
        {
            ServiceUrl = "CRM/GetOrderListCheckoutItems";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var cartData = new crmEntity()
            {
                user_id = Convert.ToInt16(Session["userid"].ToString())
            };
            HttpResponseMessage responsecart = client.PostAsJsonAsync(ServiceUrl, cartData).Result;
            if (responsecart.IsSuccessStatusCode)
            {
                var RdmPtDetails = responsecart.Content.ReadAsStringAsync().Result;
                var pDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(RdmPtDetails);
                if (pDataTable.Rows.Count > 0)
                {
                    Session["cartData"] = pDataTable;
                    lvCartList.DataSource = pDataTable;
                    lvCartList.DataBind();
                    lblTotalCartAmt.Text = string.Format("{0:N2}", Convert.ToDecimal(pDataTable.Rows[0]["TotalAmount"].ToString().Trim()));
                    lblTotaSSTAmt.Text = string.Format("{0:N2}", Convert.ToDecimal(pDataTable.Rows[0]["TotalSST_Amount"].ToString().Trim()));
                    lblsumAmout2.Text = string.Format("{0:N2}", Convert.ToDecimal(pDataTable.Rows[0]["TotalAmount"].ToString().Trim()));
                    totalAmount = string.Format("{0:N2}", Convert.ToDecimal(pDataTable.Rows[0]["TotalAmount"].ToString().Trim()));

                    //lblTotalCartAmount.Text = ViewState["totalamount"].ToString().Trim();
                    //lblsumAmout2.Text = ViewState["totalamount"].ToString().Trim();
                    //lblsumAmout3.Text = ViewState["totalamount"].ToString().Trim();
                    //totalAmount = ViewState["totalamount"].ToString().Trim();

                    //lsvSummary.DataSource = pDataTable;
                    //lsvSummary.DataBind();
                    //lsvSummary2.DataSource = pDataTable;
                    //lsvSummary2.DataBind();
                    //lsvSummary3.DataSource = pDataTable;
                    //lsvSummary3.DataBind();
                }
                else
                {
                    Session["cartData"] = null;
                    lvCartList.DataSource = pDataTable;
                    lvCartList.DataBind();
                    //lsvSummary.DataSource = pDataTable;
                    //lsvSummary.DataBind();
                }
            }
        }
        protected void btnNextPayment_ServerClick(object sender, EventArgs e)
        {
            spanShipAddress.InnerText = string.Empty;
            int countryid = 0, stateid = 0;
            string cityname = string.Empty, addr1 = string.Empty, addr2 = string.Empty, 
                postcode = string.Empty,email=string.Empty;
            if (ChkShippingAddress.Checked == true)
            {
                if (TxtFirstName.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "First Name can not be blank.";
                    TxtFirstName.Focus();
                    return;
                }
                if (TxtAddress1.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "Address 1 can not be blank.";
                    TxtAddress1.Focus();
                    return;
                }
                if (TxtAddress2.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "Address 2 can not be blank.";
                    TxtAddress2.Focus();
                    return;
                }
                if (ddlState.SelectedValue == "0")
                {
                    spanShipAddress.InnerText = "Select the state";
                    return;
                }
                if (TxtPostCode.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "Postcode can not be blank.";
                    TxtPostCode.Focus();
                    return;
                }
                if (TxtEmail.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "Email can not be blank.";
                    TxtEmail.Focus();
                    return;
                }
                bool retval = ValidateEmail();
                if (retval == false)
                {
                    spanShipAddress.InnerText = "Incorrect Email format.";
                    TxtEmail.Focus();
                    return;
                }
                if (TxtPhone.Text.Trim() == string.Empty)
                {
                    spanShipAddress.InnerText = "Mobile can not be blank.";
                    TxtPhone.Focus();
                    return;
                }
            }
            spanAgreement.InnerText = string.Empty;
            if (chkAgree.Checked == false)
            {
                spanAgreement.InnerText = "select the Payment type.";
                return;
            }
            if (RBCredit.Checked == false && RBFBX.Checked == false)
            {
                spanAgreement.InnerText = "select the Payment Mode.";
                return;
            }
            string orderNo = string.Empty, PaymentType = string.Empty;
            if (RBCredit.Checked == true)
            {
                PaymentType = "CC";
            }
            else if (RBFBX.Checked == true)
            {
                PaymentType = "FT";
            }
            //saveAddress();
            if (RBFBX.Checked)
            {
                addr1 = TxtAddress1.Text.Trim();
                addr2 = TxtAddress2.Text.Trim();
                stateid = Convert.ToInt16(ddlState.SelectedValue);
                cityname = ddlCity.SelectedItem.Text.ToString();
                countryid = Convert.ToInt16(ddlcountry.SelectedValue);
                postcode = TxtPostCode.Text.Trim();
                email = TxtEmail.Text.Trim();
            }
            else
            {
                addr1 = LblAddress1.Text.Trim() ;
                addr2 = LblAddress2.Text.Trim();
                stateid = Convert.ToInt16(LblStateId.Text.Trim());
                cityname = LblCity.Text.Trim();
                countryid = Convert.ToInt16(LblCountryId.Text.Trim());
                postcode = LblPostCode.Text.Trim();
                email = LblEmail.Text.Trim();
            }
            //return;
            #region Save to DB 
            GenerateRandomNumber();
            int UserId = Convert.ToInt16(Session["userid"].ToString());
            ServiceUrl = "CRM/AddOrderCheckOut";

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var cartOrderCheckoutData = new crmEntity
            {
                user_id = UserId,
                order_no = randomnumber,
                transaction_amount = totalAmount,
                country_id = countryid,
                state_id = stateid,
                city_name = cityname,
                address1 = addr1,
                address2 = addr2,
                postcode = postcode,
                orderDescription = "CART"
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, cartOrderCheckoutData).Result;
            if (response.IsSuccessStatusCode)
            {
                ServiceUrl = "CRM/GetOrderNoByUserloginId";
                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                var OrdernoEntity = new crmEntity()
                {
                    user_id = UserId
                };
                HttpResponseMessage responseOrderNo = client.PostAsJsonAsync(ServiceUrl, OrdernoEntity).Result;
                if (responseOrderNo.IsSuccessStatusCode)
                {
                    var OrderNoResult = responseOrderNo.Content.ReadAsStringAsync().Result;
                    var dtOrderNo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(OrderNoResult);
                    if (dtOrderNo.Rows.Count > 0)
                    {
                        orderNo = dtOrderNo.Rows[0]["order_no"].ToString();
                    }
                }
                #region AbseccPayment
                //web
                string checksum = Hash("a1ac0cc290f610d5" + "METROCRM01" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + PaymentType + "SALE" + "" + email);
                //MOBILE
                //string checksum = Hash("93704aec1d3846b7" + "METROCRM02" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + rbtnPaymentMode.SelectedValue + "SALE" + "" + txtEmail.Text.Trim());
                if (orderNo != string.Empty)
                {
                    #region Absec Payment Gateway
                    //Send Information in Hidden field to the Payment gateway            
                    Response.Clear();
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<html>");
                    sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
                    sb.AppendFormat("<form name='form' action='{0}' method='post'>", "https://apps.absecdev.xyz/payment/echeckout");
                    //WEB
                    sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", "METROCRM01");
                    // Mobile
                    //sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", "METROCRM02");
                    sb.AppendFormat("<input type='hidden' name='orderNo' value='{0}'>", cartOrderCheckoutData.order_no);
                    sb.AppendFormat("<input type='hidden' name='orderDescription' value='{0}'>", cartOrderCheckoutData.orderDescription);
                    sb.AppendFormat("<input type='hidden' name='currency' value='{0}'>", "MYR");
                    sb.AppendFormat("<input type='hidden' name='amount' value='{0}'>", totalAmount);
                    sb.AppendFormat("<input type='hidden' name='email' value='{0}'>", email);
                    sb.AppendFormat("<input type='hidden' name='method' value='{0}'>", PaymentType);
                    sb.AppendFormat("<input type='hidden' name='apiOperation' value='{0}'>", "SALE");
                    sb.AppendFormat("<input type='hidden' name='cardType' value='{0}'>", "");
                    sb.AppendFormat("<input type='hidden' name='checksum' value='{0}'>", checksum);
                    // Other params go here
                    sb.Append("</form>");
                    sb.Append("</body>");
                    sb.Append("</html>");
                    Response.Write(sb.ToString());
                    Response.End();
                    #endregion
                }
                #endregion
            }
            else
            {

            }
            #endregion
        }
        //protected void LbPaynow_Click(object sender, EventArgs e)
        //{
        //    spanShipAddress.InnerText = string.Empty;
        //    if (ChkShippingAddress.Checked == true)
        //    {
        //        if (TxtFirstName.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "First Name can not be blank.";
        //            TxtFirstName.Focus();
        //            return;
        //        }
        //        if (TxtAddress1.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "Address 1 can not be blank.";
        //            TxtAddress1.Focus();
        //            return;
        //        }
        //        if (TxtAddress2.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "Address 2 can not be blank.";
        //            TxtAddress2.Focus();
        //            return;
        //        }
        //        if (ddlState.SelectedValue == "0")
        //        {
        //            spanShipAddress.InnerText = "Select the state";
        //            return;
        //        }
        //        if (TxtPostCode.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "Postcode can not be blank.";
        //            TxtPostCode.Focus();
        //            return;
        //        }
        //        if (TxtEmail.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "Email can not be blank.";
        //            TxtEmail.Focus();
        //            return;
        //        }
        //        bool retval = ValidateEmail();
        //        if (retval == false)
        //        {
        //            spanShipAddress.InnerText = "Incorrect Email format.";
        //            TxtEmail.Focus();
        //            return;
        //        }
        //        if (TxtPhone.Text.Trim() == string.Empty)
        //        {
        //            spanShipAddress.InnerText = "Mobile can not be blank.";
        //            TxtPhone.Focus();
        //            return;
        //        }
        //    }
        //    spanAgreement.InnerText = string.Empty;
        //    if (chkAgree.Checked == false)
        //    {
        //        spanAgreement.InnerText = "select the Payment type.";
        //        return;
        //    }
        //    if (RBCredit.Checked == false && RBFBX.Checked == false)
        //    {
        //        spanAgreement.InnerText = "select the Payment Mode.";
        //        return;
        //    }
        //    string orderNo = string.Empty,PaymentType=string.Empty;
        //    if (RBCredit.Checked == true )
        //    {
        //        PaymentType = "CC";
        //    }
        //    else if (RBFBX.Checked == true)
        //    {
        //        PaymentType = "FT";
        //    }
        //    //saveAddress();
        //    //return;
        //    #region Save to DB 
        //    GenerateRandomNumber();
        //    int UserId = Convert.ToInt16(Session["userid"].ToString());
        //    ServiceUrl = "CRM/AddOrderCheckOut";

        //    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //    var cartOrderCheckoutData = new crmEntity
        //    {
        //        user_id = UserId,
        //        order_no = randomnumber,
        //        transaction_amount = totalAmount,
        //        country_id = Convert.ToInt16(ddlcountry.SelectedValue),
        //        state_id = Convert.ToInt16(ddlState.SelectedValue),
        //        city_name = TxtCity.Text.Trim(),
        //        address1 = TxtAddress1.Text.Trim(),
        //        address2 = TxtAddress2.Text.Trim(),
        //        postcode = TxtPostCode.Text.Trim(),
        //        orderDescription = "CART"
        //    };
        //    HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, cartOrderCheckoutData).Result;
        //    if (response.IsSuccessStatusCode)
        //    {
        //        ServiceUrl = "CRM/GetOrderNoByUserloginId";
        //        //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        //        var OrdernoEntity = new crmEntity()
        //        {
        //            user_id = UserId
        //        };
        //        HttpResponseMessage responseOrderNo = client.PostAsJsonAsync(ServiceUrl, OrdernoEntity).Result;
        //        if (responseOrderNo.IsSuccessStatusCode)
        //        {
        //            var OrderNoResult = responseOrderNo.Content.ReadAsStringAsync().Result;
        //            var dtOrderNo = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(OrderNoResult);
        //            if (dtOrderNo.Rows.Count > 0)
        //            {
        //                orderNo = dtOrderNo.Rows[0]["order_no"].ToString();
        //            }
        //        }
        //        #region AbseccPayment
        //        //web
        //        string checksum = Hash("a1ac0cc290f610d5" + "METROCRM01" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + PaymentType + "SALE" + "" + TxtEmail.Text.Trim());
        //        //MOBILE
        //        //string checksum = Hash("93704aec1d3846b7" + "METROCRM02" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + rbtnPaymentMode.SelectedValue + "SALE" + "" + txtEmail.Text.Trim());
        //        if (orderNo != string.Empty)
        //        {
        //            #region Absec Payment Gateway
        //            //Send Information in Hidden field to the Payment gateway            
        //            Response.Clear();
        //            StringBuilder sb = new StringBuilder();
        //            sb.Append("<html>");
        //            sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        //            sb.AppendFormat("<form name='form' action='{0}' method='post'>", "https://apps.absecdev.xyz/payment/echeckout");
        //            //WEB
        //            sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", "METROCRM01");
        //            // Mobile
        //            //sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", "METROCRM02");
        //            sb.AppendFormat("<input type='hidden' name='orderNo' value='{0}'>", cartOrderCheckoutData.order_no);
        //            sb.AppendFormat("<input type='hidden' name='orderDescription' value='{0}'>", cartOrderCheckoutData.orderDescription);
        //            sb.AppendFormat("<input type='hidden' name='currency' value='{0}'>", "MYR");
        //            sb.AppendFormat("<input type='hidden' name='amount' value='{0}'>", totalAmount);
        //            sb.AppendFormat("<input type='hidden' name='email' value='{0}'>", TxtEmail.Text.Trim());
        //            sb.AppendFormat("<input type='hidden' name='method' value='{0}'>", PaymentType);
        //            sb.AppendFormat("<input type='hidden' name='apiOperation' value='{0}'>", "SALE");
        //            sb.AppendFormat("<input type='hidden' name='cardType' value='{0}'>", "");
        //            sb.AppendFormat("<input type='hidden' name='checksum' value='{0}'>", checksum);
        //            // Other params go here
        //            sb.Append("</form>");
        //            sb.Append("</body>");
        //            sb.Append("</html>");
        //            Response.Write(sb.ToString());
        //            Response.End();
        //            #endregion
        //        }
        //        #endregion
        //    }
        //    else
        //    {

        //    }
        //    #endregion
        //}

        public void LoadProfileDetails()
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                ServiceUrl = "CRM/GetUserDetailsforCart";
                var userDetailsEntity = new crmEntity()
                {
                    userlogin_id = Convert.ToInt16(Session["userid"].ToString())
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, userDetailsEntity).Result;
                if (response.IsSuccessStatusCode)
                {
                    var UserDetailsList = response.Content.ReadAsStringAsync().Result;
                    var dtUserDetails = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(UserDetailsList);
                    if (dtUserDetails.Rows.Count > 0)
                    {
                        LblName.Text = dtUserDetails.Rows[0]["user_fistname"].ToString();
                        LblEmail.Text = dtUserDetails.Rows[0]["email_id"].ToString();
                        LblPhone.Text = dtUserDetails.Rows[0]["mobile_no"].ToString();
                        LblAddress1.Text = dtUserDetails.Rows[0]["address1"].ToString();
                        LblAddress2.Text = dtUserDetails.Rows[0]["address2"].ToString();
                        LblCountry.Text = dtUserDetails.Rows[0]["Country"].ToString();
                        LblCountryId.Text = dtUserDetails.Rows[0]["Country_id"].ToString();
                        LblState.Text = dtUserDetails.Rows[0]["state"].ToString();
                        LblStateId.Text = dtUserDetails.Rows[0]["state_id"].ToString();
                        LblCity.Text = dtUserDetails.Rows[0]["City"].ToString();
                        LblCityId.Text = dtUserDetails.Rows[0]["City_id"].ToString();
                        LblPostCode.Text = dtUserDetails.Rows[0]["postcode_id"].ToString();
                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {
                //LblMessage.Text = ex.Message.ToString();
                return;
            }
        }

        protected void BindState()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetStateDetails";
            HttpResponseMessage response = client.GetAsync(ServiceUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                var StateList = response.Content.ReadAsStringAsync().Result;
                var pDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(StateList);
                if (pDataTable.Rows.Count > 0)
                {
                    ddlState.DataSource = pDataTable;
                    ddlState.DataBind();
                    ddlState.Items.Insert(0, new ListItem("-Select-", ""));
                }
                else
                {
                    ddlState.Items.Insert(0, new ListItem("-Select-", ""));
                }
            }
        }

        protected void BindCity()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetCityListing";
            if (ddlState.SelectedIndex == 0)
            {
                ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
            }
            else
            {
                var crm = new crmEntity()
                {
                    state_id = Convert.ToInt32(ddlState.SelectedValue)
                };
                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                if (response.IsSuccessStatusCode)
                {
                    var CityList = response.Content.ReadAsStringAsync().Result;
                    var dtCityList = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(CityList);
                    if (dtCityList.Rows.Count > 0)
                    {
                        ddlCity.DataSource = dtCityList;
                        ddlCity.DataBind();
                        ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
                    }
                    else
                    {
                        ddlCity.Items.Insert(0, new ListItem("-Select-", ""));
                    }
                }
            }
        }

        private bool ValidateEmail()
        {
            string email = TxtEmail.Text;
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            bool retval = true;
            if (!match.Success)
            {
                retval = false;
                return retval;
            }
            return retval;
        }

        protected string Hash(string sendData)
        {
            using (SHA1Managed sha1 = new SHA1Managed())
            {
                var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(sendData));
                var sb = new StringBuilder(hash.Length * 2);

                foreach (byte b in hash)
                {
                    // can be "x2" if you want lowercase
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }

        protected void GenerateRandomNumber()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[8];
            var random = new Random();
            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }
            randomnumber = new String(stringChars);
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCity();
        }
    }
}