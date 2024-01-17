using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Exchange.WebServices.Data;

namespace Cafeteria.User
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    getUserDetils();
                }
                else if (Session["userId"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int userId = Convert.ToInt32(Request.QueryString["id"]);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

            string verificationCode = GenerateRandomCode();


            try
            {
                ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2013_SP1);
                service.Credentials = new WebCredentials("nkubiashvili", "Datonika1");
                service.TraceEnabled = true;

                // Replace "your-exchange-server" with the URL of your Exchange server
                service.Url = new Uri("https://email.cloud.gov.ge/ews/exchange.asmx");

                // Create the email message
                EmailMessage email = new EmailMessage(service);
                email.Subject = "დადასტურების კოდი";
                email.Body = new MessageBody(BodyType.HTML, $"<p>მადლობა რომ დარეგისტრირდით კაფეტერიაზე.</p> <p>თქვენი ვერიფიკაციის კოდი: {verificationCode}</p>");

                // Add recipient
                email.ToRecipients.Add(txtEmail.Text.Trim());

                // Send the email
                email.Send();

                // Display success message or perform additional actions
                lblMsg.Visible = true;
                lblMsg.Text = "Registration successful. A welcome email has been sent to your email address.";
                lblMsg.CssClass = "alert alert-success";
            }
            catch (Exception ex)
            {
                // Handle email sending failure
                lblMsg.Visible = true;
                lblMsg.Text = "Error sending email: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
                return;
            }




            if (fuUserImage.HasFile)
            {
                if (Utils.IsValidExtension(fuUserImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuUserImage.FileName);
                    imagePath = "Images/User/" + obj.ToString() + fileExtension;
                    fuUserImage.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "გთხოვთ აირჩიოთ სწორი სურათის ფორმატი .jpg, .jpeg or .png";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }

            }
            else
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = userId == 0 ?
                        "რეგისტრაცია წარმატებით გაიარეთ! <b><a href='Login.aspx'>Click here</a></b> to do login" :
                        "დეტალები წარმატებით შეიცვალა! <b><a href='Profile.aspx'>Can check here</a></b>";
                    lblMsg.Visible = true;
                    lblMsg.Text = "<b> " + txtUsername.Text.Trim() + "</b>" + actionName;
                    lblMsg.CssClass = "alert alert-success";
                    if (userId != 0)
                    {
                        Response.AddHeader("REFRESH", "1;URL=Profile.aspx");
                    }
                    clear();
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "<b> " + txtEmail.Text.Trim() + "<b> ასეთი მეილი უკვე არსებობს, სცადეთ სხვა!";
                        lblMsg.CssClass = "alert alert-danger";
                        return;
                    }
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "<b> " + txtUsername.Text.Trim() + "<b> ასეთი მეტსახელით უკვე არსებობს, სცადეთ სხვა!";
                        lblMsg.CssClass = "alert alert-danger";
                    }

                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }

            Session["VerificationCode"] = verificationCode;

            // Display a popup window for code verification
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "ShowPopup();", true);
        }

        private string GenerateRandomCode()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        public static bool VerifyCode(string enteredCode)
        {
            // Retrieve the stored verification code from a secure location (e.g., session variable)
            string storedCode = HttpContext.Current.Session["VerificationCode"] as string;

            // Compare the entered code with the stored code
            return (enteredCode == storedCode);
        }

        void getUserDetils()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Request.QueryString["id"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count == 1)
            {
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtUsername.Text = dt.Rows[0]["Username"].ToString();
                txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                imgUser.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString())
                    ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgUser.Height = 200;
                imgUser.Width = 200;
                txtPassword.TextMode = TextBoxMode.SingleLine;
                txtPassword.ReadOnly = true;
                txtPassword.Text = dt.Rows[0]["Password"].ToString();
            }
            lblHeaderMsg.Text = "<h2>Edit Profile</h2>";
            btnRegister.Text = "განახლება";
            lblAlreadyUser.Text = "";
        }

        private void clear()
        {
            txtName.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
        }
    }
}