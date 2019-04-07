<%@ Page Title="Activity Log" Language="C#" MasterPageFile="../../Site.Master" AutoEventWireup="true" CodeBehind="Activity.aspx.cs" Inherits="data_manager_v._1.Components.Data_Manager.Activity" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
        </div>

        <!-- Page Body -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 id="row_count" runat="server" class="m-0 font-weight-bold text-primary">Summary</h6>
            </div>
            <div class="card-body">
                <div runat="server" class="table-responsive">
                    <asp:ScriptManager ID="ScriptManager_Activity" runat="server"></asp:ScriptManager>
                    <asp:GridView role="table" class='grid' Width='100%'
                        ID="Activity_View" runat="server"
                        AllowPaging="True" OnPageIndexChanging="Activity_PageIndexChanging"
                        AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" DataKeyNames="Id" DataSourceID="Activity1" 
                        OnRowUpdating="Activity_RowUpdating"
                        OnRowEditing="Activity_RowEditing"         
                        OnRowCancelingEdit="Activity_RowCancelEditing">
                        <Columns>
                            <asp:CommandField ButtonType="Link"
                                ControlStyle-Font-Underline="false"
                                ShowEditButton="true"
                                EditText="<i style='display:inline; padding: 0.5rem' class='fas fa-edit fa-sm'></i>"
                                CancelText="<i style='display:inline; padding: 0.5rem' class='fas fa-times-circle fa-sm'></i>"
                                UpdateText="<i style='display:inline; padding: 0.5rem' class='fas fa-sync-alt fa-sm'></i>" />
                            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" Visible="false" ReadOnly="true"/>
                            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" ReadOnly="true" />
                            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" ReadOnly="true"/>
                            <asp:BoundField DataField="View" HeaderText="View" SortExpression="View" ReadOnly="true"/>
                            <asp:BoundField DataField="Content_Id" HeaderText="Content ID" SortExpression="Content_Id" ReadOnly="true" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="false" />
                        </Columns>
                        <EditRowStyle CssClass="grid-edit" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText='<i class="fas fa-chevron-left"></i>' LastPageText='<i class="fas fa-chevron-right"></i>'></PagerSettings>
                        <PagerStyle CssClass="Paging" HorizontalAlign="Right" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="Activity1" runat="server"
                        ConflictDetection="OverwriteChanges"
                        ConnectionString="<%$ ConnectionStrings:RegulationContent %>"
                        OldValuesParameterFormatString="original_{0}"
                        SelectCommand="SELECT [Username], [Time], [Action], [View], [Content_Id], [Description], [Id] FROM [Manager_Change_Tracking] WHERE [Username]=@Username ORDER BY [Time] DESC"
                        UpdateCommand="UPDATE [Manager_Change_Tracking] SET [Description] = @Description WHERE [Id] = @original_Id">
                        <UpdateParameters>
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="original_Id" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
