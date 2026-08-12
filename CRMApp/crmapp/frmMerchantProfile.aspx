<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantProfile.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantProfile" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }

        function UploadFile1(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUploadDoc.ClientID %>").click();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Merchant</h2>
            </div>
            <div id="viewlogo" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 style="text-align: center;">Merchant Logo</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:Image ID="imgMerchantLogo" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                                <div class="col-sm-2 text-right">
                                    <div class="form-group">
                                        <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Merchant Code</label>
                                <div class="col-sm-9">
                                    <asp:Label ID="lblMerchantCode" runat="server" CssClass="form-control" Readonly></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Organization Name</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtMerchant" CssClass="form-control focus" runat="server" placeholder="Organization name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Company Reg.No</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtMerchantRegNo" CssClass="form-control" runat="server" placeholder="Organization registration number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Merchant Category</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlMerchantCategory" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Person In Charge</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtPersonInCharge" CssClass="form-control" runat="server" placeholder="PIC name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mobile Phone No</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtMobileNo" CssClass="form-control" runat="server" placeholder="Mobile phone no"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Office Phone No</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtOfficeNo" CssClass="form-control" runat="server" placeholder="Office phone no"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fax No</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtFaxNo" CssClass="form-control" runat="server" placeholder="Fax no"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mailing Address 1</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtAddress1" CssClass="form-control" runat="server" placeholder="Address Line 1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mailing Address 2</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtAddress2" CssClass="form-control" runat="server" placeholder="Address Line 2"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Postcode</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtPostcode" CssClass="form-control" runat="server" placeholder="Postcode"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">State</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">City</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Email </label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Email address"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Website </label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtMerchantWebURL" CssClass="form-control" runat="server" placeholder="Merchant website URL"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Active Status</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="form-horizontal">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 text-right control-label">Upload Logo</label>
                        <div class="col-sm-9">
                            <div id='file_browse_wrapper'>
                                <asp:FileUpload ID="fuMerchantLogo" runat="server" CssClass="file_browse" />
                                <asp:Button ID="btnUpload" Text="Upload" runat="server" Style="display: none" OnClick="UploadFile" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label"><span id="uploadmsg" runat="server" style="font-size: small;"></span></label>
                        <div class="col-sm-9">
                            <a data-toggle="modal" data-target="#viewlogo" class="btn btn-default">View Merchant Logo</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Fees Details</h2>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fees Category</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlFeesCategory" CssClass="form-control" OnSelectedIndexChanged="ddlFeesCategory_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                        <asp:ListItem Value="PerVoucher" Text="Per Voucher"></asp:ListItem>
                                        <asp:ListItem Value="OneTimeCharges" Text="One Time Charges (Year)"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesType" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges Type</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlChargesType" CssClass="form-control" OnSelectedIndexChanged="ddlChargesType_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                        <asp:ListItem Value="ChargesTypeByPercent" Text="Charges by (%)"></asp:ListItem>
                                        <asp:ListItem Value="ChargesTypeByRM" Text="Charges by (RM)"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesbyPercent" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (%) </label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtChargesbyPercent" CssClass="form-control" runat="server" placeholder="Charges by percent"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesbyRM" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (RM)</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtChargesbyRM" CssClass="form-control" runat="server" placeholder="Charges by RM"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Premium Merchant</label>
                        <div class="col-sm-9">
                            <div class="form-group">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                    <ContentTemplate>
                                        <div class="col-sm-2">
                                            <asp:CheckBox ID="chkPremiumStatus" runat="server" AutoPostBack="true" OnCheckedChanged="chkPremiumStatus_CheckedChanged" />&nbsp;Yes
                                        </div>
                                        <label class="col-sm-4 control-label">Premium Fees (RM)</label>
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtPremiumFees" Enabled="false" runat="server" CssClass="form-control" placeholder="Premium Fees"></asp:TextBox>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="input-group date" id="startdate">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" placeholder="start date"></asp:TextBox>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group date" id="enddate">
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" placeholder="end date"></asp:TextBox>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Support Document</h2>
            </div>
            <div class="form-horizontal">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Upload Documents</label>
                        <div class="col-sm-3">
                            <asp:FileUpload ID="FileUploadDoc" runat="server" />
                            <asp:Button ID="btnUploadDoc" Text="Upload" runat="server" Style="display: none" OnClick="UploadDoc" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-6">
                            <span id="uploaddocmsg" runat="server" style="font-size: small;"></span>
                        </div>
                    </div>
                </div>
                <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                    <ContentTemplate>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Document Name<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvText2" runat="server" CssClass="required" ControlToValidate="txtDocName" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtDocName" runat="server" CssClass="form-control" placeholder="Document name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-10 text-right">
                                    <span id="adddocmsg" runat="server" style="font-size: smaller;"></span>&nbsp;
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                </div>
                                <div class="col-sm-2">
                                    <div class="pull-right">
                                        <asp:LinkButton ID="lnkAddSupportDoc" runat="server" ValidationGroup="submitValue" CssClass="btn btn-info" OnClick="lnkAddSupportDoc_Click">Add Document</asp:LinkButton>
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
                                                <th style="width: 40%;">Document Name</th>
                                                <th style="width: 20%;">File Path</th>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="gap-mid"></div>
    </div>
</asp:Content>
