	disableSerialization;

	private _display = uiNamespace getVariable ["baseMarkerGUI",displayNull];
	private _mapControl = _display displayCtrl 97505;
	private _mapcenter = worldsize /2;

	_mapControl ctrlMapAnimAdd [
									1, 							/// time it takes to move to the map location
									1, 							/// zoom level 0 to 1
									[_mapcenter,_mapcenter]		/// position to move map zoom to
								]; 
	ctrlMapAnimCommit _mapControl;

	true