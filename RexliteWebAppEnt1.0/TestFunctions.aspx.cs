using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RexliteWebAppEnt1._0
{
    public partial class TestFunctions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TestJsonUpdate();
            bool getSt = FindCertainValuesInJsonFile2(ExtensionMethods.MAXLite2UpdateFile, "MAXLite2DeviceIDSN", "16000000000006");
        }


        public void AppendToMaxliteJsonFile()
        {
            string fileToSearch = ExtensionMethods.MAXLite2UpdateFile;
            //get the Json filepath  
            string getPath = Server.MapPath("~/App_Data/");
            string getfile = getPath + fileToSearch;

            //deserialize JSON from file  
            string Json = File.ReadAllText(getfile);
            JObject jObject = JObject.Parse(Json);



        }


        public bool FindCertainValuesInJsonFile2(string fileToSearch, string jsonAttrToSearch, string valueToSearch)
        {
            bool valFound = false;

            //get the Json filepath  
            //string file = Server.MapPath("~/App_Data/MAXLite2Update.json");

            //get the Json filepath  
            string getPath = Server.MapPath("~/App_Data/");
            string getfile = getPath + fileToSearch;
            //getfile = getfile + ExtensionMethods.MAXAirDeviceJsonList;

            //deserialize JSON from file  
            string Json = File.ReadAllText(getfile);
            JObject jObject = JObject.Parse(Json);

            var formatSearchAttribute = ".." + jsonAttrToSearch;
            //var classNameTokens = jObject.SelectTokens("..MAXLite2DeviceIDSN");

            var attrNameTokens = jObject.SelectTokens(formatSearchAttribute);
            var values = attrNameTokens.Select(x => (x as JValue).Value);
            //string getInnerValue = values;

            foreach (string val in values)
            {
                if (val.Equals(valueToSearch))
                {
                    valFound = true;
                }
            }

            return valFound;
        }

        public void TestJsonUpdate()
        {
            RootObjectsMAXLite1Update rootObjectsMAXLite1Update = new RootObjectsMAXLite1Update();
            RexliteLib rexliteLib = new RexliteLib();
            //get the Json filepath  
            string file = Server.MapPath("~/App_Data/MAXLite1Update.json");
            //deserialize JSON from file  
            string json = File.ReadAllText(file);

            // Deserialize from file to object:
            //JsonConvert.PopulateObject(json, rootObjectsMAXLite1Update);

            string DeviceToUpdate = "MAXLite1Update";
            //var RootObjects = JsonConvert.DeserializeObject<List<rootObjectsMAXLite1Update>>(json);
            JToken root = JObject.Parse(json);
            //JToken item = root["MAXLite1Update"];
            JToken item = root[DeviceToUpdate];

            var listDev = "List<" + DeviceToUpdate  + ">";
            //Deserialize the Json to list
            //var deserializedItem = JsonConvert.DeserializeObject<List<MAXLite1Update>>(item.ToString());
            var deserializedItem = JsonConvert.DeserializeObject<List<MAXLite1Update>>(item.ToString());

            //Loop through values 
            foreach (MAXLite1Update p in deserializedItem)
            {
                //Your code to process the values
                if (p.MAXLite1DeviceIDSN == "14000000000001") {
                    p.NewMAXLite1DeviceName = "Maxlite1 New Update1 14000000000001";
                }
            }

            string output = Newtonsoft.Json.JsonConvert.SerializeObject(deserializedItem, Newtonsoft.Json.Formatting.Indented);
            bool fileSt = rexliteLib.FormatAndSaveJsonFile(output, ExtensionMethods.MAXLite1UpdateJsonHeader, ExtensionMethods.MAXLite1UpdateCmd, "update");
            //File.WriteAllText(file, output);
            int u = 0;
            //dynamic jsonObj = Newtonsoft.Json.JsonConvert.DeserializeObject(json);
            //jsonObj["Bots"][0]["Password"] = "new password";
            //string output = Newtonsoft.Json.JsonConvert.SerializeObject(jsonObj, Newtonsoft.Json.Formatting.Indented);
            //File.WriteAllText("settings.json", output);
        }


    }
}