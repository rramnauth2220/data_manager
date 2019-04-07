using OfficeOpenXml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace data_manager_v._1.Components.Data_Manager
{
    public partial class History : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Username_Filter"] = "ALL";
                ViewState["Action_Filter"] = "ALL";
                ViewState["View_Filter"] = "ALL";
                BindGrid();
            }
        }

        public DataTable GetGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetHistoryByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", ViewState["Username_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Action", ViewState["Action_Filter"].ToString());
                cmd.Parameters.AddWithValue("@View", ViewState["View_Filter"].ToString());

                adapter.SelectCommand = cmd;
                adapter.Fill(grid);

                return grid;
            }
        }

        private void BindGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetHistoryByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", ViewState["Username_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Action", ViewState["Action_Filter"].ToString());
                cmd.Parameters.AddWithValue("@View", ViewState["View_Filter"].ToString());
                
                adapter.SelectCommand = cmd;
                adapter.Fill(grid);
                History_View.DataSource = grid;
                History_View.DataBind();

                DropDownList username = (DropDownList)History_View.HeaderRow.FindControl("History_Username_Filter");
                this.BindUserList(username);

                DropDownList action = (DropDownList)History_View.HeaderRow.FindControl("History_Action_Filter");
                this.BindActionList(action);

                DropDownList view = (DropDownList)History_View.HeaderRow.FindControl("History_View_Filter");
                this.BindViewList(view);

                row_count.InnerText = Globals.ShowCount(History_View, GetGrid().Rows.Count);
            }
        }

        private void BindUserList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Username] FROM [Manager_Change_Tracking]", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Username";
                action.DataValueField = "Username";
                action.DataBind();
                action.Items.FindByValue(ViewState["Username_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        private void BindActionList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Action] FROM [Manager_Change_Tracking]", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Action";
                action.DataValueField = "Action";
                action.DataBind();
                action.Items.FindByValue(ViewState["Action_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        private void BindViewList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [View] FROM [Manager_Change_Tracking]", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "View";
                action.DataValueField = "View";
                action.DataBind();
                action.Items.FindByValue(ViewState["View_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        protected void History_Username_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList user = (DropDownList)sender;
            ViewState["Username_Filter"] = user.SelectedValue;
            this.BindGrid();
        }

        protected void History_Action_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList action = (DropDownList)sender;
            ViewState["Action_Filter"] = action.SelectedValue;
            this.BindGrid();
        }

        protected void History_View_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList view = (DropDownList)sender;
            ViewState["View_Filter"] = view.SelectedValue;
            this.BindGrid();
        }

        protected void History_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            History_View.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        protected void History_Export(object sender, EventArgs e)
        {
            var changes = GetGrid();
            ExcelPackage excel = new ExcelPackage();
            var worksheet = excel.Workbook.Worksheets.Add("History");
            var totalCols = changes.Columns.Count;
            var totalRows = changes.Rows.Count;
            for (var col = 1; col <= totalCols; col++)
            {
                worksheet.Cells[1, col].Value = changes.Columns[col - 1].ColumnName;
            }
            for (var row = 1; row <= totalRows; row++)
            {
                for (var col = 0; col < totalCols; col++)
                {
                    worksheet.Cells[row + 1, col + 1].Value = changes.Rows[row - 1][col].ToString();
                }
            }
            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=changes_" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx");
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }
    }
}