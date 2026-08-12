<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCommunityMasterDetails.aspx.cs" Inherits="CRMApp.crmapp.frmCommunityMasterDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function popupopen() {
            $("#AddNewCommunity").modal(open);
        }
        function hidepopup() {
            $("#AddNewCommunity").modal("hide");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Registered Community</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>

        <asp:UpdatePanel runat="server" ID="upCommunity">
            <ContentTemplate>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged" class="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6" style="text-align: right;">
                            <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" class="btn btn-info" />
                        </div>
                    </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="Lv_Community" runat="server" DataKeyNames="community_id" OnItemCommand="Lv_Community_ItemCommand" OnPagePropertiesChanging="Lv_Community_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="Lv_Community_ItemDataBound" OnItemEditing="Lv_Community_ItemEditing">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 4%; text-align: center;">#</th>
                                            <th style="width: 20%;">Community Name</th>
                                            <th style="width: 12%; text-align: center;">Activation URL</th>
                                            <th style="width: 9%; text-align: center;">Updated Date</th>
                                            <th style="width: 8%; text-align: center;">Status</th>
                                            <th style="width: 8%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_Community" PageSize="10">
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
                                    <td><%# Eval("community_name").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("community_url") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_date") %></td>
                                    <td style="text-align: center;"><span id="activestatus" runat="server"><%# Eval("active_status").ToString().Trim() == "1" ? "Active" : "Inactive" %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Community" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 4%; text-align: center;">#</th>
                                            <th style="width: 20%;">Community Name</th>
                                            <th style="width: 12%; text-align: center;">Activation URL</th>
                                            <th style="width: 9%; text-align: center;">Updated Date</th>
                                            <th style="width: 8%; text-align: center;">Status</th>
                                            <th style="width: 8%; text-align: center;">Action</th>
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

        <div id="AddNewCommunity" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Add New Community</h4>

                    </div>
                    <div class="modal-body">
                        <asp:UpdatePanel ID="UpdCommunity" runat="server">
                            <ContentTemplate>
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlSPid" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="txtCommunityName" ClientIDMode="Static" CssClass="form-control myfocus" runat="server" placeholder="Community Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtCommunityName" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="txtCommunityUrl" CssClass="form-control" runat="server" placeholder="Activation Url"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="regUrl" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationExpression="^((http|https)://)?([\w-]+\.)+[\w]+(/[\w- ./?]*)?$" Text="Required valid URL" />
                                </div>
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlActiveStatus_Community" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div id="Div2" runat="server" class="form-group" style="font-size: smaller;">
                                    <span id="message_community" runat="server" style="font-size: smaller;"></span>
                                </div>
                                <asp:LinkButton ID="lnkSubmit" runat="server" OnClick="lnkSubmit_Click" ValidationGroup="AddEditCommunityValue" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

    </div>

</asp:Content>
