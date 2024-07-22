private _playerUID = getPlayerUID player;
{
	private _flag = _x;
	private _buildRights = _flag getVariable ["ExileTerritoryBuildRights", []];
	if (_playerUID in _buildRights) then
	{
	private _name = _flag getVariable ["ExileTerritoryName", ""];
	private _pos = getPos _flag;
	deleteMarkerLocal _name;
 
	};
}
forEach (allMissionObjects "Exile_Construction_Flag_Static");

	["ErrorTitleandText",["Base Marker","Base markers off."]] call ExileClient_gui_toaster_addTemplateToast;
	playSound "FD_CP_Not_Clear_F";
