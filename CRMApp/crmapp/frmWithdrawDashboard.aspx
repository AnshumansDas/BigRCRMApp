<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmWithdrawDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmWithdrawDashboard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="row">
        <!--col-md-3-->
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Withdraw Dashboard</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
        <asp:UpdatePanel ID="upMerchantDashboard" runat="server">
            <ContentTemplate>
                <div class="col-sm-12">
                    <div>

                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-3.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Transaction
                                    </span>
                                    <div class="progress">
                                        <div id="divlblTotalwdTransaction" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalwdTransaction" runat="server" />
                                    </span>
                                </div>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->

                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Completed Withdrawal
                                    </span>
                                    <div class="progress">
                                        <div id="divlblTotalCompleted" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalCompleted" runat="server" />
                                    </span>
                                </div>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->

                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-2.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Pending Withdrawal</span>
                                    <div class="progress">
                                        <div id="divlblPending" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblPending" runat="server" />
                                    </span>
                                </div>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->

                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                <span class="info-box-text">Available Amount<br />
                                    to Withdraw</span>
                                <div class="progress">
                                    <div id="divlblwdAvailableAmount" runat="server" class="progress-bar" role="progressbar"></div>
                                </div>
                                <span class="progress-description">
                                    <asp:Label ID="lblwdAvailableAmount" runat="server" />
                                </span>
                                </div>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->

                        <!--==================== Recently Bought area end==================== -->

                        <div class="clearfix"></div>
                        <!-- product-details-end-->
                    </div>
                    <!-- row-end-->
                </div>
                <!--col-md-12-->
                <!--Request Withdraw-->
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Request Withdraw</h2>
                    </div>
                </div>
<!--
                <div class="col-sm-12">
                    <div class="form-horizontal">
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Available Amount</label>
                                <div class="col-md-7 col-sm-6">
                                    <p class="form-control-static">RM <asp:Label ID="lblAvailableAmount" Text="" runat="server"></asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
-->
                <div class="col-sm-12">
                    <div class="form-horizontal">
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Requested Amount&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-md-7 col-sm-6">
                                    <asp:HiddenField ID="hdAvailamt" Value="" runat="server" />
                                    <asp:TextBox ID="txtReqAmnt" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
                                    <asp:HiddenField ID="hdMerchantId" Value="" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Bank Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-md-7 col-sm-6">
                                    <asp:DropDownList ID="ddlBankList" CssClass="form-control" runat="server" AutoPostBack="true" TabIndex="0" DataTextField="bank_name" DataValueField="bank_code" OnSelectedIndexChanged="ddlBankList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <div class="col-md-12 col-sm-12">
                                    <asp:TextBox ID="txAccountNo" runat="server" TabIndex="1" CssClass="form-control" placeholder="Account Number"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <div class="col-md-12 text-right">
                                    <asp:Button ID="btnRequest" runat="server" TabIndex="25" Text="Request" CssClass="btn btn-success" OnClick="btnRequest_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <br />
                                <span id="invalidmsg" runat="server" style="font-size: smaller; color: green;"></span>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-sm-12">
                    <div class="label label-primary">Note : Minimum withdrawal amount is RM100</div>
                </div>
                <!--end Request Withdraw-->
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Withdraw History</h2>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="form-horizontal">
                <div class="col-md-3 col-sm-6">
                    <div class="form-group">
                        <div class="col-md-12 col-sm-12">
                            <asp:TextBox ID="txtVoucherDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                        <div class="col-md-7 col-sm-6">
                            <asp:DropDownList ID="dtStatus" CssClass="form-control" runat="server" AutoPostBack="true"   >
                        <asp:ListItem Value="0">Select</asp:ListItem>
                        <asp:ListItem Value="3">Pending</asp:ListItem>
                        <asp:ListItem Value="1">Completed</asp:ListItem>
                        <asp:ListItem Value="2">Rejected</asp:ListItem>
                    </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Reference No&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                        <div class="col-md-7 col-sm-6">
                            <asp:TextBox ID="txtRefno" runat="server" CssClass="form-control" placeholder="Reference No"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="form-group">
                        <div class="col-md-12  col-sm-12 text-right">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click"  />
                        </div>
                    </div>
                </div>
            </div>
        </div>
            <div  class="col-sm-12">
                <div class="gap gap-mid"></div>
                <asp:UpdatePanel ID="uplistItem" runat="server">
                    <ContentTemplate>
                        <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="withdraw_id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemCommand="LstRecentTransaction_ItemCommand"
                            OnItemDataBound="LstRecentTransaction_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row" style="display: none">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>No</th>
                                            <th>Date Requested</th>
                                            <th>Reference No</th>
                                            <th>Amount Requested</th>
                                            <th>Bank</th>
                                            <th>Account No</th>
                                            <th>Status</th>
                                            <th>Verify</th>
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
                                    <td data-title="No" style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                    <td data-title="Requested Date"><%# Eval("requested_date") %></td>
                                    <td data-title="Reference No"><%# Eval("reference_no") %></td>
                                    <td data-title="Requested Amount"><%# Eval("requested_amount") %></td>
                                    <td data-title="Bank Name)"><%# Eval("bankname") %></td>
                                    <td data-title="Account No"><%# Eval("accno") %></td>
                                    <td data-title="Status"><span id="WithdrawStatus" runat="server"><%# Eval("withdraw_status") %></span></td>
                                    <td data-title="Verify"><span id="verifybtn" runat="server" style="display: none;">
                                        <asp:LinkButton ID="lnkYes" runat="server" ToolTip="Yes" CssClass="btn btn-success btn-xs" CommandName="Yes">Yes</asp:LinkButton>
                                        <asp:LinkButton ID="lnkNo" runat="server" ToolTip="No" CssClass="btn btn-primary btn-xs" CommandName="No">No</asp:LinkButton>

                                    </span><span id="verifyInfo" runat="server"><%# Eval("verifyflag") %></span></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>No</th>
                                            <th>Date Requested</th>
                                            <th>Reference No</th>
                                            <th>Amount Requested</th>
                                            <th>Bank</th>
                                            <th>Account No</th>
                                            <th>Status</th>
                                            <th>Verify</th>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


    </div>
</asp:Content>

