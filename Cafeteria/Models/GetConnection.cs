using Cafeteria.Admin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI.WebControls;


namespace Cafeteria.Models
{
    public class GetConnection
    {
        protected static SqlConnection con;
        protected static SqlCommand cmd;
        protected static SqlDataAdapter sda;
        protected static DataTable dt;
        protected static Repeater Data;

        public static void GetConnectionDB(string List, string Action)
        {
          
            
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand(List, con);
                cmd.Parameters.AddWithValue("@Action", Action);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

            Data.DataSource = dt;
            Data.DataBind();
            
               
                
           
            
        }
    }
}