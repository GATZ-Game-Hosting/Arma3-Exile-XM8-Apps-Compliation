 /*
 * XM8 App Rules
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 5/19/2023
 * Version - 1
 * Version Date - 5/19/2023
 */

class rulesGUI
{
	idd = 96500;
	onLoad = "uiNamespace setVariable ['rulesGUI', _this select 0];";
	onUnload = "uiNamespace setVariable ['rulesGUI', displayNull];";

	class Controls
	{
		
		class rulesXM8Frame: rulesXM8RscPicture
		{
			idc = 96501;
			text = "\exile_assets\texture\ui\xm8_off_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class rulesXM8: rulesXM8RscPicture
		{
			idc = 96502;
			text = "\exile_assets\texture\ui\xm8_on_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};

		class rulesControl: rulesRscControlsGroup
		{
			idc = 96503;
			x = 0.324687 * safezoneW + safezoneX; 
			y = 0.269 * safezoneH + safezoneY; 
			w = 0.350625 * safezoneW; 
			h = 0.418 * safezoneH;
			sizeEx = 0.03;
			
			class Controls
			{
				class rules: rulesRscStructuredText
				{
					
					idc = 96504;
					x = 0.324687 * safezoneW + safezoneX;
					y = 0.269 * safezoneH + safezoneY;
					w = 0.30 * safezoneW;
					h = 3 * safezoneH;
					text = "";
					colorBackground[] = {0,0,0,0};
					colorActive[] = {0,0,0,0};
				};
			};
		};
		
		class rulesGoBackBtn: rulesRscButton
		{
			idc = 96505;
			text = "Go Back";
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};
		
		class rulesDonateBtn: rulesRscButton
		{
			idc = 96506;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class rulesDiscordBtn: rulesRscButton
		{
			idc = 96507;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};

	};
};