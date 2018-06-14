using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RexliteWebAppEnt1._0
{
    public partial class Default : System.Web.UI.Page
    {
        public delegate void AsyncCallback(IAsyncResult ar);
        public delegate void AddTolstDiscoveredDevices(object o);
        RexliteLib rexliteLib = new RexliteLib();
        public StringBuilder sb;
        public string IPAddr = string.Empty;
        public string currentGatewayIPAddr = string.Empty;
        public string DHCPReceiveString = string.Empty;
        public string BleJsonFileName = string.Empty;
        public bool BleJsonFileExists = false;
        private UdpState GlobalUDP;

        // Create new stopwatch.
        public Stopwatch stopwatch = new Stopwatch();
        public int[] transmitbuff = new int[64];
        public int[] dd = new int[64];
        public byte[] tns = new byte[16];
        public byte[] callBackArr = new byte[1000];
        public string[] cc;
        public string sbCallBackID = string.Empty, mainMAXBookID = string.Empty;
        public StringBuilder sbCallBack = new StringBuilder();

        public int arrlen = 0, totalDeviceCnt = 0;
        int i = 0, j = 0;
        string[] gatewayInfo;
        struct UdpState
        {
            public System.Net.IPEndPoint EP;
            public UdpClient UDPClient;
        }

        protected void Page_InitComplete(object sender, EventArgs e)
        {
            //DHCPReceiveString = (string)(Session["DHCPReceiveString"]);
            DHCPReceiveString = "test";
            string tmp2 = hidIPCallBack.Value;
            string tmp3 = IPAddr;
            //!string.IsNullOrEmpty(Session["emp_num"] as string) //(Session["DHCPReceiveString"] == null) ||
            //if ( (!string.IsNullOrEmpty(Session["DHCPReceiveString"] as string)))

            if (string.IsNullOrEmpty(DHCPReceiveString)) //this is correct for back button check from another page
            {
                // Begin timing.
                stopwatch.Start();

                GlobalUDP.UDPClient = new UdpClient();
                GlobalUDP.EP = new System.Net.IPEndPoint(System.Net.IPAddress.Parse("255.255.255.255"), 1205);
                System.Net.IPEndPoint BindEP = new System.Net.IPEndPoint(System.Net.IPAddress.Any, 1205 - 1);

                // Try to send the discovery request message
                byte[] DiscoverMsg = Encoding.ASCII.GetBytes("MAXBook_discovery ");

                // Set the local UDP port to listen on
                GlobalUDP.UDPClient.Client.Bind(BindEP);

                // Enable the transmission of broadcast packets without having them be received by ourself
                GlobalUDP.UDPClient.EnableBroadcast = true;
                GlobalUDP.UDPClient.MulticastLoopback = false;

                // Configure ourself to receive discovery responses
                GlobalUDP.UDPClient.BeginReceive(ReceiveCallback, GlobalUDP);

                // Transmit the discovery request message
                GlobalUDP.UDPClient.Send(DiscoverMsg, DiscoverMsg.Length, new System.Net.IPEndPoint(System.Net.IPAddress.Parse("255.255.255.255"), 1205));

                Thread.Sleep(2000);
                //Ending the UDP Global client call
            }
        }

        protected void Page_PreLoad(object sender, EventArgs e)
        {
            string tmp1 = (string)(Session["DHCPReceiveString"]);
            string tmp2 = hidIPCallBack.Value;
            string tmp3 = IPAddr;
            string tmp4 = (string)(Session["CurrentDHCPGatewayIP"]);
            string tmp5 = (string)(Session["CurrentDHCPGatewayDeviceName"]);
            string tmp6 = DHCPReceiveString;
            string tmp7 = (string)(Session["MainBleDeviceJsonList"]);

            // This will locate the Example.xml file in the App_Data folder.. (App_Data is a good place to put data files.)
            string BleJsonListFilePath = Server.MapPath("~/App_Data/");
            BleJsonFileName = BleJsonListFilePath + ExtensionMethods.BleDeviceJsonList;
            if (File.Exists(BleJsonFileName))
            {
                Response.Write(BleJsonFileName + " 檔案存在");
                BleJsonFileExists = true;
            }
            else
            {
                Response.Write(BleJsonFileName + " 檔案不存在");
            }

            //also do this section if BleJsonFileExists == false
            if ((Session["DHCPReceiveString"] != null) && (string.IsNullOrEmpty(Session["MainBleDeviceJsonList"] as string)))
            {
                string initStr = ExtensionMethods.MaxBookStr;

                //this is the correct very first command for 
                //tcpip client call in byte format
                byte[] MaxBookStrToBytes = initStr.HexToByte();

                //this will convert byte array to int array
                int[] converted = Array.ConvertAll(MaxBookStrToBytes, Convert.ToInt32);

                string tmp8 = IPAddr;
                string tmp9 = (string)(Session["DHCPReceiveString"]);
                string tmp10 = hidIPCallBack.Value;
              
                //if ((Session["DHCPReceiveString"] != null) || (hidIPCallBack.Value != String.Empty)
                //    || (!String.IsNullOrEmpty(IPAddr)))
                //{
                //    string t = (string)(Session["DHCPReceiveString"]);
                //    gatewayInfo = Regex.Split(t, "\n");
                //    rexliteLib.currentIPAddress = gatewayInfo[0];
                //    Session["CurrentDHCPGatewayIP"] = gatewayInfo[0];
                //    Session["CurrentDHCPGatewayDeviceName"] = gatewayInfo[1];
                //    currentGatewayIPAddr = gatewayInfo[0];
                //    currentGatewayDeviceName = gatewayInfo[1];
                //}

                byte[] getMainMaxBookID = new byte[1000];
                currentGatewayIPAddr = (string)(Session["CurrentDHCPGatewayIP"]);
                if (!string.IsNullOrEmpty(currentGatewayIPAddr))
                {
                    getMainMaxBookID = MakeTCPIPClientCall(converted, MaxBookStrToBytes, currentGatewayIPAddr, 1);
                }

                //Session["MainMaxBookID"] = getMainMaxBookID;
                //getMainMaxBookID is dec values, cc is hex values
                //this is to get the string value of the main MAXBook ID for sending 
                //commands to read and get back all available device IDs & SNs
                if (getMainMaxBookID.Length > 7)
                {  //Use the first Maxbook will get back all devices including Maxbooks
                    Array.Resize(ref getMainMaxBookID, 7); //so this is ok, np
                    Array.Resize(ref cc, 7);
                }

                //this will format the Maxbook client call command
                sbCallBack = rexliteLib.formatClientCallCommand(cc, "6");
                string result = sbCallBack.ToString();

                //this is the correct command for broast and readl all ble
                //devices as the tcpip client call in byte format
                byte[] MaxBookBroadcastCallStrToBytes = result.HexToByte();

                //this will convert byte array to int array
                int[] converted2 = Array.ConvertAll(MaxBookBroadcastCallStrToBytes, Convert.ToInt32);
                Array.Resize(ref converted2, converted2.Length + 2);

                Session["CurrentAction"] = "GetAllBleDeviceIDSN";

                //make the tcpip client call and get back all the ble ids and sns in byte array
                byte[] getMainBleList = new byte[1000];
                if (!string.IsNullOrEmpty(currentGatewayIPAddr))
                {
                    getMainBleList = MakeTCPIPClientCall(converted2, MaxBookBroadcastCallStrToBytes, currentGatewayIPAddr, 2);
                }

                List<string> subblelist = new List<string>();
                totalDeviceCnt = getMainBleList[0];  //get the quantity of the ble devices detected
                byte[][] twoDArray = new byte[totalDeviceCnt][];
                string[][] twoDStrArray = new string[totalDeviceCnt][];
                string str = string.Empty;
                List<string> jsonLists = new List<string>();

                for (i = 1; i < totalDeviceCnt + 1; i++)
                {
                    int firstIndx = (i * 11) - 10;
                    int lastIndx = (i * 11) - 4;
                    byte[] sub = new byte[7];
                    string[] ccsub = new string[7];
                    Array.Copy(getMainBleList, firstIndx, sub, 0, 7);
                    Array.Copy(cc, firstIndx, ccsub, 0, 7);
                    twoDArray[i - 1] = sub;
                    twoDStrArray[i - 1] = ccsub;
                    //rexliteLib.mainBleList[i - 1] = sub;
                    //cc[i] = Convert.ToString(bb[i], 16);  //from dec to hex
                    //string tt = Convert.ToString(sub[0], 16);
                    str = ExtensionMethods.BToHex(sub);
                    string jsonStr = rexliteLib.ConvertSingleHexStringToJson(str);
                    jsonLists.Add(jsonStr);
                }

                //This is the final json string for all ble devices detected and listed
                string strJson = rexliteLib.FormatFinalJsonFromListStrings(jsonLists);
                hidMainBleDeviceJsonList.Value = strJson;

                Session["2DByteDeviceArrList"] = twoDArray;
                Session["2DHexStringDeviceArrList"] = twoDStrArray;
                Session["MainBleDeviceJsonList"] = strJson;

                JObject newJsonFile = new JObject(strJson);
                // write JSON directly to a file
                using (StreamWriter file = File.CreateText(@BleJsonFileName))
                using (JsonTextWriter writer = new JsonTextWriter(file))
                {
                    newJsonFile.WriteTo(writer);
                }
                int u = 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string tmp5 = IPAddr;
                string tmp6 = (string)(Session["DHCPReceiveString"]);
                string tmp7 = hidIPCallBack.Value;
                string tmp8 = hidCallBackTimeElapsed.Value;
                string tmp9 = rexliteLib.currentIPAddress;
                //string tmp10 = gatewayInfo[0];

                //JavaScriptSerializer serializer = new JavaScriptSerializer();
            }
        }
        protected byte[] MakeTCPIPClientCall(int[] converted, byte[] origBytesArr, string currGatewayIPAddr, int status)
        {
            converted[13] = rexliteLib.modbus_crc(converted, 13) & 0xff; // reg_crc & 0xff;
            converted[14] = (rexliteLib.modbus_crc(converted, 13) >> 8) & 0xff; // reg_crc & 0xff;

            for (i = 0; i < 15; i++)
            {
                byte[] t = BitConverter.GetBytes(converted[i]);
                tns[i] = t[0];
            }

            TcpClient tcpclnt = new TcpClient();
            // Console.WriteLine("Connecting.....");

            tcpclnt.Connect(currGatewayIPAddr, ExtensionMethods.PortNumber);
            //tcpclnt.Connect("192.168.1.162", 4000);
            // use the ipaddress as in the server program

            Stream stm = tcpclnt.GetStream();

            stm.Write(tns, 0, tns.Length);

            byte[] bb = new byte[1000];
            int k = stm.Read(bb, 0, 1000);
            Array.Resize(ref cc, k);  //resize cc to k since k is the correct length of cc array
            char[] ch = new char[k];

            arrlen = k;
            byte[] ff = new byte[1000];
            int[] kk = new int[1000];

            for (i = 0; i < k; i++)
            {
                //Console.Write(Convert.ToChar(bb[i]));
                ch[i] = Convert.ToChar(bb[i]);
                cc[i] = Convert.ToString(bb[i], 16);  //from dec to hex

                //dd[i] = Convert.ToInt32(cc[i], 16);  //from hex to int
                //transmitbuff[i] = Convert.ToByte(bb[i], 16);
                //dd[i] = Convert.ToByte(cc[i], 16);
                //ff[i] = BitConverter.ToString(bb[i]);
                kk[i] = Convert.ToInt32(cc[i], 16);
            }
            Array.Resize(ref callBackArr, k);       //resize callBackArr to k elements
            Array.Resize(ref bb, k);
            Array.Copy(bb, 0, callBackArr, 0, k);   //copy bb array to callBackArr
            int[] converted2 = Array.ConvertAll(bb, Convert.ToInt32);
            //hidccArrayList.Value = cc;

            switch (status)
            {
                case 1:
                    Session["ccMainMAXBookIDFullArr"] = cc;
                    break;
                case 2:
                    Session["ccMainBleDeviceFullArrayList"] = cc;
                    break;
            }
            ////string to byte array
            //string theMessage = "This is a message!";
            //byte[] bytes = Encoding.ASCII.GetBytes(theMessage);
            //string converted = Encoding.UTF8.GetString(buffer, 0, buffer.Length);
            //converted = Encoding.UTF8.GetString(bb, 0, bb.Length);

            tcpclnt.Close();

            //this is for the led on command testing, for example, once turned on, if only one maxscene,
            // then bb[0] = 3, bb[1] = 255, these are dec values, must convert to hex in order to
            // get the correct brightness calculation
            int ft = Convert.ToInt32("3ff", 16);
            //ft = 1023, this is the highest brightness, 0-1023 => 1024 in total
            return bb;
        }

        public void ReceiveCallback(IAsyncResult ar)
        {
            UdpState MyUDP = (UdpState)ar.AsyncState;

            // Obtain the UDP message body and convert it to a string, with remote IP address attached as well
            string ReceiveString = Encoding.ASCII.GetString(MyUDP.UDPClient.EndReceive(ar, ref MyUDP.EP));
            ReceiveString = MyUDP.EP.Address.ToString() + "\n" + ReceiveString.Replace("\r\n", "\n");

            hidIPCallBack.Value = ReceiveString;
            IPAddr = ReceiveString;
            Session["DHCPReceiveString"] = ReceiveString;

            gatewayInfo = Regex.Split(ReceiveString, "\n");
            rexliteLib.currentIPAddress = gatewayInfo[0];
            Session["CurrentDHCPGatewayIP"] = gatewayInfo[0];
            Session["CurrentDHCPGatewayDeviceName"] = gatewayInfo[1];
            //hidMainJsonList.Value = initMainList;

            // Configure the UdpClient class to accept more messages, if they arrive
            MyUDP.UDPClient.BeginReceive(ReceiveCallback, MyUDP);

            // Stop timing.
            stopwatch.Stop();
            TimeSpan timeSpan = stopwatch.Elapsed; // getTimeElapsed.ToString(@"m\:ss\.ff");
            string getTimeElapsed = String.Format("Time: {0}h {1}m {2}s {3}ms", timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds, timeSpan.Milliseconds);

            Session["CurrentAction"] = "GetMaxBookID";

            hidCallBackTimeElapsed.Value = getTimeElapsed;
            Session["DHCPCallBackTimeElapsed"] = getTimeElapsed;

        }


    }
}