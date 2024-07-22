
 

disableSerialization;
private _markerName = _this;
private _display = uiNamespace getVariable ["baseMarkerGUI",displayNull];
private _mapControl = _display displayCtrl 97506;



_mapControl ctrlMapAnimAdd [
									1, 								/// time it takes to move to the map location
									0.5, 							/// zoom level 			0 to 1.0     LOW the Number the more the map zooms in
									getMarkerPos _markerName		/// position to move map zoom to
							]; 
ctrlMapAnimCommit _mapControl;

true