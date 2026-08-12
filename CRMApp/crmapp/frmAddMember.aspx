<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/crmapp/CRMBack.Master" CodeBehind="frmAddMember.aspx.cs" Inherits="CRMApp.crmapp.frmAddMember" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Account Information</h2>
            </div>
            <div id="viewlogo" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 style="text-align: center;">Merchant Logo</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:Image ID="imgMerchantLogo" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                                <div class="col-sm-2 text-right">
                                    <div class="form-group">
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtName" CssClass="form-control focus" runat="server" placeholder="Name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" CssClass="required" ControlToValidate="txtName" ValidationGroup="submitValsave" ErrorMessage="Please Enter Your Name"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Email<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Email address"></asp:TextBox><br />
                                    <asp:Label ID="lblSignupMsg" runat="server" Text="" Visible="false"></asp:Label>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvtxtEmail" runat="server" CssClass="required" ControlToValidate="txtEmail" ValidationGroup="submitValsave" ErrorMessage="Please Enter Your Email Id"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="valRegEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Please give a valid email address" ValidationGroup="submitValMerchantAddEdit" CssClass="required"
                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mobile Phone No<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtMobileNo" CssClass="form-control" runat="server" placeholder="Mobile phone no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    <asp:RequiredFieldValidator ID="rfvHpNo" runat="server" CssClass="required" ControlToValidate="txtMobileNo" ValidationGroup="submitValsave" ErrorMessage="Please Enter Your Contact Number"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Additional Information</h2>
            </div>
            <div class="form-horizontal">

                <div class="col-md-12">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Date of Birth</label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="startdate">
                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker" placeholder="start date"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">Address 1</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtAddress1" CssClass="form-control" runat="server" placeholder="Address Line 1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">Address 2</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtAddress2" CssClass="form-control" runat="server" placeholder="Address Line 2"></asp:TextBox>
                        </div>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpAddmember">
                        <ContentTemplate>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">State</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">City</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">Postcode</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtPostcode" CssClass="form-control" runat="server" MaxLength="5" placeholder="Postcode" onkeypress="return isNumberKey(event)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">Status</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                <asp:ListItem Text="--Select Status--" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="InActive" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-sm-12 text-right">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <div class="form-group">
                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="submitValsave" CssClass="btn btn-info" OnClick="btnsave_click" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="gap-mid"></div>
    </div>
</asp:Content>

