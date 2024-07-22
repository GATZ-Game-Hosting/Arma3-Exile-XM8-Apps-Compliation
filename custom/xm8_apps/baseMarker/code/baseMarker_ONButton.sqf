private _flagArray = [];

private _playerUID = getPlayerUID player;
{
	private _flag = _x;
	private _buildRights = _flag getVariable ["ExileTerritoryBuildRights", []];
	if (_playerUID in _buildRights) then
	{
		private _name = _flag getVariable ["ExileTerritoryName", ""];
		private _pos = getPos _flag;
		private _marker = createMarkerLocal [_name, _pos];
		_marker setMarkerTextLocal _name;
		_marker setMarkerTypeLocal "mil_flag";
		_marker setMarkerColorLocal "ColorYellow";
		_flagArray pushBack _flag;
	};
}forEach (allMissionObjects "Exile_Construction_Flag_Static");

if(count _flagArray <= 0)exitWith
{
	["ErrorTitleandText",["Base Marker","No bases found."]] call ExileClient_gui_toaster_addTemplateToast;
	playSound "FD_CP_Not_Clear_F";
};

private _nearestFlag = [_flagArray, player] call BIS_fnc_nearestPosition;
private _nearestFlagName = _nearestFlag getVariable ["ExileTerritoryName", ""];
[_nearestFlagName]execVM "custom\xm8_apps\baseMarker\code\baseMarker_Zoom.sqf";

	["SuccessTitleandText",["Base Marker","Base markers on"]] call ExileClient_gui_toaster_addTemplateToast;
	playSound "FD_CP_Not_Clear_F";
