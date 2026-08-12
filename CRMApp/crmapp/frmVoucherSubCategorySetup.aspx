<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmVoucherSubCategorySetup.aspx.cs" Inherits="CRMApp.crmapp.frmVoucherSubCategorySetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function popupdetails() {
            $("#Addvouchersubcat").modal(open);
        }
        function hidepopupwithdata() {
            debugger;
           $("#Addvouchersubcat").modal("hide");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Setup Voucher Sub Category</h2>
            </div>
            <div></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                         <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                            <span id="message" runat="server" style="font-size: smaller;"></span>
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                           <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add New" class="btn btn-info"/>
                        </div>                       
                    </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="lvVoucherSubCategoy" runat="server" DataKeyNames="voucher_Sub_cat_id" OnItemCommand="lvVoucherSubCategoy_ItemCommand" OnPagePropertiesChanging="lvVoucherSubCategoy_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvVoucherSubCategoy_ItemDataBound" OnItemEditing="lvVoucherSubCategoy_ItemEditing">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">Sl No</th>
                                            <th style="width: 35%; text-align: center;">Category Name</th>
                                            <th style="width: 35%; text-align: center;">Sub Category Name</th>
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
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvVoucherSubCategoy" PageSize="10">
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
                                    <td style="text-align: center;"><%# Eval("voucher_main_category").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("voucher_sub_category").ToString().Trim() %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                           <th style="width: 5%; text-align: center;">Sl No</th>
                                            <th style="width: 35%; text-align: center;">Category Name</th>
                                            <th style="width: 35%; text-align: center;">Sub Category Name</th>
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
    </div>
    <div id="Addvouchersubcat" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Add/Edit Voucher Sub Category</h4>

                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpAddVouchersubcat" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="required" ControlToValidate="ddlCategory" ValidationGroup="submitValue" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                    <div class="col-sm-12">
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataTextField="voucher_main_category" DataValueField="Voucher_main_cat_id"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">Sub Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="required" ControlToValidate="txtSubCategory" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                    <div class="col-sm-12">
                                        <asp:TextBox ID="txtSubCategory" runat="server" CssClass="form-control" placeholder="Sub Category name"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        Active Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="ddlActiveStatus" ValidationGroup="submitValue" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                    <div class="col-sm-12">
                                        <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="NA" Text="-Select-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submitValue" />
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

</asp:Content>
