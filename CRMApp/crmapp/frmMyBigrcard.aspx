<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMyBigrcard.aspx.cs" Inherits="CRMApp.crmapp.frmMyBigrcard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="main-area">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>BigR Details</h2>
                    </div>
                </div>
                <div class="col-sm-12">
                    <%--<div class="content-breadcrumbs2">--%>
                    <div id="Tabs" role="tabpanel">
                        <ul class="tabfull" role="tablist">
                            <li class="active"><a href="#register" aria-controls="register" role="tab" data-toggle="tab">Register BigR Card</a>
                            </li>
                            <li><a href="#history" aria-controls="history" role="tab" data-toggle="tab">BigR Card History</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div role="tabpanel" id="register" class="tab-pane active">
                                <%--<asp:UpdatePanel ID="upRegister" runat="server">
                                    <ContentTemplate>--%>
                                <div class="col-sm-12 col-xs-12">
                                    <a class="card-bigr-small" data-toggle="modal" data-target="#myModal">
                                        <img src="img/avatar/card.jpg">
                                        <div class="card-info-reload-small">
                                            <div class="col-sm-12">
                                                + Register Card
                                            </div>
                                        </div>
                                    </a>
                                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                                </div>

                                <asp:ListView ID="lvPreRegistrationList" DataKeyNames="id" runat="server" OnItemDataBound="lvPreRegistrationList_ItemDataBound" OnItemCommand="lvPreRegistrationList_ItemCommand">
                                    <ItemTemplate>
                                        <div class="card-bigr">
                                            <div class="card-info-user">
                                                <asp:Label ID="lblcardNo" runat="server" Visible="false" Text='<%# Eval("membership_cardno") %>'></asp:Label>
                                                <%--<%# Eval("card_no") %>
                                                <%# Eval("mifare_cardno") %>--%>
                                                <%# Eval("membership_cardno") %><br>
                                                <%# Eval("community_name") %>                                                
                                            </div>
                                            <img src="img/avatar/card.jpg">
                                            <div class="card-info-reload">
                                                <div class="col-xs-8 text-rm text-right price">
                                                    <asp:Label ID="lblbalance" runat="server" Text='<%# Eval("Balance","{0:0.00}") %>'></asp:Label>
                                                </div>
                                                <div class="col-xs-4 text-right">
                                                    <asp:Button ID="btnReloadCard" runat="server" CssClass="btn btn-success reload" Text="Reload" OnClick ="btnReloadCard_ServerClick" CommandArgument='<%# Eval("card_no") %>' CommandName="reload" />
                                                    <%--<button id="btnReloadCard" runat="server" onserverclick="btnReloadCard_ServerClick" class="btn btn-success reload" >Reload</button>--%>
                                                </div>
                                            </div>
                                            <div class="card-info-payment">
                                                <div class="col-sm-12 col-xs-12">
                                                    Payment Mode
                                                </div>
                                                <div class="col-sm-12 col-xs-12 group-radio">
                                                    <asp:Label ID="lblPayValue" runat="server" Visible="false" Text='<%# Eval("card_payment_type") %>'></asp:Label>
                                                    <asp:RadioButtonList ID="rbtnPaymentType" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rbtnPaymentType_SelectedIndexChanged">
                                                        <asp:ListItem Value="W">Wallet</asp:ListItem>
                                                        <asp:ListItem Value="T">Visa/Master</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    <%--<input id="Radio1" runat="server" name="payment" type="radio" value="W">
                                                    <label for="Radio1">Wallet</label>
                                                    <input id="Radio2" runat="server" name="payment" type="radio" value="T">
                                                    <label for="Radio2">Visa/Master Card</label>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <p>No Card Registered</p>
                                    </EmptyDataTemplate>
                                </asp:ListView>

                                <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="history">
                                <div class="row">
                                    <div class="col-sm-12 mt20">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <asp:DropDownList ID="ddlCommunity" runat="server" CssClass="form-control" DataTextField="community_name" DataValueField="community_id" AutoPostBack="true" OnSelectedIndexChanged="ddlCommunity_SelectedIndexChanged"></asp:DropDownList>                                                
                                                <asp:RequiredFieldValidator ID="rfvCommunity" runat="server" ErrorMessage="Require" class="required" ControlToValidate="ddlCommunity" InitialValue="NA" ValidationGroup="submit"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtSearchHistory" runat="server" CssClass="form-control input-sm active-part" placeholder="Search By BigR Card No an "></asp:TextBox>
                                                <i class="fa fa-search"></i>
                                                
                                            </div>
                                            <asp:Button ID="btnHistory" runat="server" Text="Search" OnClick="btnHistory_Click" CssClass="btn btn-info" ValidationGroup="submit" />
                                        </div>
                                    </div>
                                    <div class="gap gap-mid"></div>
                                    <div class="col-sm-12 pb10 pt20">
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li class="active"><a href="#usage" aria-controls="usage" role="tab" data-toggle="tab">Usage</a>
                                            </li>
                                            <li><a href="#reload" aria-controls="reload" role="tab" data-toggle="tab">Reload</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="tab-content" id="tab-innerconte">
                                            <div role="tabpanel" id="usage" class="tab-pane active">
                                                <%--<div class="row">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <div class="table-responsive">
                                                    <asp:ListView ID="lsvUsage" runat="server" DataKeyNames="card_no" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemCommand="lsvUsage_ItemCommand" OnPagePropertiesChanging="lsvUsage_PagePropertiesChanging">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                                            </div>
                                                            <table id="table-list" class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Sl No</th>
                                                                        <th>BigR Card No</th>
                                                                        <%--<th>Usage Type</th>
                                                                                        <th>Transaction Date</th>--%>
                                                                        <th>Transaction No</th>
                                                                        <th>Transaction Amount</th>
                                                                        <th>Site Name</th>
                                                                        <th>Payment Method</th>
                                                                        <th>Payment Status</th>
                                                                        <%--<th>Card Type</th>
                                                                                        <th>POS Name</th>--%>
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
                                                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lsvUsage" PageSize="10">
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
                                                                <td data-title="Sl No"><%# Container.DataItemIndex + 1 %></td>
                                                                <td data-title="order no"><%# Eval("card_no") %></td>
                                                                <td data-title="trans id"><%# Eval("transaction_no") %></td>
                                                                <td data-title="trans amount"><%# Eval("transaction_amount") %></td>
                                                                <td data-title="trans time"><%# Eval("site_name") %></td>
                                                                <td data-title="trans id"><%# Eval("transaction_mode") %></td>
                                                                <td data-title="trans status"><%# Eval("transaction_status") %></td>
                                                                <%--<td data-title="trans id"><%# Eval("card_type") %></td>
                                                                                <td data-title="trans id"><%# Eval("pos_name") %></td>--%>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <EmptyDataTemplate>
                                                            <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                <thead class="cf">
                                                                    <tr>
                                                                        <th>Sl No</th>
                                                                        <th>BigR Card No</th>
                                                                        <th>Usage Type</th>
                                                                        <th>Transaction Date</th>
                                                                        <th>Transaction No</th>
                                                                        <th>Transaction Amount</th>
                                                                        <th>Site Name</th>
                                                                        <th>Payment Method</th>
                                                                        <th>Payment Status</th>
                                                                        <%--<th>Card Type</th>
                                                                                        <th>POS Name</th>--%>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td colspan="10" style="text-align: center;">No Usage Transaction available for User!
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </EmptyDataTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </div>
                                            <div role="tabpanel" id="reload" class="tab-pane">
                                                <%--<div class="row">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <div class="table-responsive">
                                                    <asp:ListView ID="lsvReload" runat="server" DataKeyNames="rfid_tag_no" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lsvReload_PagePropertiesChanging" OnItemCommand="lsvReload_ItemCommand">
                                                        <LayoutTemplate>
                                                            <div class="row">
                                                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                                            </div>
                                                            <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Sl No</th>
                                                                        <th>BigR Card No</th>
                                                                        <th>Reload Type</th>
                                                                        <th>Transaction Date</th>
                                                                        <th>Transaction No</th>
                                                                        <th>Transaction Amount</th>
                                                                        <th>Payment Method</th>
                                                                        <th>Payment Status</th>
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
                                                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lsvReload" PageSize="10">
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
                                                                <td data-title="Sl No"><%# Container.DataItemIndex + 1 %></td>
                                                                <td data-title="order no"><%# Eval("rfid_tag_no") %></td>
                                                                <td data-title="trans amount"><%# Eval("transaction_type") %></td>
                                                                <td data-title="trans time"><%# Eval("transaction_date") %></td>
                                                                <td data-title="trans id"><%# Eval("transaction_no") %></td>
                                                                <td data-title="trans amount"><%# Eval("transaction_amount") %></td>
                                                                <td data-title="trans id"><%# Eval("transaction_mode") %></td>
                                                                <td data-title="trans status"><%# Eval("transaction_status") %></td>
                                                                <%--<td data-title="trans id"><%# Eval("card_type") %></td>
                                                                                <td data-title="trans id"><%# Eval("pos_name") %></td>          --%>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <EmptyDataTemplate>
                                                            <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                <thead class="cf">
                                                                    <tr>
                                                                        <th>Sl No</th>
                                                                        <th>BigR Card No</th>
                                                                        <th>Reload Type</th>
                                                                        <th>Transaction Date</th>
                                                                        <th>Transaction No</th>
                                                                        <th>Transaction Amount</th>
                                                                        <th>Payment Method</th>
                                                                        <th>Payment Status</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td colspan="10" style="text-align: center;">No Reload Transaction available for User!
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
                            </div>
                        </div>
                    </div>
                </div>
                <asp:HiddenField ID="TabName" runat="server" />
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Register Card</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="card">Membership BigR Card No</label>
                        <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Insert Membership BigR Card No"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="card">Promocode(if any)</label>
                        <asp:TextBox ID="txtPromocodeName" runat="server" CssClass="form-control" placeholder="Insert Promo code"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Payment Method</label>
                        <div class="group-radio">
                            <asp:RadioButtonList ID="rbtnPaymentMethod" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="W" Selected="True">Pay With Wallet</asp:ListItem>
                                <asp:ListItem Value="T">Pay With Visa/Master</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Register" OnClick="btnSave_Click" />                    
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</asp:Content>
