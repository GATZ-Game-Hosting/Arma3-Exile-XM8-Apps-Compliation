 /*
 * XM8 App Base Marker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 5/21/2023
 * Version - 1
 * Version Date - 5/21/2023
 */

class baseMarkerGUI
{
	idd = 97500;
	access = 3;
	duration = -1;
	onLoad = "uiNamespace setVariable ['baseMarkerGUI', _this select 0]; [_this]execVM 'custom\xm8_apps\baseMarker\code\baseMarker_MapCenter.sqf'";
	onUnload = "uiNamespace setVariable ['baseMarkerGUI', displayNull];";
	
	class Controls
	{
		class baseMrkrXM8Frame: baseMrkrXM8RscPicture
		{
			idc = 96501;
			text = "\exile_assets\texture\ui\xm8_off_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class baseMrkrXM8: baseMrkrXM8RscPicture
		{
			idc = 96502;
			text = "\exile_assets\texture\ui\xm8_on_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};

		class baseMrkrGBButton: baseMrkrRscButton
		{
			idc = 97502;
			text = "Go Back"; //--- ToDo: Localize;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick =  "closeDialog 0;";
		};
		class baseMrkrONButton: baseMrkrRscButton
		{
			idc = 97503;
			text = "ON"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = "[]execVM 'custom\xm8_apps\baseMarker\code\baseMarker_ONButton.sqf'";
		};
		class baseMrkrOFFButton: baseMrkrRscButton
		{
			idc = 97504;
			text = "OFF"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = "[]execVM 'custom\xm8_apps\baseMarker\code\baseMarker_OFFButton.sqf'";
		};
		
		class baseMrkrText: baseMrkrRscText
		{
			idc = 97505;
			text = "Toggle Base Markers"; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
		};
		class baseMrkrMap: baseMrkrMapControl
		{
			idc = 97506;
			maxSatelliteAlpha = 0.75;
			alphaFadeStartScale = 1.15;
			alphaFadeEndScale = 1.29;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.231 * safezoneH;
		};
	};
};
