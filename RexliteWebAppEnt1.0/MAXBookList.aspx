<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXBookList.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXBookList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXBook Device List</title>
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
    .btnMAXBookMenuSearch {
        background: url(images/APP_Button_DeviceSearch-M_B.png) no-repeat center;
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
		        <div id="MAXBookTop" class="ListPageTopDiv">
			        <div id="MAXBookBackBtn" style="float:left;">
				        <a href="Default.aspx">
					        <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				        </a>
			        </div>
			        <div id="MAXBookMenuBtn" style="float:right;">
				        <a href="Default.aspx">
					        <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				        </a>
			        </div>
		        </div>
                <div class="div.horizontal divlist" style="border: 1px solid transparent;" >
			        <div id="MAXBookTopSearchBtn" class="btnMAXBookMenuSearch">
			        </div>
                    <br /><br />   
	                <div id="MAXBookDeviceList" class="DeviceList" style="border: 1px solid transparent;">
		            </div>
                </div>
	        </div>
            <asp:HiddenField ID="hidMAXBookBleJsonList" runat="server" />
            <div id="MAXBookbottomDiv" class="bottomDiv">
			    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
	        </div>
        </div>
    </form>
    <script type="text/javascript">
    $(document).ready(function () {
        var j = 0;
        var jstr = $('input#hidMAXBookBleJsonList').val();
        console.log("MAXBook jstr =" + jstr);

        var getTopSearchBtn = document.getElementById("MAXBookTopSearchBtn");
			
		// Add click event handler
        getTopSearchBtn.addEventListener("click", function (event) {
            event.preventDefault(); 
            alert("MAXBookTopSearchBtn clicked!!!");
        });

        if (checkIsEmpty(jstr))  //only do the following events if json is not empty
        {
            console.log("jstr has value!");
            var blelist = JSON.parse(jstr);

            for (var i = 0; i < blelist.length; ++i) {	
                var bleId = blelist[i].ID;

                if (bleId == "0A" || bleId == "0a")
                {
                    console.log("j createSubDiv pre1 =" + j);
                    createSubDiv(j, "MAXBook");
                    j++;
                }
            }

            j = 0;  //reset j value
            for(var i = 0; i <blelist.length; ++i) {
		        var bleId = blelist[i].ID;
		        var sn = blelist[i].SN;
                var bleName = blelist[i].BLEName;
    
                if (bleId == "0A" || bleId == "0a")
                {
                    j++;
                    console.log("find ob =" + i + ", sn=" + sn + ", bleName=" + bleName);
                    createButton(j, bleId, sn, bleName, "MAXBook");
                }		        
	        }
        }  // ending the check jstr event

    });
    </script>
</body>
</html>
