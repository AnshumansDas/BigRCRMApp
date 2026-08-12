<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMyProfile.aspx.cs" Inherits="CRMApp.crmapp.frmMyProfile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="upTransaction" runat="server">
        <ContentTemplate>
            <div class="main-area">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="area-title bdr mt20">
                                <h2>My Profile</h2>
                            </div>
                            <div></div>
                        </div>
                        <div class="content">
                            <div class="body">
                                <asp:UpdatePanel ID="upProfile" runat="server">
                                    <ContentTemplate>
                                        <div class="col-sm-12">
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">User Name</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtuserName" CssClass="form-control" runat="server" placeholder="Enter your Name"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">NRIC NO</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtNricNo" CssClass="form-control" runat="server" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);" MaxLength="12" placeholder="Enter NRIC No"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-3" style="margin-bottom: -5px;">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">DOB</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">

                                                            <div class="input-group date">
                                                                <asp:TextBox ID="txtDob" runat="server" class="form-control datepicker" placeholder="Date of birth"></asp:TextBox>
                                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                            </div>
                                                            <%--<asp:TextBox ID="txtDob" CssClass="form-control" runat="server"></asp:TextBox>--%>
                                                        </div>
                                                        <div class="col-sm-3" style="margin-bottom: -5px;">
                                                            <%--<asp:RequiredFieldValidator ID="RfvState" runat="server" CssClass="required" ControlToValidate="ddl_State" InitialValue="0" ValidationGroup="submitValue" ErrorMessage="Required Field"></asp:RequiredFieldValidator>--%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Gender</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:DropDownList ID="ddlGender" CssClass="form-control" runat="server">
                                                                <asp:ListItem Value="0" Text="- Please Select -"></asp:ListItem>
                                                                <asp:ListItem Value="M" Text="Male"></asp:ListItem>
                                                                <asp:ListItem Value="F" Text="Female"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Email ID</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtEmailId" runat="server" placeholder="abcd@abc.com" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-3" style="margin-bottom: -5px;">
                                                            <%--<asp:RequiredFieldValidator ID="RFVGracePeriod" runat="server" CssClass="required" ControlToValidate="TxtGracePeriod" InitialValue="" ValidationGroup="submitValue" ErrorMessage="Required Field"></asp:RequiredFieldValidator>--%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Mobile No</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);" CssClass="form-control" placeholder="Mobile no"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-3" style="margin-bottom: -5px;">
                                                            <%--<asp:RequiredFieldValidator ID="RfvSeasonalBay" runat="server" CssClass="required" ControlToValidate="TxtSeasonBay" InitialValue="" ValidationGroup="submitValue" ErrorMessage="Required Field"></asp:RequiredFieldValidator>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-horizontal">


                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Address</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtAddress1" runat="server" MaxLength="150" CssClass="form-control" placeholder="Villege/Town/Plot No.."></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-3" style="margin-bottom: -5px;">
                                                            <%--<asp:RequiredFieldValidator ID="RfvSeasonPrice" runat="server" CssClass="required" ControlToValidate="TxtSeasonPrice" InitialValue="0" ValidationGroup="submitValue" ErrorMessage="Required Field"></asp:RequiredFieldValidator>--%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label"></label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtAddress2" runat="server" MaxLength="150" CssClass="form-control" placeholder="Landmark near by"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Country</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:DropDownList ID="ddlcountry" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0" Text="- Please Select -"></asp:ListItem>
                                                                <asp:ListItem Value="1" Text="Malaysia"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">State</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Postcode</label>
                                                        <div class="col-sm-6" style="margin-bottom: -5px;">
                                                            <asp:TextBox ID="txtPostCode" runat="server" MaxLength="5" CssClass="form-control" placeholder="Postcode" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group text-right">
                                                        <div class="col-sm-6 col-sm-offset-3">
                                                            <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Submit" ValidationGroup="submitValue" CssClass="btn btn-success" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-horizontal">
                                            <div class="form-group text-right">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <asp:Label ID="lblMsg" runat="server" Text="" />
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
