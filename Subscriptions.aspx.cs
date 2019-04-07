using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace data_manager_v._1
{
    public partial class Subscriptions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void Subscription_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Subscriptions_View.EditIndex = e.NewEditIndex;
            Subscriptions_View.DataBind();
        }

        protected void Subscription_RowCancelEditing(object sender, GridViewCancelEditEventArgs e)
        {
            Subscriptions_View.EditIndex = -1;
            Subscriptions_View.DataBind();
        }

        protected void Subscription_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = Subscriptions_View.DataKeys[e.RowIndex].Value.ToString();
            string body = Globals.GetValue("Reg_Change_Sources", id, "Source_ID", "Source_Full_Name");
            Subscription.Delete();
            Globals.RecordChange("delete", Title, id, "Deleted " + body + " structure");
            Subscriptions_View.DataBind();
        }

        protected void Subscription_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = Subscriptions_View.DataKeys[e.RowIndex].Value.ToString();
            string body = Globals.GetValue("Reg_Change_Sources", id, "Source_ID", "Source_Full_Name");
            Subscription.Update();
            Subscriptions_View.EditIndex = -1;
            Globals.RecordChange("change", Title, id, "Updated " + body + " structure");
            Subscriptions_View.DataBind();
        }

        protected void Subscription_Insert(object source, EventArgs e)
        {
            Subscription.Insert();
            int id = -1;
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT TOP(1) [Source_Id] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_sources") + " ORDER BY [Source_Id] DESC", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                id = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                conn.Dispose();
            }
            Globals.RecordChange("add", Title, id.ToString());
            Subscriptions_View.DataBind();
        }
    }
}