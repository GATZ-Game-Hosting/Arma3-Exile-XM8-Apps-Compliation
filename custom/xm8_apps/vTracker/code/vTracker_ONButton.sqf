 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

disableSerialization;

private _mapCenter = [worldSize / 2, worldsize / 2, 0];
private _searchRadius = sqrt 2 / 2 * worldSize;
private _vehicles = nearestObjects [_mapCenter, ["LandVehicle","Air","Ship"], _searchRadius]; 
private _vehicleArray = [];

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
	private _objID = netId _x;
	_vehicleArray pushback _objID;
}forEach _vehicles;

	["vTrackerRequest", [_vehicleArray]] call ExileClient_system_network_send;
