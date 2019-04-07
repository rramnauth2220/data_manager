using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

namespace data_manager_v._1.Components.Data_Manager
{
    public partial class Properties : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] filePaths = Directory.GetFiles(ConfigurationManager.AppSettings.Get("data_mgnr_source"), "*.config");
                List<ListItem> files = new List<ListItem>();
                foreach (string filePath in filePaths) { files.Add(new ListItem(Path.GetFileNameWithoutExtension(filePath), filePath)); }
                Config_View.DataSource = files;
                Config_View.DataBind();
            }
        }

        protected void UploadFile(object sender, EventArgs e)
        {
            string fileName = Path.GetFileName(Config_Browse.PostedFile.FileName);
            if (Path.GetExtension(fileName).Contains("config"))
            {
                /* replace */ if (File.Exists(ConfigurationManager.AppSettings.Get("data_mgnr_source") + fileName)) { Globals.RecordChange("replace", Title, "", "Replaced " + fileName); }
                /* insert  */ else { Globals.RecordChange("add", Title, "", "Added " + fileName); }
                message.InnerHtml = "";
                Config_Browse.PostedFile.SaveAs("C:/Users/Rebecca Ramnauth/source/repos/data_manager/data_manager/" + fileName);
                Response.Redirect(Request.Url.AbsoluteUri);
            } else { /* invalid type */ message.InnerHtml = "<i class='fas fa-exclamation-triangle'></i> &nbsp; File has not uploaded. Upload a configuration (<code>*.config</code>) file."; }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            string filePath = (sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }

        protected void DeleteFile(object sender, EventArgs e)
        {
            string filePath = (sender as LinkButton).CommandArgument;
            Globals.RecordChange("delete", Title, "", "Deleted " + Path.GetFileName(filePath));
            File.Delete(filePath);
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ReadFile(object sender, EventArgs e)
        {
            Div_Error.Visible = false;
            string filePath = (sender as LinkButton).CommandArgument;
            try
            {
                string[] lines = null;
                string content = "";
                if (File.Exists(filePath))
                {
                    lines = File.ReadAllLines(filePath);
                }
                foreach (string line in lines)
                {
                    content += line + "\n";
                }
                Div_Source.InnerText = content.ToString();
            }
            catch (Exception ex)
            {
                Div_Error.Visible = true;
                Div_Error.InnerText = "Request to display " + filePath + " has been denied. \n Data in the request is potentially dangerous because it includes HTML markup or script.";
                Div_Error.InnerText = "\n " + ex.ToString();
            }
        }
    }
}