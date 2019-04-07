using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;

namespace data_manager_v._1.Components.Archer
{
    public partial class Images : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] filePaths = Directory.GetFiles(ConfigurationManager.AppSettings.Get("archer_images")).Where(x => Globals.allowed_image_types.Any(t => x.Contains(t))).ToArray();
                List<ListItem> files = new List<ListItem>();
                foreach (string filePath in filePaths) { files.Add(new ListItem(Path.GetFileNameWithoutExtension(filePath), filePath)); }
                Images_View.DataSource = files;
                Images_View.DataBind();
            }
        }

        protected void UploadFile(object sender, EventArgs e)
        {
            string fileName = Path.GetFileName(Images_Browse.PostedFile.FileName);
            if (Globals.allowed_image_types.Contains(Path.GetExtension(fileName).ToLower()))
            {
                /* replace */ if (File.Exists(ConfigurationManager.AppSettings.Get("archer_images") + fileName)) { Globals.RecordChange("replace", Title, "", "Replaced " + fileName); }
                /* insert  */ else { Globals.RecordChange("add", Title, "", "Added " + fileName); }
                message.InnerHtml = "";
                Images_Browse.PostedFile.SaveAs(ConfigurationManager.AppSettings.Get("archer_images") + fileName);
                Response.Redirect(Request.Url.AbsoluteUri);
            }
            else { /* invalid type */
                message.InnerHtml = "<i class='fas fa-exclamation-triangle'></i> " + 
                    "&nbsp; File did not upload. Upload a file with one of the following extensions: <code> " 
                    + string.Join(",", Globals.allowed_image_types.ToArray()) + " </code>";
            }
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
            System.Drawing.Image image = System.Drawing.Image.FromFile(filePath);
            image.Dispose();
            File.Delete(filePath);
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ReadFile(object sender, EventArgs e)
        {
            Div_Content.Visible = false;
            string filePath = (sender as LinkButton).CommandArgument;
            Image1.ImageUrl = "Images.ashx?FileName=" + Path.GetFileName(filePath);
        }
    }
}