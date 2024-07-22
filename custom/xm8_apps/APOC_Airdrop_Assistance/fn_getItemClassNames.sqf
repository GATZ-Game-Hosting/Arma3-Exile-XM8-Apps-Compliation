	params ["_itemClassName"];
	
	private _itemCheck = [_itemClassName] call BIS_fnc_itemType;
	private _itemDispName = "";
	
	if (_itemCheck select 0 == "") then
	{
		_itemCheck = [_itemClassName] call BIS_fnc_ObjectType;
	};
	
	private _itemClass = _itemCheck select 0;
	private _itemType = _itemCheck select 1;
	diag_log Format ["AIR DROP ITEM CHECK: %1 [%2,%3]",_itemClassName,_itemClass,_itemType];
	
	switch (_itemClass) do
	{	
		case "Equipment": 
		{
			switch (_itemType) do
			{		
				case "Glasses":
				{
					_itemDispName = (getText (configFile >> "CfgGlasses" >> _itemClassName >> "displayName"));
				};
				
				case "Uniform";
				case "Vest";
				case "Backpack"; //questionable may need to look at (configFile >> "CfgVehicles" >>
				case "Headgear":
				{
					_itemDispName = (getText (configFile >> "CfgWeapons" >> _itemClassName >> "displayName"));
				};
				
				//case 
				//{	
				//	(configFile >> "CfgVehicles" >>
				//};
			};
		};
		
		case "Weapon":
		{	
			switch (_itemType) do
			{		
				case "Throw";
				case "MachineGun";
				case "Rifle";
				case "SniperRifle";
				case "AssaultRifle";
				case "SubmachineGun";					
				case "Handgun";
				case "Shotgun";
				case "GLauncher";
				case "RocketLauncher":
				{
					_itemDispName = (getText (configFile >> "CfgWeapons" >> _itemClassName >> "displayName"));
				};
			};
		};
		
		case "Item":
		{
			switch (_itemType) do 
			{
				case "AccessorySights":
				{
					_itemDispName = (getText (configFile >> "CfgWeapons" >> _itemClassName >> "displayName"));
				};
			};
		};
		
		case "Mine": 
		{
			_itemDispName = (getText(configFile >> "CfgMagazines" >> _ClassName >> "displayName"));
		};
		
		case "Magazine":
		{
			switch (_itemType) do 
			{
				case "Bullet";
				case "Shell";
				case "SmokeShell";
				case "Grenade":
				{
					_itemDispName = (getText(configFile >> "CfgMagazines" >> _ClassName >> "displayName"));
				};
				
				case "UnknownMagazine":
				{					
					if (isArray(configFile >> "CfgMagazines" >> _ClassName>> "Interactions" >> "Consuming" >> "effects")) then
					{
						_itemDispName = (getText(configFile >> "CfgMagazines" >> _ClassName >> "displayName"));
					};
				};
			};
		};
	};
	_itemDispName
