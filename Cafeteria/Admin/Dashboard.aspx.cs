using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cafeteria.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = " ";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    DashboardCount dashboard = new DashboardCount();
                    Session["category"] = dashboard.count("CATEGORY");
                    Session["product"] = dashboard.count("PRODUCT");
                    Session["order"] = dashboard.count("ORDER");
                    Session["delivered"] = dashboard.count("DELIVERED");
                    Session["pending"] = dashboard.count("PENDING");
                    Session["notPayed"] = dashboard.count("NOTPAYED");
                    Session["user"] = dashboard.count("USER");
                    Session["soldAmount"] = dashboard.count("SOLDAMOUNT");
                    Session["contact"] = dashboard.count("CONTACT");
                }
            }
        }
    }
}