 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

disableSerialization;

private _display = uiNameSpace getVariable ["RscExileXM8", displayNull];

createDialog "vTrackerGUI";

private _mapMarkers = false;
private _markerNumber = 0;
{
	if ((getMarkerType _x) == "loc_car") then
	{
		_markerNumber = _markerNumber + 1;
		private _marker = format["vTraker%1",_markerNumber];	
		deleteMarkerLocal _marker;
		_mapMarkers = true;
	};
}forEach allMapMarkers;

private _newDisplay =  uiNamespace getVariable ["vTrackerGUI",displayNull];

if(_mapMarkers)then
{
	call vTracker_ONButton;
};

private _vehListbox = _newDisplay displayCtrl 99719;
_vehListbox ctrlSetEventHandler ["LBSelChanged", "_this call vTracker_Zoom"];
