<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Custom.aspx.cs" Inherits="SelfAspNet.project3.Custom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:TextBox ID="txtName" runat="server" Columns="25"></asp:TextBox>
        <asp:CustomValidator ID="cusName" runat="server" ClientValidationFunction="myValidate" ControlToValidate="txtName" CssClass="valid" ErrorMessage="名前は20文字以内で入力してください"></asp:CustomValidator>
        <p>
            <asp:Button ID="btnSubmit" runat="server" Text="送信" />
        </p>
    </form>
</body>
</html>
