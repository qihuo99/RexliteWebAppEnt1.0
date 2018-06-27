<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXLite1List.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXLite1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXLite1 Device List</title>
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
    .btnMAXLite1MenuSearch {
        background: url(images/APP_Button_DeviceSearch-M_L-1.png) no-repeat center;
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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods = "true"></asp:ScriptManager>
        <div>
        Your Name : 
        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
        <input id="btnGetTime" type="button" value="Show Current Time" onclick = "ShowCurrentTime()" />
        </div>

        <div>
             <div class="div.horizontal divlist"  style="width:100%;">
		        <div id="MAXLite1Top" class="ListPageTopDiv">
			        <div id="MAXLite1BackBtn" style="float:left;">
				        <a href="Default.aspx">
					        <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				        </a>
			        </div>
			        <div id="MAXLite1MenuBtn" style="float:right;">
				        <a href="Default.aspx">
					        <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				        </a>
			        </div>
		        </div>
                <div class="div.horizontal divlist" style="border: 1px solid transparent;" >
			        <div id="MAXLite1TopSearchBtn" class="btnMAXLite1MenuSearch">
			        </div>
                    <br /><br />   
	                <div id="MAXLite1DeviceList" class="DeviceList" style="border: 1px solid transparent;">
		            </div>
                </div>
	        </div>
            <asp:HiddenField ID="hidMAXLite1BleJsonList" runat="server" />
            <asp:HiddenField ID="hidMAXLite1DeviceRenameJson" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceID" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceSN" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceIDSN" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceOldName" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceNewName" runat="server" />

            <div id="MAXLite1bottomDiv" class="bottomDiv">
			    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
	        </div>
        </div>
    </form>
    <script type="text/javascript">
    $(document).ready(function () {
        var j = 0;
        var jstr = $('input#hidMAXLite1BleJsonList').val();
        console.log("MAXLite1 jstr =" + jstr);

        var getTopSearchBtn = document.getElementById("MAXLite1TopSearchBtn");
			
		// Add click event handler
        getTopSearchBtn.addEventListener("click", function (event) {
            event.preventDefault(); 
            alert("MAXLite1TopSearchBtn clicked!!!");
        });

        if (checkIsNotEmpty(jstr))  //only do the following events if json is not empty
        {
            console.log("jstr has value!");
            var blelist = JSON.parse(jstr);

            for (var i = 0; i < blelist.length; ++i) {	
                var bleId = blelist[i].ID;

                if (bleId == "14")
                {
                    console.log("j createSubDiv pre1 =" + j);
                    createSubDiv(j, "MAXLite1");
                    j++;
                }
            }

            j = 0;  //reset j value
            for(var i = 0; i <blelist.length; ++i) {
		        var bleId = blelist[i].ID;
		        var sn = blelist[i].SN;
                var bleName = blelist[i].BLEName;
    
                if (bleId == "14")
                {
                    j++;
                    console.log("find j =" + j + ", sn=" + sn + ", bleName=" + bleName);
                    console.log("bleId =" + bleId);
                    createButtonMLite1(j, bleId, sn, bleName, "MAXLite1");
                }		        
	        }
        }  // ending the check jstr event


        function createButtonMLite1(j, bleId, sn, bleName, devicePage) {
            var getDevicePageName = devicePage + "DeviceList";
            //var getDiv = document.getElementById("MAXSceneDeviceList");
            var getDiv = document.getElementById(getDevicePageName);
            var btn = document.createElement("BUTTON");
            var btnRenameEditor = document.createElement("BUTTON");
            var btnSearch = document.createElement("BUTTON");
            var subDivId = devicePage + "Div" + j;

            console.log("crbtn subDiv.id =" + subDivId);
            var getSubDiv = document.getElementById(subDivId);

            btn.id = "btn" + devicePage + "_" + j;
            console.log("subDivId =" + subDivId);
            console.log("btn.id =" + btn.id);

            btn.innerHTML = "<span style='font-size:20px;font-weight: bold;'>" + bleName + "&nbsp&nbsp" + j + "</span><br /> ID: " + bleId + sn + "<br />";
            btn.style.height = "38px";
            btn.style.width = "60%";
            btn.className = "boxSt";
            $(btn).attr('data-bleID', bleId);
            $(btn).attr('data-bleSN', sn);
            $(btn).attr('data-bleIDSN', bleId + sn);

            btnRenameEditor.id = "btn" + devicePage + "Edit_" + j;
            btnRenameEditor.className = "btnRenameEdit";

            btnSearch.id = "btn" + devicePage + "Search_" + j;
            btnSearch.className = "btnSearch";
            var btnid = btn.id;

            // 3. Add event handler
            btn.addEventListener("click", function (event) {
                event.preventDefault(); //this will prevent the click event to return anything. otherwise it will return false and prevent page redirect                  
                alert("btnaddevent=" + btn.id);
                var idsn = $(this).data('bleidsn'); // $(this) refers to the button
                alert("idsn=" + idsn)
                var sn = $(this).data('blesn'); // $(this) refers to the button
                console.log("sn=" + sn);

                //var redirectPage = devicePage + "KeysPanel.aspx";
                //window.location.href = redirectPage;
            });

            // 4. Add event handler
            btnRenameEditor.addEventListener("click", function (event) {
                event.preventDefault();
                alert("Current btnRenameEditor selected is =" +btnRenameEditor.id);
                alert("Current blebtn selected is =" + btnid);
                var currBleID = "#" + btnid;
                console.log("99 currBleIDName = " + currBleID);
                var getCurrBleID = $(currBleID).data("bleid");
                var getCurrSN = $(currBleID).data("blesn");
                var getCurrIDSN = $(currBleID).data("bleidsn");
                var getNewDeviceName = "MAXLite1--" + getCurrIDSN;
                console.log("99 getCurrID = " + getCurrBleID);
                console.log("99 getCurrSN = " + getCurrSN);
                console.log("99 getCurrIDSN = " + getCurrIDSN);

                var formjson = '{"MAXLite1BleID": "' + getCurrBleID  + '", "MAXLite1DeviceSN": "' + getCurrSN +
                         '", "MAXLite1DeviceIDSN": "' + getCurrIDSN +
                         '", "NewMAXLite1DeviceName": "' + getNewDeviceName + '" }';

                console.log(formjson);  //'{"DeviceID": "' + $("#hidRenameDeviceIDSNSelected").val()
                
                $('#hidMAXLite1DeviceRenameJson').val(formjson);
                renamedialog.dialog( "open" );
                //processMaxlite1UpdateJson(formjson);
                //showMsg();
                //ShowCurrentTime();
                //processMaxlite1UpdateJson("maxlite1updatejson btnRenameEditor clicked!!! = ");

                // window.location.replace("MaxSceneDetails.aspx");
            });

            // 4. Add event handler
            btnSearch.addEventListener("click", function (event) {
                event.preventDefault();
                alert(btnSearch.id);
            });

            getSubDiv.appendChild(btn);
            getSubDiv.appendChild(btnRenameEditor);
            getSubDiv.appendChild(btnSearch);
        }

        function updateTips( t ) {
          tips
            .text( t )
            .addClass( "ui-state-highlight" );
          setTimeout(function() {
            tips.removeClass( "ui-state-highlight", 1500 );
          }, 500 );
        }
 
        function checkLength( o, n, min, max ) {
          if ( o.val().length > max || o.val().length < min ) {
            o.addClass( "ui-state-error" );
            updateTips( "Length of " + n + " must be between " +
              min + " and " + max + "." );
            return false;
          } else {
            return true;
          }
        }

        function checkRegexp( o, regexp, n ) {
          if ( !( regexp.test( o.val() ) ) ) {
            o.addClass( "ui-state-error" );
            updateTips( n );
            return false;
          } else {
            return true;
          }
        }



    });
    </script>
    <script type = "text/javascript">
          function processMaxlite1UpdateJson2(maxlite1updatejson) {
             alert("processMaxlite1UpdateJson2 here!!!");
        }

        function ShowCurrentTime() {
            PageMethods.GetCurrentTime(document.getElementById("<%=txtUserName.ClientID%>").value, OnSuccess);
        }
        function OnSuccess(response, userContext, methodName) {
            alert(response);
        }


        function processMaxlite1UpdateJson(maxlite1updatejson) {
            PageMethods.SaveMAXLite1UpdateJsonFile(maxlite1updatejson, OnMAXLite1UpdateSuccess);
        }
        function OnMAXLite1UpdateSuccess(response, userContext, methodName) {
            alert(response);
        }

    </script>
</body>
</html>
