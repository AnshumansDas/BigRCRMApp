<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmJoiningSetup.aspx.cs" Inherits="CRMApp.crmapp.frmJoiningSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Joining Setup</h2>
        </div>
        <div></div>
    </div>
    <asp:UpdatePanel ID="upJoiningSetup" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Joining Type&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvJoiningType" runat="server" CssClass="required" ControlToValidate="ddlJoiningCategory" InitialValue="NA" ValidationGroup="joinValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlJoiningCategory" CssClass="form-control" runat="server" TabIndex="0" DataTextField="joining_category" DataValueField="joining_category_id">
                            </asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Point&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvPoint" runat="server" CssClass="required" ControlToValidate="txtPoint" ValidationGroup="joinValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtPoint" runat="server" TabIndex="1" CssClass="form-control" onkeypress="return isNumberKey(event)"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Start Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvStartDate" runat="server" CssClass="required" ControlToValidate="txtStartDate" ValidationGroup="joinValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="startdate">
                                <asp:TextBox ID="txtStartDate" runat="server" TabIndex="2" CssClass="form-control datepicker1"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                        <label class="col-sm-2">End Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvEndDate" runat="server" CssClass="required" ControlToValidate="txtEndDate" ValidationGroup="joinValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="enddate">
                                <asp:TextBox ID="txtEndDate" runat="server" TabIndex="3" CssClass="form-control datepicker2"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Active Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="ddlActiveStatus" InitialValue="" ValidationGroup="joinValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server" TabIndex="4">
                                <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-6 text-right">
                            <div class="form-group">
                                <asp:Button ID="btnCancel" runat="server" TabIndex="6" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn btn-action" />
                                <asp:Button ID="btnSave" runat="server" TabIndex="5" Text="Save" OnClick="btnSave_Click" ValidationGroup="joinValue" CssClass="btn btn-success" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
