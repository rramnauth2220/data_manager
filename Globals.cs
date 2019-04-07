using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

public class Globals
{
    public static readonly string root = Directory.GetCurrentDirectory();
    public static bool authenticated = false;
    public static readonly List<string> allowed_image_types = new List<string> { ".svg", ".png", ".jpeg", ".jpg", ".ico", ".gif" };
    public static readonly List<string> allowed_source_types = new List<string> { ".cs", ".xml", ".config", ".sln", ".csproj" };


    public static void RecordChange(string action, string view, string content_id ="", string description="")
    {
        using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
        using (var cmd = new SqlCommand("RecordChange", conn))
        {
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Username", HttpContext.Current.User.Identity.Name.ToString());
            cmd.Parameters.AddWithValue("@Action", action);
            cmd.Parameters.AddWithValue("@View", view);
            cmd.Parameters.AddWithValue("@Content_Id", content_id);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.ExecuteNonQuery();
            conn.Close();
            conn.Dispose();
        }
    }

    public static void RecordUser()
    {
        if (!authenticated)
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("RecordUser", conn))
            {
                conn.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", HttpContext.Current.User.Identity.Name.ToString());
                cmd.ExecuteNonQuery();
                conn.Close();
                conn.Dispose();
            }
            authenticated = true;
        }
    }

    public static int GetCount(string table)
    {
        using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
        using (var cmd = new SqlCommand("SELECT COUNT(*) FROM " + table, conn))
        {
            conn.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            conn.Close();
            conn.Dispose();
            return count;
        }
    }

    public static string GetValue(string table, string id, string id_column, string value_column)
    {
        try
        {
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegulationContent"].ConnectionString))
            using (var cmd = new SqlCommand("SELECT " + value_column + " FROM " + table + " WHERE " + id_column + "=@id", conn))
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@id", id);
                string value = cmd.ExecuteScalar().ToString();
                conn.Close();
                conn.Dispose();
                return value;
            }
        } catch (Exception e) { return ""; }
    }

    public static string BytesToString(long byteCount)
    {
        string[] suf = { "B", "KB", "MB", "GB", "TB", "PB", "EB" };
        if (byteCount == 0) return "0" + suf[0];
        long bytes = Math.Abs(byteCount);
        int place = Convert.ToInt32(Math.Floor(Math.Log(bytes, 1024)));
        double num = Math.Round(bytes / Math.Pow(1024, place), 1);
        return (Math.Sign(byteCount) * num).ToString() + " " + suf[place];
    }

    public static string ShowCount(GridView view, int count)
    {
        int total_records = count;
        int end_records = view.PageSize * (view.PageIndex + 1);
        int start_record = end_records - view.PageSize + 1;
        if (end_records > total_records)
            end_records = total_records;
        if (total_records == 0) start_record = 0;
        if (end_records == 0) end_records = total_records;
        return "Showing records " + start_record + " to " + end_records.ToString() + " of " + total_records.ToString();
        //row_count.InnerText = "Showing records " + start_record + " to " + end_records.ToString() + " of " + total_records.ToString();
    }
}