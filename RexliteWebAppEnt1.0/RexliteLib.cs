using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Web;

namespace RexliteWebAppEnt1._0
{
    ////十進位轉二進位
    //Convert.ToString(int1, 2);

    ////二進位轉十進位
    //Convert.ToInt32(string1, 2);

    ////十進位轉十六進位
    //Convert.ToString(int1, 16);

    ////十六進位轉十進位
    //Convert.ToInt32(string1, 16)

    //10進位轉成16進位
    //System.Console.WriteLine(Convert.ToString(100, 16));

    //16進位轉成10進位
    //System.Console.WriteLine(Convert.ToInt32("64", 16));
    public class RexliteLib
    {
        public string currentIPAddress;
        public byte[][] mainBleList;
        public byte[] tns = new byte[1000];
        public string[] cc = new string[1000];
        public byte[] callBackArr = new byte[1000];
        public int i = 0, j = 0;
        public string[] initMainListStringArr()
        {
            List<String> list = new List<String>();
            list.Add("0a000000000001");  //this is the MaxBook ID + SN
            list.Add("0bffffffffffa1");  //this is the first MaxScene ID + SN
            //list.Add("16000002");
            string[] strTmpDevList = list.ToArray();

            return strTmpDevList;
        }
        public string initDefaultPageDeviceArr()
        {
            string[] list = initMainListStringArr();
            string retr = ConvertBleDeviceStringToJson(list);

            return retr;
        }
        protected string[] MakeTCPIPClientCall(int[] converted, byte[] origBytesArr, string currGatewayIPAddr, int status)
        {
            converted[13] = modbus_crc(converted, 13) & 0xff; // reg_crc & 0xff;
            converted[14] = (modbus_crc(converted, 13) >> 8) & 0xff; // reg_crc & 0xff;

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

            //arrlen = k;
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

            switch (status)
            {
                case 1:
                    //Session["ccMainMAXBookIDFullArr"] = cc;
                    break;
                case 2:
                    //Session["ccMainBleDeviceFullArrayList"] = cc;
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
            //return bb;
            return cc;
        }

        public string ConvertSingleHexStringToJson(string str)
        {
            string result = "";
            int i = 0;

            try
            {
                //for (i = 0; i < str.Length; i++)
                //{
                string id = str.Substring(0, 2);
                string sn = str.Substring(2, 12);
                string name = getDeviceType(id);

                var device = new
                {
                    ID = id,
                    SN = sn,
                    BLEName = name
                };
                result = JsonConvert.SerializeObject(device);
                //}
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }
        public string FormatFinalJsonFromListStrings(List<string> jsonlist)
        {
            string result = "";
            StringBuilder sb = new StringBuilder();

            try
            {
                foreach (var item in jsonlist)
                {
                    sb.Append(item + ",");
                }

                string res = sb.ToString().TrimEnd(',');
                //res = "{\"BleDevice\":[" + res;
                res = "[" + res;
                //res = res + "]}";
                res = res + "]";
                result = res;
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }

        public bool FormatAndSaveJsonFile(string listJson, string fileheader, string fileNameSavedCmd, string operationMethod)
        {
            bool fileSaved = false;
            string jsonFile = string.Empty;
            //string jsonFile = "{\"MAXAirDevice\":[" + listJson;

            if (operationMethod == "create") {
                jsonFile = fileheader + listJson;
                jsonFile = jsonFile + "]}";
            }
            else if (operationMethod == "update")
            {
                fileheader = fileheader.Remove(fileheader.Length - 1); 
                jsonFile = fileheader + listJson;
                jsonFile = jsonFile + "}";
            }

            //This will locate the Example.xml file in the App_Data folder.. (App_Data is a good place to put data files.)
            string BleJsonListFilePath = HttpContext.Current.Server.MapPath("~/App_Data/");
            string getSaveFileName = string.Empty;

            switch (fileNameSavedCmd)
            {
                case "MAXLite1Update":
                    getSaveFileName = ExtensionMethods.MAXLite1UpdateFile;
                    break;
                case "MAXLite2Update":
                    getSaveFileName = ExtensionMethods.MAXLite2UpdateFile;
                    break;
                case "MAXLite3Update":
                    getSaveFileName = ExtensionMethods.MAXLite3UpdateFile;
                    break;
            }

            string FileToBeSaved = BleJsonListFilePath + getSaveFileName;
            if (File.Exists(FileToBeSaved))
            {
                File.Delete(@FileToBeSaved);  //Response.Write(AirBleFile + " 檔案存在");
                File.WriteAllText(FileToBeSaved, jsonFile, Encoding.UTF8);          
                fileSaved = ExtensionMethods.CheckJsonFile(getSaveFileName);
            }
            else
            {
                //Response.Write(BleJsonFileName + " 檔案不存在");
                File.WriteAllText(FileToBeSaved, jsonFile, Encoding.UTF8);
                fileSaved = ExtensionMethods.CheckJsonFile(getSaveFileName);
            }
            return fileSaved;
        }

        //////////////////////////////////////////////////////////////////////////////////////
        //This function will convert a string array to Json array
        //////////////////////////////////////////////////////////////////////////////////////
        public string ConvertBleDeviceStringToJson(string[] devlist)
        {
            string result = "";
            StringBuilder sb = new StringBuilder();
            int i = 0;

            try
            {
                for (i = 0; i < devlist.Length; i++)
                {
                    string id = devlist[i].Substring(0, 2);
                    string sn = devlist[i].Substring(2, 12);
                    string name = getDeviceType(id);

                    var device = new
                    {
                        ID = id,
                        SN = sn,
                        BLEName = name
                    };

                    var json = JsonConvert.SerializeObject(device);
                    sb.Append(json + ",");
                }

                string res = sb.ToString().TrimEnd(',');
                //res = "{\"BleDevice\":[" + res;
                res = "[" + res;
                //res = res + "]}";
                res = res + "]";
                result = res;
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }

        public string getDeviceType(string device)
        {
            string dtype = "";

            switch (device)
            {
                case "0a":
                case "0A":
                    dtype = "MAXBook";              //接線盒
                    break;
                case "0b":
                case "0B":
                    dtype = "MAXScene";             //情境開關
                    break;
                case "13":
                    dtype = "MAXAir";               //空調開關
                    break;
                case "14":
                    dtype = "MAXLite M’L - 1";      //觸控調光開關單迴路 
                    break;
                case "16":
                    dtype = "MAXLite M’L - 2";      //觸控調光開關雙迴路
                    break;
                case "18":
                    dtype = "MAXLite M’L - 3";      //觸控調光開關三迴路
                    break;
            }
            return dtype;
        }

        public string getDeviceID(string deviceName)
        {
            string deviceID = "";

            switch (deviceName)
            {
                case "MAXBook":
                    deviceID = "0a";            //接線盒
                    break;
                case "MAXScene":
                    deviceID = "0b";            //情境開關
                    break;
                case "MAXAir":
                    deviceID = "13";            //空調開關
                    break;
                case "MAXLite M’L - 1":
                    deviceID = "14";            //觸控調光開關單迴路 
                    break;
                case "MAXLite M’L - 2":
                    deviceID = "16";            //觸控調光開關雙迴路
                    break;
                case "MAXLite M’L - 3":
                    deviceID = "18";            //觸控調光開關三迴路
                    break;
            }
            return deviceID;
        }

        //////////////////////////////////////////////////////////////////////////////////////
        //This function will create a DHCP IP Address json file from a single string
        //////////////////////////////////////////////////////////////////////////////////////
        public string CreateDHCPIPAddressJsonFile(string ipAddr)
        {
            string result = "";
            StringBuilder sb = new StringBuilder();

            try
            {
                var IPFile = new
                {
                    CurrentIP = ipAddr
                };

                var json = JsonConvert.SerializeObject(IPFile);
                sb.Append(json);

                string res = sb.ToString().Trim();
                res = "{\"CurrentIPAddress\":[" + res;
                //res = "[" + res;
                res = res + "]}";
                //res = res + "]";
                result = res;
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }

        ////////////////////////////////////////////////////////////////////////////////
        // This function will calculate and convert crc byte - 2 bytes and return it
        ////////////////////////////////////////////////////////////////////////////////
        public Int32 modbus_crc(int[] v, int g)
        {
            int j, i;

            Int32 reg_crc = 0xFFFF;
            for (i = 0; i < g; i++)
            {
                reg_crc ^= v[i];
                for (j = 0; j < 8; j++)
                {
                    if ((reg_crc & 0x01) == 0x01)
                        reg_crc = (reg_crc >> 1) ^ 0xA001;
                    else
                        reg_crc = reg_crc >> 1;
                }
            }
            return reg_crc;
        }

        ////////////////////////////////////////////////////////////////////////////////
        //This function will check the incoming character and return T/F bool value
        ////////////////////////////////////////////////////////////////////////////////
        public bool checkAlphabet(string str)
        {
            char c;
            //Console.Write("Enter a Character: ");
            c = Char.Parse(str);
            if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
            {
                //Console.WriteLine(c + " is an Alphabet.");
                return true;
            }
            else
            {
                //Console.WriteLine(c + " is not an Alphabet.");
                return false;
            }
        }

        public List<string> ConvertStringArrToList(string[] devList)
        {
            List<string> list = new List<string>(devList);

            return list;
        }

        public StringBuilder formatClientCallCommand(string[] cc, string cmdStr)
        {
            StringBuilder sbCallBack = new StringBuilder();
            int i = 0;

            //convert cc string into 2 bytes format string for input command
            for (i = 0; i < cc.Length; i++)
            {
                if (cc[i].Length == 1)
                {
                    if (i == 0)
                    {
                        sbCallBack.Append("0" + cc[i]);

                        //get the integer value from the enum variable -- Search1_2_Panel_Ethernet
                        string getMaxbookInitCallCmd = getClientCallCommand(cmdStr);
                        if (getMaxbookInitCallCmd.Length == 1)
                        {
                            sbCallBack.Append("0" + getMaxbookInitCallCmd);
                        }
                        else
                        {
                            sbCallBack.Append(getMaxbookInitCallCmd);
                        }
                        
                    }
                    else
                    {
                        sbCallBack.Append("0" + cc[i]);
                    }
                }
                else
                {
                    if (i == 0)
                    {
                        sbCallBack.Append(cc[i]);

                        //get the integer value from the enum variable -- Search1_2_Panel_Ethernet
                        //string getMaxbookInitCallCmd = CallCommandSend.Search1_2_Panel_Ethernet.ToString("d");
                        string getMaxbookInitCallCmd = getClientCallCommand(cmdStr);
                        if (getMaxbookInitCallCmd.Length == 1)
                        {
                            sbCallBack.Append("0" + getMaxbookInitCallCmd);
                        }
                        else
                        {
                            sbCallBack.Append(getMaxbookInitCallCmd);
                        }     
                    }
                    else
                    {
                        sbCallBack.Append(cc[i]);
                    }
                }
            }
            string getBleData = getBleDeviceData(cmdStr);
            sbCallBack.Append(getBleData);

            return sbCallBack;
        }

        public string getClientCallCommand(string cmdStr)
        {
            string result = string.Empty;

            switch (cmdStr)
            {
                case "1":
                    result = CallCommandSend.ConnectToMAXBook.ToString("d");                //連線哪台設備
                    break;
                case "2":
                    result = CallCommandSend.ActivateSendBackFunction.ToString("d");        //開通並讀取設備狀態資料
                    break;
                case "3":
                    result = CallCommandSend.BlinkingPanel.ToString("d");                   //閃爍面板
                    break;
                case "4":
                    result = CallCommandSend.Search1_2_3_Panel_BlueTooth.ToString("d");     //搜尋1.2.3級面板(藍芽用)
                    break;
                case "5":
                    result = CallCommandSend.Search1_2_Panel_BlueTooth.ToString("d");       //搜尋1.2級面板(藍芽用)
                    break;
                case "6":
                    result = CallCommandSend.Search1_2_Panel_Ethernet.ToString("d");        //搜尋1.2級面板(網路用)
                    break;
                case "7":
                    result = CallCommandSend.MAXScene.ToString("d");                        //情境面板
                    break;
                case "8":
                    result = CallCommandSend.MAXLite.ToString("d");                         //切面板
                    break;
            }
            return result;
        }

        public string getBleDeviceData(string request)
        {
            string dtype = string.Empty;

            switch (request)
            {
                case "1":
                    dtype = "19820008FE";       //連線哪台設備
                    break;
                case "2":
                    dtype = "1905C70010";       //開通並讀取設備狀態資料
                    break;
                case "3":
                    dtype = "1905600000";       //閃爍面板
                    break;
                case "4":
                    dtype = "1930000800";       //搜尋1.2.3級面板(藍芽用)
                    break;
                case "5":
                    dtype = "1930010800";       //搜尋1.2級面板(藍芽用)
                    break;
                case "6":
                    dtype = "1930020800";       //搜尋1.2級面板(網路用)
                    break;
            }
            return dtype;
        }

        public string getMAXSceneButtonData(string request)
        {
            string dtype = string.Empty;

            switch (request)
            {
                case "1":
                    dtype = "1905700000";       //情境面板第一鍵
                    break;
                case "2":
                    dtype = "1905720000";       //情境面板第二鍵
                    break;
                case "3":
                    dtype = "1905740000";       //情境面板第三鍵
                    break;
                case "4":
                    dtype = "1905760000";       //情境面板第四鍵
                    break;
                case "5":
                    dtype = "1905780000";       //情境面板第五鍵
                    break;
                case "6":
                    dtype = "19057A0000";       //情境面板第六鍵
                    break;
                case "0":
                    dtype = "1905860000";       //情境面板第POWER鍵
                    break;
            }
            return dtype;
        }

        public string getMAXLiteButtonData(string request)
        {
            string dtype = "";

            switch (request)
            {
                case "1":
                    dtype = "1905A20000";       //1.2.3切面板第一鍵
                    break;
                case "2":
                    dtype = "1905A30000";       //1.2.4切面板第二鍵
                    break;
                case "3":
                    dtype = "1905A40000";       //1.2.5切面板第三鍵
                    break;
                case "4":
                    dtype = "1905A50000";       //1.2.6切面板第四鍵
                    break;
                case "5":
                    dtype = "1905A60000";       //1.2.7切面板第五鍵
                    break;
                case "6":
                    dtype = "1905A70000";       //1.2.8切面板第六鍵
                    break;
            }
            return dtype;
        }

    }

   

}