using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace RexliteWebAppEnt1._0
{
    public static class ExtensionMethods
    {
        //This is the very first command to send to request the MaxBook ID info via tcpip client call
        public const string MaxBookStr = "0A13FFFFFFFFFFFF19820008FE7AF4";
        public const string BleDeviceJsonList = "BleDeviceList.json";
        public const string MAXAirDeviceJsonList = "MAXAirDeviceList.json";
        public const string CoolMasterIfconfigFile = "CoolMasterIfconfig.json";

        public const string BleDeviceListJsonHeader = "{\"BleDeviceList\":[";
        public const string MAXAirDeviceJsonHeader = "{\"MAXAirDevice\":[";
        public const string CoolMasterIfconfigJsonHeader = "{\"CoolMasterIfconfig\":[";

        public const string BleDeviceListFile = "BleDeviceJsonList";
        public const string MAXAirDeviceFile = "MAXAirDeviceJsonList";
        public const string CoolMasterFile = "CoolMasterIfconfig";

        public const int PortNumber = 4000;
        public const string searchMaxAirDeviceCmd = "ls";
        public const string getCoolMasterDHCPCmd = "ifconfig";
        public const int CoolMasterPortNumber = 10102;

        //16進位數字組成的字串轉換為Byte[]
        public static byte[] HexToByte(this string hexString)
        {
            //運算後的位元組長度:16進位數字字串長/2
            byte[] byteOUT = new byte[hexString.Length / 2];
            for (int i = 0; i < hexString.Length; i = i + 2)
            {
                //每2位16進位數字轉換為一個10進位整數
                byteOUT[i / 2] = Convert.ToByte(hexString.Substring(i, 2), 16);
            }
            return byteOUT;  //the result will be hex to dec in byte format
        }

        //Byte[]轉換為16進位數字字串
        public static string BToHex(this byte[] Bdata)
        {
            return BitConverter.ToString(Bdata).Replace("-", "");
        }

        //Byte[]轉換為10進位數字字串 int16, 2bytes per row
        public static int ConvertByteArrayToInt16(byte[] b)
        {
            return BitConverter.ToInt16(b, 0);
        }

        //Byte[]轉換為10進位數字字串 int32, 4bytes per row
        public static double ConvertByteArrayToInt32(byte[] b)
        {
            return BitConverter.ToInt32(b, 0);
        }

        public static byte[] ConvertInt32ToByteArray(Int32 I32)
        {
            return BitConverter.GetBytes(I32);
        }

        public static byte[] ConvertIntToByteArray(Int16 I16)
        {
            return BitConverter.GetBytes(I16);
        }

        public static byte[] ConvertIntToByteArray(Int64 I64)
        {
            return BitConverter.GetBytes(I64);
        }

        public static byte[] ConvertIntToByteArray(int I)
        {
            return BitConverter.GetBytes(I);
        }

        //取出字串右邊開始的指定數目字元
        public static string Right(this string str, int len)
        {
            return str.Substring(str.Length - len, len);
        }

        //取出字串右邊開始的指定數目字元(跳過幾個字元)
        public static string Right(this string str, int len, int skiplen)
        {
            return str.Substring(str.Length - len - skiplen, len);
        }


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

        public static bool CheckJsonFile(string jsonFile)
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

        public static string[] SplitWhitespace(string input)
        {
            char[] whitespace = new char[] { ' ', '\t' };
            return input.Split(whitespace);
        }

    }
}