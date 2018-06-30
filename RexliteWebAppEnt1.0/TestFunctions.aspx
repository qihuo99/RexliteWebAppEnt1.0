<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestFunctions.aspx.cs" Inherits="RexliteWebAppEnt1._0.TestFunctions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/RexliteFunctions.js"></script>
    <link href="css/rexMain.css" rel="stylesheet" type="text/css" />
    <style>
		html {
			height:100%;
		}
		body {
			background-color: #131313;
			margin:0;
			padding: 0;
			height:100%;
		}
	</style>
    <script>
    $(function () {
        var dictionary = '{"MAXLite1Update":[' +
			'{"MAXLite1BleID":"14","MAXLite1DeviceSN":"000000000001","MAXLite1DeviceIDSN":"14000000000001","NewMAXLite1DeviceName":"MAXLite1--14000000000001"}]}';

        var obj = JSON.parse(dictionary);
        var bleId = "";
        var sn = "";
        var DeviceIDSN = "";
        var OldDeviceName = "";
			
		for(var i = 0; i < obj.length; ++i) 
		{	
			bleId = obj[i].MAXLite1BleID;
			sn = obj[i].MAXLite1DeviceSN;
            DeviceIDSN = obj[i].MAXLite1DeviceIDSN;
            OldDeviceName = obj[i].NewMAXLite1DeviceName;
				
			console.log("bleId = " + bleId);
            console.log("sn =" + sn);
			console.log("DeviceIDSN = " + DeviceIDSN);
            console.log("OldDeviceName =" + OldDeviceName);
            $("#DeviceID").val(MAXLite1DeviceIDSN);
            $("#OldDeviceName").val(OldDeviceName);
        }


	
      });
    </script>
</head>
<body>
    
</body>
</html>
