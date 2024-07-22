/*
Air Strike XM8 App
By Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v2.1 05/23/2023
*/

if (isServer) exitWith{};

private _SJcooldown_timer = (round ((uiNamespace getVariable ["SJcooldown",-1]) - diag_tickTime));
		 
if (diag_tickTime < (uiNamespace getVariable ["SJcooldown",-1])) exitWith
	{
		["InfoTitleAndText", ["Air Strike Cool Down", format ["Air strike unavailable at this time, please wait %1 seconds",_SJcooldown_timer]]] call ExileClient_gui_toaster_addTemplateToast;
	};

uiNamespace setVariable ["SJcooldown",(diag_tickTime + SJcoolDnTime)];
		 
if (ExilePlayerInSafezone) exitWith
	{
		["ErrorTitleAndText", ["Air strike", "You can't do that from traders"]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["SJcooldown",(diag_tickTime + 0)];
	};
		
private _weaponClass = currentWeapon player;
if !((_weaponClass) in SJlasers) exitWith
	{
		["ErrorTitleAndText", ["Air strike", "You need a laser designator equipped to lase targets"]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["SJcooldown",(diag_tickTime + 0)];
	};

private _playerRespect = player getVariable ["ExileScore", 0];
private _playerMoney = player getVariable ["ExileLocker", 0];
if ((SJrepPercnt > 0) && (_playerRespect < SJrespectMin)) exitWith
	{
		["ErrorTitleAndText", ["Air strike", format ["You need at least %1 respect to call an air strike",SJrespectMin]]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["SJcooldown",(diag_tickTime + 0)];
	};

if ((SJmoneyPercnt > 0) && (_playerMoney < SJpopTabMin)) exitWith
	{
		["ErrorTitleAndText", ["Air strike", format ["You need at least %1 pop tabs in the bank(locker) to call an air strike",SJpopTabMin]]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["SJcooldown",(diag_tickTime + 0)];
	};
	
private _exit = false;

disableSerialization;

	(findDisplay 24015) closeDisplay 0;
	private _SJrepCost = _playerRespect * SJrepPercnt;
	private _SJCost = _playerMoney * SJmoneyPercnt;
	private _result2 = [format ["Call air strike for %1 pop tabs and %2 respect?",_SJCost,_SJrepCost], "Air strike", "Yes", "No"] call BIS_fnc_guiMessage;
	
	waitUntil { !isNil "_result2"};
	if (_result2) then
	{
		private _pos = getPosATL player;
		airstrike = [_pos,player,getPlayerUID player,_SJrepCost,_playerRespect,_SJCost,_playerMoney];
		uiSleep 0.2;
		publicVariableServer "airstrike";
	}
	else
	{
		_exit = true;
	};

if (_exit) exitWith
	{
		["InfoTitleAndText", ["Air support", "Air strike cancelled"]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["SJcooldown",(diag_tickTime + 0)];
	};
	
closeDialog 0;
private _SJscriptStartTime = time;

["SuccessTitleAndText", ["Air strike", "Getting position, Air Strike Inbound ETA 30sec, Get your laser designator ready"]] call ExileClient_gui_toaster_addTemplateToast;
	private _SJheading = [0,45,90,135,180,225,270,315,360];
	_SJheading = selectRandom _SJheading;
	private _SJcenter = player getPos [5000, _SJheading];
	private _SJJetSpawn = _SJcenter; 
	private _SJUnitspawn = _SJcenter; 
	private _SJ_Side = independent;
	private _SJGroup = createGroup _SJ_Side; 
	private _SJPilot = _SJGroup createUnit ["O_Soldier_unarmed_F", _SJUnitspawn, [], 0, "CAN_COLLIDE"];

{ 
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
	_x enableAttack false;
	_x setSkill ["aimingAccuracy", 1];
	_x setSkill ["aimingShake", 0];
	_x setSkill ["aimingSpeed", 1];
	_x setSkill ["endurance", 1];
	_x setSkill ["spotDistance", 1];
	_x setSkill ["spotTime", 1];
	_x setSkill ["courage", 1];
	_x setSkill ["reloadSpeed", 1];
	_x setSkill ["commanding", 1];
	_x setSkill ["general", 1];
	removeHeadgear _x;
	removeUniform _x;
	removeVest _x;
	removeBackpack _x;
	_x forceAddUniform "U_B_PilotCoveralls";
	_x addVest "V_RebreatherB";
	_x addHeadgear "H_PilotHelmetFighter_B";
	_x addWeapon "hgun_Rook40_F";
	_x addItemToUniform "16Rnd_9x21_Mag";
	_x addItemToUniform "16Rnd_9x21_Mag";
	_x addItemToUniform "16Rnd_9x21_Mag";
	_x addBackpack "B_Parachute";
}foreach (units _SJGroup);

private _SJ_Plane =	["B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"];						
_SJ_Plane = selectRandom _SJ_Plane;
private _SJJet = createVehicle [_SJ_Plane, _SJJetSpawn, [], 0, "FLY"];
_SJPilot moveInAny _SJJet;
_SJJet flyInHeight 300;
private _SJWP1 = _SJGroup addWaypoint [getpos player, 1];
_SJWP1 setWaypointSpeed "FULL";
_SJWP1 setWaypointType "MOVE";

_SJJet setCaptive 1;
_SJJet addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];

			while {alive _SJJet} do
			{
				private _nearbyLasers = (getPosATL _SJJet) nearEntities ["LaserTarget", 3000];
				private _dist = 3000;
				private _nearestLaser = objNull;
								
				if (time - _SJscriptStartTime >= SJflyTime) exitWith 
				{				
					["InfoTitleAndText", ["Air strike", "Returning to base, good luck out there."]] call ExileClient_gui_toaster_addTemplateToast;
					_SJJet setBehaviour "CARELESS";
					_SJJet setCombatMode "GREEN";
					_SJGroup setBehaviour "CARELESS";
					_SJGroup setCombatMode "GREEN";
					_SJJet setcaptive true;
					private _SJWP2 = _SJGroup addWaypoint [[0,0,500], 1];
					_SJWP2 setWaypointSpeed "FULL";
					_SJWP2 setWaypointType "MOVE";
					_SJWP2 setWaypointStatements["true","deleteVehicle (vehicle this);{deleteVehicle _x} forEach thislist; deleteGroup (group this);"]; 
					airstrike = nil;
				};			

				{
					private _check = _x distance _SJJet;
					if (_check < _dist) then
					{
						_dist = _check;
						_nearestLaser = _x;
						_SJJet doTarget _nearestLaser;
					};
				} count _nearbyLasers;
				UIsleep 5;
			};
		
if (!alive _SJJet) exitwith
{	
	["ErrorTitleAndText", ["Air strike", format ["Jet has taken on to much damage to continue."]]] call ExileClient_gui_toaster_addTemplateToast;

	{
		deleteVehicle _x;
	}foreach (units _SJGroup);
	airstrike = nil;
};