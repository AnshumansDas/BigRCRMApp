<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmNotification.aspx.cs" Inherits="CRMApp.crmapp.frmNotification"  MasterPageFile="~/crmapp/CRMBack.Master"%>

<asp:Content ID="Content12" ContentPlaceHolderID="head" runat="server">
  
</asp:Content>
<asp:Content runat="server" ID="cNotification" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upNotification" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="row">
            <div class="col-sm-12">
                <div class="area-title bdr mt20">
                    <h2>Email Notifications</h2>
                    <span id="message" runat="server" style="font-size: smaller;"></span>
                </div>
                <div></div>
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
                </div>
                <div>
                    <asp:ListView ID="Lv_Notification" runat="server" DataKeyNames="notification_id" 
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_Notification_PagePropertiesChanging"  OnItemCommand="Lv_Notification_ItemCommand" >
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                          <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 10%; text-align: center;display:none">notification id</th>
                                        <th style="width: 0%; text-align: center;display:none">notification category</th>
                                          <th style="width: 20%; text-align: center;">category</th>
                                        <th style="width: 20%; text-align: center;">Title</th>
                                        <th style="width:0%;text-align: center;display:none">Description</th>
                                          <th style="width: 15%;text-align: center;">Notification date</th>
                                       <%-- <th style="width: 10%;">created Date</th>--%>
                                        <th style="width: 20%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager2" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_Notification" PageSize="10">
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
                                 <td style="text-align: center;display:none"><%# Eval("notification_id") %></td>
                                <td style="text-align: center;display:none"><%# Eval("notification_user_category") %></td>
                                <td style="text-align: center;"><%# Eval("user_role_description")%></td>
                                <td style="text-align: center;"><%# Eval("notification_title") %></td>
                                <td style="text-align: center;display:none"><%# Eval("notification_summary") %></td>
                                 <td style="text-align: center;"><%# Eval("notification_date") %></td>
                                <td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" commandname="View">View</asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" style="width: 100%" cellspacing="0">
                                <thead>
                                    <tr>
                                         <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 10%; text-align: center;display:none">notification id</th>
                                        <th style="width: 0%; text-align: center;display:none">notification category</th>
                                          <th style="width: 20%; text-align: center;">category</th>
                                        <th style="width: 20%; text-align: center;">Title</th>
                                        <th style="width:0%;text-align: center;display:none">Description</th>
                                          <th style="width: 15%;text-align: center;">Notification date</th>                                     
                                        <th style="width: 20%; text-align: center;">Action</th>
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
        </div>

       
    </ContentTemplate>
</asp:UpdatePanel>

    
       
</asp:Content>


