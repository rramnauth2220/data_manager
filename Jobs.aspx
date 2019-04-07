<%@ Page Title="Jobs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Jobs.aspx.cs" Inherits="data_manager_v._1.Jobs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
            <asp:Button runat="server" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" OnClick="Job_Export" Text="Extract Details" />
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 id="row_count" runat="server" class="m-0 font-weight-bold text-primary"></h6>
            </div>
            <div class="card-body">
                <div runat="server" class="table-responsive">
                    <asp:ScriptManager ID="ScriptManager_Jobs" runat="server"></asp:ScriptManager>
                    <asp:GridView role="table" class='table table-bordered' Width='100%'
                        ID="Job_View" runat="server"
                        AllowPaging="True" AutoGenerateColumns="False"
                        DataKeyNames="Job_Id" ShowHeaderWhenEmpty="True"
                        OnPageIndexChanging="Job_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="Job_Id" HeaderText="ID" ReadOnly="True" SortExpression="Job_Id" />
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Job Type 
                                    <br></br>
                                    </span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:DropDownList
                                            ID="Job_Type_Filter" runat="server"
                                            AutoPostBack="true"
                                            AppendDataBoundItems="true"
                                            OnSelectedIndexChanged="Job_Type_Filter_Changed"
                                            CssClass="light-dropdown-item">
                                            <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Job_Type")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>Start Time 
                                    <br></br>
                                    </span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:TextBox
                                            AutoPostBack="true"
                                            OnTextChanged="Job_Start_Filter_Changed"
                                            CssClass="default-dropdown-item-sm"
                                            ID="TextBox_Job_Start" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender
                                            ID="Calendar_Job_Start" runat="server"
                                            BehaviorID="Calendar_Job_Start"
                                            TargetControlID="TextBox_Job_Start" CssClass= "calendar-theme shadow animated--grow-in"/>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("Start_Time")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="true">
                                <HeaderTemplate>
                                    <span>End Time 
                                    <br></br>
                                    </span>
                                    <div class="btn btn-light btn-icon-split btn-sm" runat="server">
                                        <span class="icon text-gray-600">
                                            <i class="fas fa-filter"></i>
                                        </span>
                                        <asp:TextBox
                                            AutoPostBack="true"
                                            OnTextChanged="Job_End_Filter_Changed"
                                            CssClass="default-dropdown-item-sm"
                                            ID="TextBox_Job_End" runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender
                                            ID="Calendar_Job_End" runat="server"
                                            BehaviorID="Calendar_Job_End"
                                            TargetControlID="TextBox_Job_End" CssClass= "calendar-theme shadow animated--grow-in"/>
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#Eval("End_Time")%>
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

    <!-- Content Row -->
    <div class="row">
        <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Job Distribution </h6>
                </div>
                <div class="card-body">
                    <div id="subscription_bars" runat="server">
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Incomplete Jobs</h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="assets/images/undraw_bug_fixing_oc7a.svg" alt="" />
                    </div>
                    <p id="exceptions" runat="server"></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
