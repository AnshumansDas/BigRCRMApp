<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmRedeemCurrency.aspx.cs" Inherits="CRMApp.crmapp.frmRedeemCurrency" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">       
        function alertforconfirm() {
            $("#RedeemPopup").modal(open);
        };
        function alertforconfirmhide() {
            $("#RedeemPopup").modal("hide");
        };       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <!-- main area start -->
    <div class="main-area">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Redeem Coin</h2>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="content-breadcrumbs2">
                        <ul class="tabfull" role="tablist">
                            <li><a href="#reward" aria-controls="reward" role="tab" data-toggle="tab">Redeem Now</a>
                            </li>
                            <li class="active"><a href="#retail" aria-controls="retail" role="tab" data-toggle="tab">Redeem History</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="tab-content" id="tab-conte">
                        <div role="tabpanel" class="tab-pane" id="reward">
                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:UpdatePanel ID="upTransaction" runat="server">
                                        <ContentTemplate>
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <span class="area-title bdr mt20">
                                                        <h2>Redeem Now</h2>
                                                    </span>
                                                    <div class="gap gap-mid"></div>
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-3">
                                                                        Total Points                                                                       
                                                                    </label>
                                                                    <div class="col-sm-2">
                                                                        <asp:Label ID="lblTotalPts" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                    <label class="col-sm-3">
                                                                        Available Points                                                                     
                                                                    </label>
                                                                    <div class="col-sm-2">
                                                                        <asp:Label ID="lblAvailablePts" runat="server" Text=""></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">
                                                                        Currency Type<span style="font-size: smaller; color: red;">&#42;</span>
                                                                        <asp:RequiredFieldValidator ID="rfvState" InitialValue="0" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="ddlCurrency" ValidationGroup="submitValSetupStateCity" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                                    </label>
                                                                    <div class="col-sm-8">
                                                                        <asp:DropDownList ID="ddlCurrency" CssClass="form-control" OnSelectedIndexChanged="ddlCurrency_SelectedIndexChanged" runat="server">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">
                                                                        Receive Address<span style="font-size: smaller; color: red;">&#42;</span>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="TxtReciveaddress" ValidationGroup="submitValRedeeem" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                                    </label>
                                                                    <div class="col-sm-8">
                                                                        <asp:TextBox ID="TxtReciveaddress" runat="server" name="Maximum" CssClass="form-control" placeholder="Account Details"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">
                                                                        Point<span style="font-size: smaller; color: red;">&#42;</span>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="TxtPoint" ValidationGroup="submitValRedeeem" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                                    </label>
                                                                    <div class="col-sm-4">
                                                                        <asp:TextBox ID="Txtpoint" runat="server" name="Point" CssClass="form-control" placeholder="Points"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <asp:Button ID="btnCalculate" runat="server" Text="Calculate" CssClass="btn btn-success" OnClick="btnCalculate_Click" ValidationGroup="submitValRedeeemed" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">
                                                                        Coin<span style="font-size: smaller; color: red;">&#42;</span>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="TxtCoin" ValidationGroup="submitValRedeeem" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                                    </label>
                                                                    <div class="col-sm-4">
                                                                        <asp:TextBox ID="TxtCoin" runat="server" name="Coin" CssClass="form-control" placeholder="Amount" Enabled="false"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <asp:Label ID="lblerror" Text="" runat="server" CssClass="col-sm-8"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-sm-6 text-right">
                                                                        <div class="form-group">
                                                                            <%--   <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-action" OnClick="btnCancel_Click" />--%>
                                                                            <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submitValRedeeem" />
                                                                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>

                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="table-responsive">
                                                                <asp:ListView ID="Lv_Bindcurrencychart" runat="server"
                                                                    GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                                    <LayoutTemplate>
                                                                        <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                            <thead class="cf">
                                                                                <tr>
                                                                                    <th>Sl No.</th>
                                                                                    <th>Currency Type</th>
                                                                                    <th>Point</th>
                                                                                    <th>Coin</th>
                                                                                    <th>Minimum Point</th>
                                                                                    <th>Maximum Point</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </LayoutTemplate>
                                                                    <GroupTemplate>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </GroupTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td data-title="Sl No." style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                                            <td data-title="Currency Type"><%# Eval("currency_type") %></td>
                                                                            <td data-title="Point"><%# Eval("point") %></td>
                                                                            <td data-title="Coin"><%# Eval("amount") %></td>
                                                                            <td data-title="Minimum"><%# Eval("min_point") %></td>
                                                                            <td data-title="Maximum"><%# Eval("max_point") %></td>

                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <EmptyDataTemplate>
                                                                        <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                            <thead class="cf">
                                                                                <tr>
                                                                                    <th>Sl No.</th>
                                                                                    <th>Currency Type</th>
                                                                                    <th>Point</th>
                                                                                    <th>Coin</th>
                                                                                    <th>Maximum Point</th>
                                                                                    <th>Minimum Point</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td colspan="10" style="text-align: center;">currently Redeems Not available!
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </EmptyDataTemplate>
                                                                </asp:ListView>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <!-- end row-->
                        </div>
                        <!-- tab content-end-->
                        <div role="tabpanel" class="tab-pane active" id="retail">

                            <div class="row">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="col-md-6">
                                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                                <div class="search-box">
                                                    <asp:TextBox ID="txtRetailSearch" runat="server" OnTextChanged="txtRetailSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                                    <i class="fa fa-search"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <span class="area-title bdr mt20">
                                                        <h2>Redeem History</h2>
                                                    </span>
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="lsvRetail" runat="server" DataKeyNames="redeem_id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                                                            OnItemCommand="lsvRetail_ItemCommand" OnPagePropertiesChanging="lsvRetail_PagePropertiesChanging" OnItemDataBound="lsvRetail_ItemDataBound">
                                                            <LayoutTemplate>
                                                                <div class="row">
                                                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                                                </div>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Currency Type</th>
                                                                            <th>Point</th>
                                                                            <th>Amount</th>
                                                                            <th>Request Date</th>
                                                                            <th>Updated Date</th>
                                                                            <th>Status</th>
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
                                                                    <div class="col-sm-12 text-right">
                                                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lsvRetail" PageSize="10">
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
                                                                    <td><%# Container.DataItemIndex + 1 %></td>
                                                                    <td><%# Eval("currency_type") %></td>
                                                                    <td><%# Eval("redeem_points") %></td>
                                                                    <td><%# Eval("amount") %></td>
                                                                    <td><%# Eval("created_date") %></td>
                                                                    <td><%# Eval("updated_date") %></td>
                                                                    <td><span id="colorstatus" runat="server"><%# Eval("status").ToString().Trim() %></span></td>
                                                                    <td data-title="action">
                                                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="View" CssClass="btn btn-primary btn-xs" CommandName="View">View</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <!-- end row-->
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- main area start -->

    <div id="RedeemPopup" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Confirm Redeem</h4>

                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpRedeemPopup" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        BigR will not responsible any wrong information has been filled up by your side.
                                    </label>
                                    <label class="col-sm-12">
                                        Please make sure your "Recieve Address" given correctly. Thank You
                                    </label>
                                    <label class="col-sm-12">
                                        Are you sure To submit This Request?
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-action" OnClick="btnRedeemCancel_Click" />
                                            <asp:Button ID="btnRedeem" runat="server" Text="Proceed" CssClass="btn btn-success"  OnClick="btnRedeem_Click" />
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
