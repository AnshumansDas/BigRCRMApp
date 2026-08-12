<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchAddSupportDoc.aspx.cs" Inherits="CRMApp.crmapp.frmMerchAddSupportDoc" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function UploadFile1(fileUpload) {
            <%--if (fileUpload.value != '') {
                document.getElementById("<%=btnUploadDoc.ClientID %>").click();
            }--%>
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Support Document for -
                    <asp:Label ID="lblMerchantName" runat="server"></asp:Label></h2>
            </div>
            <div class="form-horizontal">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">
                            Upload Documents<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="FileUploadDoc" ValidationGroup="submitValMerchAddSupportDoc"
                                runat="server" CssClass="required" />
                        </label>
                        <div class="col-sm-2">
                            <asp:FileUpload ID="FileUploadDoc" runat="server" />
                            <asp:Button ID="btnUploadDoc" Text="Upload" runat="server" Style="display: none" OnClick="UploadDoc" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8">
                            <span id="Span1" runat="server" style="font-size: small; color: darkblue;">Maximum file size to upload is 10MB (format: pdf\jpg\jpeg)</span>
                        </div>
                        <div class="col-sm-4">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="^.*\.(pdf|PDF|jpg|JPG|jpeg|JPEG)$"
                                ControlToValidate="FileUploadDoc" ValidationGroup="submitValMerchAddSupportDoc" runat="server" CssClass="required" ErrorMessage="Valid format pdf\jpg\jpeg" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <span id="uploaddocmsg" runat="server" style="font-size: small;"></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Document Name<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvText2" runat="server" CssClass="required" ControlToValidate="txtDocName" ValidationGroup="submitValMerchAddSupportDoc" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtDocName" runat="server" CssClass="form-control" placeholder="Document name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-7 text-right">
                            <span id="adddocmsg" runat="server" style="font-size: smaller;"></span>&nbsp;
                        </div>
                        <div class="col-sm-5">
                            <div class="text-right">
                                <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                <asp:LinkButton ID="lnkAddSupportDoc" runat="server" ValidationGroup="submitValMerchAddSupportDoc" CssClass="btn btn-info" OnClick="lnkAddSupportDoc_Click">Add Document</asp:LinkButton>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <asp:ListView ID="lvSupportDoc" runat="server" DataKeyNames="doc_id, doc_file_path" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                        OnPagePropertiesChanging="lvSupportDoc_PagePropertiesChanging" OnItemDataBound="lvSupportDoc_ItemDataBound"
                        OnItemCommand="lvSupportDoc_ItemCommand" OnItemDeleting="lvSupportDoc_ItemDeleting">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 30%;">Document Name</th>
                                        <th style="width: 30%;">File Path</th>
                                        <th style="width: 15%; text-align: center;">Created Date</th>
                                        <th style="width: 20%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvSupportDoc" PageSize="10">
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
                                <td><%# Eval("document_name") %></td>
                                <td><%# Eval("file_path") %></td>
                                <td style="text-align: center;"><%# Eval("doc_date") %></td>
                                <td style="text-align: center;">
                                    <a target="_blank" href='<%# Eval("doc_file_path") %>' title="Download document" class="btn btn-info">Download</a>
                                    <asp:LinkButton ID="lnkDelete" CommandName="Delete" runat="server" CssClass="btn btn-danger" ToolTip="Delete document">Remove</asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 40%;">Document Name</th>
                                        <th style="width: 20%;">File Path</th>
                                        <th style="width: 15%; text-align: center;">Created Date</th>
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
        <div class="gap-mid"></div>
    </div>
</asp:Content>
