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
    public partial class MAXLite2 : System.Web.UI.Page
    {
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            //get the Json filepath  
            string file = Server.MapPath("~/App_Data/blelist.json");
            //deserialize JSON from file  
            string Json = File.ReadAllText(file);
            hidMAXLite2BleJsonList.Value = Json;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static string SaveMAXLite2UpdateJsonFile(string maxlite1json)
        {
            RexliteLib rexliteMAXLite1Lib = new RexliteLib();
            var json = string.Empty;
            try
            {
                //bool fileSt = rexliteMAXLite1Lib.FormatAndSaveJsonFile(maxlite1json, ExtensionMethods.MAXLite1UpdateJsonHeader, ExtensionMethods.MAXLite1UpdateCmd, "create");

                return maxlite1json + " -- MAXLite2Update File is saved!!!  ";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        [System.Web.Services.WebMethod]
        public static bool SaveMAXLite2UpdateJsonFile2(string maxlite2json)
        {
            var json = maxlite2json;

            MAXLite2 maxLite2 = new MAXLite2();
            var tmp = maxLite2.getHiddenValues();

            //var getMaxlite3json = hidRenameDeviceJson.Value;
            //hidRenameDeviceJson.Value;
            //bool getSt = RexliteLib.
            //bool getSt = rexliteLib.FormatAndSaveJsonFile(maxlite3json, ExtensionMethods.MAXLite3UpdateJsonHeader, ExtensionMethods.MAXLite3UpdateFile);


            //return "Hello " + name + Environment.NewLine + "The Current Time is: "
            //    + DateTime.Now.ToString();
            return true;
        }

        public string getHiddenValues()
        {
            string str = string.Empty;
            var devieIDSN = hidSelectedDeviceIDSN.Value;



            str = str + devieIDSN;
            return str;
        }




    }
}