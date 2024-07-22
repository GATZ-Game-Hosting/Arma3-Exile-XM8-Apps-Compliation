 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

private _vehicleInfo = _this select 0;

if((count _vehicleInfo) == 0)then
{
		["ErrorTitleAndText",["Vehicle Tracker", format["No Vehicles Found!"]]] call ExileClient_gui_toaster_addTemplateToast;
		playSound "FD_CP_Not_Clear_F";
		call vTracker_OFFButton;
		breakOut "vTrackerGUI";
};

disableSerialization;

private _display = uiNameSpace getVariable ["vTrackerGUI", displayNull];
private _vehListbox = _display displayCtrl 99719;
lbClear 99719;

private _markerNumber = 0;
{
	if ((getMarkerType _x) == "loc_car") then
	{
		_markerNumber = _markerNumber + 1;
		private _marker = format["vTraker%1",_markerNumber];	
		deleteMarkerLocal _marker;
	};
}forEach allMapMarkers;

{
	private _vehiclePos = _x select 2;
	private _vehicleType = _x select 0;
	private _vehiclePin = _x select 1;
	
	_markerNumber = _markerNumber + 1;
	_markerName = format ["vTraker%1",_markerNumber];
	private _marker = createMarkerLocal [_markerName, _vehiclePos];
	_marker setMarkerTextLocal _vehicleType;
	_marker setMarkerTypeLocal "loc_car";
	_marker setMarkerColorLocal "ColorGreen";
	vTrackerMrkrs pushback _markerName;
	
	private _index = (_display displayCtrl 99719) lbAdd _vehicleType;
	_vehListbox lbSetData [_index,_markerName];
	private _toolTip = format ["Code: %1", _vehiclePin];
	_vehListbox lbSetTooltip [_index, _toolTip];
}forEach _vehicleInfo;

["SuccessTitleandText",["Vehicle Tracker","Vehicles Found!"]] call ExileClient_gui_toaster_addTemplateToast;
playSound "FD_CP_Not_Clear_F";
