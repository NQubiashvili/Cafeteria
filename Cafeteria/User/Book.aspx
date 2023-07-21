<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="Cafeteria.User.Book" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- book section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <h2>Book A Table
                </h2>
                <script>
                    function displaySuccessMessage() {
                        // Show success message
                        var successMessage = document.getElementById("successMessage");
                        successMessage.style.display = "block";

                        // Redirect to default.aspx after 5 seconds
                        setTimeout(function () {
                            window.location.href = "default.aspx";
                        }, 5000);
                    }
                </script>

                <script>
                    function displaySuccessMessage() {
                        // Check if all required fields are filled
                        var personName = document.getElementsByName('personName')[0].value;
                        var reservationTime = document.getElementById('reservationTime').value;
                        var personCount = document.getElementsByName('personCount')[0].value;
                        var reservationDate = document.getElementById('reservationDate').value;

                        if (personName && reservationTime && personCount && reservationDate) {
                            // All fields are filled, show success message
                            document.getElementById('successMessage').style.display = 'block';
                        }
                    }
                </script>

            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <form action="" onsubmit="return displaySuccessMessage()">
                            <div>
                                <input type="text" name="personName" class="form-control" placeholder="Your Name" />
                            </div>
                            <div>
                                <select id="reservationTime" name="reservationTime" class="form-control" required>
                                    <option value="">Select a time</option>
                                    <% for (int hour = 10; hour <= 22; hour++)
                                        { %>
                                    <% for (int minute = 0; minute < 60; minute += 30)
                                        { %>
                                    <% string fromTime = $"{hour:00}:{minute:00}";
                                        string toTime = $"{(hour + (minute + 30) / 60):00}:{(minute + 30) % 60:00}"; %>
                                    <option value="<%= fromTime %>">From <%= fromTime %> To <%= toTime %></option>
                                    <% } %>
                                    <% } %>
                                </select>

                            </div>
                            <div>
                                <select class="form-control ">
                                    <option value="" name="personCount" disabled selected>How many persons?
                                    </option>
                                    <option value="">2
                                    </option>
                                    <option value="">3
                                    </option>
                                    <option value="">4
                                    </option>
                                    <option value="">5
                                    </option>
                                </select>
                            </div>
                            <div>
                                <input type="date" id="reservationDate" class="form-control" name="reservationDate" /><br />
                            </div>
                            <div class="btn_box">
                                <button type="submit" onclick="displaySuccessMessage()" >Book Now</button>
                            </div>
                            <div id="successMessage" style="display: none;">
                                <p>Reservation successful!</p>
                            </div>
                            <script>
                                // Get the current date
                                var currentDate = new Date();

                                // Format the date as YYYY-MM-DD
                                var year = currentDate.getFullYear();
                                var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
                                var day = currentDate.getDate().toString().padStart(2, '0');
                                var formattedDate = year + '-' + month + '-' + day;

                                // Set the default value of the input field
                                document.getElementById('reservationDate').value = formattedDate;
                            </script>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end book section -->
</asp:Content>
