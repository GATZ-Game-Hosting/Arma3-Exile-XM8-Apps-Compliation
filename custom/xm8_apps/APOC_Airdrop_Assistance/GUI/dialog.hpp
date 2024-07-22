class airDropGUI
{
	idd = 975501;
	access = 3;
	duration = -1;
	onLoad = "uiNamespace setVariable ['airDropGUI', _this select 0];";
	onUnload = "uiNamespace setVariable ['airDropGUI', displayNull];";
	
	class Controls
	{
		class airDropPicturexm8frame: airDropRscPicture
		{
			idc = 975502;
			text = "\exile_assets\texture\ui\xm8_off_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class airDropPicturexm8: airDropRscPicture
		{
			idc = 975503;
			text = "\exile_assets\texture\ui\xm8_on_ca.paa";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.733333 * safezoneH;
		};
		class airDropCombo: airDropRscCombo
		{
			idc = 975504;
			x = 0.328812 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class airDropListbox1: airDropRscListbox
		{
			idc = 975505;
			x = 0.328812 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.15675 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class airDropListbox2: airDropRscListbox
		{
			idc = 975506;
			x = 0.49175 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.275 * safezoneH;
		};
		//class airDropListbox3: airDropRscListbox
		//{
		//	idc = 975510;
		//	x = 0.329844 * safezoneW + safezoneX;
		//	y = 0.522 * safezoneH + safezoneY;
		//	w = 0.15675 * safezoneW;
		//	h = 0.154 * safezoneH;
		//};
		class airDropButtonMenu: airDropRscButtonMenu
		{
			idc = 975507;
			text = "Order Drop"; //--- ToDo: Localize;
			x = 0.49175 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.086625 * safezoneW;
			h = 0.022 * safezoneH;
			textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
				class HitZone
				{
					left = 0;
					top = 0;
					right = 0;
					bottom = 0;
				};
		};
		class airDropButton: airDropRscButton
		{
			idc = 975508;
			text = "Go Back"; //--- ToDo: Localize;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			onButtonClick =  "closeDialog 0;";
		};
		class airDropText: airDropRscText
		{
			idc = 975509;
			text = "AIR DROP";
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 3 * GUI_GRID_H;
		};
	};
};
