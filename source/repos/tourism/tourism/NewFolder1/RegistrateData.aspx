<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrateData.aspx.cs" Inherits="tourism.NewFolder1.RegistrateData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="レビュー閲覧" BorderStyle="None" CssClass="header" ForeColor="White" style="font-size: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
            <asp:Button ID="Button3" runat="server" Text="レビュー登録" BorderStyle="None" CssClass="header" ForeColor="yellow" style="font-size: 20px; margin-left: 30px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';"/>
            <asp:Button ID="Button2" runat="server" Text="フィードバック閲覧" BorderStyle="None" CssClass="header" ForeColor="White" OnClick="Button2_Click" style="font-size: 20px; margin-left: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
        </div>
        <asp:FormView ID="FormView1" runat="server" AllowPaging="True" DataKeyNames="Id" DataSourceID="review3" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Both" Width="100%">
            <EditItemTemplate>
                Id:
                <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                review:
                <asp:TextBox ID="reviewTextBox" runat="server" Text='<%# Bind("review") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="キャンセル" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <InsertItemTemplate>
                review:
                <asp:TextBox ID="reviewTextBox" runat="server" Text='<%# Bind("review") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="挿入" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="キャンセル" />
            </InsertItemTemplate>
            <ItemTemplate>
                Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                review:
                <asp:Label ID="reviewLabel" runat="server" Text='<%# Bind("review") %>' />
                <br />

                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="編集" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="削除" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="新規作成" />
            </ItemTemplate>
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
        </asp:FormView>
        <asp:SqlDataSource ID="review3" runat="server" ConnectionString="<%$ ConnectionStrings:Reviews %>" DeleteCommand="DELETE FROM [Review] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Review] ([review]) VALUES (@review)" SelectCommand="SELECT * FROM [Review] ORDER BY [Id]" UpdateCommand="UPDATE [Review] SET [review] = @review WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="review" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="review" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
