<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMerchOutletUserProfile.aspx.cs" Inherits="CRMApp.crmapp.frmMerchOutletUserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="main-area">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>My Profile</h2>
                    </div>
                    <div><span id="trycatchmsg" runat="server" style="font-size: small; color: red;"></span></div>
                </div>
                <asp:ListView ID="lvMerchOutletProfile" runat="server" OnItemDataBound="lvMerchOutletProfile_ItemDataBound" OnItemEditing="lvMerchOutletProfile_ItemEditing" OnItemCanceling="lvMerchOutletProfile_ItemCanceling" OnItemUpdating="lvMerchOutletProfile_ItemUpdating">
                    <ItemTemplate>
                        <div class="col-sm-12">
                            <div class="row">
                                <%--  <div class="col-sm-6">
                                    <div class="col-md-12">
                                        <div class="profile-nav profile">
                                            <div class="panel">
                                                <div class="user-heading round">
                                                    <div class="user">
                                                        <img id="imgMerchLogo" src='<%#Eval("merchant_logo")%>' />
                                                    </div>
                                                    <h1><%#Eval("organization_name")%></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>--%>

                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Connect Your Account <span class="pull-right">
                                                <asp:LinkButton ID="EditProfile" Text="Edit" runat="server" CssClass="btn btn-primary btn-xs" CommandName="Edit"></asp:LinkButton>
                                            </span></h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="75%">BigR Merchant Outlet Password</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clearfix"></div>

                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Organization Name</td>
                                                    <td width="75%"><%#Eval("organization_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="35%">Organization Number</td>
                                                    <td width="65%"><%#Eval("merchant_number")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="35%">Organization Category</td>
                                                    <td width="65%"><%#Eval("merchant_category")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Merchant Outlet Information</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="35%">Outlet Name</td>
                                                    <td width="65%"><%#Eval("branch_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="35%">Longitude</td>
                                                    <td width="65%"><%#Eval("longitude")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="35%">Latitude</td>
                                                    <td width="65%"><%#Eval("latitude")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Person In Charge</td>
                                                    <td><%#Eval("person_incharge")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Person In Charge Phone Number</td>
                                                    <td><%#Eval("mobile_phone")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Office Fax Phone No</td>
                                                    <td><%#Eval("fax_no")%></td>
                                                </tr>
                                                <tr>
                                                    <td>email</td>
                                                    <td><%#Eval("email")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Address Line 1</td>
                                                    <td><%#Eval("branch_address_1")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Address Line 2</td>
                                                    <td><%#Eval("branch_address_2")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Postcode</td>
                                                    <td><%#Eval("branch_postcode")%></td>
                                                </tr>
                                                <tr>
                                                    <td>State</td>
                                                    <td><%#Eval("state_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td>City</td>
                                                    <td><%#Eval("city_name")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Connect your Account</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="75%">BigR Merchant Outlet Password</td>
                                                    <td width="25%" class="text-center">
                                                        <asp:HyperLink ID="hplChangePassword" runat="server" CssClass="btn btn-bigr btn-xs" NavigateUrl="frmChangePassword.aspx">Change</asp:HyperLink>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Profile <span class="pull-right">
                                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="btn btn-default btn-sm">Cancel <i class="fa fa-chevron-left"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lnkSave" runat="server" ValidationGroup="submitValMyMerchOutletProfile" CommandName="Update" CssClass="btn btn-warning btn-sm">Save <i class="fa fa-plus" aria-hidden="true"></i></asp:LinkButton>
                                            </span></h4>
                                        </div>
                                    </div>
                                    <asp:UpdatePanel runat="server" ID="upMerchUserProfile">
                                        <ContentTemplate>
                                            <div class="the-box gap-mini">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td width="25%">Organization Name</td>
                                                            <td width="75%"><%#Eval("organization_name")%></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="25%">Organization Number</td>
                                                            <td width="75%"><%#Eval("merchant_number")%></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="25%">Organization Category</td>
                                                            <td width="75%"><%#Eval("merchant_category")%></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="title">
                                                <div class="sub">
                                                    <h4>Merchant Outlet Information</h4>
                                                </div>
                                            </div>
                                            <div class="the-box gap-mini">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td width="35%">Outlet Name</td>
                                                            <td width="65%">
                                                                <asp:TextBox ID="TxtOutletName" runat="server" placeholder="Outlet Name" CssClass="form-control" Text='<%# Bind("branch_name") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="35%">Longitude</td>
                                                            <td width="65%">
                                                                <asp:TextBox ID="TxtLongitude" runat="server" placeholder="Longitude" CssClass="form-control" Text='<%# Bind("longitude") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="35%">Latitude</td>
                                                            <td width="65%">
                                                                <asp:TextBox ID="TxtLatitude" runat="server" placeholder="latitude" CssClass="form-control" Text='<%# Bind("latitude") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Person In Charge</td>
                                                            <td>
                                                                <asp:TextBox ID="txtPIC" runat="server" placeholder="Person in charge name" CssClass="form-control" Text='<%# Bind("person_incharge") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Person In Charge Phone Number</td>
                                                            <td>
                                                                <asp:TextBox ID="txtMobileNo" MaxLength="11" onkeydown="return isNumberKey(event)" runat="server" placeholder="Mobile phone no" CssClass="form-control" Text='<%# Bind("mobile_phone") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Office Fax Phone No</td>
                                                            <td>
                                                                <asp:TextBox ID="txtFaxNo" onkeydown="return isNumberKey(event)" runat="server" placeholder="Fax no" CssClass="form-control" Text='<%# Bind("fax_no") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Email</td>
                                                            <td>
                                                                <asp:Label ID="lblMerchProfEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Address Line 1</td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress1" runat="server" placeholder="Address 1" CssClass="form-control" Text='<%# Bind("branch_address_1") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Address Line 2</td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress2" runat="server" placeholder="Address 2" CssClass="form-control" Text='<%# Bind("branch_address_2") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Postcode</td>
                                                            <td>
                                                                <asp:TextBox ID="txtPostcode" MaxLength="5" onkeydown="return isNumberKey(event)" runat="server" CssClass="form-control" Text='<%# Bind("branch_postcode") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>State</td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                        <tr>
                                                            <td>City</td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </EditItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>
