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

        dialog = $( "#RenameDialog" ).dialog({
            autoOpen: false,
            height: 400,
            width: 350,
            modal: true,
            buttons: {
            "Rename Device : ": addUser,
            Cancel: function() {
                dialog.dialog( "close" );
            }
            },
            close: function() {
            form[0].reset();
            allFields.removeClass( "ui-state-error" );
            }
        });
	    //var obj = {"nissan": "sentra", "color": "green"};
	    //var obj2 = JSON.stringify(obj);
	    ////alert(obj2);
	
	    //var formjson = '{"name": "' + $("#DeviceID").val() + '", "id": "' + $("#DeviceIDclass").val() + '" }';
     //   alert(formjson);

        $( "#update-maxlite1" ).button().on( "click", function() {
            dialog.dialog("open");
        });
	
      });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="RenameDialog" title="Rename Device">
	        <p class="validateTips">All form fields are required.</p>
            <fieldset>
		        <label for="DeviceID">Device ID:</label>
		        <input type="text" id="DeviceID" name="DeviceID" value="" class="text ui-widget-content ui-corner-all" disabled="disabled" />
                <label for="OldDeviceName">Old Device Name:</label>
		        <input type="text" id="OldDeviceName" name="OldDeviceName" value="" class="text ui-widget-content ui-corner-all" disabled="disabled" />
                <label for="DeviceID">New Device Name:</label>
		        <input type="text" id="NewDeviceName" name="NewDeviceName" value="" class="text ui-widget-content ui-corner-all" />
		  
  	            <!-- Allow form submission with keyboard without duplicating the dialog button -->
		        <input type="submit" tabindex="-1" style="position:absolute; top:-2000px" />
		    </fieldset>
            <button id="update-maxlite1">Update MAXLite1 Device</button>

	    </div>
    </form>
</body>
</html>
