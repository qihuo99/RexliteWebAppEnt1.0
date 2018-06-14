<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXLite3List.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXLite3List" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXLite3 Device List</title>
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
    .btnRenameEdit {
        background: url(images/APP_Button_Rename.png) no-repeat center;
        background-size: 80px 50px;
        cursor: pointer;
        height: 60px;
        width: 120px;
        vertical-align: middle;
        padding: 0;
        border-top: none;
        border-right: none;
        border-bottom: none;
        border-left: 2px solid #424242;
    }
    .btnSearch {
        background: url(images/APP_Button_DeviceSearch.png) no-repeat center;
        background-size: 80px 50px;
        cursor: pointer;
        height: 60px;
        width: 120px;
        vertical-align: middle;
        padding: 0;
        border-top: none;
        border-right: none;
        border-bottom: none;
        border-left: 2px solid #424242;
    }
    .btnMAXLite3MenuSearch {
        background: url(images/APP_Button_DeviceSearch-M_L-3.png) no-repeat center;
        background-size: 520px 65px;
        cursor: pointer;
        height: 66px;
        width: 550px;
        vertical-align: middle;
        margin-left: auto;
        margin-right: auto;
        padding: 0;
    }
	</style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div class="div.horizontal divlist"  style="width:100%;">
		        <div id="MAXLite3Top" class="ListPageTopDiv">
			        <div id="MAXLite3BackBtn" style="float:left;">
				        <a href="Default.aspx">
					        <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				        </a>
			        </div>
			        <div id="MAXLite3MenuBtn" style="float:right;">
				        <a href="Default.aspx">
					        <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				        </a>
			        </div>
		        </div>
                <div class="div.horizontal divlist" style="border: 1px solid transparent;" >
			        <div id="MAXLite3TopSearchBtn" class="btnMAXLite3MenuSearch">
			        </div>
                    <br /><br />   
	                <div id="MAXLite3DeviceList" class="DeviceList" style="border: 1px solid transparent;">
		            </div>
                </div>
	        </div>
            <asp:HiddenField ID="hidMAXLite3BleJsonList" runat="server" />
            <div id="MAXLite3bottomDiv" class="bottomDiv">
			    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
	        </div>
        </div>
    </form>
    <script type="text/javascript">
    $(document).ready(function () {
        var j = 0;
        var jstr = $('input#hidMAXLite3BleJsonList').val();
        console.log("MAXLite3 jstr =" + jstr);

        var getTopSearchBtn = document.getElementById("MAXLite3TopSearchBtn");
			
		// Add click event handler
        getTopSearchBtn.addEventListener("click", function (event) {
            event.preventDefault(); 
            alert("MAXLite3TopSearchBtn clicked!!!");
        });

        if (checkIsEmpty(jstr))  //only do the following events if json is not empty
        {
            alert("jstr is not empty!!!");
            console.log("jstr has value!");
            var blelist = JSON.parse(jstr);

            for (var i = 0; i < blelist.length; ++i) {	
                var bleId = blelist[i].ID;

                if (bleId == "18")
                {
                    console.log("j createSubDiv pre1 =" + j);
                    createSubDiv(j, "MAXLite3");
                    j++;
                }
            }







        }

    });
    </script>
</body>
</html>
