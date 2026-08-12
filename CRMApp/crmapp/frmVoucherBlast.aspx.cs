using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;
using System.Text;

namespace CRMApp.crmapp
{
    public partial class frmVoucherBlast : System.Web.UI.Page
    {
        #region Global Declaration
        HttpClient client = new HttpClient();
        HttpClient Infobipclient = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty, Param1 = string.Empty;
        string StrInfobipBaseURL = ConfigurationManager.AppSettings["InfobipBaseURL"].ToString(),

        strUserEmail = string.Empty,
        strSMTPHost = ConfigurationManager.AppSettings["SMTPHost"].ToString(),
        strSMTPPort = ConfigurationManager.AppSettings["SMTPPort"].ToString(),
        strFromEmail = ConfigurationManager.AppSettings["paramFromEmail"].ToString(),
        strAdminEmail = ConfigurationManager.AppSettings["ParamAdminEmail"].ToString();//, 
           // PromotionBlastpath = ConfigurationManager.AppSettings["PromotionBlastpath"].ToString();
        static int voucherCatId = 0;
        double dOriPrice = 0, dDiscountPrice = 0, dOriPrice1 = 0, dDiscountPrice1 = 0;
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            Infobipclient.BaseAddress = new Uri(StrInfobipBaseURL);
            // Infobipclient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    BindVoucherListing();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                //BindVoucherCategoryCode();
                //BindVoucherCategoryListing();
            }
        }

        protected void lvVoucherList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem voucherItems = (ListViewDataItem)e.Item;
            if (e.CommandName == "Edit")
            {
                if (voucherItems != null)
                {
                    int voucherId = int.Parse(lvVoucherList.DataKeys[voucherItems.DisplayIndex][0].ToString());
                    Response.Redirect("frmVoucherSetup.aspx?voucher_id=" + voucherId);
                }
            }
        }

        protected void lvVoucherList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvVoucherList.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindVoucherListing();
        }
        protected void lvVoucherList_ItemDataBound(object sender, ListViewItemEventArgs e)
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

                HtmlGenericControl totalrecord = (HtmlGenericControl)lvVoucherList.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvVoucherList.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvVoucherList.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvVoucherList.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void btnBlastEmail_Click(object sender, EventArgs e)
        {
            #region send email to merchant
            try
            {
                int cnt = 0;
                int cnt1 = 0;
                invalidmsg.InnerText = "";
                invalidmsg.Style.Remove("color");
                string readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty, myStringUser = string.Empty;
                string VoucherImg = string.Empty, VoucherImg1 = string.Empty, VoucherImg2 = string.Empty, VoucherName1 = string.Empty, VoucherDesc1 = string.Empty,
                    OriginalPrice1 = string.Empty, DiscountPrice1 = string.Empty, VoucherName = string.Empty,
                     OriginalPrice = string.Empty, DiscountPrice = string.Empty, VoucherDesc = string.Empty, merchantemail = string.Empty,
                     merchantphno = string.Empty, merchantname = string.Empty, VoucherBought = string.Empty, merchantemail1 = string.Empty,
                     merchantphno1 = string.Empty, merchantname1 = string.Empty, VoucherBought1 = string.Empty, voucherURL = string.Empty;
                int merchant_id = 0;
                // myStringAdmin = myStringAdmin.Replace("$$MemberName$$", txtMerchantName.Text.Trim());
                //SendEmail(strAdminEmail, "Merchant has Pre registered it's account Successfully.", myStringAdmin);
                StreamReader readerAdmin = new StreamReader(Server.MapPath("~/crmapp/crmblastvoucheremail.html"));
                foreach (ListViewDataItem item in lvVoucherList.Items)
                {
                    CheckBox checkslct = item.FindControl("checkslct") as CheckBox;

                    if (checkslct != null)
                    {
                        if (checkslct.Checked)
                        {
                            cnt1++;
                        }
                    }
                }
                if (cnt1 < 3)
                {
                    foreach (ListViewDataItem item in lvVoucherList.Items)
                    {
                        CheckBox checkslct = item.FindControl("checkslct") as CheckBox;

                        if (checkslct != null)
                        {
                            if (checkslct.Checked)
                            {
                                cnt++;
                                int voucherId = int.Parse(lvVoucherList.DataKeys[item.DisplayIndex][0].ToString());
                                ServiceUrl = "CRM/GetVoucherBlastDetailsById";
                                //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                HttpResponseMessage response = client.GetAsync(ServiceUrl + "?voucherId=" + voucherId).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    var Productlist = response.Content.ReadAsStringAsync().Result;
                                    var DataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(Productlist);
                                    if (DataTable.Rows.Count > 0)
                                    {
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image"].ToString().Trim()))
                                        {
                                            VoucherImg = DataTable.Rows[0]["promotion_image"].ToString().Trim();
                                            //PromotionBlastpath + "/crmapp/images/voucher/" +
                                            if (cnt == 2)
                                            {
                                                VoucherImg2 = DataTable.Rows[0]["promotion_image"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherImg1 = DataTable.Rows[0]["promotion_image"].ToString().Trim();
                                            }
                                        }

                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image2"].ToString().Trim()) && string.IsNullOrEmpty(VoucherImg.Trim()))
                                        {
                                            VoucherImg = DataTable.Rows[0]["promotion_image2"].ToString().Trim();
                                            if (cnt == 2)
                                            {
                                                VoucherImg2 = DataTable.Rows[0]["promotion_image2"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherImg1 = DataTable.Rows[0]["promotion_image2"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image3"].ToString().Trim()) && string.IsNullOrEmpty(VoucherImg.Trim()))
                                        {
                                            VoucherImg = DataTable.Rows[0]["promotion_image3"].ToString().Trim();
                                            if (cnt == 2)
                                            {
                                                VoucherImg2 = DataTable.Rows[0]["promotion_image3"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherImg1 = DataTable.Rows[0]["promotion_image3"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image4"].ToString().Trim()) && string.IsNullOrEmpty(VoucherImg.Trim()))
                                        {
                                            VoucherImg = DataTable.Rows[0]["promotion_image4"].ToString().Trim();
                                            if (cnt == 2)
                                            {
                                                VoucherImg2 = DataTable.Rows[0]["promotion_image4"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherImg1 = DataTable.Rows[0]["promotion_image4"].ToString().Trim();
                                            }

                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["promotion_image5"].ToString().Trim()) && string.IsNullOrEmpty(VoucherImg.Trim()))
                                        {
                                            VoucherImg = DataTable.Rows[0]["promotion_image5"].ToString().Trim();
                                            if (cnt == 2)
                                            {
                                                VoucherImg2 = DataTable.Rows[0]["promotion_image5"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherImg1 = DataTable.Rows[0]["promotion_image5"].ToString().Trim();
                                            }

                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["voucher_name"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                VoucherName1 = DataTable.Rows[0]["voucher_name"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherName = DataTable.Rows[0]["voucher_name"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["descriptions"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                VoucherDesc1 = DataTable.Rows[0]["descriptions"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherDesc = DataTable.Rows[0]["descriptions"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["original_price"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                dOriPrice1 = Convert.ToDouble(DataTable.Rows[0]["original_price"].ToString().Trim());
                                                OriginalPrice1 = dOriPrice1.ToString("N2").Trim();
                                            }
                                            else
                                            {
                                                dOriPrice = Convert.ToDouble(DataTable.Rows[0]["original_price"].ToString().Trim());
                                                OriginalPrice = dOriPrice.ToString("N2").Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["discount_price"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                dDiscountPrice1 = Convert.ToDouble(DataTable.Rows[0]["discount_price"].ToString().Trim());
                                                DiscountPrice1 = dDiscountPrice1.ToString("N2").Trim();
                                            }
                                            else
                                            {
                                                dDiscountPrice = Convert.ToDouble(DataTable.Rows[0]["discount_price"].ToString().Trim());
                                                DiscountPrice = dDiscountPrice.ToString("N2").Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["merchant_mobile"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                merchantphno1 = DataTable.Rows[0]["merchant_mobile"].ToString().Trim();
                                            }
                                            else
                                            {
                                                merchantphno = DataTable.Rows[0]["merchant_mobile"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["merchant_email"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                merchantemail1 = DataTable.Rows[0]["merchant_email"].ToString().Trim();
                                            }
                                            else
                                            {
                                                merchantemail = DataTable.Rows[0]["merchant_email"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["merchant_id"].ToString().Trim()))
                                        {
                                            merchant_id = Convert.ToInt32(DataTable.Rows[0]["merchant_id"]);
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["merchant_name"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                merchantname1 = DataTable.Rows[0]["merchant_name"].ToString().Trim();
                                            }
                                            else
                                            {
                                                merchantname = DataTable.Rows[0]["merchant_name"].ToString().Trim();
                                            }
                                        }
                                        if (!string.IsNullOrEmpty(DataTable.Rows[0]["bought"].ToString().Trim()))
                                        {
                                            if (cnt == 2)
                                            {
                                                VoucherBought1 = DataTable.Rows[0]["bought"].ToString().Trim();
                                            }
                                            else
                                            {
                                                VoucherBought = DataTable.Rows[0]["bought"].ToString().Trim();
                                            }
                                        }


                                        if (cnt == 2)
                                        {
                                            readerAdmin = new StreamReader(Server.MapPath("~/crmapp/crmblast2voucheremail.html"));
                                        }
                                        readAdminFile = readerAdmin.ReadToEnd();
                                        myStringAdmin = readAdminFile;

                                        if (cnt == 1)
                                        {
                                            voucherURL = "https://staging.bigr.asia/frmvoucherdetails.aspx?voucher_id=" + voucherId;
                                        }
                                        //  myStringAdmin = myStringAdmin.Replace("$$MemberName$$", merchantname);



                                        myStringAdmin = myStringAdmin.Replace("$$VoucherImg$$", "<img src = " + VoucherImg1 + " alt='no voucher'"+
                                            "style='max-width: 100%;max - height: 100 %;width: auto; height: auto;"+
                                    "margin: 0 auto; ' border='0'>");
                                        myStringAdmin = myStringAdmin.Replace("$$VoucherName$$", VoucherName);
                                        //myStringAdmin = myStringAdmin.Replace("$$VoucherDesc$$", VoucherDesc);
                                        myStringAdmin = myStringAdmin.Replace("$$OriginalPrice$$", "RM" + OriginalPrice);
                                        myStringAdmin = myStringAdmin.Replace("$$DiscountPrice$$", "RM" + DiscountPrice);
                                        myStringAdmin = myStringAdmin.Replace("$$VoucherBought$$", VoucherBought);
                                        myStringAdmin = myStringAdmin.Replace("$$VoucherURL$$", voucherURL);

                                        if (cnt == 2)
                                        {
                                            String voucherURL1 = "https://staging.bigr.asia/frmvoucherdetails.aspx?voucher_id=" + voucherId;
                                            myStringAdmin = myStringAdmin.Replace("$$VoucherImg1$$", "<img src = " + VoucherImg2 + " alt='no voucher'"+
                                                " style='max-width: 100%;max - height: 100 %;width: auto;height: auto;"+
                                       " margin: 0 auto; '"+" border='0'>");
                                            myStringAdmin = myStringAdmin.Replace("$$VoucherName1$$", VoucherName1);
                                            //myStringAdmin = myStringAdmin.Replace("$$VoucherDesc1$$", VoucherDesc1);
                                            myStringAdmin = myStringAdmin.Replace("$$OriginalPrice1$$", "RM" + OriginalPrice1);
                                            myStringAdmin = myStringAdmin.Replace("$$DiscountPrice1$$", "RM" + DiscountPrice1);
                                            myStringAdmin = myStringAdmin.Replace("$$VoucherBought1$$", VoucherBought1);
                                            myStringAdmin = myStringAdmin.Replace("$$VoucherURL1$$", voucherURL1);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    int emailflag = 0, smsflag = 0;
                    if (!string.IsNullOrEmpty(merchantemail) && cnt > 0)
                    {
                        String email = merchantemail;
                        String mername = merchantname;
                        String merphno = merchantphno;
                        #region sendmail To Merchant
                        //for (int i = 0; i < cnt; i++)
                        //{
                        //    if (i == 1)
                        //    {
                        //        email = merchantemail1;
                        //        mername = merchantname1;
                        //        merphno = merchantphno1;
                        //    }
                        //    ServiceUrl = "CRM/VoucherBlastEmail";
                        //    string meremailsubj = "Hi " + mername + ", Best Discount For You Today !";
                        //    var emailparamValues = new crmEntity
                        //    {
                        //        fromEmail = "info@bigr.asia",
                        //        toEmail = email,
                        //        subject = meremailsubj,
                        //        message = myStringAdmin,
                        //        filePath = "",
                        //    };

                        //    HttpResponseMessage emailresponse = client.PostAsJsonAsync(ServiceUrl, emailparamValues).Result;
                        //    if (emailresponse.IsSuccessStatusCode)
                        //    {

                        //        var getResponse = emailresponse.Content.ReadAsStringAsync().Result;
                        //        // ValidMsg.InnerText = "Send mail successfully";
                        //        emailflag = 1;
                        //        #region sms calling
                        //        if (!string.IsNullOrEmpty(merchantphno))
                        //        {
                        //            ServiceUrl = "CRM/VoucherBlastSms";
                        //            string first = merchantphno.Substring(0);
                        //            if (first != "6")
                        //            {
                        //                merchantphno = "6" + merchantphno;
                        //            }
                        //            var smsparamValues = new crmEntity
                        //            {
                        //                fromName = "info absec",
                        //                toNumber = merchantphno,
                        //                message = "Promotion vouchers sent to your emails",

                        //            };
                        //            HttpResponseMessage smsresponse = client.PostAsJsonAsync(ServiceUrl, smsparamValues).Result;
                        //            if (smsresponse.IsSuccessStatusCode)
                        //            {
                        //                var getsmsResponse = smsresponse.Content.ReadAsStringAsync().Result;
                        //                smsflag = 1;
                        //            }
                        //        }
                        //        #endregion
                        //    }

                        //}
                        #endregion
                        ServiceUrl = "CRM/GetVoucherBlastRegisteredUsers";
                        int roleid = 2;
                        //HttpResponseMessage userresponse = client.GetAsync(ServiceUrl + "?roleid=" + roleid).Result;
                        var crm = new crmEntity()
                        {
                            role_id = roleid
                        };
                        HttpResponseMessage userresponse = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                        if (userresponse.IsSuccessStatusCode)
                        {
                            var userlist = userresponse.Content.ReadAsStringAsync().Result;
                            var userDataTable = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(userlist);
                            #region usersendmail
                            if (userDataTable.Rows.Count > 0)
                            {
                                for (int i = 0; i < userDataTable.Rows.Count; i++)
                                {
                                    string useremail = "";
                                    string username = "";
                                    if (!string.IsNullOrEmpty(userDataTable.Rows[i]["email_id"].ToString().Trim()))
                                    {
                                        useremail = userDataTable.Rows[i]["email_id"].ToString().Trim();
                                    }
                                    if (!string.IsNullOrEmpty(userDataTable.Rows[i]["user_fistname"].ToString().Trim()))
                                    {
                                        username = userDataTable.Rows[i]["user_fistname"].ToString().Trim();
                                    }
                                    string useremailsubj = "Hi " + username + ", Best Discount For You Today !";
                                    ServiceUrl = "CRM/VoucherBlastEmail";
                                    var useremailparamValues = new crmEntity
                                    {
                                        fromEmail = "info@bigr.asia",
                                        toEmail = useremail,
                                        subject = useremailsubj,
                                        message = myStringAdmin,
                                        filePath = "",
                                    };

                                    HttpResponseMessage useremailresponse = client.PostAsJsonAsync(ServiceUrl, useremailparamValues).Result;
                                    if (useremailresponse.IsSuccessStatusCode)
                                    {
                                        emailflag = 1;
                                    }
                                }
                            }
                            #endregion usersendmail
                        }
                    }
                    readerAdmin.Close();
                    readerAdmin.Dispose();
                    if (emailflag == 1)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "hideLoader()", true);
                        //ValidMsg.InnerText = "Promotion email has been successfully sending";
                    }
                    else
                    { ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "hideLoader1()", true); }

                    foreach (ListViewDataItem item in lvVoucherList.Items)
                    {
                        CheckBox checkslct = item.FindControl("checkslct") as CheckBox;

                        if (checkslct != null)
                        {
                            if (checkslct.Checked)
                            {
                                int voucherId = int.Parse(lvVoucherList.DataKeys[item.DisplayIndex][0].ToString());
                                #region insert status in tbl_merchant_status
                                ServiceUrl = "CRM/AddVoucherApiStatus";
                                var paramValues = new crmEntity
                                {
                                    voucher_id = voucherId,
                                    merchant_id = merchant_id,
                                    merchant_name = merchantname,
                                    email = merchantemail,
                                    email_status = emailflag,
                                    sms_status = smsflag,


                                };
                                HttpResponseMessage responseStatus = client.PostAsJsonAsync(ServiceUrl, paramValues).Result;
                                if (responseStatus.IsSuccessStatusCode)
                                {
                                    var res = responseStatus.Content.ReadAsStringAsync().Result;
                                }
                            }
                            #endregion

                        }
                    }

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "hideLoader1()", true);
                    invalidmsg.InnerText = "Only allowed 2 vouchers at a time";
                    invalidmsg.Style.Add("color", "Red");
                    return;
                }



            }
            catch (Exception ex)
            {
                invalidmsg.InnerText = ex.Message.ToString();
                invalidmsg.Style.Add("color", "Red");
                return;

            }
            #endregion
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindVoucherListing();
        }

        public void BindVoucherListing()
        {
            //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/GetVoucherBlastList";
            var crm = new crmEntity()
            {
                search_param = txtSearch.Text.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvVoucherList.DataSource = dtChargeType;
                    lvVoucherList.DataBind();
                }
                else
                {
                    lvVoucherList.DataSource = dtChargeType;
                    lvVoucherList.DataBind();
                }
            }
        }

        public void SendEmail(string to_sender, string subject, string message)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient();
                string s = string.Empty;
                s = strFromEmail;
                mail.From = new MailAddress(s);
                mail.To.Add(to_sender);
                mail.Subject = subject;
                mail.Body = message;
                mail.IsBodyHtml = true;
                SmtpServer.Port = Convert.ToInt16(strSMTPPort);
                SmtpServer.Host = strSMTPHost;
                SmtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                invalidmsg.InnerText = ex.Message.ToString();
                invalidmsg.Style.Add("color", "Red");
                return;
            }
        }

        //private class crmInfobipemail
        //{
        //    public string fromEmail { get; set; }
        //    public string toEmail { get; set; }
        //    public string subject { get; set; }
        //    public string message { get; set; }
        //    public string filePath { get; set; }
        //}
    }
}