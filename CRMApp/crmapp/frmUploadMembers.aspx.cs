using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRMApp.crmapp
{
    public partial class frmUploadMembers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_ServerClick(object sender, EventArgs e)
        {
            if (FU_MemberData.HasFile)
            {
                //Copy Files to Upload Folder
                string ConnectionString = string.Empty, path = string.Empty, filename = string.Empty, fileExtension = string.Empty, NewFileName = string.Empty;
                //filename = FU_MemberData.PostedFile.FileName.ToString();
                fileExtension = System.IO.Path.GetExtension(FU_MemberData.FileName).ToLower();
                NewFileName = DateTime.Now.ToString("ddMMyyyyhhmmss") + "_" + filename;

                //path = Server.MapPath("../ExcelMigration/" + NewFileName);
                string strfilename = Path.GetFileName(FU_MemberData.FileName);
                FU_MemberData.SaveAs(Server.MapPath("~//") + strfilename);

                //FU_MemberData.SaveAs(path);
                if (fileExtension == ".xls")
                {
                    ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Jet OLEDB:Database Password=sesson;Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                }
                else if (fileExtension == ".xlsx")
                {
                    ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Jet OLEDB:Database Password=season;Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=1\"";
                }
                OleDbConnection OledbCn = new OleDbConnection(ConnectionString);
                try
                {
                    #region Registraion Of Police User
                    OledbCn.Open();
                    OleDbDataAdapter da = new OleDbDataAdapter("SELECT * FROM [Sheet1$]", ConnectionString);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "CRMData");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        loading.Visible = true;
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            string UserName = ds.Tables[0].Rows[i]["UserName"].ToString().Trim();
                            string Password = ds.Tables[0].Rows[i]["Password"].ToString().Trim();
                            string Email = ds.Tables[0].Rows[i]["roleid"].ToString().Trim();
                            string email = ds.Tables[0].Rows[i]["email"].ToString().Trim();
                            //bool saveRecords = registerUserData(Name, icno, policeno);
                        }
                        bool saveFile = SaveFileInfo(NewFileName);
                        //BindFileList();
                        #endregion
                        OledbCn.Close();
                        OledbCn.Dispose();
                    }
                    loading.Visible = false;
                }
                catch (Exception ex)
                {
                    WriteToFile(ex.Message.ToString());
                    return;
                }
            }
        }

        public bool SaveFileInfo(string filePath)
        {
            bool flag = true;
            try
            {
                SqlConnection SqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["CRMConnectionString"].ConnectionString);
                SqlDataAdapter SqlDa = new SqlDataAdapter("usp_crm_saveFilePathDetails", SqlCon);
                SqlCon.Open();
                SqlCommand SqlCmd = new SqlCommand();

                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "usp_crm_saveFilePathDetails";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlCmd.Parameters.Add(new SqlParameter("@pfile_path", SqlDbType.VarChar, 50));
                SqlCmd.Parameters["@pfile_path"].Value = filePath;
                SqlCmd.Parameters.Add(new SqlParameter("@puser_name", SqlDbType.VarChar, 50));
                SqlCmd.Parameters["@puser_name"].Value = Session["username"].ToString().Trim();

                SqlCmd.ExecuteNonQuery();
                SqlCon.Close();
            }
            catch (Exception ex)
            {
                WriteToFile(ex.Message.ToString());
                //return;
                //ex.ToString();
                flag = false;
            }
            return flag;
        }

        private void WriteToFile(string text)
        {
            string filePath = Server.MapPath(ConfigurationManager.AppSettings["UploadErrorLogFileName"].ToString());
            if (!File.Exists(filePath))
            {
                using (var stream = File.Create(filePath)) { }
            }
            using (StreamWriter writer = new StreamWriter(filePath, true))
            {
                writer.WriteLine(Environment.NewLine);
                writer.WriteLine("************Exception Details on " + " " + DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt") + "****************");
                writer.WriteLine(text);
                writer.WriteLine("--------------------------------*End*------------------------------------------");
                writer.Flush();
                writer.Close();
            }
        }

        protected void LVMembersFileList_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void LVMembersFileList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

        }
    }
}