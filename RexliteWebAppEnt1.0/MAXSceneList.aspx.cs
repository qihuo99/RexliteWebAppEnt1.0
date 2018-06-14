using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RexliteWebAppEnt1._0
{
    public partial class MAXSceneList : System.Web.UI.Page
    {
        public string[] strDevList = null;
        public string mainBleListJson = string.Empty;
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        public string[] cc = new string[100];
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            //get the Json filepath  
            string file = Server.MapPath("~/App_Data/blelist.json");
            //deserialize JSON from file  
            string Json = File.ReadAllText(file);
            hidMAXSceneBleJsonList.Value = Json;

            ////string mainBleListJson = (string)(Session["MainBleDeviceJsonList"]);
            //mainBleListJson = Json;
            //hidMAXSceneBleJsonList.Value = Json;
            ////string DHCPIPAddr = (string)(Session["DHCPReceiveString"]);

            ////this is the original format of cc string array for activating 
            //cc[0] = "b";
            //cc[1] = "ff";
            //cc[2] = "ff";
            //cc[3] = "ff";
            //cc[4] = "ff";
            //cc[5] = "ff";
            //cc[6] = "a1";

            ////this will remove all empty or null array elements
            //cc = cc.Where(x => !string.IsNullOrEmpty(x)).ToArray();

            ////this will format the Maxbook client call command, send request to activate the data send back function from MAXBook device
            //// 2 is the code for requesting the activation of sending back data from MAXBook device, the client call format result is correct
            //sbCallBack = rexliteLib.formatClientCallCommand(cc, "2");
            //string result = sbCallBack.ToString();

            //int tq = 0;

            //string mainBleListValue = (string)Session["MainBleDeviceJsonList"];
            //using (StreamReader r = new StreamReader("blelist.json"))
            //{
            //    string json = r.ReadToEnd();
            //    List<BleDevice> items = JsonConvert.DeserializeObject<List<BleDevice>>(json);
            //}
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}