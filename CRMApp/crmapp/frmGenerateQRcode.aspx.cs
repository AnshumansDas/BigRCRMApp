using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QRCoder;
using System.Drawing;
using System.IO;

namespace CRMApp.crmapp
{
    public partial class frmGenerateQRcode : System.Web.UI.Page
    {
        string strUserID, strMerchantID, strBranchID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            }
        }

        protected void btnGenerateQrCode_Click(object sender, EventArgs e)
        {
            if (Session["user_id"] != null)
            { strUserID = Session["user_id"].ToString().Trim(); }
            if (Session["merchID"] != null)
            { strMerchantID = Session["merchID"].ToString().Trim(); }
            if (Session["branchID"] != null)
            { strBranchID = Session["branchID"].ToString().Trim(); }

            string code = strBranchID + "_" + strMerchantID + "_" + strUserID;
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCode qrCode = new QRCode(qrGenerator.CreateQrCode(code, QRCodeGenerator.ECCLevel.Q));
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 350;
            imgBarCode.Width = 350;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();
                    imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
                phQrcode.Controls.Add(imgBarCode);
            }
        }
    }
}