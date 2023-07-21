using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace Cafeteria.User
{

    public partial class Book : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }

            if (IsPostBack)
            {

                int personCount = Convert.ToInt32(Request.Form["personCount"]);
                string reservationTime = Request.Form["reservationTime"];
                string personName = Request.Form["personName"];

                TimeSpan parsedReservationTime;
                bool isTimeValid = TimeSpan.TryParseExact(reservationTime, "hh\\:mm", CultureInfo.InvariantCulture, out parsedReservationTime);


                if (isTimeValid)
                {
                    using (SqlConnection con = new SqlConnection(Connection.GetConnectionString()))
                    {
                        using (SqlCommand cmd = new SqlCommand("InsertReservation", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PersonCount", personCount);
                            cmd.Parameters.AddWithValue("@ReservationTime", parsedReservationTime);
                            cmd.Parameters.AddWithValue("@PersonName", personName);

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

            }
        }


    }
}

