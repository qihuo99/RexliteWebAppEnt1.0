<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXLite2List.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXLite2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXLite2 Device List</title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="css/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="Scripts/RexliteFunctions.js"></script>
    <link href="css/jquery-ui-themes-1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
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
    .btnMAXLite2MenuSearch {
        background: url(images/APP_Button_DeviceSearch-M_L-2.png) no-repeat center;
        background-size: 520px 65px;
        cursor: pointer;
        height: 66px;
        width: 550px;
        vertical-align: middle;
        margin-left: auto;
        margin-right: auto;
        padding: 0;
    }
    .validateTips {
	    border: 1px solid transparent;
	    padding: 0.3em;
    }
	</style>
</head>
<body>


    <form id="form1" runat="server">
       <asp:ScriptManager ID="MAXLite2ScriptManager1" runat="server" EnablePageMethods = "true"></asp:ScriptManager>
       <div>
            <div id="RenameDialog" title="Rename Device">
                <p id="validate-rename-dialog" class="validateTips">All form fields are required.</p>
	            <div id="RenameDeviceForm"><!--begin the dialog form -->
		        <fieldset>
		            <label for="DeviceID">Device ID:</label><br />
		            <input type="text" id="DeviceID" name="DeviceID" value="" class="text ui-widget-content ui-corner-all" style="border: 1px solid #81F7F3;background-color: #E6E6E6;" readonly="true" />
		            <br /><br />
                    <label for="OldDeviceName">Old Device Name:</label><br />
		            <input type="text" id="OldDeviceName" name="OldDeviceName" value="" class="text ui-widget-content ui-corner-all" style="border: 1px solid #81F7F3;background-color: #E6E6E6;"  readonly="true" />
		            <br /><br />
                    <label for="DeviceID">New Device Name:</label><br />
		            <input type="text" id="NewDeviceName" name="NewDeviceName" value="" class="text ui-widget-content ui-corner-all" style="border: 1px solid #58D3F7;"  />
		  
  	                <!-- Allow form submission with keyboard without duplicating the dialog button -->
		            <input type="submit" tabindex="-1" style="position:absolute; top:-2000px" />
		        </fieldset>
	            </div><!-- ending the dialog form -->
	        </div><br /><br />

             <div class="div.horizontal divlist"  style="width:100%;">
		        <div id="MAXLite2Top" class="ListPageTopDiv">
			        <div id="MAXLite2BackBtn" style="float:left;">
				        <a href="Default.aspx">
					        <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				        </a>
			        </div>
			        <div id="MAXLite2MenuBtn" style="float:right;">
				        <a href="Default.aspx">
					        <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				        </a>
			        </div>
		        </div>
                <div class="div.horizontal divlist" style="border: 1px solid transparent;" >
			        <div id="MAXLite2TopSearchBtn" class="btnMAXLite2MenuSearch">
			        </div>
                    <br /><br />   
	                <div id="MAXLite2DeviceList" class="DeviceList" style="border: 1px solid transparent;">
		            </div>
                </div>
	        </div>
            <asp:HiddenField ID="hidMAXLite2BleJsonList" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceID" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceSN" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceIDSN" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceOldName" runat="server" />
            <asp:HiddenField ID="hidSelectedDeviceNewName" runat="server" />
            <div id="MAXLite2bottomDiv" class="bottomDiv">
			    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
	        </div>
        </div>
    </form>
    
   <script>
   $(function () {
        var renamedialog, form,
               newDeviceName= $( "#NewDeviceName" ),
               allMAXAirFields = $( [] ).add( newDeviceName ),
               tips = $( ".validateTips" );

        renamedialog = $( "#RenameDialog" ).dialog({
          autoOpen: false,
          height: 460,
          width: 380,
          modal: true,
          buttons: {
            "Rename Device": updateDeviceName,
            Cancel: function() {	
              renamedialog.dialog( "close" );
		      $('#validate-rename-dialog').css('color', '#000000');  //back to black
		      $("#validate-rename-dialog").text("All form fields are required.");
		      $('#NewDeviceName').val("");
            }
          },
           close: function (event) {
              event.preventDefault(); 
              //$("#RenameDeviceForm")[0].reset();
              renamedialog.dialog( "close" );
              allMAXAirFields.removeClass("ui-state-error");
              alert("Rename Device maxlite2 dialog is closed!!!");
              processMaxlite2UpdateJson("Rename Device maxlite2 is renamed!!!");
          }
        });

        var j = 0;
        var jstr = $('input#hidMAXLite2BleJsonList').val();
        console.log("MAXLite2 jstr =" + jstr);

        var getTopSearchBtn = document.getElementById("MAXLite2TopSearchBtn");
			
		// Add click event handler
        getTopSearchBtn.addEventListener("click", function (event) {
            event.preventDefault(); 
            alert("MAXLite2TopSearchBtn clicked!!!");
        });

        if (checkIsNotEmpty(jstr))  //only do the following events if json is not empty
        {
            console.log("jstr has value!");
            var blelist = JSON.parse(jstr);

            for (var i = 0; i < blelist.length; ++i) {	
                var bleId = blelist[i].ID;

                if (bleId == "16")
                {
                    console.log("j createSubDiv pre1 =" + j);
                    createSubDiv(j, "MAXLite2");
                    j++;
                }
            }

            j = 0;  //reset j value
            for(var i = 0; i <blelist.length; ++i) {
		        var bleId = blelist[i].ID;
		        var sn = blelist[i].SN;
                var bleName = blelist[i].BLEName;
    
                if (bleId == "16")
                {
                    j++;
                    console.log("find j =" + j + ", sn=" + sn + ", bleName=" + bleName);
                    console.log("bleId =" + bleId);
                    createButtonMLite2(j, bleId, sn, bleName, "MAXLite2");
                }		        
	        }
        }  // ending the check jstr event
        
        function createButtonMLite2(j, bleId, sn, bleName, devicePage) {
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
                alert(btnRenameEditor.id);

                $('#validate-rename-dialog').css('color', '#000000');  //back to black
		        $("#validate-rename-dialog").text("All form fields are required.");
                $('#NewDeviceName').val("");

                $('#hidSelectedDeviceID').val(bleId);
                $('#hidSelectedDeviceSN').val(sn);
                $('#hidSelectedDeviceIDSN').val(bleId + sn);
                $('#hidSelectedDeviceOldName').val(bleName);

                $('#DeviceID').val(bleId + sn);
                $('#OldDeviceName').val(bleName);
                //$('#hidSelectedDeviceNewName').val(bleId + sn);
                renamedialog.dialog("open");
                //processMaxlite2UpdateJson(bleId);
                //alert("Rename Device maxlite2 process is completed!!!");
                //processMaxlite2UpdateJson("Rename Device maxlite2 is renamed!!!");
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

	    function updateDeviceName() {
		    var valid = true;
            allMAXAirFields.removeClass("ui-state-error");

	 
		    valid = valid && checkLength( newDeviceName, "New Device Name", 6, 14 );
	        console.log("current valid status =" + valid );
		    if (!valid){
			    $('#validate-rename-dialog').css('color', 'red');    
		    }
		    //else 
		    if ( valid ) {
			    updateTips("");
			    $('#validate-rename-dialog').css('color', '#000000');  //back to black
			    $("#validate-rename-dialog").text("All form fields are required.");
		        console.log("now valid status should be true =" + valid );
						
			    var getNewDeviceName = $('#NewDeviceName').val();
			    $('#hidSelectedDeviceNewName').val(getNewDeviceName);
			    $('#NewDeviceName').val("");
			    //alert(getNewDeviceName);
			    renamedialog.dialog( "close" );;
		    }
		    return valid;
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

   } );
   </script>
   <script type = "text/javascript">
        function processMaxlite2UpdateJson(maxlite2updatejson) {
            PageMethods.SaveMAXLite2UpdateJsonFile(maxlite2updatejson, OnMAXLite2UpdateSuccess);
        }
        function OnMAXLite2UpdateSuccess(response, userContext, methodName) {
            alert(response);
        }

   </script>
</body>
</html>
