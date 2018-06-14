<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RexliteWebAppEnt1._0.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Rexlite Home</title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <link href="css/rexMain.css" rel="stylesheet" type="text/css"  />
    <script type="text/javascript">
        var javacriptVariable = "<%=DateTime.Now%>";
        console.log("javacriptVariable =" + javacriptVariable );
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="mainContent" class="mainContent">
            <div class="horizontal div1" style="border: 1px solid transparent;" >
                <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXLiTE1_img" src="images/APP_Button_M_L-1-OFF.png" width="107" height="152"  /> 
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXLiTE1_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>	
                <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
			        <img id="Vertical_Row1_img" src="images/APP_Button_Bar-Vertical-OFF.png"  width="3" height="170" /> 
		        </div>
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXAir_img" src="images/APP_Button_M_A-OFF.png" width="107" height="152"  /> 
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXAir_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>
            </div>  <!-- ending div1 row  -->
            <br /><br />
            <div class="horizontal div2" style="border: 1px solid transparent;" >
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXLiTE2_img" src="images/APP_Button_M_L-2-OFF.png" width="107" height="152"  /> 
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXLiTE2_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>	
		        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
			        <img id="Vertical_Row2_img" src="images/APP_Button_Bar-Vertical-OFF.png"  width="3" height="170" /> 
		        </div>
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
                        <a href="MAXSceneList.aspx">
				            <img id="MAXScene_img" src="images/APP_Button_M_S-OFF.png" width="107" height="152"  /> 
                        </a>
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXScene_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>
	        </div><!-- ending div2 row  -->
            <br /><br />
            <div class="horizontal div3" style="border: 1px solid transparent;" >
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXLiTE3_img" src="images/APP_Button_M_L-3-OFF.png" width="107" height="152"  /> 
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img  id="MAXLiTE3_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>	
		        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
			        <img id="Vertical_Row3_img" src="images/APP_Button_Bar-Vertical-OFF.png"  width="3" height="170" /> 
		        </div>
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXBook_img" src="images/APP_Button_M_B-OFF.png" width="107" height="152"  /> 
			        </div>
			        <br />
			        <div class="" style="display: block; margin: 0 auto; " >
				        <img id="MAXBook_buttonbar_img" src="images/APP_Button_Bar-Landscape-OFF.png"  width="220" height="3" style="margin: 0, auto;" /> 
			        </div>
		        </div>
	        </div><!-- ending div3 row  -->
            <br /><br />
		    <div id="bottomDiv" class="bottomDiv">
			    <a href="MAXLiTE1.html">
				    <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
			    </a>
		    </div>
            <asp:HiddenField ID="hidMainBleDeviceJsonList" runat="server" />
            <asp:HiddenField ID="hidIPCallBack" runat="server" />
            <asp:HiddenField ID="hidCallBackTimeElapsed" runat="server" />
        </div>
    </form>
    <script type="text/javascript">
        var MAXLiTE1_status = false, MAXLiTE2_status = false, MAXLiTE3_status = false; 
        var MAXAir_status = false, MAXScene_status = false, MAXBook_status = false; 	

        //var getBleJson = document.getElementById("<%=hidMainBleDeviceJsonList.ClientID%>");
        //console.log("getJson value =" + getBleJson.value);

       //initBleDeviceJson();

        function initBleDeviceJson(){   
		    var obj = JSON.parse(getBleJson.value);
			
		    for(var i = 0; i < obj.length; ++i) 
		    {	
			    var bleId = obj[i].ID;
			    var sn = obj[i].SN;
			    var bleName = obj[i].BLEName;
				
                console.log("bleId i = " + bleId);
                console.log("sn i = " + sn);
                console.log("bleName i = " + bleName);
			    var st = setupBleDeviceStatus(bleId);
			    console.log("st =" + st);
		    }
	    }

        function setupBleDeviceStatus (condition) {
		    var stuff = {
		    '0A': function () {
                MAXBook_status = true;
                //console.log("stuff =" + "0A");
			    $('#MAXBook_img').attr('src','images/APP_Button_M_B-ON.png');
			    $('#MAXBook_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row3_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');
			    $('#MAXBook_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });	  
			    $("#MAXBook_img").click(function () {
				    alert('MAXBook_img btn clicked');
			    });
			    return true;
		    },
		    '0B': function () {
			    MAXScene_status = true;
			    $('#MAXScene_img').attr('src','images/APP_Button_M_S-ON.png');
			    $('#MAXScene_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row2_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');
			    $('#MAXScene_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });
			    $("#MAXScene_img").click(function () {
                    alert('MAXScene_img btn clicked');
                    window.location.href="MAXSceneList.aspx";
			    });
			    return true;
		    },
		    '13': function () {
			    MAXAir_status = true;
			    $('#MAXAir_img').attr('src','images/APP_Button_M_A-ON.png');
			    $('#MAXAir_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row1_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');
			    $('#MAXAir_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });
			    $("#MAXAir_img").click(function () {
				    alert('MAXAir_img btn clicked');
			    });
			    return true;
		    },
		    '14': function () {
			    MAXLiTE1_status = true;
			    $('#MAXLiTE1_img').attr('src','images/APP_Button_M_L-1-ON.png');
			    $('#MAXLiTE1_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row1_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');
			    $('#MAXLiTE1_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });
			    $("#MAXLiTE1_img").click(function () {
				    alert('MAXLiTE1_img btn clicked');
			    });
			    return true;
		    },
		    '16': function () {
			    MAXLiTE2_status = true;
			    $('#MAXLiTE2_img').attr('src','images/APP_Button_M_L-2-ON.png');
			    $('#MAXLiTE2_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row2_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');	  
			    $('#MAXLiTE2_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });
			    $("#MAXLiTE2_img").click(function () {
				    alert('MAXLiTE2_img btn clicked');
			    });
			    return true;                                      
		    },
		    '18': function () {
			    MAXLiTE3_status = true;
			    $('#MAXLiTE3_img').attr('src','images/APP_Button_M_L-3-ON.png');
			    $('#MAXLiTE3_buttonbar_img').attr('src','images/APP_Button_Bar-Landscape-ON.png');
			    $('#Vertical_Row3_img').attr('src','images/APP_Button_Bar-Vertical-ON.png');
			    $('#MAXLiTE3_img').hover(function() {
				    $(this).css('cursor','pointer');
			    });
			    $("#MAXLiTE3_img").click(function () {
				    alert('MAXLiTE3_img btn clicked');
			    });
			    return true;
		    }
		    };

		    if (typeof stuff[condition] !== 'function') {
		    return 'default';
		    }
		  
		    return stuff[condition]();
	    }

    </script>
</body>
</html>
