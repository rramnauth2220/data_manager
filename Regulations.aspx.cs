using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;

namespace data_manager_v._1
{
    public partial class Regulations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["Action_Filter"] = "ALL";
                ViewState["Body_Filter"] = "ALL";
                ViewState["Jurisdiction_Filter"] = "ALL";
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetRegulationsByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Body_Filter", ViewState["Body_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Action_Filter", ViewState["Action_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Jurisdiction_Filter", ViewState["Jurisdiction_Filter"].ToString());

                adapter.SelectCommand = cmd;
                adapter.Fill(grid);
                Regulation_View.DataSource = grid;
                Regulation_View.DataBind();

                DropDownList jurisdiction = (DropDownList)Regulation_View.HeaderRow.FindControl("Regulation_Jurisdiction_Filter");
                this.BindJurisdictionList(jurisdiction);

                DropDownList action = (DropDownList)Regulation_View.HeaderRow.FindControl("Regulation_Action_Filter");
                this.BindActionList(action);

                DropDownList body = (DropDownList)Regulation_View.HeaderRow.FindControl("Regulation_Body_Filter");
                this.BindBodyList(body);

                row_count.InnerText = Globals.ShowCount(Regulation_View, GetGrid().Rows.Count);
            }
        }

        private DataTable GetGrid()
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("GetRegulationsByFilters", conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var grid = new DataTable();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Body_Filter", ViewState["Body_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Action_Filter", ViewState["Action_Filter"].ToString());
                cmd.Parameters.AddWithValue("@Jurisdiction_Filter", ViewState["Jurisdiction_Filter"].ToString());

                adapter.SelectCommand = cmd;
                adapter.Fill(grid);

                return grid;
            }
        }

        private void BindJurisdictionList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Reg_Jurisdiction] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_regs"), conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Reg_Jurisdiction";
                action.DataValueField = "Reg_Jurisdiction";
                action.DataBind();
                action.Items.FindByValue(ViewState["Jurisdiction_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        private void BindActionList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Content_Action] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_regs"), conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Content_Action";
                action.DataValueField = "Content_Action";
                action.DataBind();
                action.Items.FindByValue(ViewState["Action_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        private void BindBodyList(DropDownList action)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT DISTINCT [Reg_Body] FROM " + ConfigurationManager.AppSettings.Get("lexis_parser_regs"), conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                conn.Open();
                action.DataSource = cmd.ExecuteReader();
                action.DataTextField = "Reg_Body";
                action.DataValueField = "Reg_Body";
                action.DataBind();
                action.Items.FindByValue(ViewState["Body_Filter"].ToString()).Selected = true;
                conn.Close();
                conn.Dispose();
            }
        }

        protected void Date_Start_Filter_Changed(object sender, EventArgs e)
        {
            TextBox cal = (TextBox)sender;
            ViewState["Date_Start_Filter"] = cal.Text;
            this.BindGrid();
        }

        protected void Date_End_Filter_Changed(object sender, EventArgs e)
        {
            TextBox cal = (TextBox)sender;
            ViewState["Date_End_Filter"] = cal.Text;
            this.BindGrid();
        }

        protected void Regulatory_Body_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList body = (DropDownList)sender;
            ViewState["Body_Filter"] = body.SelectedValue;
            this.BindGrid();
        }

        protected void Regulatory_Action_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList action = (DropDownList)sender;
            ViewState["Action_Filter"] = action.SelectedValue;
            this.BindGrid();
        }

        protected void Regulatory_Jurisdiction_Filter_Changed(object sender, EventArgs e)
        {
            DropDownList jurisdiction = (DropDownList)sender;
            ViewState["Jurisdiction_Filter"] = jurisdiction.SelectedValue;
            this.BindGrid();
        }

        protected void Regulation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Regulation_View.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        protected void Regulation_Export(object sender, EventArgs e)
        {
            var regulations = GetGrid();
            ExcelPackage excel = new ExcelPackage();
            var worksheet = excel.Workbook.Worksheets.Add("Regulations");
            var totalCols = regulations.Columns.Count;
            var totalRows = regulations.Rows.Count;
            for (var col = 1; col <= totalCols; col++)
            {
                worksheet.Cells[1, col].Value = regulations.Columns[col - 1].ColumnName;
            }
            for (var row = 1; row <= totalRows; row++)
            {
                for (var col = 0; col < totalCols; col++)
                {
                    worksheet.Cells[row + 1, col + 1].Value = regulations.Rows[row - 1][col].ToString();
                }
            }
            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=regulations_" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx");
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }
    }
}