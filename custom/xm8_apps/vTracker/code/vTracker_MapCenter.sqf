 /*
 * XM8 App VTracker
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/03/2023
 * Version - 1
 * Version Date - 6/03/2023
 */

disableSerialization;

private _display = uiNamespace getVariable ["vTrackerGUI",displayNull];
private _mapControl = _display displayCtrl 99718;
private _mapcenter = worldsize /2;

_mapControl ctrlMapAnimAdd [
								1, 							/// time it takes to move to the map location
								1, 							/// zoom level 0 to 1
								[_mapcenter,_mapcenter]		/// position to move map zoom to
							]; 
ctrlMapAnimCommit _mapControl;