<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAdminWithdrawNotification.aspx.cs" Inherits="CRMApp.crmapp.frmAdminWithdrawNotification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
     <div class="row">
        <!--col-md-3-->
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Withdraw Notifications</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
      <!--   <asp:UpdatePanel ID="upMerchantDashboard" runat="server">
            <ContentTemplate>-->
               

                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        
                    </div>

                     
                                        <div class="col-md-2">
                                            <asp:TextBox ID="txtNotifyDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                                        </div>
                             
                                        
                                        <div class="col-md-2">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click"  />
                                        </div>
                    <div>
  <div class="gap gap-mid"></div>
                       
                             <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="notification_id" 
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" >
                            <LayoutTemplate>
                                <div class="row" style="display: none">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>No</th>
                                            <th>Merchant Name</th>
                                            <th>Reference No</th>
                                            <th>Verification Date</th>
                                            <th>Status</th>
                                            <th>Amount (RM)</th>
                                            <th>Remarks</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="row">
                                    <div class="gap gap-small"></div>
                                    <div class="col-md-12 text-right">
                                        <asp:DataPager ID="DataPager2" runat="server" class="btn-group btn-group-sm" PageSize="10">
                                            <Fields>
                                                <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                    ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary" RenderNonBreakingSpacesBetweenControls="false"
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
                                    <td data-title="No"  style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                  
                                    <td data-title="Merchant Name"><%# Eval("organization_name") %></td>
                                       <td data-title="Reference No"><%# Eval("reference_no") %></td>
                                    <td data-title="Verification Date"><%# Eval("notification_date") %></td>
                                     <td data-title="Status"><%# Eval("notification_type") %></td>
                                    <td data-title="Amount"><%# Eval("req_amount") %></td>
                                    <td data-title="Remarks"><%# Eval("notification_summary") %></td>
                                    
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                          <th>No</th>
                                            <th>Merchant Name</th>
                                            <th>Reference No</th>
                                            <th>Verification Date</th>
                                            <th>Status</th>
                                            <th>Amount</th>
                                            <th>Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" align="center">No Transaction record found!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>




           <!--  </ContentTemplate>
        </asp:UpdatePanel>-->
    </div>
</asp:Content>
