/*
BASE script made by Shix http://www.exilemod.com/profile/4566-shix/
this is just the base for any project so scripters do not have to figure out how to hide controlls and figure out a go back solution
Made for XM8 Apps http://www.exilemod.com/topic/9040-updated-xm8-apps/
I would strongly suggest reading these 2 BIS WIKI articles if you have never done anything like this before
https://community.bistudio.com/wiki/ctrlCreate
https://community.bistudio.com/wiki/ctrlSetPosition
*/

// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
// Apoc's Airdrop Assistance
// https://github.com/osuapoc
// Basic Framework for the XM8 app by Shix (http://www.exilemod.com/topic/9040-xm8-apps/), all credit for that work is to his greatness
// GNU Licensing required for my portions to comply with borrowed function from A3Wasteland


disableSerialization;
scriptName "APOC_Airdrop_Assistance_XM8";

private _display = uiNameSpace getVariable ["RscExileXM8", displayNull];

createDialog "airDropGUI";

uiSleep 0.2;

private _newDisplay = uiNamespace getVariable ["airDropGUI",displayNull];

private _cbDropCategories = _newDisplay displayCtrl 975504;
_cbDropCategories ctrlSetEventHandler ["LBSelChanged", "_this call fn_DropCategory_Load"];
_cbDropCategories ctrlCommit 0;

private _lbDropList = _newDisplay displayCtrl 975505;
_lbDropList ctrlSetEventHandler ["LBSelChanged", "_this call fn_DropContents_Load"];
_lbDropList ctrlCommit 0;

private _lbDropContentList = _newDisplay displayCtrl 975506;
_lbDropContentList ctrlCommit 0;

private _btnOrderDrop = _newDisplay displayCtrl 975507;
_btnOrderDrop ctrlCommit 0;
_btnOrderDrop ctrlSetEventHandler ["ButtonClick", "_this call fn_OrderDrop;"];

// Establish Category List from config file
private _DropCategories = []; //Clear the array

if (UseAPOC_DropLayout)then
	{
		for "_i" from 0 to (count APOC_AA_Drops)-1 do {
			private _Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"
			_DropCategories pushBack _Category;
		};
	}
	else
	{
		private _lbItemsList = _newDisplay ctrlCreate ["RscListBox", 975510];
		_lbItemsList ctrlSetPosition [0.329844 * safezoneW + safezoneX, 0.522 * safezoneH + safezoneY, 0.15675 * safezoneW, 0.154 * safezoneH];
		_lbItemsList ctrlSetEventHandler ["MouseButtonDblClick", "_this call fn_dropItems_Load"];
		_lbItemsList ctrlCommit 0;

		private _lbCostBox = _newDisplay ctrlCreate ["RscText", 975511];
		_lbCostBox ctrlSetPosition [0.494844 * safezoneW + safezoneX,0.643 * safezoneH + safezoneY,0.0670312 * safezoneW,0.033 * safezoneH];
		_lbCostBox ctrlSetText "Cost: 0 Tabs";
		_lbCostBox ctrlCommit 0;

		_lbDropContentList ctrlSetEventHandler ["MouseButtonDblClick", "_this call fn_dropItems_Remove"];
		_lbDropContentList ctrlCommit 0;
		
		private _traders = missionConfigFile >> "CfgTraders";
		for "_i" from 0 to (count _traders)-1 do {
			private _traderString = getText((_traders select _i) >> "name");
			if!(_traderString in AD_tradersBlackList) then
			{
				_DropCategories pushback _traderString;
			};
		};
	};
	
  {
    (_newDisplay displayCtrl 975504) lbAdd Format["%1",_x];
    (_newDisplay displayCtrl 975504) lbSetData [_forEachIndex,_x];
  } foreach _DropCategories;
(_newDisplay displayCtrl 975504) lbSetCurSel 0; //Try and select the first value from the newly populated listbox, should force the downstream listbox to populate as well, due to EH firing


