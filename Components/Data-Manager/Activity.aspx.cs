using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace data_manager_v._1.Components.Data_Manager
{
    public partial class Activity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.Activity1.SelectParameters.Clear();
                this.Activity1.SelectParameters.Add("Username", System.Data.DbType.String, HttpContext.Current.User.Identity.Name);
                row_count.InnerText = Globals.ShowCount(Activity_View, GetCount());
            }
        }

        public int GetCount()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT COUNT(*) FROM " 
                + ConfigurationManager.AppSettings.Get("data_mgnr_history") 
                + " WHERE [Username]=@Username", conn))
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@Username", HttpContext.Current.User.Identity.Name);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                conn.Dispose();
                return count;
            }
        }

        protected void Activity_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Activity_View.PageIndex = e.NewPageIndex;
            row_count.InnerText = Globals.ShowCount(Activity_View, GetCount());
        }

        protected void Activity_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Activity_View.EditIndex = e.NewEditIndex;
            Activity_View.DataBind();
        }

        protected void Activity_RowCancelEditing(object sender, GridViewCancelEditEventArgs e)
        {
            Activity_View.EditIndex = -1;
            Activity_View.DataBind();
        }

        protected void Activity_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int gridview_rows = Activity_View.Rows.Count;
            string id = Activity_View.DataKeys[e.RowIndex].Value.ToString();
            Activity1.Update();
            Activity_View.EditIndex = -1;
            Globals.RecordChange("change", Title, id, "Updated change description");
            Activity_View.DataBind();
        }
    }
}