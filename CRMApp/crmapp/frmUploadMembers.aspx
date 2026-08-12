<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmUploadMembers.aspx.cs" Inherits="CRMApp.crmapp.frmUploadMembers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Upload Members</h2>

            </div>
            <div id="loading" runat="server" visible="false">
                <img alt="loading" src="../img/waiting_icon.gif" />
            </div>
        </div>
        <div class="col-sm-12">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 padding-rem">
                    <label class="control-label col-md-1 col-sm-12 name-height">Filename</label>
                    <div class="col-md-3 col-sm-12 gap-butabo">
                        <div class="fileinput fileinput-new" data-provides="fileinput">
                            <span class="btn btn-default btn-file">
                                <asp:fileupload id="FU_MemberData" runat="server" class="btn btn-primary" />
                            </span>
                            <span class="fileinput-filename"></span>
                        </div>
                    </div>
                    <div class="col-md-1 col-sm-12 col-xs-12 but-height">
                        <button type="submit" id="btnUpload" runat="server" onserverclick="btnUpload_ServerClick" class="btn btn-success">Upload</button>
                    </div>
                </div>
            </div>
            <div>
                <div class="gap gap-mid"></div>

                    <asp:ListView ID="LVMembersFileList" runat="server" OnItemCommand="LVMembersFileList_ItemCommand" 
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="LVMembersFileList_PagePropertiesChanging">
                        <LayoutTemplate>
                            <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                <thead class="cf">
                                    <tr>
                                        <th>No.</th>
                                        <th>File Name</th>
                                        <th>Upload Date</th>
                                        <th>Created By</th>
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
                                <div class="gap gap-small"></div>
                                <div class="col-md-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PageSize="10">
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
                                <td data-title="No" align="center"><%# Container.DataItemIndex + 1 %></td>
                                <td data-title="File Name"><%# Eval("FileName") %></td>
                                <td data-title="Upload Date"><%# Eval("FileUploadDate") %></td>
                                <td data-title="Upload Date"><%# Eval("CreatedBy") %></td>
                                <td data-title="Action" align="center">
                                    <%--<asp:LinkButton ID="lnkEdit" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" runat="server" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>--%>
                                    <asp:LinkButton ID="lnkDelete" ToolTip="Edit Content" CssClass="btn btn-danger btn-xs" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure to delete this product?');"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                <thead class="cf">
                                    <tr>
                                        <th>No.</th>
                                        <th>File Name</th>
                                        <th>Upload Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="10" align="center">No File record found!
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </EmptyDataTemplate>
                    </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>
