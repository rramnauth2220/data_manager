using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;

namespace data_manager_v._1.Components.Archer
{
    public class Images1 : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string imgName = context.Request.QueryString["FileName"];
                string filePath = ConfigurationManager.AppSettings.Get("archer_images") + imgName;
                string contenttype = "image/" + Path.GetExtension(context.Request.QueryString["FileName"].Replace(".", "")); ;
                Image image = Image.FromFile(filePath);
                image.Save(context.Response.OutputStream, image.RawFormat);
                image.Dispose();
            } catch (Exception e) { }
        }

        public bool IsReusable { get { return false; } }
    }
}