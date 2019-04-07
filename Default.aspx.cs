using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace data_manager_v._1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                reg_daily.InnerText = string.Format("{0:n0}", GetCount("SELECT COUNT([Reg_Change_Content].File_Name) FROM [Reg_Change_Content] INNER JOIN [Reg_Change_Extract_Tracker] ON [Reg_Change_Extract_Tracker].File_name=[Reg_Change_Content].File_Name WHERE [Reg_Change_Extract_Tracker].Start_Time <= " + DateTime.Today.Day));
                reg_monthly.InnerText = string.Format("{0:n0}", GetCount("SELECT COUNT([Reg_Change_Content].File_Name) FROM [Reg_Change_Content] INNER JOIN [Reg_Change_Extract_Tracker] ON [Reg_Change_Extract_Tracker].File_name=[Reg_Change_Content].File_Name WHERE DATEPART(month, [Reg_Change_Extract_Tracker].Start_Time)=" + DateTime.Today.Month));
                pending_tasks.InnerText = string.Format("{0:n0}", Directory.GetFiles("C:/Users/Rebecca Ramnauth/source/repos/data_manager/data_manager/error_reports").Length);
            }
        }

        private DataTable GetRegulations(string query)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand(query, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var regulations = new DataTable();
                adapter.Fill(regulations);
                return regulations;
            }
        }

        private int GetCount(string query)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();
                return count;
            }
        }
    }
}