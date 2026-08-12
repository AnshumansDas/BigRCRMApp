<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPreviledgesList.aspx.cs" Inherits="CRMApp.crmapp.frmPreviledgesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>User Previledge</h2>
        </div>
        <div class="row">
            <asp:ListView ID="LstUserCategory" runat="server" DataKeyNames="role_id" GroupPlaceholderID="groupPlaceHolder1" 
                ItemPlaceholderID="itemPlaceHolder1" OnItemCommand="LstUserCategory_ItemCommand" OnItemDataBound="LstUserCategory_ItemDataBound">
                <LayoutTemplate>
                    <div class="row">
                        <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                    </div>
                    <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                        <thead class="cf">
                            <tr>
                                <th>Sl No</th>
                                <th>Role Name</th>
                                <th>Action</th>
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
                        <td align="center"><%# Container.DataItemIndex + 1 %></td>
                        <td><%# Eval("user_role_description") %></td>
                        <td style="text-align: center;">
                            <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Priveledges" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                        <thead class="cf">
                            <tr>
                                <th>Sl No</th>
                                <th>DATE CREATED</th>
                                <th>VOUCHER NAME</th>
                                <th>PURCHASED BY</th>
                                <th>TRANSACTION DATE</th>
                                <th>TRANSACTION ID</th>
                                <th>TRANSACTION AMOUNT</th>
                                <th>TRANSACTION STATUS</th>
                                <th>VOUCHER CODE</th>
                                <th>VOUCHER CATEGORY</th>
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
        <div class="gap-mini"></div>
    </div>    
</asp:Content>
