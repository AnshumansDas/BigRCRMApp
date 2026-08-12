<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMyFeedback.aspx.cs" Inherits="CRMApp.crmapp.frmMyFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>My Feedback</h2>
        </div>
        <div></div>
    </div>
    <asp:UpdatePanel ID="upFeedbackList" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div>
                    <asp:ListView ID="lvFeedbackList" runat="server" DataKeyNames="ID"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvFeedbackList_PagePropertiesChanging"
                        OnItemDataBound="lvFeedbackList_ItemDataBound" OnItemCommand="lvFeedbackList_ItemCommand">
                        <LayoutTemplate>
                             <div class="row">
                        <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                             <table class="table-list table table-striped nowrap" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Subject</th>
                                        <th>Created date</th>
                                       <%-- <th>Reply By</th>
                                        <th>Reply Message</th> --%>
                                        <th>Reply Status</th>
                                       <th>Reply Date</th>
                                        <th>action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="gap-mid"></div>
                            <div class="row">                               
                                <div class="col-sm-12 text-right">
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
                             <div class="gap-mid"></div>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <tr>
                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                            <tr>
                                <td data-title="No" style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                <%--<td data-title="Name"><%# Eval("name") %>></td>--%>
                                <td data-title="Name"><%# Eval("name") %></td>
                                <td data-title="Email"><%# Eval("email") %></td>
                                <td data-title="Subject"><%# Eval("subject") %></td>
                                <td data-title="Create Date"><%# Eval("create_date") %></td>
                              <%--  <td data-title="Create Date"><%# Eval("reply_by ") %></td>
                                <td data-title="Create Date"><%# Eval("reply_msg ") %></td> --%>                               
                               <td data-title="Status"><span id="colorstatus" runat="server"><%#Eval("reply_status").ToString().Trim()%></span></td>                             
                               <td data-title="Create Date"><%# Eval("update_date ") %></td>
                                <td>
                                   <asp:LinkButton ID="lnkView" runat="server" ToolTip="View Content" CssClass="btn btn-primary btn-xs" commandname="View">View</asp:LinkButton>
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
                                        <th>Created date</th>
                                       <%--  <th>Reply By</th>
                                      <th>Reply Message</th> --%>                                      
                                         <th>Reply Status</th>
                                         <th>Reply Date</th>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
