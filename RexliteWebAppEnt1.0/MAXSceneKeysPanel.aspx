<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MAXSceneKeysPanel.aspx.cs" Inherits="RexliteWebAppEnt1._0.MAXSceneKeysPanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rexlite MaxScene Keys Panel</title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.min.js"></script>
    <link href="css/rexMain.css" rel="stylesheet" type="text/css"  />
    <style>
	html {
		height:100%;
		margin:0; 
		padding:0; 
	}
	body {
		height:100%;
		margin:0; 
		padding:0; 
		background-color: black;
		font-family: Arial, Helvetica, sans-serif;
	}
	/* this will center the div in the center of the web page */
	.MAXScenePanelMainContent
	{
        position: absolute;
        font-size: 28px;
        font-weight: bold;
        color: #AD8C42;
        margin: auto;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        width: 425px;
        height: 650px;
        background-color: #0C0C0C;
        border: 1px solid transparent;
	}
	.MAXScenePanelKeyMainListContent
	{
        width: 350px;
        height: 520px;
        margin: 0 auto;
        display: table;
        background-color: #323232;
        color: #656565;
        padding: 15px;
        border: 1px solid transparent;
	}
	.MAXSceneSubKeysListContent
	{
        width: 180px;
        height: 100%;
        background-color: #323232;
        border: 1px solid transparent;
        padding: 0px 0px 0px 20px; /*  padding-top,  padding-right,  padding-bottom,  padding-left  */
        float: left;
	}
	.MAXSceneSubArrowButtonContent
	{
        width: 100px;
        height: 450px;
        background-color: 323232;
        border: 1px solid transparent;
        padding: 0px 0px 0px 0px; /*  padding-top,  padding-right,  padding-bottom,  padding-left  */
        float: right;
	}

	</style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="MAXSceneMainContentDiv" class="MAXScenePanelMainContent">
		    MAXScene 
	       <br />&nbsp;
	       <br />
	       <div id="MAXSceneMainKeyListContentDiv" class="MAXScenePanelKeyMainListContent">
			    <div id="MAXSceneSubKeysListContentDiv" class="MAXSceneSubKeysListContent">
				    <br />
				    <div id="MAXSceneKey1Div">
				     Scene 1
				    </div><br />
				    <div id="MAXSceneKey2Div">
				     Scene 2
				    </div><br />
				    <div id="MAXSceneKey3Div">
				     Scene 3
				    </div><br />	
				    <div id="MAXSceneKey4Div">
				     Scene 4
				    </div><br />
				    <div id="MAXSceneKey5Div">
				     Scene 5
				    </div><br />
				    <div id="MAXSceneKey6Div">
				     Scene 6
				    </div>
                    <div> 
                   </div>
			    </div>
			    <div id="MAXSceneKeyListContentDiv" class="MAXSceneSubArrowButtonContent">
			        <br /><br /><br /><br /><br /><br />
				    <div id="ImgUpDiv" runat="server">
					    <img id="MAXSceneArrowUp" src="images/APP_Button_UP-ON.png"  width="50" height="40" style="margin: 0, auto;" /> 
				    </div>
				    <br /><br /><br />
				    <div id="ImgDownDiv" runat="server">
					    <img id="MAXSceneArrowDown" src="images/APP_Button_UP-OFF.png"  width="50" height="40" style="margin: 0, auto;" /> 
				    </div>		 
			    </div> 
	       </div>
	    </div> 
    </form>
    <script type="text/javascript">
    $(document).ready(function () {
        var upArrowClickCount = 0;
		var downArrowClickCount = 0;
		var currentDimmingStatus = 3;      //set to default
		var currMAXSceneKeyID = 16;        //set to default
		
		var currSt = setDimmingCondigion(currentDimmingStatus);
		var currMaxKey = MAXSceneKeyStausCheck(currMAXSceneKeyID);

        initSetupMaxSceneKeyDiv();


		$("#MAXSceneKey1Div").click(function () {
			//console.log("MAXSceneKey1Div clicked! ");
            setupMaxSceneKeyDiv(1);			
            currMAXSceneDeviceID = '16';
		});
		
		$("#MAXSceneKey2Div").click(function () {
			//console.log("MAXSceneKey2Div clicked! ");
			setupMaxSceneKeyDiv(2);	
			currMAXSceneDeviceID = '18';
		});
		
		$("#MAXSceneKey3Div").click(function () {
			//console.log("MAXSceneKey3Div clicked! ");  
			setupMaxSceneKeyDiv(3);	
			currMAXSceneDeviceID = '1a';
		});
		
		$("#MAXSceneKey4Div").click(function () {
			//console.log("MAXSceneKey4Div clicked! ");	 
			setupMaxSceneKeyDiv(4);			
			currMAXSceneDeviceID = '1c';
		});
		
		$("#MAXSceneKey5Div").click(function () {
			//console.log("MAXSceneKey5Div clicked! ");
			setupMaxSceneKeyDiv(5);					
			currMAXSceneDeviceID = '1c';
		});
		
		$("#MAXSceneKey6Div").click(function () {
			//console.log("MAXSceneKey6Div clicked! ");
			setupMaxSceneKeyDiv(6);					
			currMAXSceneDeviceID = '1c';
		});
		
		$('#MAXSceneArrowUp').click(function(){
		   console.log("ArrowUp button is clicked!" );
		   var st = catchArrowClickCondition("up");
		   console.log("currentDimmingStatus up =" + currentDimmingStatus);
		   var st2 = setDimmingCondigion(currentDimmingStatus);
		});
		
		$('#MAXSceneArrowDown').click(function(){
		   console.log("ArrowDown button is clicked!" );
		   var st = catchArrowClickCondition("down");
		   console.log("currentDimmingStatus down =" + currentDimmingStatus);
		   var st3 = setDimmingCondigion(currentDimmingStatus);
		});

        function initSetupMaxSceneKeyDiv(){
			for (i = 1; i < 7; i++)
			{
				var getDiv = "#MAXSceneKey" + i + "Div";
                $(getDiv).css('cursor','pointer');	

			}
		}

		function setupMaxSceneKeyDiv(divNum){
			for (i = 1; i < 7; i++)
			{
				var getDiv = "#MAXSceneKey" + i + "Div";
				//console.log("MAXSceneKeyStausCheck = " + getDiv);
				if (i == divNum) 
					$(getDiv).css('color', '#AD8C42');	
				else
					$(getDiv).css('color', '#656565');
			}
		}
		
		function MAXSceneKeyStausCheck(condition) {
		    var stuff = {
				'16': function () {  //MAXScene Key #1	
					$("#MAXSceneKey1Div").css('color', '#AD8C42');	  
					currMAXSceneDeviceID = '16';
					return true;
				},
				'18': function () {    //MAXScene Key #2					
					$("#MAXSceneKey2Div").css('color', '#AD8C42');	  
					$("#MAXSceneKey2Div").click(function () {
						console.log("MAXSceneKey2Div clicked! ");
					});
					currMAXSceneDeviceID = '18';
					return true;
				},
				'1a': function () {		//MAXScene Key #3					
					$("#MAXSceneKey3Div").css('color', '#AD8C42');	  
					$("#MAXSceneKey3Div").click(function () {
						console.log("MAXSceneKey3Div clicked! ");
					});
					currMAXSceneDeviceID = '1a';
					return true;
				},
				'1c': function () {		//MAXScene Key #4				
					$("#MAXSceneKey4Div").css('color', '#AD8C42');	  
					$("#MAXSceneKey4Div").click(function () {
						console.log("MAXSceneKey4Div clicked! ");
					});
					currMAXSceneDeviceID = '1c';
					return true;
				},
				'1e': function () {		//MAXScene Key #5			
					$("#MAXSceneKey5Div").css('color', '#AD8C42');	  
					$("#MAXSceneKey5Div").click(function () {
						console.log("MAXSceneKey5Div clicked! ");
					});
					currMAXSceneDeviceID = '1e';
					return true;                                      
				},
				'20': function () {		//MAXScene Key #6
					$("#MAXSceneKey6Div").css('color', '#AD8C42');	  
					$("#MAXSceneKey6Div").click(function () {
						console.log("MAXSceneKey6Div clicked! ");
					});
					currMAXSceneDeviceID = '20';
					return true;
				}
		    };

		    if (typeof stuff[condition] !== 'function') {
				return 'default';
		    }
		  
		    return stuff[condition]();
	    }
		
		function catchArrowClickCondition(ArrowValue) {
		    console.log("ArrowValue =" + ArrowValue);
		    var stuff = {
				"up": function () {		//up arrow button is clicked
					if (currentDimmingStatus < 6)
					{
						currentDimmingStatus++;  
					}
					//console.log("currentDimmingStatus =" + currentDimmingStatus);
					return true;
				},
				"down": function () {		//down arrow button is clicked
					if (currentDimmingStatus > 0)
					{
						currentDimmingStatus--;					    
					}
					//console.log("currentDimmingStatus =" + currentDimmingStatus);
					return true;
				}
		    };

		    if (typeof stuff[ArrowValue] !== 'function') {
				return 'default';
		    }
		  
			return stuff[ArrowValue]();
	    }
		
		function setDimmingCondigion(DimmingValue) {
			console.log("inside dimmingVal =" + DimmingValue);
		    var stuff = {
				0: function () {  //MAXScene brightness -- up arrow is off, down arrow is brightest
					$("#MAXSceneArrowUp").fadeTo("fast", 0.09);
					$("#MAXSceneArrowDown").fadeTo("fast", 1);
					return true;
				},
				1: function () {    //MAXScene brightness -- level 2 brightness
					$("#MAXSceneArrowUp").fadeTo("fast", 0.17);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.84);
					return true;
				},
				2: function () {		//MAXScene brightness -- level 3 brightness
					$("#MAXSceneArrowUp").fadeTo("fast", 0.30);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.70);
					return true;
				},
				3: function () {		//MAXScene brightness -- level 4 brightness
					$("#MAXSceneArrowUp").fadeTo("fast", 0.50);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.50);
					return true;
				},
				4: function () {		//MAXScene brightness -- level 5 brightness
					$("#MAXSceneArrowUp").fadeTo("fast", 0.70);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.30);
					return true;                                      
				},
				5: function () {		//MAXScene brightness -- level 6 brightness
					$("#MAXSceneArrowUp").fadeTo("fast", 0.84);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.17);
					return true;
				},
				6: function () {		//MAXScene brightness -- up arrow is brightest, down arrow is off
					$("#MAXSceneArrowUp").fadeTo("fast", 1);
					$("#MAXSceneArrowDown").fadeTo("fast", 0.09);
					return true;
				}
		    };

		    if (typeof stuff[DimmingValue] !== 'function') {
				return 'default';
		    }
		  
			return stuff[DimmingValue]();
	    }


    });
    </script>
</body>
</html>
