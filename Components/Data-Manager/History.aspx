<%@ Page Title="Data Manager - History" Language="C#" MasterPageFile="../../Site.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="data_manager_v._1.Components.Data_Manager.History" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
            <asp:Button runat="server" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" OnClick="History_Export" Text="Extract Details" />
        </div>

        <!-- Page Body -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 id="row_count" runat="server" class="m-0 font-weight-bold text-primary">Summary</h6>
            </div>
            <div class="card-body">
                <div runat="server" class="table-responsive">
                    <asp:ScriptManager ID="ScriptManager_History" runat="server"></asp:ScriptManager>
                    <asp:GridView role="table" class='grid' Width='100%'
                        ID="History_View" runat="server"
                        AllowPaging="True" OnPageIndexChanging="History_PageIndexChanging" PagerSettings-Mode="NumericFirstLast"
                        AutoGenerateColumns="False" ShowHeaderWhenEmpty="True">
                        <Columns>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>User 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList
                                            ID="History_Username_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="History_Username_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Username")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" /> --%>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>View 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList 
                                            ID="History_View_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="History_View_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("View")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Content_Id" HeaderText="Content ID" SortExpression="Content_Id" />
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Description 
                                    <br> </br></span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList 
                                            ID="History_Action_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems = "true"
                                            OnSelectedIndexChanged="History_Action_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text = "ALL" Value = "ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Description")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" FirstPageText='<i class="fas fa-chevron-left"></i>' LastPageText='<i class="fas fa-chevron-right"></i>'></PagerSettings>
                        <PagerStyle CssClass="Paging" HorizontalAlign="Right" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</asp:Content>