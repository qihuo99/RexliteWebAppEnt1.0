using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Web;

namespace RexliteWebAppEnt1._0
{
    public class RexliteMAXAirLib
    {

        public string ConvertCoolMasterIfconfigRetrievelToJson(string[] list)
        {
            string result = "";
            StringBuilder sbCallback = new StringBuilder();
            int i = 0;
            string mac = string.Empty;
            string link = string.Empty;
            string ip = string.Empty;
            string netmask = string.Empty;
            string gateway = string.Empty;
            string dns1 = string.Empty;
            string dns2 = string.Empty;
            string autoip = string.Empty;

            try
            {
                for (i = 0; i < list.Length; i++)
                {
                    if (list[i].ToUpper() == "OK")
                    {
                        break;
                    }
                    else
                    {
                        string[] devListInfo = ExtensionMethods.SplitWhitespace(list[i]);

                        //use linq to remove empty array elements
                        devListInfo = devListInfo.Where(x => !string.IsNullOrEmpty(x)).ToArray();

                        //var splitted0 = devListInfo[0].Split(' ');  //splite string on :
                        //string[] splitted0 = ExtensionMethods.SplitWhitespace(devListInfo[0]);

                        if (devListInfo[0].ToString().Trim() == "MAC")
                        {
                            mac = devListInfo[2].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "Link")
                        {
                            link = devListInfo[2].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "IP")
                        {
                            ip = devListInfo[2].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "Netmask:")
                        {
                            netmask = devListInfo[1].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "Gateway:")
                        {
                            gateway = devListInfo[1].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "DNS1")
                        {
                            dns1 = devListInfo[2].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "DNS2")
                        {
                            dns2 = devListInfo[2].ToString().Trim();
                        }
                        else if (devListInfo[0].ToString().Trim() == "Autoip")
                        {
                            autoip = devListInfo[2].ToString().Trim();
                        }

                    }
                }

                var CoolMasterIfconfig = new
                {
                    MAC = mac,
                    Link = link,
                    IP = ip,
                    Netmask = netmask,
                    Gateway = gateway,
                    DNS1 = dns1,
                    DNS2 = dns2,
                    Autoip = autoip
                };

                var json = JsonConvert.SerializeObject(CoolMasterIfconfig);
                result = json;
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }

        public bool FormatAndSaveAirDeviceJsonFile(string listJson, string fileheader, string fileNameToBeSaved)
        {
            bool fileSaved = false;
            //string jsonFile = "{\"MAXAirDevice\":[" + listJson;
            string jsonFile = fileheader + listJson;
            jsonFile = jsonFile + "]}";

            //This will locate the Example.xml file in the App_Data folder.. (App_Data is a good place to put data files.)
            string BleJsonListFilePath = HttpContext.Current.Server.MapPath("~/App_Data/");
            string getSaveFileName = string.Empty;

            switch (fileNameToBeSaved)
            {
                case "BleDeviceJsonList":
                    getSaveFileName = ExtensionMethods.BleDeviceJsonList;                 //連線哪台設備
                    break;
                case "MAXAirDeviceJsonList":
                    getSaveFileName = ExtensionMethods.MAXAirDeviceJsonList;                //開通並讀取設備狀態資料
                    break;
                case "CoolMasterIfconfig":
                    getSaveFileName = ExtensionMethods.CoolMasterIfconfigFile;                 //閃爍面板
                    break;
            }

            string FileToBeSaved = BleJsonListFilePath + getSaveFileName;
            if (File.Exists(FileToBeSaved))
            {
                File.Delete(@FileToBeSaved);  //Response.Write(AirBleFile + " 檔案存在");
                //File.WriteAllText(BleJsonListFilePath, ExtensionMethods.MAXAirDeviceJsonList);
                File.WriteAllText(FileToBeSaved, jsonFile, Encoding.UTF8);
                //Write the file
                //using (System.IO.StreamWriter outfile = new System.IO.StreamWriter(@"C:\yourDirectory\yourFile.txt"))
                //{
                //    outfile.Write(yourFileAsString);
                //}             
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
        //This function will convert a string array to Json array for MAXAir devices detected
        //////////////////////////////////////////////////////////////////////////////////////
        public string ConvertMAXAirSearchStringToJson(string[] list)
        {
            string result = "";
            StringBuilder sbAir = new StringBuilder();
            int i = 0;

            try
            {
                for (i = 0; i < list.Length; i++)
                {
                    if (list[i].ToUpper() == "OK")
                    {
                        break;
                    }
                    else
                    {
                        string[] devListInfo = ExtensionMethods.SplitWhitespace(list[i]);

                        //use linq to remove empty array elements
                        devListInfo = devListInfo.Where(x => !string.IsNullOrEmpty(x)).ToArray();

                        var splitted = devListInfo[0].Split('.');  //splite string on dot
                        string channel = splitted[0];
                        string id = splitted[1];
                        string powerSt = devListInfo[1];
                        string presetTemperature = devListInfo[2];
                        string indoorTemperature = devListInfo[3];
                        string fanSpeed = devListInfo[4];
                        string selection = devListInfo[5];

                        var AirDevice = new
                        {
                            Channel = channel,
                            ID = id,
                            PowerStatus = powerSt,
                            PresetTemperature = presetTemperature,
                            IndoorTemperature = indoorTemperature,
                            FanSpeed = fanSpeed,
                            Selection = selection
                        };

                        var json = JsonConvert.SerializeObject(AirDevice);
                        sbAir.Append(json + ",");
                    }
                }

                string res = sbAir.ToString().TrimEnd(',');
                result = res;
            }
            catch (Exception ex)
            {
                result = "Error..... " + ex.StackTrace;
            }
            return result;
        }

        public string[] makeCoolMasterClientCall(string DHCPIPAddr, string Cmd)
        {
            string[] lines = new string[10000];

            try
            {
                byte[] s = { 0x6C, 0x73, 0x0D, 0x0A };  //Sending CoolMaster byte message ls + Carriage Return + Line Feed
                byte[] s2 = { 108, 115, 10, 13 };

                TcpClient tcpclnt = new TcpClient();  //Console.WriteLine("Connecting.....");
                tcpclnt.Connect(DHCPIPAddr, ExtensionMethods.CoolMasterPortNumber);
                // use the ipaddress as in the server program

                //Console.WriteLine("Connected");
                //Console.Write("Enter the string to be transmitted : ");

                //String str = Console.ReadLine();
                //String str = "ifconfig\r\n";
                //String str = "stat\r\n";
                //String str = "ls\r\n";
                String str = Cmd + "\r\n";  // append Carriage return + Line Feed for CoolMaster only
                Stream stm = tcpclnt.GetStream();

                ASCIIEncoding asen = new ASCIIEncoding();
                byte[] ba = asen.GetBytes(str);

                //Console.WriteLine("Transmitting.....");
                stm.Write(ba, 0, ba.Length);

                var responseData = "";
                byte[] bb = new byte[10000];
                int k = stm.Read(bb, 0, 10000);
                Thread.Sleep(2000);

                for (int i = 0; i < k; i++)
                {
                    if (bb[i] != 62)  //exclude the special character < 
                    {
                        //Console.Write(Convert.ToChar(bb[i]));
                        responseData = responseData + Convert.ToChar(bb[i]);
                    }
                }

                tcpclnt.Close();

                //Console.Write(responseData);
                responseData = responseData.Trim();  //trim the response data

                lines = responseData.Split(
                    new[] { Environment.NewLine },
                    StringSplitOptions.None
                );
                //use linq to remove empty array elements
                lines = lines.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            }
            catch (Exception e)
            {
                Console.WriteLine("Error..... " + e.StackTrace);
            }

            return lines;
        }




    }
}