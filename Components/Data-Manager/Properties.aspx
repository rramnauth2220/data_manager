<%@ Page Title="Data Manager - Properties" Language="C#" MasterPageFile="../../Site.Master" AutoEventWireup="true" CodeBehind="Properties.aspx.cs" Inherits="data_manager_v._1.Components.Data_Manager.Properties" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"><%: Title %></h1>
        </div>

        <!-- Description -->
        <p class="mb-4" id="message" runat="server">Listing of configuration files available for viewing, download, and deletion. To replace a file, upload another with the same name. </p>
        
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Configuration Files</h6>
                <asp:FileUpload ID="Config_Browse" runat="server"/>
                <asp:Button ID="Config_Upload" runat="server" Text="Upload" OnClick="UploadFile"/>
            </div>
            <div class="card-body">
                <div runat="server" id="dataHolder" class="table-responsive">
                    <asp:GridView CssClass="grid" ID="Config_View" runat="server" AutoGenerateColumns="false" EmptyDataText="No files uploaded">
                        <Columns>
                            <asp:BoundField DataField="Text" HeaderText="File Name" />
                            <asp:TemplateField HeaderText="File Extension">
                                <ItemTemplate>
                                    <asp:Label ID="file_extension" runat="server" Text='<%# new System.IO.FileInfo(Eval("Value").ToString()).Extension.ToString() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Size">
                                <ItemTemplate>
                                    <asp:Label ID="file_size" runat="server" Text='<%# Globals.BytesToString(new System.IO.FileInfo(Eval("Value").ToString()).Length).ToString() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Modified">
                                <ItemTemplate>
                                    <asp:Label ID="file_modified" runat="server" Text='<%# System.IO.File.GetLastWriteTime(Eval("Value").ToString()).ToString() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Created">
                                <ItemTemplate>
                                    <asp:Label ID="file_creation" runat="server" Text='<%# System.IO.File.GetCreationTime(Eval("Value").ToString()).ToString() %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkRead" Text="Read" CommandArgument='<%# Eval("Value") %>' runat="server" OnClick="ReadFile"><i class="fas fa-fw fa-eye"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownload" Text="Download" CommandArgument='<%# Eval("Value") %>' runat="server" OnClick="DownloadFile"><i class="fas fa-fw fa-download"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" CommandArgument='<%# Eval("Value") %>' runat="server" OnClick="DeleteFile"><i class="fas fa-fw fa-trash-alt"></i></asp:LinkButton>
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

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Content</h6>
            <div id="Div_Error" runat="server">Select a file to view its content </div>
        </div>
        <div class="card-body">
            <pre><code id="Div_Source" class="xml" runat="server"></code></pre>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ScriptsContent" ContentPlaceHolderID="PageLevelScripts" runat="server">
    <script src="../../assets/js/highlight.pack.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
</asp:Content>

<asp:Content ID="StyleContent" ContentPlaceHolderID="PageLevelStyle" runat="server">
    <link rel="stylesheet" href="../../assets/css/highlight-styles/vs.css" />
</asp:Content>
