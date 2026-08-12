<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmSecuritySettings.aspx.cs" Inherits="CRMApp.crmapp.frmSecuritySettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function blockSpecialChar(e) {
            var k = e.keyCode;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || (k >= 48 && k <= 57));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="UpSecuritySettings" runat="server">
        <ContentTemplate>
            <%--<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>--%>
            <a name="security" target="_self"></a>
            <div class="row">
                <!--col-md-3-->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="area-title bdr mt20">
                            <h2>Password Security Settings</h2>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div id="divAlert" runat="server">
                            <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                <asp:Label ID="lblerrormsg" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div id="no-more-tables">
                                    <table class="table-bordered table-striped table-condensed cf" style="width: 100%">
                                        <thead class="cf">
                                            <tr>
                                                <th>No.</th>
                                                <th>Items</th>
                                                <th>Value</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td data-title="No" align="center">1</td>
                                                <td data-title="Password History(Minimum Value is 1)">Password History(Minimum Value is 1)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="password_historyTxt" runat="server" CssClass="form-control" MaxLength="45" TabIndex="1" Width="300px" onfocus="SetEnd(this)"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="password_historyRFV" runat="server" ErrorMessage="Password History is required." CssClass="error" ControlToValidate="password_historyTxt">*</asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">2</td>
                                                <td data-title="Password Expiry Type">Password Expiry Type</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="passwordExpiry_typeRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1">Never expire for all users</asp:ListItem>
                                                            <asp:ListItem Value="2">Expiry password for all users after</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="password_expiry" runat="server" ErrorMessage="Select One option is required." CssClass="error" ControlToValidate="passwordExpiry_typeRd"></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">3</td>
                                                <td data-title="Password Expiry Days">Password Expiry Days</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="password_expirydaysTxt" runat="server" CssClass="form-control" MaxLength="45" TabIndex="1" Width="300px" onfocus="SetEnd(this)"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="password_expirydays" runat="server" ErrorMessage="Password Expiry Days is required." CssClass="error" ControlToValidate="password_expirydaysTxt"></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">4</td>
                                                <td data-title="Change Password On 1st Logon">Change Password On 1st Logon</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="change_passwordRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="change_password" runat="server" ErrorMessage="Change Password On 1st Logon is required." CssClass="error" ControlToValidate="change_passwordRd"></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">5</td>
                                                <td data-title="Minimum Password Length">Minimum Password Length</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="password_lengthTxt" runat="server" CssClass="form-control" MaxLength="45" TabIndex="1" Width="300px" onfocus="SetEnd(this)"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="password_length" runat="server" ErrorMessage="Minimum Password Length is required." CssClass="error" ControlToValidate="password_lengthTxt"></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">6</td>
                                                <td data-title="Merchant ID">Minimum numeric characters in password(Minimum value is 0)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="minimum_numericTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="1" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="minimum_numeric" runat="server" ControlToValidate="minimum_numericTxt" CssClass="error" ErrorMessage="Minimum numeric characters in password is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td data-title="No" align="center">7</td>
                                                <td data-title="Minimum alpha characters in password(Minimum value is 0)">Minimum alpha characters in password(Minimum value is 0)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="minimum_alphaTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="1" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="minimum_alpha" runat="server" ControlToValidate="minimum_alphaTxt" CssClass="error" ErrorMessage="Minimum alpha characters in password is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td data-title="No" align="center">8</td>
                                                <td data-title="Minimum Uppercase Characters In Password(Minimum value is 0)">Minimum Uppercase Characters In Password(Minimum value is 0)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="upper_charactersTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="1" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="upper_characters" runat="server" ControlToValidate="upper_charactersTxt" CssClass="error" ErrorMessage="Minimum Uppercase Characters In Password is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">9</td>
                                                <td data-title="Minimum Lowercase Characters In Password(Minimum value is 0)">Minimum Lowercase Characters In Password(Minimum value is 0)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="lowercase_charactersTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="9" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="lowercase_characters" runat="server" ControlToValidate="lowercase_charactersTxt" CssClass="error" ErrorMessage="Minimum Lowercase Characters In Password is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">10</td>
                                                <td data-title="Password Minimum Age(User is Allowed To Change Password How Many Time(s))">Password Minimum Age(User is Allowed To Change Password How Many Time(s))</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="minimum_ageTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="9" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="minimum_age" runat="server" ControlToValidate="minimum_ageTxt" CssClass="error" ErrorMessage="Password Minimum Age is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">11</td>
                                                <td data-title="Password Change Remainder(How Many Days Before Expire)">Password Change Remainder(How Many Days Before Expire)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="password_remainderTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="9" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="password_remainder" runat="server" ControlToValidate="password_remainderTxt" CssClass="error" ErrorMessage="Password Change Remainder is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">12</td>
                                                <td data-title="Allow Multiple Simultaneous Online Session(Multiple Login)">Allow Multiple Simultaneous Online Session(Multiple Login)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="multiple_loginRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="2">No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="multiple_login" runat="server" ControlToValidate="multiple_loginRd" CssClass="error" ErrorMessage="Slect one option for Multiple Login is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">13</td>
                                                <td data-title="Answer Security Questions after Login">Answer Security Questions after Login</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="security_queansRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>                                                            
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="security_queans" runat="server" ControlToValidate="security_queansRd" CssClass="error" ErrorMessage="Slect one option for Answer Security Questions after Login is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">14</td>
                                                <td data-title="Maximum Logon Retry Per Single Logon Session(In Times)">Maximum Logon Retry Per Single Logon Session(In Times)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="maximum_logonretryRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="0">No maximum logon retry</asp:ListItem>
                                                            <asp:ListItem Value="1">For all users</asp:ListItem>                                                            
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="maximum_logonretry" runat="server" ControlToValidate="maximum_logonretryRd" CssClass="error" ErrorMessage="Slect one option for Maximum Logon Retry Per Single Logon Session is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td data-title="No" align="center">15</td>
                                                <td data-title="Maximum Session For Logon Retry(In Times)">Maximum Session For Logon Retry(In Times)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:RadioButtonList ID="maximum_sessionRd" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="0">No maximum Session</asp:ListItem>
                                                            <asp:ListItem Value="1">One Sessions</asp:ListItem>                                                            
                                                        </asp:RadioButtonList>
                                                        <asp:RequiredFieldValidator ID="maximum_session" runat="server" ControlToValidate="maximum_sessionRd" CssClass="error" ErrorMessage="Select one option Maximum Session For Logon Retry is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">16</td>
                                                <td data-title="UserId Lockout Duaration">UserId Lockout Duaration</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-12 col-sm-12 col-md-12 col-xs-12 storedata">
                                                        <asp:TextBox ID="user_lockoutTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="9" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="user_lockout" runat="server" ControlToValidate="user_lockoutTxt" CssClass="error" ErrorMessage="UserId Lockout Duaration is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td data-title="No" align="center">17</td>
                                                <td data-title="Inactive Account Action(Revoke After ? Days)">Inactive Account Action(Revoke After ? Days)</td>
                                                <td data-title="Merchant Name">
                                                    <p class="col-lg-6 col-sm-9 col-md-9 col-xs-12 storedata">
                                                        <asp:TextBox ID="inactive_accountTxt" runat="server" CssClass="form-control" MaxLength="45" onfocus="SetEnd(this)" TabIndex="9" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="inactive_account" runat="server" ControlToValidate="inactive_accountTxt" CssClass="error" ErrorMessage="Inactive Account Action is required."></asp:RequiredFieldValidator>
                                                    </p>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td data-title="No" align="right" colspan="3">
                                                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Cancel" OnClick="btnCancel_Click" />
                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="gap gap-med"></div>
                            </div>
                        </div>
                    </div>
                </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
