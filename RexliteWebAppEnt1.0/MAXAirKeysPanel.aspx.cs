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
        public bool CoolMasterIfconfigFileExists = false;

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            //string getCoolMasterCallIPCmd = rexliteAirLib.ge 

            if (ExtensionMethods.CheckJsonFile(ExtensionMethods.CoolMasterIfconfigFile))
            {
                CoolMasterIfconfigFileExists = true;
            }
            else
            {  
                CoolMasterIfconfigFileExists = false;  //needs to create a json file and save here
                string[] createCoolMasterIfconfigCmdList = rexliteAirLib.makeCoolMasterClientCall("192.168.1.129", ExtensionMethods.getCoolMasterDHCPCmd);
                string initCoolMasterIfconfigJson = rexliteAirLib.ConvertCoolMasterIfconfigRetrievelToJson(createCoolMasterIfconfigCmdList);
                //bool getFileSavedStatus = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(initCoolMasterIfconfigJson, "{\"CoolMasterIfconfig\":[", "CoolMasterIfconfig");
                CoolMasterIfconfigFileExists = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(initCoolMasterIfconfigJson, ExtensionMethods.CoolMasterIfconfigJsonHeader, ExtensionMethods.CoolMasterFile);

            }

            //if (ExtensionMethods.CheckJsonFile(ExtensionMethods.MAXAirDeviceJsonList))
            //{
            //    MAXAirFileExists = true;
            //}
            //else
            //{
            //    MAXAirFileExists = false;
            //    //string[] airDeviceList = rexliteAirLib.searchMAXAirDevices("192.168.1.129");
            //    //string output = rexliteAirLib.ConvertMAXAirSearchStringToJson(airDeviceList);
            //    //bool saveOutput = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(output);
            //}

            //int u = 9;

        }
        protected void Page_Load(object sender, EventArgs e)
        {



        }
    }
}