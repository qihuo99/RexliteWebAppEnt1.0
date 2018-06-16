using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RexliteWebAppEnt1._0
{
    public partial class MAXAirKeysPanel : System.Web.UI.Page
    {
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        RexliteMAXAirLib rexliteAirLib = new RexliteMAXAirLib();
        public bool MAXAirFileExists = false;

        protected void Page_PreLoad(object sender, EventArgs e)
        {

            if (rexliteAirLib.CheckJsonFile(ExtensionMethods.MAXAirDeviceJsonList))
            {
                MAXAirFileExists = true;
            }
            else
            {
                MAXAirFileExists = false;
                string[] airDeviceList = rexliteAirLib.searchMAXAirDevices("192.168.1.129");
                string output = rexliteAirLib.ConvertMAXAirStringToJson(airDeviceList);
                bool saveOutput = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(output);


            }

            //int u = 9;

        }
        protected void Page_Load(object sender, EventArgs e)
        {



        }
    }
}