<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXAirList.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXAirList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXAir Device List</title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="Scripts/RexliteFunctions.js"></script>
    <script type="text/javascript" src="css/jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <link href="css/rexMain.css" rel="stylesheet" type="text/css"  />
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
        .btnMAXAirMenuSearch {
            background: url(images/APP_Button_DeviceSearch-M_A.png) no-repeat center;
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
		        <div id="MAXAirTop" class="ListPageTopDiv">
			        <div id="MAXAirBackBtn" style="float:left;">
				        <a href="Default.aspx">
					        <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				        </a>
			        </div>
			        <div id="MAXAirMenuBtn" style="float:right;">
				        <a href="Default.aspx">
					        <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				        </a>
			        </div>
		        </div>
                <div class="div.horizontal divlist" style="border: 1px solid transparent;" >
			        <div id="MAXAirTopSearchBtn" class="btnMAXAirMenuSearch">
			        </div>
                    <br /><br />   
	                <div id="MAXAirDeviceList" class="DeviceList" style="border: 1px solid transparent;">
		            </div>
                </div>
	        </div>
            <asp:HiddenField ID="hidMAXAirDeviceJsonList" runat="server" />
            <div id="MAXAirbottomDiv" class="bottomDiv">
			    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
	        </div>
        </div>
    </form>
    <script type="text/javascript">
    $(document).ready(function () {
        var j = 0;
        var jstr = $('input#hidMAXAirDeviceJsonList').val();
        console.log("MAXAir jstr =" + jstr);

        var getTopSearchBtn = document.getElementById("MAXAirTopSearchBtn");
	
		// Add click event handler
        getTopSearchBtn.addEventListener("click", function (event) {
            event.preventDefault(); 
            alert("MAXAirTopSearchBtn clicked!!!");
		});

        if (checkIsEmpty(jstr))  //only do the following events if json is not empty
        {
			console.log("jstr has value!");
		    var deviceList = JSON.parse(jstr);
		    var deviceName = "MAXAir";
			
		    for (var i = 0; i < deviceList.MAXAirDeviceList.length; ++i) {	
                var deviceId = deviceList.MAXAirDeviceList[i].ID;
				
				createSubDiv(i, deviceName);
            }
			
			for (var i = 0; i < deviceList.MAXAirDeviceList.length; ++i) {	
				var deviceId = deviceList.MAXAirDeviceList[i].ID;
				createMAXAirButton(i, deviceId, deviceName);
			}
		}

        function createMAXAirButton(i, bleId, deviceName) {
            var getDiv = document.getElementById("MAXAirDeviceList");
            var btn = document.createElement("BUTTON");
            var btnRenameEditor = document.createElement("BUTTON");
            var btnSearch = document.createElement("BUTTON");
            console.log("here is create maxair buttons ");

            var subDivId = deviceName + "Div" + (i + 1);
            console.log("createMAbtn subDiv.id =" + subDivId);
            var getSubDiv = document.getElementById(subDivId);

            btn.id = deviceName + "btn_" + i;
            //btn.innerHTML = "btn_" + i;
            //alert(btn.id);
            var indx = i + 1;

            btn.innerHTML = "<span style='font-size:20px;font-weight: bold;'>" + deviceName + "&nbsp&nbsp&nbsp&nbsp&nbsp" + indx + "</span><br /> ID: " + bleId + "<br />";
            btn.style.height = "38px";
            btn.style.width = "60%";
            btn.className = "boxSt";
            $(btn).attr('data-MAXAirID', bleId);

            btnRenameEditor.id = "bleEditBtn_" + i;
            btnRenameEditor.style.height = "60px";
            btnRenameEditor.style.width = "20%";
            btnRenameEditor.className = "btnRenameEdit";

            btnSearch.id = "bleSearchBtn_" + i;
            btnSearch.style.height = "60px";
            btnSearch.style.width = "20%";
            btnSearch.className = "btnSearch";

            // 3. Add event handler
            btn.addEventListener("click", function () {
                alert(btn.id);
                //var a = $("blebtn_0").data('bleidsn'); //getter
            });

            // 4. Add event handler
            btnRenameEditor.addEventListener("click", function () {
                alert(btnRenameEditor.id);
            });

            // 4. Add event handler
            btnSearch.addEventListener("click", function () {
                alert(btnSearch.id);
            });

            getSubDiv.appendChild(btn);
            getSubDiv.appendChild(btnRenameEditor);
            getSubDiv.appendChild(btnSearch);
        }




    });
    </script>
</body>
</html>