//APOC_Airdrop_Assistance Functions
fn_DropCategory_Load = {
		private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
		lbClear 975505; //Clear Drop List lb
		
		private _ctrl = _this select 0;
		private _Selection = _ctrl lbData (lbCurSel _ctrl);
		
			//Initializing some variables
		private _Category = "";
		private _Drop = "";
		private  _DropID = "";
		private _DropDesc = "";
		private _DropPrice  = 0;
		
			private _playerMoney = 0;
			private _playerRespect = 0;
			if (APOC_AA_UseExileLockerFunds) then {
				_playerMoney = player getVariable ["ExileLocker",0];
			} else {
			_playerMoney = player getVariable ["ExileMoney", 0];
			};
			
			_playerRespect = player getVariable ["ExileScore",0];
		//Load in the Drops under this category
		if (UseAPOC_DropLayout)then
		{
			lbClear 975506; //Clear Drop Content lb

			for "_i" from 0 to (count APOC_AA_Drops)-1 do
			{
				_Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"
			
				if (_Category == _Selection) then
				{
					{
						_DropDesc =  _x select 0;
						_DropID = _x select 1;
						_DropPrice = _x select 2;
						private  _DropRespectThreshold = _x select 4;
				
						_Drop = format ["%1 - Cost: %2 tabs", _DropDesc, _DropPrice];
				
						(_newDisplay displayCtrl 975505) lbAdd Format["%1",_Drop];
						(_newDisplay displayCtrl 975505) lbSetData [_forEachIndex,_DropID];
						
						if ((_DropPrice > _playerMoney)||(_DropRespectThreshold > _playerRespect)) then {
							(_newDisplay displayCtrl 975505) lbSetColor [_forEachIndex,[1,0,0,1]]; //Set drop text to red if too expensive for player
						};
						
						private _toolTip = format ["Respect Required: %1", _DropRespectThreshold];
						(_newDisplay displayCtrl 975505) lbSetTooltip [_forEachIndex, _toolTip];
				
					} forEach ((APOC_AA_Drops select _i) select 1);
				};
			};
		}
		else
		{
			lbClear 975510;
	
			private _traders = missionConfigFile >> "CfgTraders";
			private _traderString = "";
			
			for "_i" from 0 to (count _traders)-1 do 
			{
				_traderString = getText((_traders select _i) >> "name");
				if(_traderString == _Selection) then
				{
					{
						_DropID = _x;
						private _traderCategory = missionConfigFile >> "CfgTraderCategories" >> _DropID;
						_Drop = getText(_traderCategory >> "name");
						if!(_Drop in AD_categoryBlackList)then
						{
							private _index = (_newDisplay displayCtrl 975505) lbAdd _Drop;
							(_newDisplay displayCtrl 975505) lbSetData [_index,_DropID];
						};
					}forEach getArray((_traders select _i) >> "categories");
				};
			};
		};
};

