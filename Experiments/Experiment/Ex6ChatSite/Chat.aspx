﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script>
        var refresh = function () {
            $.ajax({
                url    : "Ajax.aspx",
                cache  : false,
                success: function (text) {
                    document.getElementById('divMsg').innerHTML = text;
                },
                error: function (jqXHR, textStatus, errorThrow) {
                    alert('网络异常，请重试！');
                }
            });

            setTimeout('refresh()', 500);
        };
    </script>
</head>
<body onload="refresh()">
    <form id="form1" runat="server">
    <div id="divMsg"></div>
    <div>
    
        <asp:Label ID="lblName" runat="server"></asp:Label>
        <br />
        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Height="85px"></asp:TextBox>
        <br />
        <asp:Button ID="btnSend" runat="server" Text="发送" OnClick="btnSend_Click" />
    
    </div>
    </form>
</body>
</html>
