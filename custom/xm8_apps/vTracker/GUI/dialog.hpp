 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

class vTrackerGUI
{
    idd = 99715;
    access = 3;
    duration = -1;
    onLoad = "uiNamespace setVariable ['vTrackerGUI', _this select 0]; [_this]call vTracker_MapCenter";
    onUnload = "uiNamespace setVariable ['vTrackerGUI', displayNull];";
    
    class Controls
	{
		class vTrackerXM8Off: vTrackerPicture
		{
			idc = 99716;
			text = "\exile_assets\texture\ui\xm8_off_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class vTrackerXM8On: vTrackerPicture
		{
			idc = 99717;
			text = "\exile_assets\texture\ui\xm8_on_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class vTrackerMap: vTrackerMapControl
		{
			idc = 99718;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.335 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.286 * safezoneH;
		};
		class vTrackerList: vTrackerListbox
		{
			idc = 99719;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.297 * safezoneH;
		};
		class vTrackerOn: vTrackerButton
		{
			idc = 99720;
			text = "ON"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = "[]call vTracker_ONButton";
		};
		class vTrackerOff: vTrackerButton
		{
			idc = 99721;
			text = "OFF"; //--- ToDo: Localize;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = "[]call vTracker_OFFButton";
		};
		class vTrackerRefresh: vTrackerButton
		{
			idc = 99722;
			text = "REFRESH"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "[]call vTracker_ONButton";
		};
		class vTrackerBack: vTrackerButton
		{
			idc = 99723;
			text = "GO BACK"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick =  "closeDialog 0;";
		};
		class vTrackerTitle: vTrackerText
		{
			idc = 99724;
			text = "VEHICLE TRACKER"; //--- ToDo: Localize;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
		};
	};
};