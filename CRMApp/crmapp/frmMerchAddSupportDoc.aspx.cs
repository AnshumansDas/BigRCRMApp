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
using System.IO;
using Newtonsoft.Json.Linq;

namespace CRMApp.crmapp
{
    public partial class frmMerchAddSupportDoc : System.Web.UI.Page
    {
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["m_code"].Trim() != "''" && Request.QueryString["m_name"].Trim() != "''")
                {
                    BindSupportDocument();
                    lblMerchantName.Text = Request.QueryString["m_name"].Trim();
                }
            }
            //FileUploadDoc.Attributes["onchange"] = "UploadFile1(this)";
        }

        #region support document
        protected void UploadDoc(object sender, EventArgs e)
        {
            //if (FileUploadDoc.HasFile)
            //{
            //    tryuploaddocmsg
            //    {
            //        var filePath = Server.MapPath("../crmapp/merchant_doc/" + FileUploadDoc.FileName);
            //        if (File.Exists(filePath))
            //        {
            //            File.Delete(filePath);
            //        }

            //        if (FileUploadDoc.PostedFile.ContentLength < 10240000)
            //        {
            //            FileUploadDoc.SaveAs(HttpContext.Current.Server.MapPath("../crmapp/merchant_doc/" + FileUploadDoc.FileName));
            //            ViewState["doc_file_path"] = "../crmapp/merchant_doc/" + Path.GetFileName(FileUploadDoc.FileName);
            //            uploaddocmsg.InnerText = "Successfully upload : " + FileUploadDoc.FileName;
            //            uploaddocmsg.Style.Add("color", "DarkGreen");
            //        }
            //        else
            //        {
            //            uploaddocmsg.InnerText = "File size should not exceed 10mb";
            //            uploaddocmsg.Style.Add("color", "Red");
            //            return;
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        uploaddocmsg.InnerText = "Error occured: " + ex.Message;
            //        uploaddocmsg.Style.Add("color", "Red");
            //    }
            //}
            //else
            //{ ViewState["doc_file_path"] = string.Empty; }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmMerchant.aspx");
        }

        protected void lnkAddSupportDoc_Click(object sender, EventArgs e)
        {
            #region file upload
            if (FileUploadDoc.HasFile)
            {
                uploaddocmsg.InnerText = string.Empty;
                try
                {
                    //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                    //var filePath = Server.MapPath("../crmapp/merchant_doc/" + FileUploadDoc.FileName);
                    var filePath = Server.MapPath("../crmapp/merchant_doc/" + FileUploadDoc.FileName.Replace(" ","_"));
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }

                    if (FileUploadDoc.PostedFile.ContentLength < 10240000)
                    {
                        //Added By Mani on 18MAr2019 the below code for Replacing the Empty space with Underscore (IOS,ANDROID and FB).
                        FileUploadDoc.SaveAs(HttpContext.Current.Server.MapPath("../crmapp/merchant_doc/" + FileUploadDoc.FileName.Replace(" ", "_")));
                        ViewState["doc_file_path"] = "../crmapp/merchant_doc/" + Path.GetFileName(FileUploadDoc.FileName.Replace(" ", "_"));
                        #region sp doc
                        string strMerchCode = string.Empty;
                        try
                        {
                            string strCreatedBy = string.Empty;
                            if (Request.QueryString["m_code"].Trim() != "''")
                            {
                                strMerchCode = Request.QueryString["m_code"].ToString().Trim();
                            }

                            if (!string.IsNullOrEmpty(Session["username"].ToString()))
                            { strCreatedBy = Session["username"].ToString(); }
                            else { strCreatedBy = "metroadmin123"; }

                            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                            ServiceUrl = "CRM/AddEditMerchantSupportDocument";
                            var crm = new crmEntity()
                            {
                                merchant_code = strMerchCode.Trim(),
                                user_by = strCreatedBy,
                                document_name = txtDocName.Text,
                                doc_file_path = ViewState["doc_file_path"].ToString().Trim(),
                                doc_date = DateTime.Now
                            };
                            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                            if (response.IsSuccessStatusCode)
                            {
                                BindSupportDocument();
                                txtDocName.Text = string.Empty;
                                ViewState["doc_file_path"] = string.Empty;
                            }
                            else
                            {
                                adddocmsg.InnerText = response.ReasonPhrase.ToString();
                                adddocmsg.Style.Add("color", "Red");
                            }
                        }
                        catch (Exception ex)
                        {
                            adddocmsg.InnerText = ex.Message.ToString();
                            return;
                        }
                        #endregion
                    }
                    else
                    {
                        uploaddocmsg.InnerText = "File size should not exceed 10mb";
                        uploaddocmsg.Style.Add("color", "Red");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    uploaddocmsg.InnerText = "Error occured: " + ex.Message;
                    uploaddocmsg.Style.Add("color", "Red");
                }
            }
            else
            { ViewState["doc_file_path"] = string.Empty; }
            #endregion

        }

        protected void lvSupportDoc_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            DataTable dt = new DataTable();
            ListViewDataItem dataItem = (ListViewDataItem)e.Item;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlGenericControl totalrecord = (HtmlGenericControl)lvSupportDoc.FindControl("totalrecord");
                if (ViewState["dtcont"] != null)
                {
                    dt = (DataTable)ViewState["dtcont"];
                    totalrecord.InnerText = dt.Rows.Count.ToString();
                }
                else
                { totalrecord.InnerText = "0"; }
            }

            if ((lvSupportDoc.FindControl("DataPager1") as DataPager).PageSize < Convert.ToInt16(dt.Rows.Count.ToString()))
            {
                (lvSupportDoc.FindControl("DataPager1") as DataPager).Visible = true;
            }
            else
            {
                (lvSupportDoc.FindControl("DataPager1") as DataPager).Visible = false;
            }
        }

        protected void lvSupportDoc_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            ListViewDataItem commentItem = (ListViewDataItem)e.Item;
            if (e.CommandName == "Delete")
            {
                if (commentItem != null)
                {
                    string contentID = (string)lvSupportDoc.DataKeys[commentItem.DisplayIndex][0].ToString();
                    string strFilePath = (string)lvSupportDoc.DataKeys[commentItem.DisplayIndex][1].ToString();
                    if (!string.IsNullOrEmpty(contentID))
                    {
                        string path = Server.MapPath(strFilePath);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                            try
                            {
                                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                ServiceUrl = "CRM/DeleteMerchantSupportDocument";
                                var crm = new crmEntity()
                                {
                                    doc_id = Convert.ToInt16(contentID.Trim())
                                };
                                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    BindSupportDocument();
                                }
                                else
                                {
                                    adddocmsg.InnerText = response.ReasonPhrase.ToString();
                                    adddocmsg.Style.Add("color", "Red");
                                }
                            }
                            catch (Exception ex)
                            {
                                adddocmsg.InnerText = ex.Message.ToString();
                                return;
                            }
                        }
                        else
                        {
                            try
                            {
                                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                                ServiceUrl = "CRM/DeleteMerchantSupportDocument";
                                var crm = new crmEntity()
                                {
                                    doc_id = Convert.ToInt16(contentID.Trim())
                                };
                                HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
                                if (response.IsSuccessStatusCode)
                                {
                                    BindSupportDocument();
                                }
                                else
                                {
                                    adddocmsg.InnerText = response.ReasonPhrase.ToString();
                                    adddocmsg.Style.Add("color", "Red");
                                }
                            }
                            catch (Exception ex)
                            {
                                adddocmsg.InnerText = ex.Message.ToString();
                                return;
                            }
                        }
                    }
                }
            }
        }

        protected void lvSupportDoc_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }

        public void BindSupportDocument()
        {
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/ListMerchantSupportDocumentDetails";
            string strMerchCode = string.Empty;
            if (Request.QueryString["m_code"].Trim() != "''")
            {
                strMerchCode = Request.QueryString["m_code"].ToString().Trim();
            }

            var crm = new crmEntity()
            {
                merchant_code = strMerchCode.Trim()
            };
            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, crm).Result;
            if (response.IsSuccessStatusCode)
            {
                var ChargeType = response.Content.ReadAsStringAsync().Result;
                var dtChargeType = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ChargeType);
                ViewState["dtcont"] = dtChargeType;
                if (dtChargeType.Rows.Count > 0)
                {
                    lvSupportDoc.DataSource = dtChargeType;
                    lvSupportDoc.DataBind();
                }
                else
                {
                    lvSupportDoc.DataSource = dtChargeType;
                    lvSupportDoc.DataBind();
                }
            }
            else
            {
                adddocmsg.InnerText = response.ReasonPhrase.ToString();
                adddocmsg.Style.Add("color", "Red");
            }

        }

        protected void lvSupportDoc_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvSupportDoc.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindSupportDocument();
        }
        #endregion
    }
}