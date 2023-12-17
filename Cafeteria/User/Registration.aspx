<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Cafeteria.User.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--For disappearing alert message--%>

    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>


    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
    function ShowPopup() {
        // Assuming you have a modal with ID 'verificationModal'
        $('#verificationModal').modal('show');
    }

    function VerifyCode() {
        var enteredCode = $("#txtVerificationCode").val();

        // Assuming you have a method on the server to verify the code
        PageMethods.VerifyCode(enteredCode, OnVerifyCodeSuccess, OnVerifyCodeFailure);
    }

    function OnVerifyCodeSuccess(result) {
        if (result === true) {
            alert("Verification successful. Registration complete!");
            window.location.href = "Profile.aspx"; // Redirect to the profile page or any other destination
        } else {
            alert("Invalid verification code. Please try again.");
        }
    }

    function OnVerifyCodeFailure(error) {
        alert("Error verifying code: " + error._message);
    }
</script>



    <%--Show Image Preview --%>

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>მომხმარებლის რეგისტრაცია</h2>"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="სახელი აუცილებელია" ControlToValidate="txtName"
                                 ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="სახელი უნდა იყოს მხოლოდ ასოებით"
                                 ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[a-zA-Z\s]+$"
                                 ControlToValidate="txtName"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"  placeholder="შეიყვანეთ სრული სახელი"
                                ToolTip="Full Name"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="მეტსახელი აუცილებელია" ControlToValidate="txtUsername"
                                 ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"  placeholder="შეიყვანეთ მეტსახელი"
                                ToolTip="Username"></asp:TextBox>
                    </div>

                    <div>
    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="მეილი აუცილებელია" ControlToValidate="txtEmail"
        ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>

    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="შეიყვანეთ მეილი"
        ToolTip="Email" TextMode="Email"></asp:TextBox>

    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="მეილი მხოლოდ pog.gov.ge ან justice.gov.ge მისამართებს შეიძლება"
        ControlToValidate="txtEmail" ValidationExpression="^[\w-]+(\.[\w-]+)*@(pog\.gov\.ge|justice\.gov\.ge)$"
        ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
</div>


                        

                </div>
          </div>

                <div class="col-md-6">
                    <div class="form_container">

                       
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="ტელ. ნომერი აუცილებელია" 
                                ControlToValidate="txtMobile" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="ნომერი უნდა შეიცავდეს 9 ციფრს"
                                 ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[0-9]{9}$"
                                 ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"  placeholder="შეიყვანეთ ტელეფონის ნომერი"
                                ToolTip="Mobile" TextMode="Number"></asp:TextBox>
                        </div>
                        

                    <div>
                        <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="User Image" onchange="ImagePreview(this);"/>
                    </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="პაროლი აუილებელია" 
                                ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"  placeholder="შეიყვანეთ პაროლი"
                                ToolTip="Password" TextMode="Password"></asp:TextBox>
                        </div>

                    </div>
                </div>

                <div class="row pl-4">
                    <div class="btn_box">
                        <asp:Button ID="btnRegister" runat="server" Text="რეგისტრაცია" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                             OnClick="btnRegister_Click"/>

                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100" 
                            Text="უკვე დარეგისტრირებულიხარ? <a href='Login.aspx' class='badge badge-info'>გაიარე ავტორიზაცია აქ..</a>">
                        </asp:Label>
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items:center">
                        <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail"/>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
