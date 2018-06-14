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
    public partial class MAXLite1 : System.Web.UI.Page
    {
        public StringBuilder sbCallBack = new StringBuilder();
        RexliteLib rexliteLib = new RexliteLib();
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            //get the Json filepath  
            string file = Server.MapPath("~/App_Data/blelist.json");
            //deserialize JSON from file  
            string Json = File.ReadAllText(file);
            hidMAXLite1BleJsonList.Value = Json;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}