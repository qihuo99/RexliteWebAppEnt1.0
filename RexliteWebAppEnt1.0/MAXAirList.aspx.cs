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
    public partial class MAXAirList : System.Web.UI.Page
    {
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        RexliteMAXAirLib rexliteAirLib = new RexliteMAXAirLib();
        public bool MAXAirFileExists = false;
        public bool CoolMasterIfconfigFileExists = false;
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Buffer = true;
                Response.CacheControl = "no-cache";
                Response.AddHeader("Pragma", "no-cache");
                Response.Expires = -1441;

                string getJson = string.Empty;

                try {

                    //if (ExtensionMethods.CheckJsonFile(ExtensionMethods.CoolMasterIfconfigFile))
                    //{
                    //    CoolMasterIfconfigFileExists = true;

                    //    //get the Json filepath  
                    //    string getfile = Server.MapPath("~/App_Data/");
                    //    getfile = getfile + ExtensionMethods.CoolMasterIfconfigFile;

                    //}
                    //else
                    //{
                    //    CoolMasterIfconfigFileExists = false;  //needs to create a json file and save here
                    //    string[] createCoolMasterIfconfigCmdList = rexliteAirLib.makeCoolMasterClientCall("192.168.1.129", ExtensionMethods.getCoolMasterDHCPCmd);
                    //    string initCoolMasterIfconfigJson = rexliteAirLib.ConvertCoolMasterIfconfigRetrievelToJson(createCoolMasterIfconfigCmdList);
                    //    CoolMasterIfconfigFileExists = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(initCoolMasterIfconfigJson, ExtensionMethods.CoolMasterIfconfigJsonHeader, ExtensionMethods.CoolMasterFile);

                    //    //get the Json filepath  
                    //    var getlocalJsonFile = "~/App_Data/blelist.json" + ExtensionMethods.CoolMasterFile;
                    //    string jsonfilename = Server.MapPath(getlocalJsonFile);

                    //    ////deserialize JSON from file  
                    //    //string Json = File.ReadAllText(file);
                    //}

                    if (ExtensionMethods.CheckJsonFile(ExtensionMethods.MAXAirDeviceJsonList))
                    {
                        MAXAirFileExists = true;

                        //get the Json filepath  
                        string getfile = Server.MapPath("~/App_Data/");
                        getfile = getfile + ExtensionMethods.MAXAirDeviceJsonList;
                        //deserialize JSON from file  
                        getJson = File.ReadAllText(getfile);
                        //hidMAXBookBleJsonList.Value = Json;
                        hidMAXAirDeviceJsonList.Value = getJson;
                    }
                    else
                    {
                        MAXAirFileExists = false;
                        string[] airDeviceList = rexliteAirLib.makeCoolMasterClientCall("192.168.1.129", ExtensionMethods.searchMaxAirDeviceCmd);
                        string output = rexliteAirLib.ConvertMAXAirSearchStringToJson(airDeviceList);
                        bool saveOutput = rexliteAirLib.FormatAndSaveAirDeviceJsonFile(output, ExtensionMethods.MAXAirDeviceJsonHeader, ExtensionMethods.MAXAirDeviceFile);

                        //get the Json filepath  
                        string getfile = Server.MapPath("~/App_Data/");
                        getfile = getfile + ExtensionMethods.MAXAirDeviceJsonList;
                        //deserialize JSON from file  
                        getJson = File.ReadAllText(getfile);
                        //hidMAXBookBleJsonList.Value = Json;
                        hidMAXAirDeviceJsonList.Value = getJson;
                    }

                }
                catch (Exception ex) {

                }

            }


        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}