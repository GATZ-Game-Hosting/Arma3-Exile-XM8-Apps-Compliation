if (isServer) exitWith{};

private _EMPcooldown_timer = (round ((uiNamespace getVariable ["EMPcooldown",-1]) - diag_tickTime));
		 
if (diag_tickTime < (uiNamespace getVariable ["EMPcooldown",-1])) exitWith
	{
		["InfoTitleAndText", ["EMP Cool Down", format ["EMP unavailable at this time, please wait %1 seconds",_EMPcooldown_timer]]] call ExileClient_gui_toaster_addTemplateToast;
	};

uiNamespace setVariable ["EMPcooldown",(diag_tickTime + 900)];// 900 seconds default, set this to whatever you want the cooldown to be in seconds
		 
if (ExilePlayerInSafezone) exitWith
	{
		["ErrorTitleAndText", ["EMP", "You can't use EMP near traders"]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["EMPcooldown",(diag_tickTime + 0)];
	};

if !(isNull objectParent player) exitWith
	{
		["ErrorTitleAndText", ["EMP", "You can't use EMP while in a vehicle"]] call ExileClient_gui_toaster_addTemplateToast;
		uiNamespace setVariable ["EMPcooldown",(diag_tickTime + 0)];
	};

["SuccessTitleOnly", ["EMP Charging wait 10 Seconds"]] call ExileClient_gui_toaster_addTemplateToast;
Player playActionNow "stand";
sleep 10;
["SuccessTitleOnly", ["EMP Activiated"]] call ExileClient_gui_toaster_addTemplateToast;
playSound "geiger";
playSound "murmur";
playSound "spark1";
playSound "spark2";
playSound "spark3";
playSound "spark4";
playSound "spark5";
playSound "spark11";
playSound "spark22";
playSound "tiuit";

enableCamShake true;
addCamShake [5,10,27];

Private	_ripple = "#particlesource" createVehicleLocal getposatl player;
	_ripple setParticleCircle [0,[0,0,0]];
	_ripple setParticleRandom [0,[0.25,0.25,0],[0.175,0.175,0],0,0.25,[0,0,0,0.1],0,0];
	_ripple setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1], "", "Billboard", 1, 0.5, [0, 0, 0], [0, 0, 0],0,10,7.9,0, [30,1000], [[1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", player];
	_ripple setDropInterval 0.1;
	[_ripple] spawn {Private _de_sters = _this select 0;sleep 1;deleteVehicle _de_sters};

Private _blast = "#particlesource" createVehicleLocal getposatl player;
	_blast setParticleCircle [0, [0, 0, 0]];
	_blast setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
	_blast setParticleParams [["\A3\data_f\koule", 1, 0, 1], "", "SpaceObject", 1,1,[0,0,0],[0,0,1],3,10,7.9,0,[50,1000],[[1, 1, 1, 0.1], [1, 1, 1, 0]], [1], 1, 0, "", "", player];
	_blast setDropInterval 50;
	[_blast] spawn {Private _de_sters = _this select 0;sleep 1;deleteVehicle _de_sters};

Private _light_emp = "#lightpoint" createVehiclelocal getposatl player;
	_light_emp lightAttachObject [player, [0,0,3]];
	_light_emp setLightAmbient [1,1,1];  
	_light_emp setLightColor [1,1,1];
	_light_emp setLightBrightness 0;
	_light_emp setLightDayLight true;
	_light_emp setLightAttenuation [1,4,4,0,20,500];
Private _range_lit=0;
Private _brit=0;
	while {_brit < 50} do 
	{
		_light_emp setLightBrightness _brit;
		_brit = _brit+2;
		sleep 0.01;
	};
	deleteVehicle _light_emp;

Private _side = east;
Private _radius = 25; // radius of the EMPs effect

_nearMen = player nearEntities [["Man", "Air", "Car", "Tank"], _radius];
{
 if (side _x == _side) then {
   _x setDamage 1.0;  //How much damage you want AI to get from EMP use, default 100%
 };
} forEach (_nearMen - [player]);  