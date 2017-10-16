// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package
{
	import starling.events.Event;
	import Events.GAME_RECALL_EVENT;
	import Events.KEYPAD_EVENT;
	import Service.*;
	
	public class SERVICE_MENU extends SERVICE_BASE
	{
		private var Service_Meters:SERVICE_METERS;
		private var Service_Settings:SERVICE_SETTINGS;
		private var Logs_Menu:SERVICE_LOGS_MENU;
		private var Versions:SERVICE_VERSIONS;
		private var Peripheral_Test:PERIPHERAL_TEST;
		private var IO_Test:IO_TEST;
		private var Verify:VERIFY;
		private var Game_Setup:GAME_SETUP;
		private var Game_Information:GAME_INFORMATION;
		private var Calibration_Test:CALIBRATION_TEST;
		private var Progressive_Setup:PROGRESSIVE_SETUP;
		//private var Paycheck:PAYCHECK;
		//private var Recall:RECALL;
		private var Buttons:Array;
		private var Status_Area:TEXT;
		private var Update_Timer:TIMER;
		private var Progressives_Enabled:Boolean;
		private var Keypad:KEYPAD;
		private var New_Date:String;
		private var Game:GAME;

		public function SERVICE_MENU(game:GAME)
		{
			super(Back_Button_Handler);

			Game  	= game;
			Title 	= "Service Menu";
			Back_Button.text = "Exit";

			Buttons = new Array();
			
			for(var i=0; i<Config.Menu.Item.length(); i++)
			{
				var button = new SERVICE_BUTTON(Assets, Config.Menu.Item[i].@Button);
				button.x = Config.Menu.Item[i].@X;
				button.y = Config.Menu.Item[i].@Y;
				button.name = Config.Menu.Item[i].@Name;
				button.addEventListener(Event.TRIGGERED, Button_Handler);
				addChild(button);
				Buttons[button.name] = button;
			}

			Service_Meters		= new SERVICE_METERS();
			Service_Settings	= new SERVICE_SETTINGS();
			Logs_Menu			= new SERVICE_LOGS_MENU();
			Versions			= new SERVICE_VERSIONS();
			Peripheral_Test		= new PERIPHERAL_TEST();
			IO_Test				= new IO_TEST();
			Verify				= new VERIFY();
			Game_Setup			= new GAME_SETUP(game);
			Game_Information	= new GAME_INFORMATION(game);
			Calibration_Test	= new CALIBRATION_TEST();
			Progressive_Setup	= new PROGRESSIVE_SETUP();
			
			Status_Area = new TEXT("System_Font", CONFIG::SCREEN_WIDTH, 30, ALIGN.LEFT, ALIGN.TOP, false);
			Status_Area.scaleX = Status_Area.scaleY = 0.7;
			Status_Area.y = CONFIG::SCREEN_HEIGHT-Status_Area.height;

			Keypad = new KEYPAD();
			Keypad.addEventListener(KEYPAD_EVENT.EVENT_COMPLETE, Keypad_Handler);
			
			Add_Children([	Service_Meters, Service_Settings, Logs_Menu, Versions, Peripheral_Test, IO_Test, Verify,
							Game_Setup, Game_Information, Calibration_Test, Progressive_Setup, Status_Area, Keypad]);

			Update_Timer = new TIMER(1000, true);
			Update_Timer.addEventListener(TIMER.EVENT_COMPLETE, Update_Status);
			Update_Timer.Start();

			Core.addEventListener(CORE.EVENT_ENTER_SERVICE, Display);
			Core.addEventListener(CORE.EVENT_EXIT_SERVICE, Remove);

			// Disable buttons if necessary.

			if(Config.@Enable_Touch_Screen_Buttons == "FALSE")
			{
				Buttons["Calibrate_TS"].Disable();
				Buttons["Calibration_Test"].Disable();
			}

			// For now.
			Buttons["Calibration_Test"].Disable();
			
			Progressives_Enabled = True(Config.@Progressives_Enabled);
		}
		
		private function Keypad_Handler(e:KEYPAD_EVENT):void
		{
			if(e.Name == "DATE")
			{
				New_Date = e.Result;
				Keypad.Display(KEYPAD.TYPE_INTEGER, "Enter Time - HHMMSS", "", "TIME");
			}
			else if(e.Name == "TIME")
			{
				Core.Set_System_Time(	uint(New_Date.substr(4, 4)),
										uint(New_Date.substr(0, 2)),
										uint(New_Date.substr(2, 2)),
										uint(e.Result.substr(0, 2)),
										uint(e.Result.substr(2, 2)),
										uint(e.Result.substr(4, 2)));
			}
		}

		public function Back_Button_Handler():void
		{
			Core.Service = false;
		}
	
		public function Button_Handler(e:Event):void
		{
			var button:SERVICE_BUTTON = e.currentTarget as SERVICE_BUTTON;
			
			switch(button.name)
			{
				case "Meters":
					Service_Meters.Display();
					break;

				case "Settings":
					Service_Settings.Display();
					break;
				
				case "Volume":
					var current_volume:Number = SOUND.Master_Volume;
					current_volume += 20;
					if(current_volume > 100)
					{
						current_volume = 40;
					}
					SOUND.Master_Volume = current_volume;
					Buttons["Volume"].text = "Volume\n" + SOUND.Master_Volume + "%";
					Core.Change_Setting("VOLUME", String(current_volume));
					break;
					
				case "Test_Voucher":
					Core.Print_Test_Voucher();
					break;
				
				case "Logs_Menu":
					Logs_Menu.Display();
					break;
				
				case "Versions":
					Versions.Display();
					break;
				
				case "Peripheral_Test":
					Peripheral_Test.Display();
					break;
				
				case "IO_Test":
					IO_Test.Display();
					break;
				
				case "Lockout":
					Core.Lockout_Request();
					break;
				
				case "Game_Recall":
					//Recall.Display();
					break;
				
				case "Verify_EGM":
					Verify.Display();
					break;
				
				case "Game_Setup":
					Game_Setup.Display();
					break;

				case "Game_Information":
					Game_Information.Display();
					break;

				case "Calibrate_TS":
					Core.Application_Request("C:/CGM/Utilities/Calibrate.bat");
					break;

				case "Calibration_Test":
					Calibration_Test.Display();
					break;
				
				case "Progressive_Setup":
					Progressive_Setup.Display();
					break;
				
				case "Paycheck":
					//Paycheck.Display();
					break;
				
				case "Date_Time_Setup":
					Keypad.Display(KEYPAD.TYPE_INTEGER, "Enter Date - MMDDYYYY", "", "DATE");
				default:
					break;
			}
		}

		public function Update_Status():void
		{
			var date:Date = new Date();
			Status_Area.Set("Asset #: " + Core.Asset_Number + ", " + date + ", " + Core_Config.@Jurisdiction);
			Back_Button.enabled = (Core.Game_Denomination && Core.SAS_Address);

			Buttons["Game_Information"].enabled		= Core.Game_Denomination || Core.Progressive_Information.Group;
			Buttons["Game_Setup"].enabled			= Core.Allow_Changes;
			Buttons["Progressive_Setup"].enabled	= Core.Allow_Changes && Progressives_Enabled;

			if(Core.Demo)
			{
				Buttons["Peripheral_Test"].Disable();
				Buttons["Game_Recall"].Disable();
				Buttons["Verify_EGM"].Disable();
				Buttons["Game_Information"].Disable();
			}
		}
		
		public function Display():void
		{
			Buttons["Game_Recall"].enabled = (Core.Games_Played > 0) && !Core.Tilted;
			Buttons["Volume"].text = "Volume\n" + SOUND.Master_Volume + "%";

		/*	if(Paycheck == null)
			{
				Paycheck = new PAYCHECK(Game);
				addChild(Paycheck);
			}

			if(Recall == null)
			{
				Recall = new RECALL(Game);
				addChild(Recall);
			}*/

			Show();
			Update_Status();
		}
		
		public function Remove():void
		{
			MENU.Pointer.visible = false;
			Hide();
		}
	}
}


