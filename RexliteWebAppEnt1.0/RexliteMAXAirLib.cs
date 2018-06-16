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
        public const string searchMaxAirDeviceCmd = "ls";
        public const int CoolMasterPortNumber = 10102;

        public static double FahrenheitToCelsius(double tempIn)
        {
            Double fCels = (tempIn - 32) * (5 / 9);

            return fCels;
        }
        public static double CelsiusToFahenreit(double tempIn)
        {
            double dFahr = (1.8) * (tempIn + 32);

            return dFahr;
        }
        public static string[] SplitWhitespace(string input)
        {
            char[] whitespace = new char[] { ' ', '\t' };
            return input.Split(whitespace);
        }

        public bool CheckJsonFile(string jsonFile)
        {
            string BleJsonListFilePath = HttpContext.Current.Server.MapPath("~/App_Data/");
            string fullFileName = BleJsonListFilePath + jsonFile;
            if (File.Exists(fullFileName))
            {
                return true;
            }
            else
            {
                return false; 
            }
        }

        public bool FormatAndSaveAirDeviceJsonFile(string listJson)
        {
            bool fileSaved = false;
            string jsonFile = "{\"MAXAirDevice\":[" + listJson;
            jsonFile = jsonFile + "]}";
            //res = "{\"BleDevice\":[" + res;
            //res = "[" + res;
            //res = res + "]}";
            //res = res + "]";

            //This will locate the Example.xml file in the App_Data folder.. (App_Data is a good place to put data files.)
            string BleJsonListFilePath = HttpContext.Current.Server.MapPath("~/App_Data/");        

            string AirBleFileName = BleJsonListFilePath + ExtensionMethods.MAXAirDeviceJsonList;
            if (File.Exists(AirBleFileName))
            {
                //Response.Write(AirBleFile + " 檔案存在");
                File.Delete(@AirBleFileName);
                //File.WriteAllText(BleJsonListFilePath, ExtensionMethods.MAXAirDeviceJsonList);
                File.WriteAllText(AirBleFileName, jsonFile, Encoding.UTF8);
                //Write the file
                //using (System.IO.StreamWriter outfile = new System.IO.StreamWriter(@"C:\yourDirectory\yourFile.txt"))
                //{
                //    outfile.Write(yourFileAsString);
                //}
                fileSaved = true;
            }
            else
            {
                //Response.Write(BleJsonFileName + " 檔案不存在");
                File.WriteAllText(AirBleFileName, jsonFile, Encoding.UTF8);
                fileSaved = true;
            }

            return fileSaved;
        }

        //////////////////////////////////////////////////////////////////////////////////////
        //This function will convert a string array to Json array for MAXAir devices detected
        //////////////////////////////////////////////////////////////////////////////////////
        public string ConvertMAXAirStringToJson(string[] list)
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
                        string[] devListInfo = SplitWhitespace(list[i]);

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

        public string[] searchMAXAirDevices(string DHCPIPAddr)
        {
            string[] lines = new string[10000];

            try
            {
                byte[] s = { 0x6C, 0x73, 0x0D, 0x0A };  //Sending CoolMaster byte message ls + Carriage Return + Line Feed
                byte[] s2 = { 108, 115, 10, 13 };

                TcpClient tcpclnt = new TcpClient();  //Console.WriteLine("Connecting.....");
                tcpclnt.Connect(DHCPIPAddr, CoolMasterPortNumber);
                // use the ipaddress as in the server program

                //Console.WriteLine("Connected");
                //Console.Write("Enter the string to be transmitted : ");

                //String str = Console.ReadLine();
                //String str = "ifconfig\r\n";
                //String str = "stat\r\n";
                //String str = "ls\r\n";
                String str = searchMaxAirDeviceCmd + "\r\n";  // append Carriage return + Line Feed for CoolMaster only
                Stream stm = tcpclnt.GetStream();

                ASCIIEncoding asen = new ASCIIEncoding();
                byte[] ba = asen.GetBytes(str);

                //Console.WriteLine("Transmitting.....");
                stm.Write(ba, 0, ba.Length);

                var responseData = "";
                byte[] bb = new byte[10000];
                int k = stm.Read(bb, 0, 10000);
                Thread.Sleep(4000);

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