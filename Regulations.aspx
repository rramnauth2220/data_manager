<%@ Page Title="Regulations" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Regulations.aspx.cs" Inherits="data_manager_v._1.Regulations" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
            <asp:Button runat="server" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" OnClick="Regulation_Export" Text="Extract Details" />
        </div>

        <!-- Page Body -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 id="row_count" runat="server" class="m-0 font-weight-bold text-primary"></h6>
            </div>
            <div class="card-body">
                <div runat="server" class="table-responsive">
                    <asp:ScriptManager ID="ScriptManager_Regulations" runat="server"></asp:ScriptManager>

                    <asp:GridView role="table" class='table table-bordered' Width='100%'
                        ID="Regulation_View" runat="server"
                        AllowPaging="True" OnPageIndexChanging="Regulation_PageIndexChanging"
                        AutoGenerateColumns="False" ShowHeaderWhenEmpty="True">
                        <Columns>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Citation 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList 
                                            ID="Regulation_Body_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="Regulatory_Body_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Reg_Citation")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Jurisdiction 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList 
                                            ID="Regulation_Jurisdiction_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="Regulatory_Jurisdiction_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Reg_Jurisdiction")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Content_Updated" HeaderText="Content Updated" SortExpression="Content_Updated" />
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Action 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList 
                                            ID="Regulation_Action_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="Regulatory_Action_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Content_Action")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Subscription_Id" HeaderText="Subscription ID" SortExpression="Subscription_Id" Visible="false" />
                            <asp:BoundField DataField="File_Source" HeaderText="Source" SortExpression="File_Source" Visible="false" />
                            <asp:BoundField DataField="File_Name" HeaderText="File Name" SortExpression="File_Name" Visible="false" />
                            <asp:BoundField DataField="File_Id" HeaderText="File ID" SortExpression="File_Id" Visible="false" />
                            <asp:BoundField DataField="File_Updated" HeaderText="File Updated" SortExpression="File_Updated" Visible="false" />
                            <asp:BoundField DataField="File_Publish" HeaderText="Publish Type" SortExpression="File_Publish" Visible="false" />
                            <asp:BoundField DataField="Content_Id" HeaderText="Content ID" SortExpression="Content_Id" Visible="false"/>
                            <asp:BoundField DataField="Reg_Body" HeaderText="Regulatory Body" SortExpression="Reg_Body" Visible="false"/>
                            <asp:BoundField DataField="Reg_Title" HeaderText="Title" SortExpression="Reg_Title" Visible="false"/>
                            <asp:BoundField DataField="Reg_Subtitle" HeaderText="Subtitle" SortExpression="Reg_Subtitle" Visible="false"/>
                            <asp:BoundField DataField="Reg_Chapter" HeaderText="Chapter" SortExpression="Reg_Chapter" Visible="false" />
                            <asp:BoundField DataField="Reg_Subchapter" HeaderText="Subchapter" SortExpression="Reg_Subchapter" Visible="false" />
                            <asp:BoundField DataField="Reg_Part" HeaderText="Part" SortExpression="Reg_Part" Visible="false" />
                            <asp:BoundField DataField="Reg_Subpart" HeaderText="Subpart" SortExpression="Reg_Subpart" Visible="false" />
                            <asp:BoundField DataField="Reg_Section" HeaderText="Section" SortExpression="Reg_Section" Visible="false" />
                            <asp:BoundField DataField="Reg_Subsection" HeaderText="Subsection" SortExpression="Reg_Subsection" Visible="false" />
                            <asp:BoundField DataField="Reg_Content" HeaderText="Description" SortExpression="Reg_Content" Visible="false" />
                            <asp:BoundField DataField="Reg_References" HeaderText="References" SortExpression="Reg_References" Visible="false" />
                        </Columns>

                        <PagerSettings Mode="NumericFirstLast" FirstPageText='<i class="fas fa-chevron-left"></i>' LastPageText='<i class="fas fa-chevron-right"></i>'></PagerSettings>
                        <PagerStyle CssClass="Paging" HorizontalAlign="Right" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</asp:Content>