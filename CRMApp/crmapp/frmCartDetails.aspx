<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCartDetails.aspx.cs" Inherits="CRMApp.crmapp.frmCartDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="Javascript">
       <!--
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode != 45 && charCode > 31
            && (charCode < 48 || charCode > 57))
            return false;
        //Test
        return true;
    }
    function updateValidator() {
        var enableValidator = !event.srcElement.status;
        var rfvSubject = document.getElementById('rfvSubject');
        ValidatorEnable(rfvSubject, enableValidator);
    }

       //-->
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <!--col-md-3-->
        <div class="col-md-12 pt20">
            <ol class="breadcrumb">
                <li class="home"><a href="index.html" title="Go to Home Page">Home</a>
                </li>
                <li class="active">Shopping Cart</li>
            </ol>
        </div>
        <div class="col-md-12 col-sm-12">
            <h3 class="text-bigr">Shopping Cart</h3>
            <asp:ListView ID="lvCartList" runat="server" DataKeyNames="voucher_id" ItemPlaceholderID="itemPlaceHolder1">
                <LayoutTemplate>
                    <div class="panel panel-default panel-box addtocart">
                        <div class="panel-body">
                            <table class="table table-checkout head">
                                <tbody>
                                    <tr>
                                        <td>
                                            <label class="label-style">
                                                <input type="checkbox" class="checkAll">
                                                <span class="checkmark"></span>
                                            </label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td>Voucher</td>
                                        <td>QTY</td>
                                        <td>Original Price</td>
                                        <td>Discount Price</td>
                                        <td>SST Amount</td>
                                        <td>Promo Code</td>
                                        <td>Total Price</td>
                                        <td>Action</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="panel panel-default panel-box addtocart">
                        <div class="panel-body">
                            <table class="table table-checkout">
                                <tbody>
                                    <tr>
                                        <td>
                                            <label class="label-style">
                                                <input type="checkbox" class="item-s">
                                                <span class="checkmark"></span>
                                            </label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td>
                                            <asp:Label ID="lblProductId" runat="server" Text='<%#Eval("Product_ID")%>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblOrderId" runat="server" Text='<%#Eval("orderid")%>' Visible="false"></asp:Label>
                                            <asp:Label runat="server" ID="lblproname" Text='<%# Eval("voucher_name") %>'></asp:Label></td>
                                        <td>
                                            <div class="input-group cart">

                                                <span class="input-group-btn">
                                                    <button class="btn btn-default minus" type="button">
                                                        <i class="fa fa-fw fa-minus"></i>
                                                    </button>
                                                </span>
                                                <%--<input type="text" class="form-control">--%>
                                                <%-- <asp:Label ID="txtQuantity" runat="server" Text='<%#Eval("Product_Qty")%>' Width="20px"></asp:Label>--%>
                                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Eval("Product_Qty")%>' Width="20px"></asp:TextBox>
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default add" type="button">
                                                        <i class="fa fa-fw fa-plus"></i>
                                                    </button>
                                                </span>
                                            </div>
                                            <!-- /input-group -->
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrice" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("original_price").ToString())) ? Convert.ToDouble(Eval("original_price")).ToString("N2") : "0.00" %>'></asp:Label></td>
                                        <td>
                                            <asp:Label ID="LblSSTAmount" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("discount_price").ToString())) ? Convert.ToDouble(Eval("discount_price")).ToString("N2") : "0.00" %>'></asp:Label></td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("sst_amount").ToString())) ? Convert.ToDouble(Eval("sst_amount")).ToString("N2") : "0.00" %>'></asp:Label></td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("total_amount").ToString())) ? Convert.ToDouble(Eval("total_amount")).ToString("N2") : "0.00" %>'></asp:Label>
                                            <asp:Label ID="lblBasePrice" runat="server" Text='<%#Eval("original_price")%>' Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <button class="btn btn-remove-2">
                                                <i class="fa fa-fw fa-trash-o"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:ListView>
            <div class="panel panel-default panel-box addtocart">
                <div class="panel-body">
                    <table class="table table-checkout-final">
                        <tbody>
                            <tr>
                                <td></td>
                                <td><a class="final-total" href="#">Continue Shopping ></a>
                                </td>
                                <td>Total Price</td>
                                <%--<td>RM 13.00</td>--%>
                                <td>RM<asp:Label ID="lblsumAmout2" runat="server" Text="Label"></asp:Label></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>SST (6%)</td>
                                <td>RM
                                    <asp:Label ID="lblTotaSSTAmt" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><span class="final-total">Grand Total</span>
                                </td>
                                <td><span class="final-total">RM
                                    <asp:Label ID="lblTotalCartAmt" runat="server" Text="Label"></asp:Label>
                                </span>
                                </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <h3 class="text-bigr">Address
                            <label class="label-style pull-right change-bill">
                                I would like to change my Billing Address
                                <input type="checkbox" id="ChkShippingAddress" runat="server" class="chan-bill">
                                <span class="checkmark"></span>
                            </label>
            </h3>

            <div class="panel panel-default panel-box addtocart">
                <div class="panel-heading">
                    Your Billing Address
                             <span id="spanShipAddress" style="color: red;" runat="server"></span>
                </div>

                <div class="panel-body bill-new">
                    <asp:TextBox ID="TxtFirstName" CssClass="form-control" runat="server" placeholder="Name"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="TxtAddress1" CssClass="form-control" runat="server" placeholder="Enter Address"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="TxtAddress2" CssClass="form-control" runat="server" placeholder="Enter Address 1"></asp:TextBox>
                    <br />
                    <asp:UpdatePanel ID="UP_ShippingAddress" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" DataTextField="state_name" DataValueField="state_id" required></asp:DropDownList>
                            <br />
                            <asp:DropDownList ID="ddlCity" AutoPostBack="true" DataValueField="city_id" DataTextField="city_name" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <asp:DropDownList ID="ddlcountry" runat="server" CssClass="form-control" required>
                        <asp:ListItem Text="Malaysia" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:TextBox ID="TxtPostCode" MaxLength="6" onkeypress="return isNumberKey(event)" CssClass="form-control" runat="server" placeholder="Enter PostCode"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="TxtEmail" CssClass="form-control" runat="server" placeholder="Enter Email"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="TxtPhone" onkeypress="return isNumberKey(event)" MaxLength="12" CssClass="form-control" runat="server" placeholder="Enter Mobile No"></asp:TextBox>
                    <%-- <div class="text-right pt10">
                        <button class="btn btn-bigr">Save</button>
                    </div>--%>
                </div>

                <div class="panel-body bill-curent">
                    <address>
                        <p>
                            <asp:Label ID="LblName" runat="server"></asp:Label>
                        </p>
                        <br>
                        <p>
                            <asp:Label ID="LblAddress1" runat="server"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="LblAddress2" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblAddress3" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblState" runat="server"></asp:Label>
                            <asp:Label ID="LblStateId" Visible="false" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblCity" runat="server"></asp:Label>
                            <asp:Label ID="LblCityId" Visible="false" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblCountry" runat="server"></asp:Label>
                            <asp:Label ID="LblCountryId" Visible="false" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblPostCode" runat="server"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="LblEmail" runat="server"></asp:Label>
                            <br />
                            <asp:Label ID="LblPhone" runat="server"></asp:Label>
                        </p>
                    </address>

                </div>
            </div>
        </div>
        <div class="col-md-6">
            <h3 class="text-bigr">Payment Method</h3>
            <div class="panel panel-default panel-box addtocart">
                <div class="panel-heading">
                    Please choose your payment method
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <span id="spanAgreement" style="color: red;" runat="server"></span>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-body">
                    <label class="label-style">
                        I agree to the terms of service and will adhere to them unconditionally.(Read the Terms of Service)
                        <input type="checkbox" runat="server" id="chkAgree" class="agred" />
                        <span class="checkmark"></span>
                    </label>
                    <label>
                        <input class="radio-payment" id="RBFBX" type="radio" name="test" runat="server" value="FT">
                        <img src="img/payment-fpx.png">
                    </label>
                    <label>
                        <input class="radio-payment" id="RBCredit" type="radio" name="test" runat="server" value="CC">
                        <img src="img/payment-credit.png" />
                    </label>
                </div>

            </div>
        </div>
        <div class="col-sm-offset-4 col-sm-4 text-center pb20">
            <%-- <asp:UpdatePanel ID="UpPay" runat="server">
                <ContentTemplate>
                    <asp:LinkButton ID="LbPaynow" OnClick="LbPaynow_Click" CssClass="btn btn-bigr btn-lg btn-block" runat="server">Pay Now</asp:LinkButton>
                </ContentTemplate>
            </asp:UpdatePanel>--%>
           <%-- <asp:UpdatePanel ID="UpPay" runat="server">
                <ContentTemplate>--%>
                    <div class="col-sm-offset-4 col-sm-4 text-center pb20">
                        <a href="#" runat="server" id="btnNextPayment" onserverclick="btnNextPayment_ServerClick" class="btn btn-bigr btn-lg btn-block">Pay Now</a>
                    </div>
               <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
    </div>
    <!--row-->
</asp:Content>
