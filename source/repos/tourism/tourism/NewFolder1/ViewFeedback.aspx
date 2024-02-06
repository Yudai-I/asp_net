<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewFeedback.aspx.cs" Inherits="tourism.NewFolder1.ViewFeedback" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server">
        
        <div class="header"><asp:Button ID="Button1" runat="server" Text="レビュー閲覧" BorderStyle="None" CssClass="header" ForeColor="White" OnClick="Button1_Click" style="font-size: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
            <asp:Button ID="Button2" runat="server" Text="レビュー登録" BorderStyle="None" CssClass="header" ForeColor="White" OnClick="Button2_Click" style="font-size: 20px; margin-left: 30px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';"/>
            <asp:Button ID="Button3" runat="server" Text="フィードバック閲覧" BorderStyle="None" CssClass="header" ForeColor="yellow" style="font-size: 20px; margin-left: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
        </div>
        <p style="margin-top: 20px;"><asp:Label ID="Label1" runat="server" Text="フィードバック" Width="100%" style="text-align: center; font-weight: bold; font-size: 35px;" ></asp:Label></p>
      
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="FeedBack" AllowSorting="True" Width="100%">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="good" HeaderText="good" SortExpression="good" />
                <asp:BoundField DataField="plan" HeaderText="plan" SortExpression="plan" />
                <asp:BoundField DataField="bad" HeaderText="bad" SortExpression="bad" />
                <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" />
                <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:SqlDataSource ID="FeedBack" runat="server" ConnectionString="<%$ ConnectionStrings:Reviews %>" DeleteCommand="DELETE FROM [Feedback] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Feedback] ([good], [plan], [bad], [comment]) VALUES (@good, @plan, @bad, @comment)" SelectCommand="SELECT [good], [plan], [bad], [comment], [Id] FROM [Feedback] ORDER BY [comment]" UpdateCommand="UPDATE [Feedback] SET [good] = @good, [plan] = @plan, [bad] = @bad, [comment] = @comment WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="good" Type="String" />
                <asp:Parameter Name="plan" Type="String" />
                <asp:Parameter Name="bad" Type="String" />
                <asp:Parameter Name="comment" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="good" Type="String" />
                <asp:Parameter Name="plan" Type="String" />
                <asp:Parameter Name="bad" Type="String" />
                <asp:Parameter Name="comment" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="形態素解析" Width="100%" Height="52px" style="font-size: 30px; font-weight: bold;" />
        <p style="margin-top: 20px;">
            <asp:Label ID="Label2" runat="server" Text="解析結果" style="text-align: center; margin-top: 20px; font-weight: bold; font-size: 35px;" Width="100% " ></asp:Label>
        </p>
        <asp:GridView ID="GridView2" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="Analysis" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
    <Columns>
        <asp:BoundField DataField="bad" HeaderText="bad" SortExpression="bad" />
        <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
    </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
</asp:GridView>

<asp:SqlDataSource ID="Analysis" runat="server" ConnectionString="<%$ ConnectionStrings:Reviews %>"
    SelectCommand="SELECT [bad], COUNT([bad]) AS [Count] FROM [Analysis] GROUP BY [bad] ORDER BY [Count] DESC">
</asp:SqlDataSource>

        <asp:TextBox ID="TextBox1" runat="server" Height="289px" TextMode="MultiLine" Width="1001px"></asp:TextBox>

    </form>
</body>
</html>
