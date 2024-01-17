<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Cafeteria.Admin.Product" %>

<%@ Import Namespace="Cafeteria" %>

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



    <%--Show Image Preview --%>

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgProduct.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h4 class="sub-title">პროდუქტი</h4>
                                            <div>
                                                <div class="form-group">
                                                    <label>პროდუქტის სახელი</label>
                                                    <div>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                            placeholder="შეიყვანეთ პროდუქტის დასახელება"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                            ErrorMessage="პროდუქტის სახელი აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                                        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>პროდუქტის აღწერა</label>
                                                    <div>
                                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                                            placeholder="შეიყვანეთ პროდუქტის აღწერა" TextMode="MultiLine"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                            ErrorMessage="პროდუქტის აღწერა აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtDescription">
                                                        </asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>პროდუქტის ფასი(₾)</label>
                                                    <div>
                                                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"
                                                            placeholder="შეიყვანეთ პროდუქტის ფასი"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                            ErrorMessage="ფასი აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                            ErrorMessage="ფასი მიუთითეთ რიცხვებით" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtPrice"
                                                            ValidationExpression="\d{0,8}(\.\d{1,4})?$"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>პროდუქტის მარაგი</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"
                                                            placeholder="შეიყვანეთ პროდუქტის მარაგი"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                            ErrorMessage="მარაგის შეყვანა აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtQuantity"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                            ErrorMessage="მარაგი უნდა იყოს დადებითი რიცხვი" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtQuantity"
                                                            ValidationExpression="^([1-9]\d*|0)$"></asp:RegularExpressionValidator>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>ერთეულის რაოდენობა</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtUnit" runat="server" CssClass="form-control"
                                                            placeholder="შეიყვანეთ ერთეული პროდუქტის რაოდენობა"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                            ErrorMessage="ერთეული პროდუქტის რაოდენობის შეყვანა აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtUnit"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                                            ErrorMessage="რაოდენობა უნდა იყოს დადებითი რიცხვი" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="txtUnit"
                                                            ValidationExpression="^([1-9]\d*|0)$"></asp:RegularExpressionValidator>
                                                        <asp:DropDownList ID="ddlQuantityUnit" runat="server" CssClass="form-control"
                                                            Style="max-width: 150px;">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label>პროდუქტის სურათი</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>პროდუქტის კატეგორია</label>
                                                    <div>
                                                        <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control"
                                                            DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId"
                                                            AppendDataBoundItems="True">
                                                            <asp:ListItem Value="0">აირჩიეთ კატეგორია</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                            ErrorMessage="კატეგორიის არჩევა აუცილებელია" ForeColor="Red" Display="Dynamic"
                                                            SetFocusOnError="true" ControlToValidate="ddlCategories" InitialValue="">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"  ConnectionString="<%$ ConnectionStrings:CafetDBConnectionString %>" SelectCommand="SELECT [CategoryId], [Name] FROM [Categories]" ProviderName="<%$ ConnectionStrings:CafetDBConnectionString.ProviderName %>"></asp:SqlDataSource>
                                                    </div>
                                                </div>

                                                <div class="form-check pl-4">
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; აქტიურია"
                                                        CssClass="form-check-input" />
                                                </div>
                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="დამატება" CssClass="btn btn-primary"
                                                        OnClick="btnAddOrUpdate_Click" />
                                                    &nbsp;
                                                <asp:Button ID="btnClear" runat="server" Text="წაშლა" CssClass="btn btn-primary"
                                                    CausesValidation="false" OnClick="btnClear_Click" />
                                                </div>
                                                <div>
                                                    <asp:Image ID="imgProduct" runat="server" CssClass="img-thumbnail" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">პროდუქტების სია</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand"
                                                        OnItemDataBound="rProduct_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>

                                                                    <tr>
                                                                        <th class="table-plus">სახელი</th>
                                                                        <th>სურათი</th>
                                                                        <th>ფასი(₾)</th>
                                                                        <th>რაოდენობა</th>
                                                                        <th>ერთ. რაოდენობა</th>
                                                                        <th>ერთ.</th>
                                                                        <th>კატეგორიები</th>
                                                                        <th>აქტიურია</th>
                                                                        <th>აღწერა</th>
                                                                        <th>დამატების დრო</th>
                                                                        <th class="datatable-nosort">მოქმედება</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Name") %> </td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" />
                                                                </td>
                                                                <td><%# Eval("Price") %> </td>
                                                                <td>
                                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblUnit" runat="server" Text='<%# Eval("Unit") %>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblQuantityUnit" runat="server" Text='<%# Eval("QuantityUnit") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("CategoryName") %> </td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                                                </td>

                                                                <td><%# Eval("Description") %> </td>

                                                                <td><%# Eval("CreatedDate") %> </td>

                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server"
                                                                        CssClass="badge badge-primary" CausesValidation="false"
                                                                        CommandArgument='<%# Eval("ProductId") %>' CommandName="edit">
                                                                        <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("ProductId") %>'
                                                                        OnClientClick="return confirm('ნამდვილად გსურთ წაშალოთ ეს პროდუქტი?');"
                                                                        CausesValidation="false">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
