using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Data;
using System.Web.UI.HtmlControls;

namespace CRMApp.crmapp
{
    public partial class frmBankCardRegistration : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, strCreatedby = string.Empty,
            strTID = string.Empty, strAPIKey = string.Empty, strCreateTokenURL = string.Empty, strPaymentType = string.Empty, stremail = string.Empty;
        static string totalAmount = string.Empty;
        static string randomnumber;
        static int TokenId = 0;


        #endregion

        #region Page_Events
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    GetTpinDetailsByUserId();
                    BindTokenDetailsByUserId();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }

        //protected void BtnCredtDebitDetails_Click(object sender, EventArgs e)
        //{
        //    int UserId = Convert.ToInt16(Session["user_id"].ToString());
        //    totalAmount = "";
        //    string Currency = string.Empty;
        //    #region Save to DB 
        //    GenerateRandomNumber();
        //    ServiceUrl = "Payment/InsertTokenDetails";
        //    if (Session["EmailId"] != null)
        //    { stremail = Session["EmailId"].ToString().Trim(); }
        //    var tokenData = new crmEntity
        //    {
        //        user_id = UserId,
        //        order_no = randomnumber,
        //        token_amount = totalAmount,
        //        orderDescription = "GenerateToken",
        //        email = stremail,
        //        currency = ""
        //    };
        //    HttpResponseMessage responseToken = client.PostAsJsonAsync(ServiceUrl, tokenData).Result;
        //    if (responseToken.IsSuccessStatusCode)
        //    {
        //        var TokenResult = responseToken.Content.ReadAsStringAsync().Result;
        //        var dtToken = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(TokenResult);
        //        if (dtToken.Rows.Count > 0)
        //        {
        //            #region AbseccPayment
        //            //web
        //            strTID = ConfigurationManager.AppSettings["CreateTokenTID"].ToString();
        //            strAPIKey = ConfigurationManager.AppSettings["CreateTokenAPIKey"].ToString();
        //            strCreateTokenURL = ConfigurationManager.AppSettings["CreateTokenURL"].ToString();
        //            string strMethod = "CC", strAPiOperation = "TOKENIZATION", StrCardType = "";
        //            //string checksum = Hash("a1ac0cc290f610d5" + "METROCRM01" + randomnumber + cartOrderCheckoutData.orderDescription + "MYR" + totalAmount + PaymentType + "SALE" + "" + email);
        //            string checksum = Hash(strAPIKey + strTID + randomnumber + tokenData.orderDescription + tokenData.currency + totalAmount + strMethod + strAPiOperation + StrCardType + tokenData.email);
        //            if (tokenData.order_no != string.Empty)
        //            {
        //                #region Absec Payment Gateway
        //                //Send Information in Hidden field to the Payment gateway            
        //                Response.Clear();
        //                StringBuilder sb = new StringBuilder();
        //                sb.Append("<html>");
        //                sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        //                sb.AppendFormat("<form name='form' action='{0}' method='post'>", strCreateTokenURL);
        //                sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", strTID);
        //                sb.AppendFormat("<input type='hidden' name='orderNo' value='{0}'>", tokenData.order_no);
        //                sb.AppendFormat("<input type='hidden' name='orderDescription' value='{0}'>", tokenData.orderDescription);
        //                sb.AppendFormat("<input type='hidden' name='currency' value='{0}'>", tokenData.currency);
        //                sb.AppendFormat("<input type='hidden' name='amount' value='{0}'>", totalAmount);
        //                sb.AppendFormat("<input type='hidden' name='email' value='{0}'>", tokenData.email);
        //                sb.AppendFormat("<input type='hidden' name='method' value='{0}'>", strMethod);
        //                sb.AppendFormat("<input type='hidden' name='apiOperation' value='{0}'>", strAPiOperation);
        //                sb.AppendFormat("<input type='hidden' name='cardType' value='{0}'>", StrCardType);
        //                sb.AppendFormat("<input type='hidden' name='checksum' value='{0}'>", checksum);

        //                // Other params go here
        //                sb.Append("</form>");
        //                sb.Append("</body>");
        //                sb.Append("</html>");
        //                Response.Write(sb.ToString());
        //                Response.End();
        //                #endregion
        //            }
        //            #endregion
        //        }
        //    }
        //    else
        //    {

        //    }
        //    #endregion

        //}

        protected void LvTokenDetails_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)LvTokenDetails.FindControl("totalrecord");
                if (ViewState["Vs_TokenDetailsByUserId"] != null)
                {
                    dt = (DataTable)ViewState["Vs_TokenDetailsByUserId"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }

                Label LblPrimaryFlag = (Label)e.Item.FindControl("LblPrimaryFlag");
                LinkButton lnkPrimary = (LinkButton)e.Item.FindControl("lnkPrimary");
                lnkPrimary.Enabled = true;
                if (LblPrimaryFlag.Text == "1")
                {
                   lnkPrimary.Enabled = false;
                    lnkPrimary.CssClass = "btn btn-default btn-sm disabled";
                }
            }
        }

        protected void LvTokenDetails_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (String.Equals(e.CommandName, "Primary"))
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                TokenId = Convert.ToInt32(LvTokenDetails.DataKeys[dataItem.DisplayIndex].Value.ToString());
                ServiceUrl = "Payment/UpdatePrimaryCardByTokenId";
                var UpPrimCardEntity = new crmEntity()
                {
                    token_id = TokenId,
                    user_id = Convert.ToInt16(Session["user_id"].ToString())
                };
                HttpResponseMessage responsePrimCard = client.PostAsJsonAsync(ServiceUrl, UpPrimCardEntity).Result;
                if (responsePrimCard.IsSuccessStatusCode)
                {
                    var PrimaryCardType = responsePrimCard.Content.ReadAsStringAsync().Result;
                    var dtPrimCardType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(PrimaryCardType);
                    //ViewState["dtcont"] = dtChargeType;
                    if (dtPrimCardType.Rows.Count > 0)
                    {
                        {
                            if (dtPrimCardType.Rows[0]["update_flag"].ToString() == "Y")
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "alert('Primary Card Set Successfully..');", true);
                                BindTokenDetailsByUserId();
                                return;
                            }

                        }
                    }
                    else
                    {

                    }
                }
            }
        }

        protected void lnkValidateCancelTPin_Click(object sender, EventArgs e)
        {
            txtPin1.Text = string.Empty;
            txtPin2.Text = string.Empty;
            txtPin3.Text = string.Empty;
            txtPin4.Text = string.Empty;
            txtPin5.Text = string.Empty;
            txtPin6.Text = string.Empty;
            message_cPin.InnerText = "";
        }

        protected void LbValidateTpin_Click(object sender, EventArgs e)
        {
            string strPin = txtPin1.Text.Trim() + txtPin2.Text.Trim() + txtPin3.Text.Trim() + txtPin4.Text.Trim() + txtPin5.Text.Trim() + txtPin6.Text.Trim();
            ServiceUrl = "CRM/ValidateTransactionPin";

            var pinEntity = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString()),
                pin_no = strPin
            };
            HttpResponseMessage responseTpin = client.PostAsJsonAsync(ServiceUrl, pinEntity).Result;
            if (responseTpin.IsSuccessStatusCode)
            {
                var varTPin = responseTpin.Content.ReadAsStringAsync().Result;
                var dtPin = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(varTPin);
                if (dtPin.Rows.Count > 0)
                {
                    int UserId = Convert.ToInt16(Session["user_id"].ToString());
                    totalAmount = "";
                    string Currency = string.Empty;
                    #region Save to DB 
                    GenerateRandomNumber();
                    ServiceUrl = "Payment/InsertTokenDetails";
                    if (Session["EmailId"] != null)
                    { stremail = Session["EmailId"].ToString().Trim(); }
                    var tokenData = new crmEntity
                    {
                        user_id = UserId,
                        order_no = randomnumber,
                        token_amount = totalAmount,
                        orderDescription = "GenerateToken",
                        email = stremail,
                        currency = ""
                    };
                    HttpResponseMessage responseToken = client.PostAsJsonAsync(ServiceUrl, tokenData).Result;
                    if (responseToken.IsSuccessStatusCode)
                    {
                        var TokenResult = responseToken.Content.ReadAsStringAsync().Result;
                        var dtToken = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(TokenResult);
                        if (dtToken.Rows.Count > 0)
                        {
                            #region AbseccPayment
                            //web
                            strTID = ConfigurationManager.AppSettings["CreateTokenTID"].ToString();
                            strAPIKey = ConfigurationManager.AppSettings["CreateTokenAPIKey"].ToString();
                            strCreateTokenURL = ConfigurationManager.AppSettings["CreateTokenURL"].ToString();
                            string strMethod = "CC", strAPiOperation = "TOKENIZATION", StrCardType = "";
                            string checksum = Hash(strAPIKey + strTID + randomnumber + tokenData.orderDescription + tokenData.currency + totalAmount + strMethod + strAPiOperation + StrCardType + tokenData.email);
                            if (tokenData.order_no != string.Empty)
                            {
                                #region Absec Payment Gateway
                                //Send Information in Hidden field to the Payment gateway            
                                Response.Clear();
                                StringBuilder sb = new StringBuilder();
                                sb.Append("<html>");
                                sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
                                sb.AppendFormat("<form name='form' action='{0}' method='post'>", strCreateTokenURL);
                                sb.AppendFormat("<input type='hidden' name='TID' value='{0}'>", strTID);
                                sb.AppendFormat("<input type='hidden' name='orderNo' value='{0}'>", tokenData.order_no);
                                sb.AppendFormat("<input type='hidden' name='orderDescription' value='{0}'>", tokenData.orderDescription);
                                sb.AppendFormat("<input type='hidden' name='currency' value='{0}'>", tokenData.currency);
                                sb.AppendFormat("<input type='hidden' name='amount' value='{0}'>", totalAmount);
                                sb.AppendFormat("<input type='hidden' name='email' value='{0}'>", tokenData.email);
                                sb.AppendFormat("<input type='hidden' name='method' value='{0}'>", strMethod);
                                sb.AppendFormat("<input type='hidden' name='apiOperation' value='{0}'>", strAPiOperation);
                                sb.AppendFormat("<input type='hidden' name='cardType' value='{0}'>", StrCardType);
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
                    }
                    else
                    {

                    }
                    #endregion
                }
                else
                {
                    message_cPin.InnerText = "Incorrect T-Pin";
                    message_cPin.Style.Add("color", "Red");
                }
            }
            else
            {
                message_cPin.InnerText = "PIN Not Match";
                message_cPin.Style.Add("color", "Red");
            }
        }

        protected void LbCancelNewTPin_Click(object sender, EventArgs e)
        {
            TxtNewPin1.Text = string.Empty; TxtNewPin2.Text = string.Empty;
            TxtNewPin3.Text = string.Empty; TxtNewPin4.Text = string.Empty;
            TxtNewPin5.Text = string.Empty; TxtNewPin6.Text = string.Empty;

            message_nPin.InnerText = "";
        }

        protected void LbNewTPin_Click(object sender, EventArgs e)
        {
            //Insert record to DB-----------------------------------------
            string strNewTPin = TxtNewPin1.Text.Trim() + TxtNewPin2.Text.Trim() + TxtNewPin3.Text.Trim() + TxtNewPin4.Text.Trim() + TxtNewPin5.Text.Trim() + TxtNewPin6.Text.Trim();
            var crm = new crmEntity()
            {
                user_id = Convert.ToInt32(Session["user_id"].ToString()),
                pin_no = strNewTPin,
                pin_id = 0,
                active_status = 1,
                created_by = Session["username"].ToString(),
                updated_by = Session["username"].ToString()
            };

            ServiceUrl = "CRM/AddEditTransactionPin";
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                LbCancelNewTPin_Click(null, null);
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "NewTPinMsg();", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "alert('Tpin Created Successfully..');", true);
                GetTpinDetailsByUserId();
            }
            else
            {
                //for change pin
                message_nPin.InnerText = response.ReasonPhrase.ToString();
                message_nPin.Style.Add("color", "Red");
            }
            //-------------------------------------------------------------
        }


        #endregion

        #region UD_Events
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

        public void BindTokenDetailsByUserId()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "Payment/GetTokenDetailsByUserId";
            var varTokenDetailsEntity = new crmEntity()
            {
                user_id = Convert.ToInt16(Session["user_id"].ToString())
            };
            HttpResponseMessage responseTokenDetails = client.PostAsJsonAsync(ServiceUrl, varTokenDetailsEntity).Result;
            if (responseTokenDetails.IsSuccessStatusCode)
            {
                var tokenDetailsByUserId = responseTokenDetails.Content.ReadAsStringAsync().Result;
                var dttokenDetailsByUserId = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(tokenDetailsByUserId);
                ViewState["Vs_TokenDetailsByUserId"] = dttokenDetailsByUserId;
                if (dttokenDetailsByUserId.Rows.Count > 0)
                {
                    LvTokenDetails.DataSource = dttokenDetailsByUserId;
                    LvTokenDetails.DataBind();

                }
                else
                {
                    LvTokenDetails.DataSource = dttokenDetailsByUserId;
                    LvTokenDetails.DataBind();
                }

            }
        }

        public void GetTpinDetailsByUserId()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetTPinDetailsByUserId";
            var varTokenDetailsEntity = new crmEntity()
            {
                user_id = Convert.ToInt16(Session["user_id"].ToString())
            };
            HttpResponseMessage responseTokenDetails = client.PostAsJsonAsync(ServiceUrl, varTokenDetailsEntity).Result;
            if (responseTokenDetails.IsSuccessStatusCode)
            {
                var tokenDetailsByUserId = responseTokenDetails.Content.ReadAsStringAsync().Result;
                var dttokenDetailsByUserId = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(tokenDetailsByUserId);
                if (dttokenDetailsByUserId.Rows.Count > 0)
                {
                    LnkValidateTpin.Visible = true;
                    LnkNewTPin.Visible = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "alert('You have not created a Tpin, create a Tpin before Tokenization!!');", true);
                    //ScriptManager.RegisterStartupScript(updtranpin, updtranpin.GetType(), "Pop", "SuccessChangePinMsg();", true);
                    LnkValidateTpin.Visible = false;
                    LnkNewTPin.Visible = true;
                }

            }
        }
        #endregion


    }



}
