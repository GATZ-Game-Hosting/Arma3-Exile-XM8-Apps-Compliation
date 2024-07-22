 /*
 * XM8 App BRAmaRecipes
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/16/2023
 * Version - 1
 * Version Date - 6/16/2023
 */

class bramaRecipesGUI
{
	idd = 74510;
	access = 3;
	duration = -1;
	onLoad = "uiNamespace setVariable ['bramaRecipesGUI', _this select 0];";
	onUnload = "uiNamespace setVariable ['bramaRecipesGUI', displayNull];";
	
	class Controls
	{
		class bramaXM8Frame: bramaXM8RscPicture
		{
			idc = 74511;
			text = "\exile_assets\texture\ui\xm8_off_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class bramaXM8: bramaXM8RscPicture
		{
			idc = 74512;
			text = "\exile_assets\texture\ui\xm8_on_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class bramaListboxComp: bramaRscListbox
		{
			idc = 74513;
			x = 0.335 * safezoneW + safezoneX; 
			y = 0.335 * safezoneH + safezoneY; 
			w = 0.165 * safezoneW; 
			h = 0.165 * safezoneH;
		};
		class bramaListboxRecipe: bramaRscListbox
		{
			idc = 74514;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.33 * safezoneH;
		};
		//class bramaPic: bramaXM8RscPicture
		//{
		//	idc = 74515;
		//	text = "custom\xm8_apps\bramarecipes\brama.paa";
		//	x = 0.345312 * safezoneW + safezoneX;
		//	y = 0.5 * safezoneH + safezoneY;
		//	w = 0.154687 * safezoneW;
		//	h = 0.176 * safezoneH;
		//};
		class bramaDropDown: bramaRscCombo
		{
			idc = 74516;
			x = 0.335 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class bramaCraft: bramaRscButton
		{
			idc = 74517;
			text = "CRAFT"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class bramaGoBack: bramaRscButton
		{
			idc = 74518;
			text = "GO BACK"; //--- ToDo: Localize;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class bramaTittle: bramaRscText
		{
			idc = 74519;
			text = "RECIPIES"; //--- ToDo: Localize;
			x = 18.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};
