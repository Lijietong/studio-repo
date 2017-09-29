﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChatLogin.aspx.cs" Inherits="ChatLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
        .auto-style2 {
            width: 484px;
        }
        .auto-style3 {
            height: 20px;
            width: 484px;
        }
        .auto-style4 {
            width: 28%;
        }
        .auto-style5 {
            width: 42%;
        }
        .auto-style6 {
            height: 20px;
            width: 28%;
        }
        .auto-style7 {
            height: 20px;
            width: 42%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table style="width: 44%;">
            <tr>
                <td class="auto-style1" colspan="3" style="text-align: center">我的聊天室</td>
            </tr>
            <tr>
                <td class="auto-style4" style="text-align: right">用户名：</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txtName" runat="server" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style5">
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" style="text-align: right">密码：</td>
                <td class="auto-style3">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="200px"></asp:TextBox>
                </td>
                <td class="auto-style7">
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" style="text-align: center">&nbsp;</td>
                <td class="auto-style3" style="text-align: center">
                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="登录" />
                </td>
                <td class="auto-style1" style="text-align: center">&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
