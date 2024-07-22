 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

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

["ErrorTitleAndText",["Vehicle Tracker","Tracker Turned Off!"]] call ExileClient_gui_toaster_addTemplateToast;
playSound "FD_CP_Not_Clear_F";
