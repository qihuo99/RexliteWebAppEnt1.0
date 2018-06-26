using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RexliteWebAppEnt1._0
{
    public class RexliteClassesCollections
    {
    }

    public class BleDevice
    {
        public string ID { get; set; }
        public string SN { get; set; }
        public string BLEName { get; set; }
        //public string EditImg { get; set; }
    }
    public class MAXSceneDisplay
    {
        public string MAXSceneName { get; set; }
        public string MAXSceneIDSN { get; set; }
        public string EditImg { get; set; }
        public string SearchImg { get; set; }
    }
    public enum CallCommandSend : int
    {
        ConnectToMAXBook = 13,                  //連線哪台設備
        ActivateSendBackFunction = 06,          //開通並讀取設備狀態資料
        BlinkingPanel = 06,                     //閃爍面板
        Search1_2_3_Panel_BlueTooth = 12,       //搜尋1.2.3級面板(藍芽用)
        Search1_2_Panel_BlueTooth = 12,         //搜尋1.2級面板(藍芽用)
        Search1_2_Panel_Ethernet = 12,          //搜尋1.2級面板(網路用)
        MAXScene = 06,                          //情境面板
        MAXLite = 06                            //切面板
    }

    public class RootObjectsMAXLite1Update
    {
        public List<MAXLite1Update> MAXLite1Update { get; set; }
    }

    public class MAXLite1Update
    {
        public string MAXLite1BleID { get; set; }
        public string MAXLite1DeviceSN { get; set; }
        public string MAXLite1DeviceIDSN { get; set; }
        public string NewMAXLite1DeviceName { get; set; }
    }


}