<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmNormalUserProfile.aspx.cs" Inherits="CRMApp.crmapp.frmNormalUserProfile" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function changeQuantity(obj) {
            var count = $(obj).closest('tr').find("[id$='fuUserPhoto']").val();
            alert(count);
        }

        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                $(obj).closest('tr').find("[id$='btnUpload']").click();
                $(obj).closest('tr').find("[id$='imgUserPhoto']").click();
            }
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
                                                        <%--<img  src="../dashboard/img/avatar/avatar.jpg">--%>
                                                        <img id="imgUser" runat="server" src='<%#Eval("image_path")%>' />
                                                    </div>
                                                    <h1><%#Eval("user_fistname")%></h1>
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
                                                    <td width="75%">BigR Member Password</td>
                                                    <%--<td width="25%" class="text-center">
                                                        <asp:HyperLink ID="hplChangePassword" runat="server" CssClass="btn btn-bigr btn-xs" NavigateUrl="frmChangePassword.aspx">Change</asp:HyperLink>
                                                    </td>--%>
                                                </tr>
                                                <%--<tr>
                                            <td>Facebook</td>
                                            <td class="text-center">
                                                <button class="btn btn-info btn-xs">Connect</button></td>
                                        </tr>
                                        <tr>
                                            <td>Google</td>
                                            <td class="text-center">
                                                <button class="btn btn-success btn-xs">Connected</button></td>
                                        </tr>--%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Profile <span class="pull-right">
                                                <%--<button class="btn btn-primary btn-xs">Edit</button>--%>
                                                <%--<asp:Button ID="EditProfile" Text="Edit" runat="server" CssClass="btn btn-primary btn-xs" CommandName="Edit" />--%>
                                                <asp:LinkButton ID="EditProfile" Text="Edit" runat="server" CssClass="btn btn-primary btn-xs" CommandName="Edit"></asp:LinkButton>
                                            </span></h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Name</td>
                                                    <td width="75%"><%#Eval("user_fistname")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Date of Birth</td>
                                                    <td><%#Eval("user_dateofbirth")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Email Address</td>
                                                    <td><%#Eval("email_id")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Mobile No</td>
                                                    <td><%#Eval("mobile_no")%></td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Addtional Information</h4>
                                        </div>
                                    </div>
                                    <div class="the-box gap-mini">
                                        <table class="table table-striped table-bordered table-hover">
                                            <tbody>
                                                <tr>
                                                    <td width="25%">Address Line 1</td>
                                                    <td width="75%"><%#Eval("address1")%></td>
                                                </tr>
                                                <tr>
                                                    <td width="25%">Address Line 2</td>
                                                    <td width="75%"><%#Eval("address2")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Postcode</td>
                                                    <td><%#Eval("postcode_id")%></td>
                                                </tr>
                                                <tr>
                                                    <td>State</td>
                                                    <td><%#Eval("state_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td>City</td>
                                                    <td><%#Eval("city_name")%></td>
                                                </tr>
                                                <tr>
                                                    <td>Country</td>
                                                    <td><%#Eval("country_name")%></td>
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
                                                        <img id="imgUserPhoto" runat="server" />
                                                    </div>
                                                    <h1><%#Eval("user_fistname")%></h1>
                                                </div>
                                                <ul class="nav nav-pills nav-stacked">
                                                    <form>
                                                        <%--<span id="fileselector">
                                                            <label class="btn btn-default btn-block" for="file_upload">
                                                                <input id="file_upload" type="file">
                                                                <i class="fa fa-edit"></i>Update Profile Picture
                                                            </label>
                                                        </span>--%>
                                                        <div id='file_browse_wrapper'>
                                                            <%--<asp:FileUpload ID="fuUserPhoto" onchange="this.form.submit()" runat="server" CssClass="file_browse" />--%>
                                                            <asp:FileUpload ID="fuUserPhoto" runat="server" CssClass="file_browse" />
                                                        </div>
                                                        <%--<asp:FileUpload ID="fuUserPhoto" runat="server" />
                                                        <asp:Button ID="btnUpload" Text="Upload" runat="server" Style="display: none" OnClick="UploadFile" />--%>
                                                        <div><span id="logovalidatemsg" runat="server" style="font-size: small;"></span></div>
                                                        <div>
                                                            <span id="Span1" runat="server" style="font-size: small; color: darkblue;">Maximum file size to upload is 2MB (format: png\jpg\jpeg)</span>
                                                        </div>
                                                    </form>
                                                </ul>

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
                                                    <td width="75%">BigR Member Password</td>
                                                    <td width="25%" class="text-center">
                                                        <asp:HyperLink ID="hplChangePassword" runat="server" CssClass="btn btn-bigr btn-xs" NavigateUrl="frmChangePassword.aspx">Change</asp:HyperLink>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                            <td>Facebook</td>
                                            <td class="text-center">
                                                <button class="btn btn-info btn-xs">Connect</button></td>
                                        </tr>
                                        <tr>
                                            <td>Google</td>
                                            <td class="text-center">
                                                <button class="btn btn-success btn-xs">Connected</button></td>
                                        </tr>--%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="title">
                                        <div class="sub">
                                            <h4>Profile <span class="pull-right">
                                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="btn btn-default btn-sm">Cancel <i class="fa fa-chevron-left"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lnkSave" ValidationGroup="submitValMyProfile" runat="server" CommandName="Update" CssClass="btn btn-warning btn-sm">Save <i class="fa fa-plus" aria-hidden="true"></i></asp:LinkButton>
                                            </span></h4>
                                        </div>
                                    </div>
                                    <asp:UpdatePanel runat="server" ID="upNormalUserProfile">
                                        <ContentTemplate>
                                            <div class="the-box gap-mini">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td width="25%">Name</td>
                                                            <td width="75%">
                                                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Bind("user_fistname") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Date of Birth
                                                                <asp:RequiredFieldValidator ID="rfvDOB" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtDob" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <div class="input-group date">
                                                                    <asp:TextBox ID="txtDob" runat="server" class="form-control datepicker" Text='<%# Bind("user_dateofbirth") %>' placeholder="Date of birth"></asp:TextBox>
                                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Email Address</td>
                                                            <td>
                                                                <asp:TextBox ID="txtEmailID" runat="server" Enabled="false" CssClass="form-control" Text='<%# Bind("email_id") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Mobile No
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtMobileNo" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtMobileNo" MaxLength="11" onkeydown="return isNumberKey(event)" runat="server" placeholder="Mobile phone no" CssClass="form-control" Text='<%# Bind("mobile_no") %>' />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="title">
                                                <div class="sub">
                                                    <h4>Addtional Information</h4>
                                                </div>
                                            </div>
                                            <div class="the-box gap-mini">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td width="25%">Address 1
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtaddress1" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td width="75%">
                                                                <asp:TextBox ID="txtaddress1" runat="server" CssClass="form-control" Text='<%# Bind("address1") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="25%">Address 2</td>
                                                            <td width="75%">
                                                                <asp:TextBox ID="txtaddress2" runat="server" CssClass="form-control" Text='<%# Bind("address2") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Postcode
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtPostcode" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPostcode" MaxLength="5" onkeydown="return isNumberKey(event)" runat="server" CssClass="form-control" Text='<%# Bind("postcode_id") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>State
                                                                <asp:RequiredFieldValidator ID="rfvMerchantState" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlState" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>City
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlCity" ValidationGroup="submitValMyProfile" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Country</td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCountry" runat="server" class="form-control">
                                                                    <%--<asp:ListItem Value="" Text="-Select-"></asp:ListItem>--%>
                                                                    <asp:ListItem Value="1" Text="Malaysia"></asp:ListItem>
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
                    <EmptyDataTemplate>
                        <p style="text-align: center;">No record found!</p>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>
