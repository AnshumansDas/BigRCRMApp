<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmFeedback.aspx.cs" Inherits="CRMApp.crmapp.frmFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upMember">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Feedback listing</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="row">
                            <%--<label class="col-sm-2 control-label">Feedback Status</label>--%>
                            <div class="col-sm-3">
                                <div class="search-categori">
                                    <div class="search-box">
                                        <asp:DropDownList ID="ddlReplyStatus" runat="server" CssClass="form-control" TabIndex="1" AutoPostBack="True" OnSelectedIndexChanged="ddlReplyStatus_SelectedIndexChanged">
                                            <asp:ListItem Value="2" Text="All"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Reply"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="Not Reply"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5 text-right">
                                <span id="Span1" runat="server" style="font-size: smaller;"></span>
                            </div>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="lvFeedbackList" runat="server" DataKeyNames="ID" OnItemCommand="lvFeedbackList_ItemCommand" OnItemDeleting="lvFeedbackList_ItemDeleting"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvFeedbackList_PagePropertiesChanging"
                            OnItemDataBound="lvFeedbackList_ItemDataBound">
                            <LayoutTemplate>
                                <table class="table-list table table-striped nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Subject</th>
                                            <th>Mobile No</th>
                                            <th>Role</th>
                                            <th>Create Date</th>
                                            <th>Reply Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="gap gap-mid">
                                            <label class="">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvFeedbackList" PageSize="10">
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
                            </LayoutTemplate>
                            <GroupTemplate>
                                <tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                </tr>
                            </GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td data-title="No" style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                    <td data-title="Name"><%# Eval("name") %></td>
                                    <td data-title="Email"><%# Eval("email") %></td>
                                    <td data-title="Subject"><%# Eval("subject") %></td>
                                    <td data-title="Mobile No"><%# Eval("hp_no ") %></td>
                                    <td data-title="Role"><%# Eval("role_type ") %></td>
                                    <td data-title="Create Date"><%# Eval("create_date ") %></td>
                                    <td data-title="Status"><span id="colorstatus" runat="server"><%# (Eval("reply_status").ToString() == "1") ? "Reply":"Not Reply" %></span></td>
                                    <td data-title="Action">
                                        <asp:HiddenField ID="HdnReplyStatus" runat="server" Value='<%# Eval("reply_status") %>' />
                                        <asp:LinkButton ID="lnkEdit" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" runat="server" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lnkDelete" ToolTip="Delete Content" CssClass="btn btn-danger btn-xs" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure to delete?');"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table-list table table-striped nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Subject</th>
                                            <th>Mobile No</th>
                                            <th>Role</th>
                                            <th>Create Date</th>
                                            <th>Reply Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" style="text-align: center;">No Feedback found!!!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
