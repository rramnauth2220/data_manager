<%@ Page Title="Feed Subscriptions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Subscriptions.aspx.cs" Inherits="data_manager_v._1.Subscriptions" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
            <asp:Button ID="Button_Subscription_Insert" runat="server" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" OnClick="Subscription_Insert" Text="Insert New Subscription" />
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Summary</h6>
            </div>
            <div class="card-body">
                <div runat="server" id="dataHolder" class="table-responsive">
                    <asp:GridView ID="Subscriptions_View" runat="server" 
                        AutoGenerateColumns="False" DataKeyNames="Source_ID" 
                        DataSourceID="Subscription" EmptyDataText="null"
                        OnRowEditing="Subscription_RowEditing"         
                        OnRowCancelingEdit="Subscription_RowCancelEditing" 
                        OnRowUpdating="Subscription_RowUpdating"
                        OnRowDeleting="Subscription_RowDeleting"
                        CssClass="grid">
                        <Columns>
                            <asp:CommandField ButtonType="Link"
                                ControlStyle-Font-Underline="false"
                                ShowEditButton="true"
                                ShowDeleteButton="true"
                                EditText="<i style='display:inline; padding: 0.5rem' class='fas fa-edit fa-sm'></i>"
                                DeleteText="<i style='display:inline; padding: 0.5rem' class='fas fa-trash-alt fa-sm'></i>"
                                CancelText="<i style='display:inline; padding: 0.5rem' class='fas fa-times-circle fa-sm'></i>"
                                UpdateText="<i style='display:inline; padding: 0.5rem' class='fas fa-sync-alt fa-sm'></i>" />
                            <asp:BoundField Visible="false" DataField="Source_ID" HeaderText="Source_ID" InsertVisible="False" ReadOnly="True" SortExpression="Source_ID" />
                            <asp:BoundField DataField="Source_ShortName" HeaderText="Source Short Name" SortExpression="Source_ShortName"/>
                            <asp:BoundField DataField="Source_Full_Name" HeaderText="Source Full Name" SortExpression="Source_Full_Name"/>
                            <asp:BoundField DataField="Subscription_ID" HeaderText="Subscription ID" SortExpression="Subscription_ID" />
                            <asp:BoundField DataField="Subscription_FullName" HeaderText="Subscription Name" SortExpression="Subscription_FullName" />
                            <asp:BoundField DataField="Subscription_ShortName" HeaderText="Subscription ShortName" SortExpression="Subscription_ShortName"/>
                            <asp:BoundField DataField="Body" HeaderText="Body" SortExpression="Body" />
                            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                            <asp:BoundField DataField="Jurisdiction" HeaderText="Jurisdiction" SortExpression="Jurisdiction" />
                            <asp:BoundField DataField="Last_Epoch" HeaderText="Last Epoch" SortExpression="Last_Epoch" />
                            <asp:BoundField DataField="Last_Update" HeaderText="Last Update" SortExpression="Last_Update" />
                            <asp:BoundField DataField="Schedule_Freq" HeaderText="Frequency" SortExpression="Schedule_Freq" />
                            <asp:BoundField DataField="Process_Time" HeaderText="Process Time" SortExpression="Process_Time" />
                            <asp:BoundField DataField="Scan_Error" HeaderText="Scan Error" SortExpression="Scan_Error" />
                        </Columns>
                        <EditRowStyle CssClass="grid-edit" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="Subscription" runat="server"
                        ConnectionString="<%$ ConnectionStrings:RegulationContent %>" 
                        DeleteCommand="DELETE FROM [Reg_Change_Sources] WHERE [Source_ID] = @original_Source_ID" 
                        InsertCommandType="StoredProcedure"
                        InsertCommand="InsertNewSubscription"
                        OldValuesParameterFormatString="original_{0}" 
                        SelectCommand="SELECT * FROM [Reg_Change_Sources] ORDER BY [Source_ID] DESC" 
                        UpdateCommand="UPDATE [Reg_Change_Sources] SET [Source_Full_Name] = @Source_Full_Name, [Source_ShortName] = @Source_ShortName, [Subscription_ID] = @Subscription_ID, [Subscription_FullName] = @Subscription_FullName, [Subscription_ShortName] = @Subscription_ShortName, [Body] = @Body, [Active] = @Active, [Jurisdiction] = @Jurisdiction, [Last_Epoch] = @Last_Epoch, [Last_Update] = @Last_Update, [Schedule_Freq] = @Schedule_Freq, [Process_Time] = @Process_Time, [Scan_Error] = @Scan_Error WHERE [Source_ID] = @original_Source_ID">
                        <DeleteParameters>
                            <asp:Parameter Name="original_Source_ID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Source_Full_Name" Type="String" />
                            <asp:Parameter Name="Source_ShortName" Type="String" />
                            <asp:Parameter Name="Subscription_ID" Type="String" />
                            <asp:Parameter Name="Subscription_FullName" Type="String" />
                            <asp:Parameter Name="Subscription_ShortName" Type="String" />
                            <asp:Parameter Name="Body" Type="String" />
                            <asp:Parameter Name="Active" Type="Boolean" />
                            <asp:Parameter Name="Jurisdiction" Type="String" />
                            <asp:Parameter Name="Last_Epoch" Type="Int32" />
                            <asp:Parameter DbType="DateTime2" Name="Last_Update" />
                            <asp:Parameter Name="Schedule_Freq" Type="Int32" />
                            <asp:Parameter Name="Process_Time" Type="String" />
                            <asp:Parameter Name="Scan_Error" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Source_Full_Name" Type="String" />
                            <asp:Parameter Name="Source_ShortName" Type="String" />
                            <asp:Parameter Name="Subscription_ID" Type="String" />
                            <asp:Parameter Name="Subscription_FullName" Type="String" />
                            <asp:Parameter Name="Subscription_ShortName" Type="String" />
                            <asp:Parameter Name="Body" Type="String" />
                            <asp:Parameter Name="Active" Type="Boolean" />
                            <asp:Parameter Name="Jurisdiction" Type="String" />
                            <asp:Parameter Name="Last_Epoch" Type="Int32" />
                            <asp:Parameter DbType="DateTime2" Name="Last_Update" />
                            <asp:Parameter Name="Schedule_Freq" Type="Int32" />
                            <asp:Parameter Name="Process_Time" Type="String" />
                            <asp:Parameter Name="Scan_Error" Type="String" />
                            <asp:Parameter Name="original_Source_ID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </form>
</asp:Content>