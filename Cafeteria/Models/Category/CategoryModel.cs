using Cafeteria.Admin;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI.WebControls;

namespace Cafeteria.Models.Category
{
    public class CategoryModel : GetConnection 
    {
         protected static string Model ="Cart_Crud";
         protected static string Actio = "SELECT";
  /*      protected int CategoryId;
        protected string Name;
        protected string ImageUrl;
        protected bool IsActive;
        protected DateTime CreatedDate;*/
 





        public static void GetConnectionDB()
        {
            GetConnectionDB(Model,Actio);
      



        }

    }
}