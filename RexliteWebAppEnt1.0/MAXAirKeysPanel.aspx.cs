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
    public partial class MAXAirKeysPanel : System.Web.UI.Page
    {
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        RexliteMAXAirLib rexliteAirLib = new RexliteMAXAirLib();

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            var formatCoolMasterDeviceCmd = ExtensionMethods.getCoolMasterStatusCmd + " 101";

            //string[] getMAXAirStatusByID = rexliteAirLib.makeCoolMasterClientCall("192.168.1.129", formatCoolMasterDeviceCmd);
            //string getJson = rexliteAirLib.ConvertMAXAirStatusByIDStringToJson(getMAXAirStatusByID);

            //get the Json filepath  
            string file = Server.MapPath("~/App_Data/MAXAirID_101.json");
            //deserialize JSON from file  
            string Json = File.ReadAllText(file);
            hidMAXAirStatusInfoByID.Value = Json;

            //    string[] createCoolMasterIfconfigCmdList = rexliteAirLib.makeCoolMasterClientCall("192.168.1.129", ExtensionMethods.getCoolMasterDHCPCmd);
            //    string initCoolMasterIfconfigJson = rexliteAirLib.ConvertCoolMasterIfconfigRetrievelToJson(createCoolMasterIfconfigCmdList);
            //    CoolMasterIfconfigFileExists = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(initCoolMasterIfconfigJson, ExtensionMethods.CoolMasterIfconfigJsonHeader, ExtensionMethods.CoolMasterFile);

            //    //get the Json filepath  
            //    var getlocalJsonFile = "~/App_Data/blelist.json" + ExtensionMethods.CoolMasterFile;
            //    string jsonfilename = Server.MapPath(getlocalJsonFile);

        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}