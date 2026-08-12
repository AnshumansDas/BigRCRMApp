<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMember.aspx.cs" Inherits="CRMApp.crmapp.frmMember" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PopupAddEditUserModal() {
          $('#AddEditMember').modal(open);
        }
        function Hidepopup() {
            $('#AddEditMember').modal('hide');
            $('.modal-backdrop').remove();
         
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upMember">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>User Listing</h2>
                    </div>
                    <div id="AddEditMember" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title">
                                        <asp:Label ID="lblPopUpTitle" runat="server"></asp:Label></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        Role<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvRole" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlRole" ValidationGroup="submitValAddEditUser" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:DropDownList ID="ddlRole" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        Name<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvName" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtName" ValidationGroup="submitValAddEditUser" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtName" runat="server" placeholder="Name of user" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        Username<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvUsername" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtUsername" ValidationGroup="submitValAddEditUser" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Username for login" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        Email<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvEmail" SetFocusOnError="True" runat="server" CssClass="required" ControlToValidate="txtEmailAddress" ValidationGroup="submitValAddEditUser" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="valRegExEmail" runat="server" ControlToValidate="txtEmailAddress"
                                            ErrorMessage="Please give a valid email address" ValidationGroup="submitValAddEditUser" CssClass="required"
                                            ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                        </asp:RegularExpressionValidator>
                                        <asp:TextBox ID="txtEmailAddress" runat="server" placeholder="User email address" CssClass="form-control"></asp:TextBox>
                                       
                                    </div>
                                    <div class="form-group">
                                        Active Status
                                        <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group text-right">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="submitValAddEditUser" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" class="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4" style="text-align: right; margin-top: 16px;">
                            <span id="invalidmsg" runat="server" style="font-size: smaller;"></span>
                            <%-- <span id="checkexistedemail" runat="server" style="font-size: smaller;"></span>--%>
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:LinkButton ID="lnkAddNewMember" runat="server" CssClass="btn btn-info" OnClick="lnkAddNewMember_Click">Add New</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <asp:ListView ID="LV_Member" runat="server" DataKeyNames="user_id" OnItemCommand="LV_Member_ItemCommand"
                        OnItemEditing="LV_Member_ItemEditing" OnItemDataBound="LV_Member_ItemDataBound" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                        OnPagePropertiesChanging="LV_Member_PagePropertiesChanging">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%; text-align: left">Role Name</th>
                                        <th style="width: 15%; text-align: left;">User Name</th>
                                        <th style="width: 20%; text-align: center;">Email Id</th>
                                        <th style="width: 15%; text-align: center;">Created Date</th>
                                        <th style="width: 15%; text-align: center;">Active Status</th>
                                        <th style="width: 10%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LV_Member" PageSize="10">
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
                            </div>
                            <div class="gap-mid"></div>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                        </GroupTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                <td style="text-align: left"><%# Eval("user_role") %></td>
                                <td style="text-align: left;"><%# Eval("user_name") %></td>
                                <td style="text-align: center;"><%# Eval("email_id").ToString().Trim() %></td>
                                <td style="text-align: center;"><%# Eval("Created_date") %></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                <td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Member" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit</asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%; text-align: center">Role Name</th>
                                        <th style="width: 15%; text-align: center;">User Name</th>
                                        <th style="width: 20%; text-align: center;">Email Id</th>
                                        <th style="width: 15%; text-align: center;">Created Date</th>
                                        <th style="width: 15%; text-align: center;">Active Status</th>
                                        <th style="width: 10%; text-align: center;">Action</th>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
