<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCart.aspx.cs" Inherits="CRMApp.crmapp.frmCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 45 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function updateValidator() {
            var enableValidator = !event.srcElement.status;
            var rfvSubject = document.getElementById('rfvSubject');
            ValidatorEnable(rfvSubject, enableValidator);
        }
    </script>
    <script>
        function changeQuantity(obj, type) {
            var count = $(obj).closest('tr').find("[id$='txtQuantity']").val();
            var dprice, oprice, totamt, sstamt, caAmt;
            var qty;
            var hdp, hop;
            if (type == 'plus') {
                $(obj).closest('tr').find("[id$='txtQuantity']").val(parseInt(count, 10) + 1);

                //original price
                hop = $(obj).closest('tr').find("input[name$=hfop]").val();
                qty = parseInt(count, 10) + 1;
                oprice = qty * hop;
                var or;
                or = numberWithCommas(oprice);
                $(obj).closest('tr').find("[id$='txtOriPrice']").val(or);

                //discount price
                hdp = $(obj).closest('tr').find("input[name$=hfdp]").val();
                qty = parseInt(count, 10) + 1;
                dprice = qty * hdp;
                var dp;
                dp = numberWithCommas(dprice);
                $(obj).closest('tr').find("[id$='txtDiscountedPrice']").val(dp);

                //SST Amount
                hfsst = $(obj).closest('tr').find("input[name$=hfsst]").val();
                qty = parseInt(count, 10) + 1;
                sstamt = qty * hfsst;
                var sst;
                sst = numberWithCommas(sstamt);
                $(obj).closest('tr').find("[id$='TxtSSTAmount']").val(sst);

                //TotalPrice
                hfta = $(obj).closest('tr').find("input[name$=hfta]").val();
                qty = parseInt(count, 10) + 1;
                totamt = qty * hfta;
                var ta;
                ta = numberWithCommas(totamt);
                $(obj).closest('tr').find("[id$='TxtTotalAmt']").val(ta);
            }
            else if (count < 2) {
                $(obj).closest('tr').find("[id$='txtQuantity']").val('1');
            }
            else {
                $(obj).closest('tr').find("[id$='txtQuantity']").val(parseInt(count, 10) - 1);
                hop = $(obj).closest('tr').find("input[name$=hfop]").val();
                qty = parseInt(count, 10) - 1;
                oprice = qty * hop;
                var or;
                or = numberWithCommas(oprice);
                $(obj).closest('tr').find("[id$='txtOriPrice']").val(or);

                hdp = $(obj).closest('tr').find("input[name$=hfdp]").val();
                qty = parseInt(count, 10) - 1;
                dprice = qty * hdp;
                var dp;
                dp = numberWithCommas(dprice);
                $(obj).closest('tr').find("[id$='txtDiscountedPrice']").val(dp);

                //SSTAmount
                hfsst = $(obj).closest('tr').find("input[name$=hfsst]").val();
                qty = parseInt(count, 10) - 1;
                sstamt = qty * hfsst;
                var sst;
                sst = numberWithCommas(sstamt);
                $(obj).closest('tr').find("[id$='TxtSSTAmount']").val(sst);

                //TotalAmount
                hfta = $(obj).closest('tr').find("input[name$=hfta]").val();
                qty = parseInt(count, 10) - 1;
                totamt = qty * hfta;
                var ta;
                ta = numberWithCommas(totamt);
                $(obj).closest('tr').find("[id$='TxtTotalAmt']").val(ta);

                //TotalCartAmount
                //hftCaAmt = $(obj).closest('tr').find("input[name$=hftCaAmt]").val();
                //hftCaAmt = $this.find('input[name$=hftCaAmt]')
                //qty = parseInt(count, 10) - 1;
                //caAmt = qty * hftCaAmt;
                //var ca;
                //ca = numberWithCommas(caAmt);
                //$(obj).closest('tr').find("[id$='TxtTotalCartAmt']").val(ca);
            }
        }

        function numberWithCommas(x) {
            return x.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
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
            <span id="message" runat="server" style="font-size: smaller;"></span>
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
                                </td>
                                <td>Voucher</td>
                                <td>QTY</td>
                                <td>Original Price(RM)</td>
                                <td>Discount Price(RM)</td>
                                <td>SST Amount</td>
                                <td>Promo Code</td>
                                <td>Total Price(RM)</td>
                                <td>Action</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <asp:UpdatePanel ID="UpUpdateOrderList" runat="server">
                <ContentTemplate>
                    <div class="panel panel-default panel-box addtocart">
                        <div class="panel-body">
                            <asp:ListView ID="lvCartList" runat="server" DataKeyNames="voucher_id,orderid" ItemPlaceholderID="itemPlaceHolder1"
                                OnItemCommand="lvCartList_ItemCommand" OnItemDeleting="lvCartList_ItemDeleting">
                                <LayoutTemplate>
                                    <table class="table table-checkout">
                                        <tbody>
                                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                        </tbody>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <label class="label-style">
                                                <input type="checkbox" class="item-s">
                                                <span class="checkmark"></span>
                                            </label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductId" runat="server" Text='<%#Eval("Product_ID")%>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblOrderId" runat="server" Text='<%#Eval("orderid")%>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblVoucherid" runat="server" Text='<%#Eval("voucher_id")%>' Visible="false"></asp:Label>
                                            <asp:Label runat="server" ID="lblproname" Text='<%# Eval("voucher_name") %>'></asp:Label></td>
                                        <td>
                                            <div class="input-group cart">
                                                <asp:Label runat="server" ID="LblQty" Text='<%# Eval("Product_Qty") %>'></asp:Label></td>
                                              <%--  <asp:DropDownList ID="ddlQty" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlQty_SelectedIndexChanged" SelectedValue='<%# Eval("Product_Qty") %>' CssClass="form-control">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                    <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                    <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                    <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                    <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                    <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                                    <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                                    <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                                    <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                                    <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                                    <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                                    <asp:ListItem Text="21" Value="21"></asp:ListItem>
                                                    <asp:ListItem Text="22" Value="22"></asp:ListItem>
                                                    <asp:ListItem Text="23" Value="23"></asp:ListItem>
                                                    <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                    <asp:ListItem Text="26" Value="26"></asp:ListItem>
                                                    <asp:ListItem Text="27" Value="27"></asp:ListItem>
                                                    <asp:ListItem Text="28" Value="28"></asp:ListItem>
                                                    <asp:ListItem Text="29" Value="29"></asp:ListItem>
                                                    <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                                    <asp:ListItem Text="31" Value="31"></asp:ListItem>
                                                    <asp:ListItem Text="32" Value="32"></asp:ListItem>
                                                    <asp:ListItem Text="33" Value="33"></asp:ListItem>
                                                    <asp:ListItem Text="34" Value="34"></asp:ListItem>
                                                    <asp:ListItem Text="35" Value="35"></asp:ListItem>
                                                    <asp:ListItem Text="36" Value="36"></asp:ListItem>
                                                    <asp:ListItem Text="37" Value="37"></asp:ListItem>
                                                    <asp:ListItem Text="38" Value="38"></asp:ListItem>
                                                    <asp:ListItem Text="39" Value="39"></asp:ListItem>
                                                    <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                                    <asp:ListItem Text="41" Value="41"></asp:ListItem>
                                                    <asp:ListItem Text="42" Value="42"></asp:ListItem>
                                                    <asp:ListItem Text="43" Value="43"></asp:ListItem>
                                                    <asp:ListItem Text="44" Value="44"></asp:ListItem>
                                                    <asp:ListItem Text="45" Value="45"></asp:ListItem>
                                                    <asp:ListItem Text="46" Value="46"></asp:ListItem>
                                                    <asp:ListItem Text="47" Value="47"></asp:ListItem>
                                                    <asp:ListItem Text="48" Value="48"></asp:ListItem>
                                                    <asp:ListItem Text="49" Value="49"></asp:ListItem>
                                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                </asp:DropDownList>--%>
                                                <%--<span class="input-group-btn">
                                            <button class="btn btn-default btn-number"  data-type="minus">
                                                <i class="fa fa-fw fa-minus"></i>
                                            </button>
                                        </span>
                                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Eval("Product_Qty")%>' CssClass="form-control input-number" min="1" ClientIDMode="Static"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default btn-number" data-type="plus" onclick="changeQuantity(this,'plus');">
                                                <i class="fa fa-fw fa-plus"></i>
                                            </button>
                                        </span>--%>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrice" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("original_price").ToString())) ? Convert.ToDouble(Eval("original_price")).ToString("N2") : "0.00" %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDiscountedPrice" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("discount_price").ToString())) ? Convert.ToDouble(Eval("discount_price")).ToString("N2") : "0.00" %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSSTamount" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("sst_amount").ToString())) ? Convert.ToDouble(Eval("sst_amount")).ToString("N2") : "0.00" %>'></asp:Label></td>

                                        <td><asp:Label ID="lblPromocodeName" runat="server" Text='<%#Eval("Promocode_name")%>'></asp:Label></td>
                                        <td>
                                            <%--<asp:Label ID="lblTotalAmt" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("total_amount").ToString())) ? Convert.ToDouble(Eval("total_amount")).ToString("N2") : "0.00" %>'></asp:Label>--%>
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("final_price").ToString())) ? Convert.ToDouble(Eval("final_price")).ToString("N2") : "0.00" %>'></asp:Label>

                                            <asp:Label ID="lblBasePrice" runat="server" Text='<%#Eval("original_price")%>' Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkDelete" CommandName="Delete" OnClientClick="return confirm('Are you sure you want delete this voucher');" runat="server" CssClass="btn btn-remove-2" ToolTip="remove from cart"><i class="fa fa-fw fa-trash-o"></i></asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                    <div class="panel panel-default panel-box addtocart">
                        <div class="panel-body">
                            <table class="table table-checkout-final">
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td><a class="final-total" href="../frmSearchList.aspx?search_value=&main_category_id=">Continue Shopping ></a>
                                        </td>
                                        <%--<td>Total Price</td>
                                <td>RM<asp:Label ID="lblsumAmout2" runat="server" Text="Label"></asp:Label></td>
                                <td></td>--%>
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
                                            <%-- <asp:TextBox ID="TxtTotalCartAmt" BorderStyle="None" runat="server" ClientIDMode="Static"></asp:TextBox>
                                    <asp:HiddenField ID="hftCaAmt" runat="server" />--%>
                                        </span>
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
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
                        <img src="../crmapp/img/payment-fpx.png">
                    </label>
                    <label id="lblCredit" runat="server" visible="true">
                        <input class="radio-payment" id="RBCredit" type="radio" name="test" runat="server" value="CC">
                        <img src="../crmapp/img/payment-credit.png" />
                    </label>
                </div>

            </div>
        </div>
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
</asp:Content>

