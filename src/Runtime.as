package {


    import Events.LOADING_EVENT;
    import Extended.*;
    import starling.events.*;
    import starling.utils.AssetManager;
    import starling.core.Starling;

    public class Runtime extends DISPLAY {

//------UI Elements-----------------------------//
        private var Language_Button:E_BUTTON;
        private var Start_Button:E_BUTTON;
//------Functional Elements---------------------//
        private var _Asset_Loader:ASSET_LOADER;
        private var _Assets:AssetManager;
        private var _Config:XML;
        private var _Math_Config:XML;
        private var _Directory:String;
        private var _Locality:LOCALITY;

        public function Runtime(directory:String) {
            _Directory = directory + "/";

            _Asset_Loader = new ASSET_LOADER(Directory, Asset_Loader_Handler);
            Asset_Loader.Add_Directory(Directory);
            Asset_Loader.Start();
        }

        private function Asset_Loader_Handler(progress:Number):void {
            var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
            Loading_Event.Percentage = progress;
            dispatchEvent(Loading_Event);

            if(progress < 1) return;

            _Assets = Asset_Loader.Get_Assets();
            _Config = Assets.getXml("xml/Game");
            _Math_Config = Assets.getXml("xml/Math");
            _Locality = new LOCALITY(Assets.getXml("xml/Locality"));




            Locality_Handler();
        }
        private function Locality_Handler():void {
            Language_Button.Text = Locality.Get_Item("Language_Button");
        }
        private function Change_Language():void {
            Locality.Next_Language;
        }



















        //Getters
        public function get Asset_Loader():ASSET_LOADER {
            return _Asset_Loader;
        }
        public function get Assets():AssetManager {
            return _Assets;
        }
        public function get Config():XML {
            return _Config;
        }
        public function get Math_Config():XML {
            return _Math_Config;
        }
        public function get Directory():String {
            return _Directory;
        }
        public function get Locality():LOCALITY {
            return _Locality;
        }
    }
}
