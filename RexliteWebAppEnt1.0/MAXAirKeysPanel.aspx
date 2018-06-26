<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXAirKeysPanel.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXAirKeysPanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXAir Keys Panel</title>
    <link href="css/jquery-ui-1.8.16.css" rel="stylesheet" type="text/css"  />
    <link href="css/rexMain.css" rel="stylesheet" type="text/css"  />
    <script type="text/javascript" src="Scripts/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery-1.8.ui.min.js"></script>
    <script type="text/javascript" src="Scripts/RexliteFunctions.js"></script>
    <style>
        html {
            height: 100%;
        }
		body {
			background-color: #131313;
			margin:0;
			padding: 0;
			height:100%;
		}
        div.horizontal {
            display: flex;
            justify-content: center;
        }
        div.vertical {
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .subTitleDiv {
            display: block;
            margin: 0 auto;
            color: #AD8C41;
            font-size: 32px;
            font-weight: bold;
        }
        .MAXAirKeyMainContentDiv {
			background-color: #323232;
			color: #AD8C42;
			display: block; 
			margin: 0 auto; 
			width: 300px;
			font-size: 42px;
			font-weight: bold;
			padding: 0px 40px 0px 40px;  */ /*padding-top, padding-right, padding-bottom, padding-left */
		}
        .break {
            display: block;
            margin: 0 0 0.3em;
        }
    </style>
    <style>
        .ui-widget-content { border: 0px solid #ccc; background: #262626  }
        .ui-widget-header { border: 0px solid #aaaaaa; background: #AD8C42  }

        .ui-slider { position: relative; text-align: left; }
        .ui-slider .ui-slider-handle { height: 5px; width: 5px; position: absolute; z-index: 2; width: 1.2em; height: 1.2em; cursor: default; }
        .ui-slider .ui-slider-range { position: absolute; z-index: 1; font-size: .7em; display: block; border: 0; background-position: 10 10; }

        .ui-slider-horizontal { height: .2em; width: 325px; border: 0px;   }
        .ui-slider-horizontal .ui-slider-handle { top: -.8em; margin-left: -.7em; width: 30px; height: 30px; border: 0; background: url('images/APP_Button_O-S-Front-S30px.png');} 
        .ui-slider-horizontal .ui-slider-range { top: 0; height: 100%; border: 0px; }
        .ui-slider-horizontal .ui-slider-range-min { left: 0;  }
        .ui-slider-horizontal .ui-slider-range-max { right: 70;}
	</style>
    	<script>
	$(document).ready(function(){
        var airId = "";
		var powerStatus = "";
		var presetTempDegree = "";
		var presetTempScale = "";
		var indoorTempDegree = "";
		var indoorTempScale = "";
		var fanSpeed = "";
		var selection = "";
		var currCTemp  = "";
        var currFTemp = "";

        initMAXAirDeviceJson();

        function initMAXAirDeviceJson(){ 
            var dictionary = $("#hidMAXAirStatusInfoByID").val();
            var obj = JSON.parse(dictionary);

            for (var i = 0; i < obj.length; ++i) 
			{	
				airId = obj[i].ID;
				powerStatus = obj[i].PowerStatus;
				presetTempDegree = obj[i].PresetTempDegree;
				presetTempScale = obj[i].PresetTempScale;
				indoorTempDegree = obj[i].IndoorTempDegree;
				indoorTempScale = obj[i].IndoorTempScale;
				fanSpeed = obj[i].FanSpeed;
				selection = obj[i].Selection;
				
				console.log("airId = " + airId);
				console.log("powerStatus =" + powerStatus);
				console.log("presetTempDegree =" + presetTempDegree);
				console.log("presetTempScale =" + presetTempScale);
				console.log("indoorTempDegree =" + indoorTempDegree);
				console.log("indoorTempScale =" + indoorTempScale);
				console.log("fanSpeed =" + fanSpeed);
				console.log("selection =" + selection);
            }

        }

        function setupMAXAirStatusInfoDisplay() {
			CurrentTempDisplay();
		    PresetTempDisplay();
			
			if (powerStatus == "ON")
			{
				
				var st = getSelection(selection);
			}
			else
			{
				turnOffAllButtons(); 
			}
			
		}

        function getSelection(condition) {
		    var stuff = {
		    'Cool': function () {
				$("#MAXAirCooler_Img").attr('src',"images/APP_Button_Cool-ON.png");
				$("#MAXAirHeater_Img").attr('src',"images/APP_Button_Hot-OFF.png");
				$("#MAXAirFan_Img").attr('src',"images/APP_Button_Fan-OFF.png");
				$("#MAXAirDehumidifier_Img").attr('src',"images/APP_Button_Dehumidify-OFF.png");
			    return true;
		    },
		    'Fan': function () {
				$("#MAXAirCooler_Img").attr('src',"images/APP_Button_Cool-OFF.png");
				$("#MAXAirHeater_Img").attr('src',"images/APP_Button_Hot-OFF.png");
				$("#MAXAirFan_Img").attr('src',"images/APP_Button_Fan-ON.png");
				$("#MAXAirDehumidifier_Img").attr('src',"images/APP_Button_Dehumidify-OFF.png");
			    return true;
		    },
		    'Heat': function () {
				$("#MAXAirCooler_Img").attr('src',"images/APP_Button_Cool-OFF.png");
				$("#MAXAirHeater_Img").attr('src',"images/APP_Button_Hot-ON.png");
				$("#MAXAirFan_Img").attr('src',"images/APP_Button_Fan-OFF.png");
				$("#MAXAirDehumidifier_Img").attr('src',"images/APP_Button_Dehumidify-OFF.png");
			    //$('#MAXAir_img').hover(function() {
				//    $(this).css('cursor','pointer');
			    //});
			    //$("#MAXAir_img").click(function () {
				//    alert('MAXAir_img btn clicked');
			    //});
			    return true;
		    },
		    'Dry': function () {    
				$("#MAXAirCooler_Img").attr('src',"images/APP_Button_Cool-OFF.png");
				$("#MAXAirHeater_Img").attr('src',"images/APP_Button_Hot-OFF.png");
				$("#MAXAirFan_Img").attr('src',"images/APP_Button_Fan-OFF.png");
				$("#MAXAirDehumidifier_Img").attr('src',"images/APP_Button_Dehumidify-ON.png");
			    return true;
		    },
		    };

		    if (typeof stuff[condition] !== 'function') {
		    return 'default';
		    }
		  
		    return stuff[condition]();
        }

        function CurrentTempDisplay() 
		{
			if (indoorTempScale == "C")
			{
				$("#MAXAirCurrCTemp").text(indoorTempDegree);
				var getFtemp = ConvertCelciusToFahrenheit(indoorTempDegree); 
			    $("#MAXAirCurrFTemp").text(getFtemp);
			}
			else if (indoorTempScale == "F")
			{
				$("#MAXAirCurrFTemp").text(indoorTempDegree);
				var getCtemp = ConvertFahrenheitToCelcius(indoorTempDegree); 
			    $("#MAXAirCurrCTemp").text(getCtemp);
			}
		}

        function PresetTempDisplay() 
		{
			if (presetTempScale == "C")
			{
				$("#MAXAirPresetTemp").text(presetTempDegree);
			}
			else if (indoorTempScale == "F")
			{
				$("#MAXAirPresetTemp").text(presetTempDegree);
			}
		}
        		
		function ConvertFahrenheitToCelcius(tempVal) {
		    console.log("convert F2C Temp init =" + tempVal);
			tempVal = parseFloat(tempVal);
			tempVal = (tempVal-32) / 1.8;
			console.log("convert F2C  afterConvert before rounding =" + tempVal);
			tempVal = Math.round(tempVal);
			console.log("convert F2C  afterConvert after rounding =" + tempVal);
			return tempVal;
		}
		
		function ConvertCelciusToFahrenheit(tempVal) {
		    console.log("convert C2F init =" + tempVal);
			tempVal = parseFloat(tempVal);
			tempVal = (tempVal*1.8)+32;
			console.log("convert C2F afterConvert before rounding =" + tempVal);
			tempVal = Math.round(tempVal);
			console.log("convert C2F afterConvert after rounding =" + tempVal);
			return tempVal;
		}

        function turnOffAllButtons() 
		{
			$("#MAXAirCooler_Img").attr('src',"images/APP_Button_Cool-OFF.png");
			$("#MAXAirHeater_Img").attr('src',"images/APP_Button_Hot-OFF.png");
			$("#MAXAirFan_Img").attr('src',"images/APP_Button_Fan-OFF.png");
			$("#MAXAirDehumidifier_Img").attr('src',"images/APP_Button_Dehumidify-OFF.png");
			
			$("#MAXAirTemperatureSetting_Img").attr('src',"images/APP_Button_TP-OFF.png");
			$("#MAXAirTimeSetting_Img").attr('src',"images/APP_Button_Time-OFF.png");
			$("#MAXAirFlowVolumeSetting_Img").attr('src',"images/APP_Button_Air_volume-OFF.png");
			$("#MAXAirFreshAirSetting_Img").attr('src',"images/APP_Button_Fresh-OFF.png");
			$("#MAXAirSleepSetting_Img").attr('src',"images/APP_Button_Sleep-OFF.png");
		}

	   $( "#MAXAirSlider1" ).slider({
			range: "min",
			value: 0,
			min: 0,
			max: 100,
			step: 10,
			slide: function( event, ui )  {
				$( "#MAXAirBar1Progress" ).val( ui.value + "%" );
				console.log( "#MAXAirBar1Progress val=" + ui.value );
				//update();
			}
		});
       
		$( "#MAXAirBar1Progress" ).val( $( "#MAXAirSlider1" ).slider( "value" ) + "%");

	});
	</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="MAXAirKeyPanelTop" class="ListPageTopDiv">
			    <div id="MAXAirKeyPaneBackBtn" style="float:left;">
				    <a href="Default.aspx">
					    <img border="0" alt="Back" src="images/APP_Button_Back.png" width="50px" height="40px" />
				    </a>
			    </div>
			    <div id="MAXAirKeyPanelMenuBtn" style="float:right;">
				    <a href="Default.aspx">
					    <img border="0" alt="Menu" src="images/APP_Button_Menu.png" width="50px" height="40px" />
				    </a>
			    </div>
		    </div>
            <div class="horizontal div1" style="border: 1px solid transparent;" >
		        <div class="vertical"  style="border: 1px solid transparent; margin: 0, auto;">
                    <div class="subTitleDiv" style="" >
				        <img id="MAXAirEdit_img" src="images/APP_Button_Rename.png" width="25" height="25"  /> 
				        &nbsp; &nbsp;客廳空調 &nbsp;&nbsp; 
				        <br /><br />
			        </div>
			        <span class="break"></span>
                    <div class="MAXAirKeyMainContentDiv" style="display: block; margin: 0 auto; " ><!--begin first MAXAirKeyMainContentDiv  -->
     				    <span class="break"></span>
				        <div class="subTitleDiv" style="margin: 0, auto;" >
					        <span style="font-size: 18px; ">Current Temperature<span/>
					        <br /><br />
				        </div>

                       <div class="horizontal currTempDisplayDiv" style="border: 0px;" >
					        <div id="MAXAirCurrCTempDisplayDiv" class="horizontal d1"  style="font-size: 62px;  float: right;border: 1px solid transparent;margin: 0, auto;">
						        <span id="MAXAirCurrCTemp">&nbsp;12</span><span style="font-size: 24px;"><sup>&#8451;</sup></span>&nbsp;&nbsp;
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="Vertical_Row1_img" src="images/APP_Button_Bar-Vertical-ON.png"  width="3" height="35" /> 
					        </div>
					        <div id="MAXAirCurrFTempDisplay" class="horizontal d2"  style="font-size: 62px;; border: 1px solid transparent; margin: 0, auto;">
						        <span id="MAXAirCurrFTemp">&nbsp;63</span><span style="font-size: 24px;"><sup>&#8457;</sup></span>&nbsp;&nbsp;
					        </div>
				        </div>
				        <span class="break"></span>
				        <div class="horizontal currAirSelectionDiv" style="border: 0px;" >
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto;  " >
						        <img id="MAXAirCooler_Img" src="images/APP_Button_Cool-ON.png"  width="35" height="35"  /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto;" >
						        <img id="MAXAirHeater_Img" src="images/APP_Button_Hot-OFF.png"  width="35" height="35" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="MAXAirFan_Img" src="images/APP_Button_Fan-OFF.png"  width="35" height="35" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="MAXAirDehumidifier_Img" src="images/APP_Button_Dehumidify-OFF.png"  width="35" height="35" /> 
					        </div>
				        </div>	
				        <span class="break"></span>
			        </div><!--ending first MAXAirKeyMainContentDiv  -->
                    <span class="break"></span>

                    <div class="MAXAirKeyMainContentDiv" style="display: block; margin: 0 auto; border: 0px; " ><!--begin second MAXAirKeyMainContentDiv  -->
				        <br />
				        <div class="horizontal currTempDisplayDiv" style="border: 1px solid transparent; padding: 1px;" >
					        <div class="horizontal d1"  style="float: right; border: 1px solid transparent; margin: 0, auto;">
						        <span style="font-size: 18px;text-align: left;">Set Temp</span>&nbsp;&nbsp;&nbsp;
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="Vertical_Row0_img" src="images/APP_Button_Bar-Vertical-ON.png" style="width: 1px; height: 5px; visibility: hidden;" /> 
					        </div>
					        <div class="horizontal d2"  style="border: 1px solid transparent; margin: 0, auto;">
						        <span style="font-size: 18px;">Remaining Time</span>
					        </div>
				        </div>
				        <div class="horizontal currTempDisplayDiv" style="border: 1px solid transparent;" >
					        <div class="horizontal d1"  style="font-size: 62px;  float: right;border: 1px solid transparent;margin: 0, auto;">
						        &nbsp;&nbsp;<span id="MAXAirPresetTemp">86</span><span style="font-size: 24px;"><sup>&#8451;</sup></span>&nbsp;&nbsp;
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="Vertical_Row11_img" src="images/APP_Button_Bar-Vertical-ON.png"  width="3" height="35" /> 
					        </div>
					        <div class="horizontal d2"  style="font-size: 62px;; border: 1px solid transparent; margin: 0, auto;">
						        &nbsp;&nbsp;8<span style="font-size: 24px;">hr</span>&nbsp;&nbsp;&nbsp;
					        </div>
				        </div>
				        <div class="horizontal currAirSelectionDiv" style="border: 1px solid transparent;padding: 0px 30px 0px 30px;" >
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; width:35px; padding: 10px;" >
						        <img id="MAXAirTemperatureSetting_Img" src="images/APP_Button_TP-ING.png"  width="35" height="35" style="padding: 0px;" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; width:35px; padding: 10px;" >
						        <img id="MAXAirTimeSetting_Img" src="images/APP_Button_Time-ON.png"  width="35" height="35" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto;width:35px; padding: 10px;" >
						        <img id="MAXAirFlowVolumeSetting_Img" src="images/APP_Button_Air_volume-ON.png"  width="35" height="35" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; width:35px; padding: 10px;" >
						        <img id="MAXAirFreshAirSetting_Img" src="images/APP_Button_Fresh-ON.png"  width="35" height="35" /> 
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto;width:35px; padding: 10px;" >
						        <img id="MAXAirSleepSetting_Img" src="images/APP_Button_Sleep-ON.png"  width="35" height="35" /> 
					        </div>
				        </div>	
			        </div><!--ending second MAXAirKeyMainContentDiv  -->

                    <div class="horizontal sliderDiv" style="border: 0px;" >
				        <div class="vertical" style="width: 340px; border: 0px;  margin: 0, auto; background-color: #323232;" >
					        <div id="MAXAirSlider1">
					        </div>
					        <span class="break"></span>
				        </div>
			        </div>	
			        <br /><br />
			        <div class="subTitleDiv" style="padding: 0px 0px 0px 260px; margin: 0, auto;" >
				        <label for="MAXAirBar1Progress">CH1 (10 increments):</label>
				        <input type="text" id="MAXAirBar1Progress" readonly style="border:0; background-color: #131313; color:#AD8C42; font-size: 24px; font-weight:bold;" />
				        <br />
			        </div>
            	</div>
                <asp:HiddenField ID="hidMAXAirStatusInfoByID" runat="server" />
		    </div>
	        <br /><br />
	        <div id="MAXAirKeyPanelBottomDiv" class="bottomDiv">
		        <a href="MAXLiTE1.html">
			        <img src="images/APP_Button_REXLiTE.png" width="280" height="12" />
		        </a>
	        </div>

        </div>
    </form>
</body>
</html>
