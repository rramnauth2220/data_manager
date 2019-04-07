using OfficeOpenXml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace data_manager_v._1
{
    public partial class Jobs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Type_Filter"] = "ALL";
                ViewState["Start_Filter"] = DateTime.Today.AddYears(-100);
                ViewState["End_Filter"] = DateTime.Today;
                BindGrid();

                subscription_bars.InnerHtml = ConvertDataToBars(GetJobs("SELECT [Job_Type], COUNT(Job_Type) AS CT FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_jobs") + " GROUP BY [Job_Type] ORDER BY CT DESC"));

                string exceptions_list = ConvertDataToList(GetJobs("SELECT [Job_Id], [Job_Type] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_jobs") + " WHERE [End_Time] IS NULL"));
                exceptions.InnerHtml = (exceptions_list == "") ? "All jobs were sucessfully completed! No exceptions found..." : exceptions_list;
            }
        }

        public DataTable GetJobs(string query)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand(query, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var jobs = new DataTable();
                adapter.Fill(jobs);
                return jobs;
            }
        }

        private DataTable GetGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetJobsByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Type_Filter", ViewState["Type_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Start_Filter", ViewState["Start_Filter"]);
                cmd.Parameters.AddWithValue("@End_Filter", ViewState["End_Filter"]);

                adapter.SelectCommand = cmd;
                adapter.Fill(grid);

                return grid;
            }
        }
        
        private void BindGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetJobsByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Type_Filter", ViewState["Type_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Start_Filter", ViewState["Start_Filter"]);
                cmd.Parameters.AddWithValue("@End_Filter", ViewState["End_Filter"]);

                adapter.SelectCommand = cmd;
                adapter.Fill(grid);
                Job_View.DataSource = grid;
                Job_View.DataBind();

                DropDownList type = (DropDownList)Job_View.HeaderRow.FindControl("Job_Type_Filter");
                this.BindTypeList(type);

                row_count.InnerText = Globals.ShowCount(Job_View, GetGrid().Rows.Count);
            }
        }

        private void BindTypeList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Job_Type] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_jobs"), conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Job_Type";
                action.DataValueField = "Job_Type";
                action.DataBind();
                action.Items.FindByValue(ViewState["Type_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        protected void Job_Type_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList type = (DropDownList)sender;
            ViewState["Type_Filter"] = type.SelectedValue;
            this.BindGrid();
        }

        protected void Job_Start_Filter_Changed(object sender, EventArgs e)
        {
            TextBox start = (TextBox)sender;
            ViewState["Start_Filter"] = start.Text;
            this.BindGrid();
        }

        protected void Job_End_Filter_Changed(object sender, EventArgs e)
        {
            TextBox end = (TextBox)sender;
            ViewState["End_Filter"] = end.Text;
            this.BindGrid();
        }

        protected void Job_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Job_View.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        public static string ConvertDataToBars(DataTable dt)
        {
            string html = "";
            if (dt.Columns.Count == 2)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string title = "<h4 class='small font-weight - bold'>" + dt.Rows[i][0].ToString() +
                        "<span class='float-right'>" + Convert.ToInt32(dt.Rows[i][1]) + "</span></h4>";
                    string value = "<div class='progress mb-4'><div class='progress-bar' role='progressbar' style='width:"
                        + (Convert.ToInt32(dt.Rows[i][1]) * 100.0) / Convert.ToInt32(dt.Rows[0][1]) + "%' aria-valuenow='"
                        + dt.Rows[i][1] + "' aria-valuemin='0'"
                        + "aria-valuemax='" + dt.Rows[0][1] + "'></div></div>";
                    html += title + value;
                }
            }
            return html;
        }

        protected string ConvertDataToList(DataTable dt)
        {
            string html = "";
            if (dt.Columns.Count == 2 && dt.Rows.Count > 0)
            {
                html += "<ul>";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    html += "<li class='small text-gray-500'>" + dt.Rows[i][0] + "</li>";
                }
                html += "</ul>";
            }
            return html;
        }

        protected void Job_Export(object sender, EventArgs e)
        {
            var jobs = GetGrid();
            ExcelPackage excel = new ExcelPackage();
            var worksheet = excel.Workbook.Worksheets.Add("Jobs");
            var totalCols = jobs.Columns.Count;
            var totalRows = jobs.Rows.Count;
            for (var col = 1; col <= totalCols; col++)
            {
                worksheet.Cells[1, col].Value = jobs.Columns[col - 1].ColumnName;
            }
            for (var row = 1; row <= totalRows; row++)
            {
                for (var col = 0; col < totalCols; col++)
                {
                    worksheet.Cells[row + 1, col + 1].Value = jobs.Rows[row - 1][col].ToString();
                }
            }
            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=jobs_" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx");
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }
    }
}