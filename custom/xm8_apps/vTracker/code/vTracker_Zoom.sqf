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
private _vehListCtrl = _display displayCtrl 99719;
private _Selection = _vehListCtrl lbData (lbCurSel _vehListCtrl);

private _markerName = _Selection;
private _mapControl = _display displayCtrl 99718;

_mapControl ctrlMapAnimAdd [
									1, 								/// time it takes to move to the map location
									0.5, 							/// zoom level 			0 to 1.0     LOW the Number the more the map zooms in
									getMarkerPos _markerName		/// position to move map zoom to
							]; 
							
ctrlMapAnimCommit _mapControl;