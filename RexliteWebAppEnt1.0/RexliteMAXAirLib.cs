using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
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

        public string[] searchMAXAirDevices(string DHCPIPAddr)
        {
            string[] lines = new string[10000];

            try
            {
                byte[] s = { 0x6C, 0x73, 0x0D, 0x0A };  //Sending CoolMaster byte message ls + Carriage Return + Line Feed
                byte[] s2 = { 108, 115, 10, 13 };

                TcpClient tcpclnt = new TcpClient();
                //Console.WriteLine("Connecting.....");

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
                byte[] bb = new byte[1000];
                int k = stm.Read(bb, 0, 1000);

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