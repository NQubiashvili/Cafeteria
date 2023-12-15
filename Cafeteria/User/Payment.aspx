<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Cafeteria.User.Payment" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .rounded {
            border-radius: 1rem
        }

        .nav-pills .nav-link {
            color: #555
        }

            .nav-pills .nav-link.active {
                color: white
            }

        .bold {
            font-weight: bold
        }

        .card {
            padding: 40px 50px;
            border-radius: 20px;
            border: none;
            box-shadow: 1px 5px 10px 1px rgba(0, 0, 0, 0.2)
        }
    </style>
    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
        /*For tooltip*/
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>

    <%--Function for preventing back button--%>
    <script type="text/javascript">
        function DisableBackButton() {
            window.history.forward()
        }
        DisableBackButton();
        window.onload = DisableBackButton;
        window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
        window.onunload = function () { void (0) }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section" style="background-image: url('../Images/payment-bg.png'); width: 100%; height: 100%; background-repeat: no-repeat; background-size: auto; background-attachment: fixed; background-position: left;">

        <div class="container py-5">
            <div class="align-self-end">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            <!-- For demo purpose -->
            <div class="row mb-4">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-6">Order Payment</h1>
                </div>
            </div>
            <!-- End -->
            <div class="row pb-5">
                <div class="col-lg-6 mx-auto">
                    <div class="card ">
                        <div class="card-header">
                            <div class="bg-white shadow-sm pt-4 pl-2 pr-2 pb-2">
                                <!-- Payment type tabs -->
                                <ul role="tablist" class="nav bg-light nav-pills rounded nav-fill mb-3">
                                    <li class="nav-item"><a data-toggle="pill" href="#COD" class="nav-link active"><i class="fa fa-money mr-2"></i>Cash On Delivery </a></li>
                                </ul>
                                <!-- End -->
                            </div>

                            <!-- Cash On Delivery info -->
                            <div id="COD" class="tab-pane fade show active pt-3">
                                <div class="form-group">
                                    <label for="txtName">
                                                <h6>სახელი</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required"
                                                ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationGroup="cod">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                ErrorMessage="Name must be in characters" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName" ValidationGroup="cod">*
                                            </asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Card Owner Name"></asp:TextBox>
                                    <label for="txtCODAddress">
                                        <h6>მიტანის ადგილი</h6>
                                    </label>
                                    <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control" placeholder="Delivery Address"
                                        TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ErrorMessage="Address is required" ForeColor="Red"
                                        ControlToValidate="txtCODAddress" Display="Dynamic" SetFocusOnError="true" ValidationGroup="cod"
                                        Font-Names="Segoe Script"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label for="ddlTakeawayTime">
                                        <h6>მიტანის დრო</h6>
                                    </label>
                                    <select id="reservationTime" name="reservationTime" class="form-control" required>
                                        <option value="">აირჩიეთ დრო</option>
                                        <% for (int hour = 10; hour <= 22; hour++)
                                            { %>
                                        <% for (int minute = 0; minute < 60; minute += 30)
                                            { %>
                                        <% string fromTime = $"{hour:00}:{minute:00}";
                                            string toTime = $"{(hour + (minute + 30) / 60):00}:{(minute + 30) % 60:00}"; %>
                                        <option value="<%= fromTime %>"><%= fromTime %> -დან <%= toTime %> -მდე </option>
                                        <% } %>
                                        <% } %>
                                    </select>
                                </div>
                                <p>
                                    <asp:LinkButton ID="lbCodSubmit" runat="server" CssClass="btn btn-info" ValidationGroup="cod" OnClick="lbCodSubmit_Click">
                                            <i class="fa fa-cart-arrow-down mr-2"></i>შეკვეთა</asp:LinkButton>
                                </p>
                                <p class="text-muted">
                                    Note: At the of recieving your order, you need to do full payment. 
                                    After completing the payment process, you can check your updated order status.
                                </p>
                            </div>
                            <!-- End -->
                        </div>
                        <!-- End -->
                    </div>
                    <div class="card-footer">
                        <b class="badge badge-success badge-pill shadow-sm">Order Total: ₾ <% Response.Write(Session["grandTotalPrice"]); %> </b>
                        <div class="pt-1">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="card"
                                HeaderText="Fix the following errors" Font-Names="Segoe Script" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

