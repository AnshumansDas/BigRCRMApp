<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMerchandiseOutlet.aspx.cs" Inherits="CRMApp.crmapp.frmMerchandiseOutlet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upContentAddEdit2" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="area-title bdr mt20">
                    <h2>Merchandise Outlet Setup</h2>
                </div>
                <div></div>
            </div>
            <div class="col-sm-12">
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Branch Name</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtBranchName" runat="server" TabIndex="0" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2">Person In Charge</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtPersonInCharge" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Address 1</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtAddress1" runat="server" TabIndex="2" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2">Address 2</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtAddress2" runat="server" TabIndex="3" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Post Code</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtPostCode" runat="server" TabIndex="4" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2">State</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlState" CssClass="form-control" runat="server" AutoPostBack="true" TabIndex="5" DataTextField="state_name" DataValueField="state_id" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">City</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server" AutoPostBack="true" TabIndex="6" DataTextField="city_name" DataValueField="city_id">
                            </asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Active Status</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server" TabIndex="8">
                                <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                            </asp:DropDownList>
                            
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Remark</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" TabIndex="7" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-2"></label>
                        <div class="col-sm-4">
                            <asp:Button ID="btnCancel" runat="server" TabIndex="10" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn btn-action" />
                            <asp:Button ID="btnSave" runat="server" TabIndex="9" Text="Save" OnClick="btnSave_Click" ValidationGroup="submitValue" CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>
            </div>
            <div></div>
            <div class="col-sm-12">
                <div class="area-title bdr mt20">
                    <h2>Merchandise Outlet Setup</h2>
                </div>
                <div></div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="search-categori">
                            <div class="search-box">
                                <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                <i class="fa fa-search"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div></div>
                <asp:ListView ID="lvMerchandiseOutletList" runat="server" DataKeyNames="branch_id" OnItemCommand="lvMerchandiseOutletList_ItemCommand" OnPagePropertiesChanging="lvMerchandiseOutletList_PagePropertiesChanging"
                    GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvMerchandiseOutletList_ItemDataBound">
                    <LayoutTemplate>
                        <div class="row">
                            <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                        </div>
                        <table class="table table-striped" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="width: 5%; text-align: center;">No</th>
                                    <th style="width: 20%; text-align: center;">Branch Name</th>
                                    <%--<th style="width: 20%; text-align: left;">Person In Charge</th>--%>
                                    <th style="width: 20%; text-align: left;">Address</th>
                                    <th style="width: 5%; text-align: center;">State</th>
                                    <th style="width: 10%; text-align: center;">City</th>
                                    <th style="width: 20%; text-align: center;">Remarks</th>                                    
                                    <th style="width: 10%; text-align: center;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-12 text-right">
                                <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvMerchandiseOutletList" PageSize="10">
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
                            <td style="text-align: left;"><%# Eval("branch_name") %></td>
                            <%--<td style="text-align: left;"><%# Eval("person_in_charge")%></td>--%>
                            <td style="text-align: left;"><%# Eval("branch_address_1") %><br /><%# Eval("branch_address_2") %></td>
                            <td style="text-align: center;"><%# Eval("state_name")%></span></td>
                            <td style="text-align: center;"><%# Eval("city_name") %></td>
                            <td style="text-align: center;"><%# Eval("remarks") %></td>
                            <td style="text-align: center;">
                                <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Outlet" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                <%--<asp:LinkButton ID="lnkDelete" runat="server" ToolTip="Delete Voucher" CssClass="btn btn-primary btn-xs" CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>--%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <table class="table table-striped" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="width: 5%; text-align: center;">No</th>
                                    <th style="width: 20%; text-align: center;">Branch Name</th>
                                    <%--<th style="width: 20%; text-align: left;">Person In Charge</th>--%>
                                    <th style="width: 20%; text-align: left;">Address</th>
                                    <th style="width: 5%; text-align: center;">State</th>
                                    <th style="width: 10%; text-align: center;">City</th>
                                    <th style="width: 20%; text-align: center;">Remarks</th>                                    
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
