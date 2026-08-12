<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchUserProfile.aspx.cs" Inherits="CRMApp.crmapp.frmMerchUserProfile" MasterPageFile="~/crmapp/CRMBack.Master" %>

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
                <asp:ListView ID="lvProfile" runat="server" OnItemDataBound="lvProfile_ItemDataBound" OnItemEditing="lvProfile_ItemEditing" OnItemCanceling="lvProfile_ItemCanceling" OnItemUpdating="lvProfile_ItemUpdating">
                    <ItemTemplate>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
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
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Connect Your Account</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="75%">BigR Merchant Password</td>                                                    
                                                </tr>                                          
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Fees Information</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Fee Category</td>
                                                    <td width="75%"><%#Eval("fee_cat")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Fee Charges (RM)</td>
                                                    <td><%#Eval("per_voucher_chargesby_rm", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Fee Charges (%)</td>
                                                    <td><%#Eval("per_voucher_chargesby_percent")%></td>
                                                </tr>
                                                <tr>
                                                    <td>On Boarding Fee Charges (RM)</td>
                                                    <td><%#Eval("yearly_one_time_charges_rm", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Is Premium Merchant</td>
                                                    <td><%#Eval("is_premium_merch")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Premium Fees (RM)</td>
                                                    <td><%#Eval("premium_fees", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Premium Date</td>
                                                    <td>Start : <%#Eval("startdate")%> End : <%#Eval("enddate")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Support Document</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <asp:ListView ID="lvSupportDoc" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                            <LayoutTemplate>
                                                <%--<div class="row">
                                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                                </div>--%>
                                                <table class="table table-striped table-bordered table-hover text-center">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 5%; text-align: center;">No</th>
                                                            <th style="width: 55%; text-align: center;">Document Name</th>
                                                            <th style="width: 20%; text-align: center;">Created Date</th>
                                                            <th style="width: 20%; text-align: center;">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                    </tbody>
                                                </table>                                            
                                                <div class="gap-mid"></div>
                                            </LayoutTemplate>
                                            <GroupTemplate>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                            </GroupTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                    <td style="text-align: center;"><%# Eval("document_name") %></td>
                                                    <td style="text-align: center;"><%# Eval("doc_date") %></td>
                                                    <td style="text-align: center;">
                                                        <a target="_blank" href='<%# Eval("doc_file_path") %>' title="Download document" class="btn btn-bigr btn-xs">Download</a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <EmptyDataTemplate>
                                                <table class="table table-striped table-bordered table-hover text-center">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 5%; text-align: center;">No</th>
                                                            <th style="width: 55%; text-align: center;">Document Name</th>
                                                            <th style="width: 20%; text-align: center;">Created Date</th>
                                                            <th style="width: 20%; text-align: center;">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="10" style="text-align: center;">No record found!
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </EmptyDataTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Profile <span class="pull-right">
                                                <asp:LinkButton ID="EditProfile" Text="Edit" runat="server" CssClass="btn btn-primary btn-xs" CommandName="Edit"></asp:LinkButton>
                                            </span></h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Organization Name</td>
                                                    <td width="75%"><%#Eval("organization_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Office Phone No</td>
                                                    <td><%#Eval("office_phone")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Email Address</td>
                                                    <td><%#Eval("email")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Merchant Information</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="35%">Organization Number</td>
                                                    <td width="65%"><%#Eval("merchant_number")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="35%">Organization Category</td>
                                                    <td width="65%"><%#Eval("merchant_category")%></td>
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
                                                    <td>Website</td>
                                                    <td><%#Eval("website")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Address Line 1</td>
                                                    <td><%#Eval("address_1")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Address Line 2</td>
                                                    <td><%#Eval("address_2")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Postcode</td>
                                                    <td><%#Eval("postcode")%></td>
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
                                    <div class="col-md-12">
                                        <div class="profile-nav profile">
                                            <div class="panel">
                                                <div class="user-heading round">
                                                    <div class="user">
                                                        <img id="imgMerchLogo" runat="server" />
                                                    </div>
                                                    <h1><%#Eval("organization_name")%></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="clearfix"></div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Connect Your Account</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="75%">BigR Merchant Password</td>
                                                    <td width="25%" class="text-center">
                                                        <asp:HyperLink ID="hplChangePassword" runat="server" CssClass="btn btn-bigr btn-xs" NavigateUrl="frmChangePassword.aspx">Change</asp:HyperLink>
                                                    </td>
                                                </tr>                                              
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Fees Information</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Fee Category</td>
                                                    <td width="75%"><%#Eval("fee_cat")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Fee Charges (RM)</td>
                                                    <td><%#Eval("per_voucher_chargesby_rm", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Fee Charges (%)</td>
                                                    <td><%#Eval("per_voucher_chargesby_percent")%></td>
                                                </tr>
                                                <tr>
                                                    <td>On Boarding Fee Charges (RM)</td>
                                                    <td><%#Eval("yearly_one_time_charges_rm", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Is Premium Merchant</td>
                                                    <td><%#Eval("is_premium_merch")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Premium Fees (RM)</td>
                                                    <td><%#Eval("premium_fees", "{0:0.00}")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Premium Date</td>
                                                    <td>Start : <%#Eval("startdate")%> End : <%#Eval("enddate")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Support Document</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <asp:ListView ID="lvSupportDoc" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                            <LayoutTemplate>
                                                <%--<div class="row">
                                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                                </div>--%>
                                                <table class="table table-striped table-bordered table-hover text-center">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 5%; text-align: center;">No</th>
                                                            <th style="width: 55%; text-align: center;">Document Name</th>
                                                            <th style="width: 20%; text-align: center;">Created Date</th>
                                                            <th style="width: 20%; text-align: center;">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                    </tbody>
                                                </table>
                                                <%--<div class="row">
                                                    <div class="col-sm-12 text-right">
                                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvSupportDoc" PageSize="10">
                                                            <Fields>
                                                                <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                                    ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary btn-xs" RenderNonBreakingSpacesBetweenControls="false"
                                                                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                                                <asp:NextPreviousPagerField NextPageText="&raquo;" LastPageText=">|" ShowNextPageButton="true"
                                                                    ShowLastPageButton="true" ShowPreviousPageButton="false" ShowFirstPageButton="false"
                                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                            </Fields>
                                                        </asp:DataPager>
                                                    </div>
                                                </div>--%>
                                                <div class="gap-mid"></div>
                                            </LayoutTemplate>
                                            <GroupTemplate>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                            </GroupTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                    <td style="text-align: center;"><%# Eval("document_name") %></td>
                                                    <td style="text-align: center;"><%# Eval("doc_date") %></td>
                                                    <td style="text-align: center;">
                                                        <a target="_blank" href='<%# Eval("doc_file_path") %>' title="Download document" class="btn btn-bigr btn-xs">Download</a>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <EmptyDataTemplate>
                                                <table class="table table-striped table-bordered table-hover text-center">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 5%; text-align: center;">No</th>
                                                            <th style="width: 55%; text-align: center;">Document Name</th>
                                                            <th style="width: 20%; text-align: center;">Created Date</th>
                                                            <th style="width: 20%; text-align: center;">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="10" style="text-align: center;">No record found!
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </EmptyDataTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Profile <span class="pull-right">
                                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="btn btn-default btn-sm">Cancel <i class="fa fa-chevron-left"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lnkSave" runat="server" CommandName="Update" CssClass="btn btn-warning btn-sm">Save <i class="fa fa-plus" aria-hidden="true"></i></asp:LinkButton>
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
                                                            <td>Office Phone No</td>
                                                            <td>
                                                                <asp:TextBox ID="txtOfficeNo" MaxLength="11" onkeydown="return isNumberKey(event)" runat="server" placeholder="Office phone no" CssClass="form-control" Text='<%# Bind("office_phone") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Email Address</td>
                                                            <td><%#Eval("email")%></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="title">
                                                <div class="sub">
                                                    <h4>Merchant Information</h4>
                                                </div>
                                            </div>
                                            <div class="the-box gap-mini">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td width="35%">Organization Number</td>
                                                            <td width="65%"><%#Eval("merchant_number")%></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="35%">Organization Category</td>
                                                            <td width="65%">
                                                                <asp:DropDownList ID="ddlMerchantCategory" CssClass="form-control" AutoPostBack="true" runat="server">
                                                                </asp:DropDownList></td>
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
                                                                <asp:TextBox ID="txtFaxNo" MaxLength="11" onkeydown="return isNumberKey(event)" runat="server" placeholder="Fax no" CssClass="form-control" Text='<%# Bind("fax_no") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Website</td>
                                                            <td>
                                                                <asp:TextBox ID="txtMerchantWebURL" runat="server" placeholder="Merchant website URL" CssClass="form-control" Text='<%# Bind("website") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Address Line 1</td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress1" runat="server" CssClass="form-control" Text='<%# Bind("address_1") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Address Line 2</td>
                                                            <td>
                                                                <asp:TextBox ID="txtaddress2" runat="server" CssClass="form-control" Text='<%# Bind("address_2") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Postcode</td>
                                                            <td>
                                                                <asp:TextBox ID="txtPostcode" MaxLength="5" onkeydown="return isNumberKey(event)" runat="server" CssClass="form-control" Text='<%# Bind("postcode") %>' /></td>
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
