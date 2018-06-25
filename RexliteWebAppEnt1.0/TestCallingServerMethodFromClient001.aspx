<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestCallingServerMethodFromClient001.aspx.cs" Inherits="RexliteWebAppEnt1._0.TestCallingServerMethodFromClient001" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/RexliteFunctions.js"></script>
    <link href="css/rexMain.css" rel="stylesheet" type="text/css" />
    <script type = "text/javascript">
        function ShowCurrentTime() {
            PageMethods.GetCurrentTime(document.getElementById("<%=txtUserName.ClientID%>").value, OnSuccess);
        }
        function OnSuccess(response, userContext, methodName) {
            alert(response);
        }
    </script> 
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods = "true">
        </asp:ScriptManager>
        <div>
            Your Name : 
            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
            <input id="btnGetTime" type="button" value="Show Current Time" onclick = "ShowCurrentTime()" />
        </div>
    </form>
</body>
</html>
