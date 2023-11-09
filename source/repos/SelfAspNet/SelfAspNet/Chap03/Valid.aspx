<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Valid.aspx.cs" Inherits="SelfAspNet.project3.Valid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>検証コントロール</title>
    <link href="../Site.css" rel="stylesheet" />
</head>
<body>
    <form id="Valid" runat="server">
        <div>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="reqName" runat="server" ErrorMessage="名前は必須です" SetFocusOnError="True" ControlToValidate="txtName"></asp:RequiredFieldValidator>
        </div>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="決定" />
        </p>
        <p>
            <asp:Label ID="lblResult" runat="server" Text="Label"></asp:Label>
        </p>
    </form>
</body>
</html>
