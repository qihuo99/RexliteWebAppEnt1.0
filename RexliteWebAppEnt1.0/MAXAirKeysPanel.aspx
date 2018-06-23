<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXAirKeysPanel.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXAirKeysPanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MAXAir Keys Panel</title>
    <link href="css/jquery-ui-1.8.16.css" rel="stylesheet" type="text/css"  />
    <link href="css/rexMain.css" rel="stylesheet" type="text/css"  />
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
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

	   $( "#MAXAirSlider1" ).slider({
			range: "min",
			value: 0,
			min: 0,
			max: 100,
			step: 10,
			slide: function( event, ui )  {
				$( "#MaxLiteBar1Progress" ).val( ui.value + "%" );
				console.log( "#MaxLiteBar1Progress val=" + ui.value );
				//if (ui.value <= 1)
				//{
				//	$("#MaxLiteBar1OnButton").css('color', '#262626');
				//	$("#MaxLiteBar1OffButton").css('color', '#262626');
				//}
				//else
				//{
				//	$("#MaxLiteBar1OnButton").css('color', '#AD8C42');
				//	$("#MaxLiteBar1OffButton").css('color', '#AD8C42');
				//}
				//update();
			}
		});
       
		$( "#MaxLiteBar1Progress" ).val( $( "#MAXLiteSlider1" ).slider( "value" ) + "%");

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
					        <span style="font-size: 18px; ">Current Temperature</span>
					        <br /><br />
				        </div>

                        <div class="horizontal currTempDisplayDiv" style="border: 0px;" >
					        <div id="MAXAirCurrCTempDisplay" class="horizontal d1"  style="font-size: 62px;  float: right;border: 1px solid transparent;margin: 0, auto;">
						        &nbsp;28<span style="font-size: 24px;"><sup>&#8451;</sup></span>&nbsp;&nbsp;
					        </div>
					        <div class="vertical" style="border: 1px solid transparent;  margin: 0, auto; " >
						        <img id="Vertical_Row1_img" src="images/APP_Button_Bar-Vertical-ON.png"  width="3" height="35" /> 
					        </div>
					        <div id="MAXAirCurrFTempDisplay" class="horizontal d2"  style="font-size: 62px;; border: 1px solid transparent; margin: 0, auto;">
						        &nbsp;&nbsp;82<span style="font-size: 24px;"><sup>&#8457;</sup></span>&nbsp;&nbsp;
					        </div>
				        </div>


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