fn_DropContents_Load = {
		private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
		private _ctrl = _this select 0;
		private _Selection = _ctrl lbData (lbCurSel _ctrl);

		//Initializing some variables
		private _Drop = "";
		private _DropID = "";
		private _DropDesc = "";
		private _DropPrice  = 0;
	
  	if(UseAPOC_DropLayout)then
	{
		lbClear 975506; //Clear Drop Content lb
		//Load in the Drop contents under this DropID
		for "_i" from 0 to (count APOC_AA_Drop_Contents)-1 do {
			_DropID = (APOC_AA_Drop_Contents select _i) select 0;
		
			if (_DropID == _Selection) then
			{
				{
					private _DropContentItemName = (_x select 1) select 0; //Only grab the first if multiple in the items
					private _DropContentDisplayName = getText (configfile >> "CfgMagazines" >> _DropContentItemName >> "displayName");
					if (_DropContentDisplayName == "") then
					{
					_DropContentDisplayName = getText (configfile >> "CfgWeapons" >> _DropContentItemName >> "displayName");
						if (_DropContentDisplayName =="") then
						{
						_DropContentDisplayName = getText (configfile >> "CfgVehicles" >> _DropContentItemName >> "displayName");
						};
					};
					private _DropContentQuantity = _x select 2;
					/*diag_log format["AAA - Diagnostic - DropContentItemName=%1, DisplayName=%2",_DropContentItemName,_DropContentDisplayName];*/
					private _DropContent = format ["%1 - %2", _DropContentQuantity,_DropContentDisplayName];
			
					(_newDisplay displayCtrl 975506) lbAdd Format["%1",_DropContent];
			
				} forEach ((APOC_AA_Drop_Contents select _i) select 1);
			};
		};
  	}
	else
	{
		lbClear 975510;
		private _traderCategory = missionConfigFile >> "CfgTraderCategories";
		private _playerMoney = 0;
		private _playerRespect = 0;
		
		if (APOC_AA_UseExileLockerFunds) then {
			_playerMoney = player getVariable ["ExileLocker",0];
		} else {
		_playerMoney = player getVariable ["ExileMoney", 0];
		};
		
		_playerRespect = player getVariable ["ExileScore",0];

		for "_i" from 0 to (count _traderCategory)-1 do 
		{
			private _traderString = configName (_traderCategory select _i);
			if(_traderString == _Selection) then
			{
				{
					_DropID = _x;
					if!(_DropID in AD_itemBlackList)then
					{
						private _itemRespect = getNumber(missionConfigFile >> "CfgExileArsenal" >> _DropID >> "quality");
						private _itemPrice = getNumber(missionConfigFile >> "CfgExileArsenal" >> _DropID >> "price");
						_itemPrice = floor (_itemPrice + (_itemPrice * AD_dropItemPrice));
						private _requiredRespect = getNumber(missionConfigFile >> "CfgTrading" >> "requiredRespect" >> format["Level%1",_itemRespect]);
						private _configName = _DropID call ExileClient_util_gear_getConfigNameByClassName;
						_Drop = (getText (configFile >> _configName >> _DropID >> "displayName"));
						private _index = (_newDisplay displayCtrl 975510) lbAdd _Drop;
						(_newDisplay displayCtrl 975510) lbSetData [_index,_DropID];
	
						if(_requiredRespect > _playerRespect)then
						{
							(_newDisplay displayCtrl 975510) lbSetColor [_index,[1,0,0,1]]; //Set drop text to red if too expensive for player
							
							private _missingRep = _requiredRespect - _playerRespect;
							private _toolTip = format ["[Respect Unlock: %1], Missing %2 Respect", _requiredRespect, _missingRep];
							(_newDisplay displayCtrl 975510) lbSetTooltip [_index, _toolTip];
						}
						else
						{
							if(_itemPrice > _playerMoney)then 
							{
								(_newDisplay displayCtrl 975510) lbSetColor [_index,[1,0,0,1]]; //Set drop text to red if too expensive for player
							
								private _missingTabs = _itemPrice - _playerMoney;
								private _toolTip = format ["[Price: %1], Missing %2 Poptabs", _itemPrice, _missingTabs];
								(_newDisplay displayCtrl 975510) lbSetTooltip [_index, _toolTip];
							};
							
							private _toolTip = format ["Price: %1", _itemPrice];
							(_newDisplay displayCtrl 975510) lbSetTooltip [_index, _toolTip];
						};
					};
				}forEach getArray((_traderCategory select _i) >> "items");
			};
		};
	};
};

