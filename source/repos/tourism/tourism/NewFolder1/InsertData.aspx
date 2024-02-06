<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertData.aspx.cs" Inherits="tourism.NewFolder1.InsertData" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script src="https://unpkg.com/mermaid/dist/mermaid.min.js"></script>
<script>
    var ele = document.querySelector('.mermaid');
    if (ele && ele.textContent.trim() !== '') {
        var loadingImage = document.getElementById('loadingImage');

        // ローディング画像を表示
        loadingImage.style.display = 'block';
        mermaid.initialize({
            startOnLoad: true,
            theme: 'default'
        });
        loadingImage.style.display = 'none';
    } else {
        ele.style.display = 'none';
    }
</script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <asp:Button ID="Button1" runat="server" Text="レビュー閲覧" BorderStyle="None" CssClass="header" ForeColor="yellow" style="font-size: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="レビュー登録" BorderStyle="None" CssClass="header" ForeColor="White" style="font-size: 20px; margin-left: 30px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
            <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="フィードバック閲覧" BorderStyle="None" CssClass="header" ForeColor="White" style="font-size: 20px; margin-left: 20px; transition: box-shadow 0.3s;" onmouseover="this.style.boxShadow='0 0 10px rgba(255,255,255,0.7)';" onmouseout="this.style.boxShadow='none';" />
        </div>
        <asp:Image ID="Image1" runat="server" ImageUrl="~/img/cat.jpeg" Style="display: none;" />
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
        <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="キーワード検索" />
        <p style="margin-top: 20px;"><asp:Label ID="Label1" runat="server" Text="レビュー" Width="100%" style="text-align: center; font-weight: bold; font-size: 35px;" ></asp:Label></p>
        
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" PageSize="5" >
            <Columns>
                <asp:TemplateField ShowHeader="False" ItemStyle-Width="100%">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="キャンセル"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <div style="display: flex; align-items: center;">
                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="編集" style="margin-left: 15px;" ></asp:LinkButton>
                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="削除" style="margin-left: 15px;" ></asp:LinkButton>
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="分析" style="margin-left: 15px; color: blue; background-color: none; border: none; " Width="55px" />
                            </div>
                    </ItemTemplate>

<ItemStyle Width="20%"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="review" HeaderText="review" SortExpression="review" />
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
        <asp:SqlDataSource ID="review" runat="server" ConnectionString="<%$ ConnectionStrings:Reviews %>" DeleteCommand="DELETE FROM [Review] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Review] ([review]) VALUES (@review)" SelectCommand="SELECT [Id], [review] FROM [Review]" UpdateCommand="UPDATE [Review] SET [review] = @review WHERE [Id] = @Id">
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
            <div><asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="フィードバックを挿入" Width="100%" style="font-size: 30px; font-weight: bold;" Height="52" /></div>
        
            <div></div>
        
        <div style="height: 490px"><asp:TextBox ID="Prompttxt" runat="server" Height="175px" style="margin-top: 11px" TextMode="MultiLine" Width="100%"></asp:TextBox>
            <asp:TextBox ID="Good" runat="server" Width="100%"></asp:TextBox><br />
            <asp:TextBox ID="Bad" runat="server" Width="100%"></asp:TextBox><br />
            <asp:TextBox ID="Imp" runat="server" Width="100%"></asp:TextBox>
            <br />
            <asp:TextBox ID="TextBox4" runat="server" Height="281px" TextMode="MultiLine" Width="100%"></asp:TextBox>
        </div>

        <br />
        
            <br />
        
        <br />
        <div class="mermaid">
            
        </div>

        <br />
        <br />
        <asp:Image ID="Image2" runat="server" />
        <br />
        <br />
        <br />
        <br />
        <br />
    </form>
        </body>
</html>
