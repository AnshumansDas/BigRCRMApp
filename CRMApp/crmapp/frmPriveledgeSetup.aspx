<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPriveledgeSetup.aspx.cs" Inherits="CRMApp.crmapp.frmPriveledgeSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Voucher Lists</h2>
        </div>
        <div></div>
    </div>
    <asp:UpdatePanel ID="upVoucheList" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-6">
                        <asp:Label ID="lblmsg" runat="server" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="col-sm-6 text-right">
                        <asp:LinkButton ID="btnback" runat="server" Text="Back" OnClick="btnback_Click" CssClass="btn btn-default" />
                        <asp:LinkButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success" />                        
                    </div>
                </div>
                <div>
                    <asp:ListView ID="lvPageList" runat="server" DataKeyNames="privilege_id"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvPageList_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-checkout" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%;">Page Name</th>
                                        <th style="width: 20%;">View Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <%--<div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvVoucherList" PageSize="10">
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
                                <td style="text-align: left;"><%# Eval("module_name")%>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("previledge_status")%>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblPreId" runat="server" Text='<%# Eval("privilege_id")%>' Visible="false"></asp:Label>
                                </td>
                                <th style="width: 20%; text-align: left;">
                                    <asp:CheckBox ID="chkpage" runat="server" />
                                </th>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%;">Page Name</th>
                                        <th style="width: 20%;">View Status</th>
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
                <div class="row">
                    <div class="col-sm-6">
                        <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="col-sm-6 text-right">
                        <asp:LinkButton ID="btnBack2" runat="server" Text="Back" OnClick="btnback_Click" CssClass="btn btn-default" />
                        <asp:LinkButton ID="btnSave2" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success" />
                    </div>
                </div>
                <div class="gap-mini"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
