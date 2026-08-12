<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmBannerAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmBannerAddEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Add/Edit Banner</h2>
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
                                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="submitValue" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="col-md-6">
                <div class="form-group" runat="server" visible="false">
                    <label for="inputEmail3" class="col-sm-3 control-label">Banner Code</label>
                    <div class="col-sm-9">
                        <asp:Label ID="lblBannerCode" runat="server" CssClass="form-control" Readonly></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">Banner Title <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="txtBannerTitle" runat="server" placeholder="Banner Title" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="RFVBannerTitle" runat="server" CssClass="required" ControlToValidate="txtBannerTitle" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">Start Date <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-7">
                        <div class="input-group date" id="startdate">
                            <%--<asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" placeholder="start date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>--%>
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker1" placeholder="start date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="RFVStartDate" runat="server" CssClass="required" ControlToValidate="txtStartDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 text-right control-label">Banner Image <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-7">
                        <div id='file_browse_wrapper'>
                            <asp:FileUpload ID="Fu_BannerImage" runat="server" CssClass="file_browse" />
                            <asp:Button ID="btnUpload" Text="Upload" runat="server" OnClick="Upload" Style="display: none" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group" runat="server" visible="false">
                    <label for="inputEmail3" class="col-sm-3 control-label">Banner Description</label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="TxtBannerDescription" placeholder="Banner Description" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">Banner Category <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="ddlBannerCat" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="RFvBannerCategory" runat="server" CssClass="required" InitialValue="0" ControlToValidate="ddlBannerCat" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">End Date <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-7">
                        <div class="input-group date" id="enddate">
                            <%--<asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" placeholder="end date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>--%>
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datepicker2" placeholder="end date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="RFVEndDate" runat="server" CssClass="required" ControlToValidate="txtEndDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">Active Status</label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

            </div>

        </div>
    </div>
    <div class="col-sm-12">
        <div class="form-horizontal">
            <div class="col-md-6">
                <%-- <asp:UpdatePanel ID="UpImage" runat="server">
                    <ContentTemplate>--%>
                <div class="form-group">
                    <div class="row" id="dvImgpreview" runat="server" visible="false">
                        <div class="col-sm-9">
                            <label class="control-label"></label>
                            <p>
                                <asp:Label ID="lblMessage" runat="server" Text="Successfully uploaded." ForeColor="Green" Visible="false"></asp:Label>
                                <asp:Image ID="imgpreview" runat="server" />
                            </p>
                        </div>
                    </div>
                </div>
                <%-- </ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="form-horizontal">
            <div class="col-md-6">
                <div class="form-group">
                    <div class="row">
                        <div class="col-sm-12">
                            <span style="color: red; font-size: small;">Note:
                                <br />
                                1) For bottom or top banner category please upload using this format size (1164 px width * 246 px height)
                                <br />
                                2) For inner page banner category please upload using this format size (372 px width * 410 px height)</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