fn_dropItems_Load = {
	private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
	private _ctrl = _this select 0;
	private _Selection = _ctrl lbData (lbCurSel _ctrl);
	private _DropID = _Selection;
	
	if !((_ctrl lbColor (lbCurSel _ctrl)) isEqualTo [1,1,1,1]) then 
	{
		["ErrorTitleAndText",["Air Drop", format["Hover mouse over item to see missing requirements."]]] call ExileClient_gui_toaster_addTemplateToast;
		playSound "FD_CP_Not_Clear_F";
	}
	else 
	{
		(_newDisplay displayCtrl 975510) ctrlEnable true;
		
		private _itemPrice = getNumber(missionConfigFile >> "CfgExileArsenal" >> _DropID >> "price");
		_itemPrice = floor (_itemPrice + (_itemPrice * AD_dropItemPrice));

		private _configName = _Selection call ExileClient_util_gear_getConfigNameByClassName;
		private _Drop = (getText (configFile >> _configName >> _DropID >> "displayName"));
	
		private _index = (_newDisplay displayCtrl 975506) lbAdd _Drop;
		(_newDisplay displayCtrl 975506) lbSetData [_index,_DropID];
		
		private _toolTip = format ["Price: %1", _itemPrice];
		(_newDisplay displayCtrl 975506) lbSetTooltip [_index, _toolTip];
		
		private _count = lbSize (_newDisplay displayCtrl 975506);
		private _dropPrice = 0;
		for "_i" from 0 to (_count)-1 do
		{
			private _indexItem = (_newDisplay displayCtrl 975506) lbData _i;
			
			private _itemPrice = getNumber(missionConfigFile >> "CfgExileArsenal" >> _indexItem >> "price");
			_itemPrice = floor (_itemPrice + (_itemPrice * AD_dropItemPrice));
			_dropPrice = _dropPrice + _itemPrice;
		};
		
		private _costText = format ["Cost: %1 Tabs",_dropPrice];
		(_newDisplay displayCtrl 975511) ctrlSetText _costText;
	};
};

fn_dropItems_Remove = {
		private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
		private _ctrl = _this select 0;
		private _Selection = lbCurSel _ctrl;

		_ctrl lbDelete _Selection;
		
		private _count = lbSize (_newDisplay displayCtrl 975506);
		private _dropPrice = 0;
		for "_i" from 0 to (_count)-1 do
		{
			private _indexItem = (_newDisplay displayCtrl 975506) lbData _i;
			
			private _itemPrice = getNumber(missionConfigFile >> "CfgExileArsenal" >> _indexItem >> "price");
			_itemPrice = floor (_itemPrice + (_itemPrice * AD_dropItemPrice));
			_dropPrice = _dropPrice + _itemPrice;
		};
		
		private _costText = format ["Cost: %1 Tabs",_dropPrice];
		(_newDisplay displayCtrl 975511) ctrlSetText _costText;
};	

