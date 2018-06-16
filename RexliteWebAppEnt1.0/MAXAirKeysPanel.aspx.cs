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
        //public string[] airDeviceList = new string[100000];
        protected void Page_PreLoad(object sender, EventArgs e)
        {

            string[] airDeviceList = rexliteAirLib.searchMAXAirDevices("192.168.1.129");

            int u = 9;

        }
        protected void Page_Load(object sender, EventArgs e)
        {



        }
    }
}