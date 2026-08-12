using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmFeedbackEdit : System.Web.UI.Page
    {
        #region GLobal Declaration
        HttpClient client = new HttpClient();
        string StrBaseURL = ConfigurationManager.AppSettings["BaseURL"].ToString(), ServiceUrl = string.Empty;
        #endregion

        #region Control_Events
        protected void Page_Load(object sender, EventArgs e)
        {
            client.BaseAddress = new Uri(StrBaseURL);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!Page.IsPostBack)
            {
                BindFeedbackList();
            }
        }

        

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmFeedback.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string strUname = string.Empty, readAdminFile = string.Empty, readUserFile = string.Empty, myStringAdmin = string.Empty,
                myStringUser = string.Empty;
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            ServiceUrl = "CRM/EditFeedback";
            if (Session["username"] != null)
            {
                strUname = Session["username"].ToString();
            }
            else
            {
                strUname = Session["userid"].ToString();
            }
            var FBEntity = new crmEntity()
            {
                ID = Convert.ToInt16(Request.QueryString["id"]),
                reply_msg = txtReplyMessage.Text,
                reply_by = strUname,
                reply_status = 1,
                update_by = strUname
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                string strpagename = "FrmFeedback.aspx";
                ScriptManager.RegisterStartupScript(upFeedbackList, upFeedbackList.GetType(), "Pop", "SuccessFBMsg('" + strpagename + "');", true);

            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }
        #endregion

        #region UserDefined_Methods
        public void BindFeedbackList()
        {
            int FBid = 0;
            ServiceUrl = "CRM/GetFeedbackList";
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                FBid = Convert.ToInt16(Request.QueryString["id"]);
            }
            var FBEditEntity = new crmEntity()
            {
                ID = FBid
            };

            HttpResponseMessage response = client.PostAsJsonAsync(ServiceUrl, FBEditEntity).Result;
            if (response.IsSuccessStatusCode)
            {
                var ResResult = response.Content.ReadAsStringAsync().Result;
                var dtContent = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(ResResult);
                ViewState["dtcont"] = dtContent;
                if (dtContent.Rows.Count > 0)
                {
                    lblName.Text = dtContent.Rows[0]["name"].ToString();
                    lblEmail.Text = dtContent.Rows[0]["email"].ToString();
                    lblSubject.Text = dtContent.Rows[0]["subject"].ToString();
                    txtMessage.Text = dtContent.Rows[0]["message"].ToString();
                    txtReplyMessage.Text = dtContent.Rows[0]["reply_msg"].ToString();
                }
                else
                {
                    dtContent = null;
                }
            }
            else
            {
                message.InnerText = response.ReasonPhrase.ToString();
                message.Style.Add("color", "Red");
            }
        }

        #endregion
    }

}