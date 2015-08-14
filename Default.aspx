<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Appliance Repairs</title>
       <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="container">

            <div id="main">

                <h1>Home Appliance Repairs</h1>

                <p>Please select Technician below:</p>
    
                <asp:DropDownList ID="ddlTechnicians" runat="server" 
                    DataSourceID="SqlDataSource1" 
                    DataTextField="Name"
                    DataValueField="TechID" 
                    AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:AppRepairsConnectionString %>" 
                    SelectCommand="SELECT [TechID], [Name] FROM [Technicians] ORDER BY [Name]">
                </asp:SqlDataSource>

                <br /> <br />
       
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" OnRowUpdated="GridView1_RowUpdated" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="GridView1_RowCancelingEdit">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                    <asp:BoundField DataField="RepairID" HeaderText="ID" ReadOnly="True">
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProductCode" HeaderText="Product code" ReadOnly="True">
                        <ItemStyle  VerticalAlign="Top" />
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DateReported" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date reported"
                        HtmlEncode="False" ReadOnly="True">
                        <ItemStyle VerticalAlign="Top" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DateRepaired" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date repaired"
                        HtmlEncode="False" NullDisplayText="Null" ApplyFormatInEditMode="True">
                        <ControlStyle />
                        <ItemStyle VerticalAlign="Top" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" ReadOnly="True">
                        <ItemStyle VerticalAlign="Top" />
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Description">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Description") %>'
                                Rows="4" TextMode="MultiLine" Width="100%" ></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" >
                        <ItemStyle VerticalAlign="Top" />
                    </asp:CommandField>
                </Columns>
                    <EditRowStyle BackColor="#AEC0E5" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    ConflictDetection="CompareAllValues"
                     DataObjectTypeName="Repair"
                     OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetRepairsByTechnician" 
                    UpdateMethod="UpdateRepair"
                    TypeName="RepairDB" OnUpdated="ObjectDataSource1_Updated">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlTechnicians" Name="technician" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:Label ID="lblError" runat="server"></asp:Label>
    
            </div> <!--main-->

    
        </div> <!--container-->
    </form>
</body>
</html>