fn_OrderDrop = {
	private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
	private _DropPrice = 0;
	private _DropType = "";
	private _DropRespectThreshold = 0;
	private _DropSelection = "";
	
	if(UseAPOC_DropLayout)then
	{
		//diag_log format["AAA - fn_OrderDrop Called"];
		private _ctrl = (_newDisplay displayCtrl 975504);
		private  _CategorySelection = _ctrl lbData (lbCurSel _ctrl);
		_ctrl = (_newDisplay displayCtrl 975505);
		_DropSelection = _ctrl lbData (lbCurSel _ctrl);  //_DropId
		
		//Initializing some variables
		private _Drop = "";
		private _DropID = "";
		private _DropDesc = "";
		private _NotificationText = "";
		
		//Very convoluted system to extract the price from the arrays
		for "_i" from 0 to (count APOC_AA_Drops)-1 do
		{
			private _Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"
			if (_Category == _CategorySelection) then
			{
			//diag_log format["AAA - _Category line 179 = %1",_Category];
			{
				private _Selection = _x select 1;
				if (_DropSelection == _Selection) then
				{
				//diag_log format["AAA - _Selection line 184 = %1",_Selection];
				_DropDesc = _x select 0;
				_DropPrice = _x select 2;
				_DropType = _x select 3;
				_DropRespectThreshold = _x select 4;
				};
			} forEach ((APOC_AA_Drops select _i) select 1);
			};
		};
		//diag_log format ["AAA - _DropPrice = %1", _DropPrice];
		//Dive out of the tree if an empty order is selected (or not)
		If (isNil "_DropType") exitWith {diag_log "AAA - _DropType Not Specified, cannot place order";};
		If (isNil "_DropDesc") exitWith {diag_log "AAA - _DropDesc Not Specified, cannot place order";};
		If (isNil "_DropPrice") exitWith {diag_log "AAA - _DropPrice Not Specified, cannot place order";};
	}
	else
	{
		private _dropArry = [];
		private _vehicleTypes = ["Car","Motorcycle","Tank","Ship","WheeledAPC"];
		private _newDisplay = uiNameSpace getVariable ["airDropGUI", displayNull];
		private _ctrl = (_newDisplay displayCtrl 975506);
		private _count = lbSize _ctrl;
		
		if (_count == 0)then
		{
			["ErrorTitleAndText",["Air Drop", format["You cant order an empty box!"]]] call ExileClient_gui_toaster_addTemplateToast;
			playSound "FD_CP_Not_Clear_F";
			breakOut "APOC_Airdrop_Assistance_XM8";
		};
		
		private _dropItem = "";

		for "_i" from 0 to (_count - 1) do 
		{
			_dropItem = _ctrl lbData _i;
			private _typeOfItem = "";

			private _itemPrice = getNumber(missionConfigFile >> "CfgExileArsenal" >> _dropItem >> "price");
			_itemPrice = floor (_itemPrice + (_itemPrice * AD_dropItemPrice));
			_dropPrice = _dropPrice + _itemPrice;

			private _itemCheck = [_dropItem] call BIS_fnc_itemType;		/// gets item item type and class type
					
			if (_itemCheck select 0 == "") then
			{
				_itemCheck = [_dropItem] call BIS_fnc_ObjectType;
			};
			
			private _itemClass = _itemCheck select 0;	
			private _itemType = _itemCheck select 1;	

			if(_itemType == "Backpack")then
			{
				_typeOfItem = "bac";
			}
			else
			{
				if(_itemClass == "Weapon")then
				{
					_typeOfItem = "wep";
				}
				else
				{
					if(_itemType in _vehicleTypes)then
					{
						_typeOfItem = "veh";
					}
					else
					{
						if((_itemType == "Helicopter") || (_itemType == "Plane"))then
						{
							_typeOfItem = "air";
						}
						else
						{
							_typeOfItem = "itm";
						};
					};
				};
			};
			private _DropItemFormat = [[_typeOfItem,[_dropItem],1]];
			_dropArry append _DropItemFormat;
		};
		
		private _dropArryCount = count _dropArry;
		
		if(_dropArryCount > 1)then
		{
			{
				private _dropItemType = _x select 0;
				if(_dropItemType == "veh")then
				{
					_NotificationText =  format["Check your order over, you can only order a box of items or 1 vehicle!", ceil _timeRemainingReuse];
					["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
					playSound "FD_CP_Not_Clear_F";
					breakOut "APOC_Airdrop_Assistance_XM8";
				}
				else
				{
					_DropType = "supply";
					_DropSelection = [];
					private _DropSelectionName = "Player_Made";
					private _DropSelectionFormat = [_DropSelectionName,_dropArry];
					_DropSelection append _DropSelectionFormat;
				};
			}forEach _dropArry;
		}
		else
		{
			{
				private _dropItemType = _x select 0;
				if(_dropItemType == "veh")then
				{
					_DropType = "vehicle";
					_DropSelection = _dropItem;
				}
				else
				{
					if(_dropItemType == "air")then
					{
						_NotificationText =  format["You can't order an air vehicle via air drop!", ceil _timeRemainingReuse];
						["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
						playSound "FD_CP_Not_Clear_F";
						breakOut "APOC_Airdrop_Assistance_XM8";
					}
					else
					{
						_DropType = "supply";
						_DropSelection = [];
						private _DropSelectionName = "Player_Made";
						private _DropSelectionFormat = [_DropSelectionName,_dropArry];
						_DropSelection append _DropSelectionFormat;
					};
				};
			}forEach _dropArry;
		};
		_DropRespectThreshold = 0;
	};

		//diag_log format["AAA - _DropDesc = %1, _DropPrice = %2, _DropType = %3",_DropDesc,_DropPrice, _DropType];
		/////////////  Cooldown Timer ////////////////////////
			if (!isNil "APOC_AA_lastUsedTime") then
			{
			//diag_log format ["AAA - Last Used Time: %1; CoolDown Set At: %2; Current Time: %3",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime];
			private _timeRemainingReuse = APOC_AA_coolDownTime - (diag_tickTime - APOC_AA_lastUsedTime); //time is still in s
			if ((_timeRemainingReuse) > 0) then
			{
				_NotificationText =  format["You need to wait %1 seconds before calling an airdrop again!", ceil _timeRemainingReuse];
				["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
				playSound "FD_CP_Not_Clear_F";
				breakOut "APOC_Airdrop_Assistance_XM8";
			};
			};
			//diag_log format["AAA - Made it to line 203!, _DropPrice %1",_DropPrice];
		////////////////////////////////////////////////////////
		private _playerMoney = 0;
		private _playerRespect = 0;
		if (APOC_AA_UseExileLockerFunds) then {
			_playerMoney = player getVariable ["ExileLocker",0];
		} else {
			_playerMoney = player getVariable ["ExileMoney", 0];
		};
		_playerRespect = player getVariable ["ExileScore", 0];
		//diag_log format["AAA - Made it to line 237!, _DropPrice %1, _playerMoney %2",_DropPrice, _playerMoney];
		if(UseAPOC_DropLayout)then
		{
			if (_DropPrice > _playerMoney)then
			{
			_NotificationText =  "You don't have enough money to request this airdrop!";
			["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
			playSound "FD_CP_Not_Clear_F";
			breakOut "APOC_Airdrop_Assistance_XM8";
			};
		}
		else
		{
			if (_DropPrice > _playerMoney)then
			{
			_NotificationText =  format ["You don't have enough money to request this airdrop, try removing a few items. DROP COST: %1",_DropPrice];
			["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
			playSound "FD_CP_Not_Clear_F";
			breakOut "APOC_Airdrop_Assistance_XM8";
			};
		};
		if (_DropRespectThreshold > _playerRespect)then
			{
			_NotificationText =  "You don't have enough respect to request this airdrop!";
			["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
			playSound "FD_CP_Not_Clear_F";
			breakOut "APOC_Airdrop_Assistance_XM8";
			};
		
		/////////////////////////
		//Do Stuff!
		if(UseAPOC_DropLayout)then
		{
			[_DropType,_DropSelection,player] remoteExec ["APOC_srv_startAirdrop",2]; //Make sure you whitelisted this!
		}
		else
		{
			[_DropType,_DropSelection,player,_DropPrice] remoteExec ["APOC_srv_startAirdrop",2]; //Make sure you whitelisted this!
		};
		APOC_AA_lastUsedTime = diag_tickTime;
		diag_log format ["AAA - Just Used Time: %1; CoolDown Set At: %2; Current Time: %3, Type %4, Selection %5",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime,_DropType,_DropSelection];
		// Give some feedback that the pilot has heard the call to action!
		_NotificationText = format ["Your airdrop is on its way!  ETA ~90 seconds!  DROP COST: %1",_DropPrice]; //You could put a variable here in case you change the spawn in distance
		["SuccessTitleandText",["Airdrop Success!",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
		playSound3D ["a3\sounds_f\sfx\radio\ambient_radio17.wss",player,false,getPosASL player,1,1,25]; // Thanks Lodac (TOParma!)
		//TO THE SERVER FUNCTION!
};