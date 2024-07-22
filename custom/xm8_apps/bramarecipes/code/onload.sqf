 /*
 * XM8 App BRAmaRecipes
 * Created by - Crito @Vanaheim Gaming Servers
 * Discord - https://discord.gg/WEFzqPa
 * Date Created - 6/16/2023
 * Version - 1
 * Version Date - 6/16/2023
 */

disableSerialization;

private _BRAmaRecipesPath = "custom\xm8_apps\BRAmaRecipes";

private _display = uiNameSpace getVariable ["RscExileXM8", displayNull];

createDialog "bramaRecipesGUI";

uiSleep 0.2;

private _bramadisplay = uiNamespace getVariable "bramaRecipesGUI";

private _recipesCategories = _bramadisplay displayCtrl 74516;
_recipesCategories ctrlSetEventHandler ["LBSelChanged", "_this call fnc_recipe_Load"];
_recipesCategories ctrlCommit 0;

private _goCraftBtn = _bramadisplay displayCtrl 74517;
_goCraftBtn ctrlSetEventHandler ["ButtonClick", "SelectedRecipe call ExileClient_gui_crafting_show;"];
_goCraftBtn ctrlCommit 0;

private _backbtn = _bramadisplay displayCtrl 74518;
_backbtn ctrlSetEventHandler ["ButtonClick", "closeDialog 0;"];
_backbtn ctrlCommit 0;

private _recipeList = _bramadisplay displayCtrl 74513;
_recipeList ctrlSetEventHandler ["LBSelChanged", "_this call fnc_components_Load;"];
_recipeList ctrlCommit 0;

private _recipesPic = _bramadisplay ctrlCreate ["RscPictureKeepAspect", 74515];
_recipesPic ctrlSetPosition [0.345312 * safezoneW + safezoneX, 0.5 * safezoneH + safezoneY, 0.154687 * safezoneW, 0.176 * safezoneH];
_recipesPic ctrlCommit 0;
_recipesPic ctrlSetText _BRAmaRecipesPath + "\BRAma.paa";

private _componentsList = _bramadisplay displayCtrl 74514;
_componentsList ctrlCommit 0;

private _RecipeCategories = [];

for '_j' from 0 to (count (missionConfigFile >> "CfgCraftingRecipes"))-1 do
{
	private _CategoryConfig = (missionConfigFile >> "CfgCraftingRecipes") select _j;
	
	private _RecipeCategory = getText(_CategoryConfig >> "category");	

	if!(_RecipeCategory in _RecipeCategories)then{_RecipeCategories pushBack _RecipeCategory;};		
	_RecipeCategory = "Uncategorized";
	if!(_RecipeCategory in _RecipeCategories)then{_RecipeCategories pushBack _RecipeCategory;};

};

lbClear _recipesCategories;
{
_recipesCategories lbAdd Format["%1",_x];
_recipesCategories lbSetData [_forEachIndex,_x];
} foreach _RecipeCategories;

lbSort _recipesCategories;
_recipesCategories lbSetCurSel 0;

fnc_recipe_Load = {
private _BRAmaRecipesPath = "custom\xm8_apps\BRAmaRecipes";

private _display = uiNameSpace getVariable ["bramaRecipesGUI", displayNull];

lbClear 74514;
lbClear 74513;
(_display displayCtrl 74515) ctrlSetText _BRAmaRecipesPath + "\BRAma.paa";

private _CategoryCtrl = _this select 0;
private _SelectedCategory 	= _CategoryCtrl lbData (lbCurSel _CategoryCtrl);


for '_j' from 0 to (count (missionConfigFile >> "CfgCraftingRecipes"))-1 do
{
	private _CategoryConfig = (missionConfigFile >> "CfgCraftingRecipes") select _j;	
	private _pictureItemClassName = getText(_CategoryConfig >> "pictureItem");
	private _RecipeCategory = getText(_CategoryConfig >> "category");
	private _RecipeClass = configName _CategoryConfig;	
	private _currentRecipeName = getText(_CategoryConfig >> "name");	
	private _pictureItemConfig = configFile >> "CfgMagazines" >> _pictureItemClassName;
	private _recipePicture = getText(_pictureItemConfig >> "picture");	

	if (_RecipeCategory == _SelectedCategory) then
	{
		private _lbsize = lbSize (_display displayCtrl 74513);
		(_display displayCtrl 74513) lbAdd Format["%1",_currentRecipeName];
		(_display displayCtrl 74513) lbSetPicture [_lbsize,_recipePicture];
		(_display displayCtrl 74513) lbSetData [_lbsize,_RecipeClass];
	}
	else 
	{
		if (_SelectedCategory == "Uncategorized" && _RecipeCategory == "") then
		{
			private _lbsize = lbSize (_display displayCtrl 74513);
			(_display displayCtrl 74513) lbAdd Format["%1",_currentRecipeName];
			(_display displayCtrl 74513) lbSetPicture [_lbsize,_recipePicture];
			(_display displayCtrl 74513) lbSetData [_lbsize,_RecipeClass];
		};		
	};
		
};
	
	lbSort (_display displayCtrl 74513);
	
};

fnc_components_Load = {
private _display = uiNameSpace getVariable ["bramaRecipesGUI", displayNull];

private _equippedMagazines = magazines player;
private _SelectedRecipeCtrl = _this select 0;
SelectedRecipe 	= _SelectedRecipeCtrl lbData (lbCurSel _SelectedRecipeCtrl);

private _components 				   = getArray(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "components");
private _Tools 						   = getArray(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "tools");
private _requiredInteractionModelGroup = getText(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "requiredInteractionModelGroup");
private _requiresOcean 				   = getNumber(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "requiresOcean");
private _requiresConcreteMixer		   = getNumber(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "requiresConcreteMixer");
private _requiresFire 				   = getNumber(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "requiresFire");
private _returnedItems 				   = getArray(missionConfigFile >> "CfgCraftingRecipes" >> SelectedRecipe  >> "returnedItems");

lbClear 74514;

	/***********************
	 * Populate Components *
	 ***********************/	 
	  (_display displayCtrl 74514) lbAdd Format["====== COMPONENTS ======"];
      {
        private _Quantity = _x select 0;
        private _Component = _x select 1;
        
		private _ComponentDispName = getText (configfile >> "CfgMagazines" >> _Component >> "displayName");
		private _ComponentPicture  = getText (configfile >> "CfgMagazines" >> _Component >> "picture");			
		
		//Exile Code
		private _equippedComponentQuantity = { _x == _Component} count _equippedMagazines;
		if (_equippedComponentQuantity < _Quantity ) then
		{
			(_display displayCtrl 74514) lbAdd Format["%3 - [%1/%2]",  _equippedComponentQuantity, _Quantity, _ComponentDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];
		}
		else
		{ 
			(_display displayCtrl 74514) lbAdd Format["%3 - [%1/%2]",  _equippedComponentQuantity, _Quantity, _ComponentDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];			
		};		
		
		
        
		(_display displayCtrl 74514) lbSetPicture [_forEachIndex+1,_ComponentPicture];
		(_display displayCtrl 74514) lbSetData [_forEachIndex+1,_Component];
		
      } forEach _components;
	  
	  
	/***********************
	 * Populate Tools *
	 ***********************/	  
	  if (count _Tools > 0)  then { (_display displayCtrl 74514) lbAdd Format["====== TOOLS ======"]; };
	  
      {	
		
       private _Tool = _x;
        
		private _ToolDispName = getText (configfile >> "CfgMagazines" >> _Tool >> "displayName");
		private _ToolPicture  = getText (configfile >> "CfgMagazines" >> _Tool >> "picture");			
		
		//Exile Code
		private _equippedToolQuantity = { _x == _Tool } count _equippedMagazines;
		if (_equippedToolQuantity == 0 ) then
		{
			(_display displayCtrl 74514) lbAdd Format["%1 - [MISSING]",_ToolDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];			
		}
		else 
		{
			(_display displayCtrl 74514) lbAdd Format["%1 - [OK]",_ToolDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];			
			
		};		
        
		private _lbsize = lbSize (_display displayCtrl 74514);
		(_display displayCtrl 74514) lbSetPicture [_lbsize-1,_ToolPicture];
		(_display displayCtrl 74514) lbSetData [_lbsize-1,_Tool];
      } forEach _Tools;	  
	  
	  
	/***********************
	 * Populate Required   *
	 ***********************/
	  if (_requiredInteractionModelGroup != "" || _requiresOcean == 1 || _requiresFire == 1 || _requiresConcreteMixer == 1)  then { (_display displayCtrl 74514) lbAdd Format["====== REQUIRES ======"]; };
	  
	/***********************
	 * Populate Models   *
	 ***********************/
	 
	  if (_requiredInteractionModelGroup != "")  then 
	  {
		private _foundObject = false;
		
		private _interactionModelGroupConfig = missionConfigFile >> "CfgInteractionModels" >> _requiredInteractionModelGroup;
		private _RequiredDispName = getText(_interactionModelGroupConfig >> "name");
		private _interactionModelGroupModels = getArray(_interactionModelGroupConfig >> "models");
	
		//Exile Code
		if ([ASLtoAGL (getPosASL player), 150, _interactionModelGroupModels] call ExileClient_util_model_isNearby) then
		{
			(_display displayCtrl 74514) lbAdd Format["%1 - [OK]",_RequiredDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];			
			_foundObject = true;	
		}
		else 
		{
			if ( _interactionModelGroupModels call ExileClient_util_model_isLookingAt ) then
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [OK]",_RequiredDispName];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];			
				_foundObject = true;	
			};
		};
		if !(_foundObject) then
		{
			(_display displayCtrl 74514) lbAdd Format["%1 - [MISSING]",_RequiredDispName];
			private _lbsize = lbSize (_display displayCtrl 74514);
			(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];				
		};
	
		private _lbsize = lbSize (_display displayCtrl 74514);
		(_display displayCtrl 74514) lbSetData [_lbsize-1,_requiredInteractionModelGroup];
	  };
	  
	/***********************
	 * Populate Ocean   *
	 ***********************/
	 
	  if (_requiresOcean == 1)  then 
	  {
			//Exile Code
			if !(surfaceIsWater getPos player) then 
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [MISSING]", "Ocean"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];				
			}
			else 
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [OK]", "Ocean"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];				
			};
	  };	  
	  
	/***********************
	 * Populate Concrete Mixer   *
	 ***********************/
	 
	  if (_requiresConcreteMixer == 1)  then 
	  {
			//Exile Code
			private _concreteMixerRequire = (ASLtoAGL (getPosASL player)) call ExileClient_util_world_getNearestConcreteMixer;
			if (isNull _concreteMixerRequire) then 
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [MISSING]", "Concrete Mixer"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];				
			}
			else 
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [OK]", "Concrete Mixer"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];				
			};

	  };	  

	/***********************
	 * Populate Fire   *
	 ***********************/
	 
	  if (_requiresFire == 1)  then 
	  {
			//Exile Code
			if !([player, 150] call ExileClient_util_world_isFireInRange) then 
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [MISSING]", "Fire"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.918, 0, 0,1]];				
			}
			else
			{
				(_display displayCtrl 74514) lbAdd Format["%1 - [OK]", "Fire"];
				private _lbsize = lbSize (_display displayCtrl 74514);
				(_display displayCtrl 74514) lbSetColor [_lbsize-1, [0.698, 0.925, 0,1]];			
			};			

	  };	

	/***********************
	 * Populate Returns   *
	 ***********************/
	 
	 (_display displayCtrl 74514) lbAdd Format["====== RETURNS ======"];
      {
		private _Quantity = _x select 0;
		private _Component = _x select 1;
        
		private _ComponentDispName = getText (configfile >> "CfgMagazines" >> _Component >> "displayName");
		private _ComponentPicture  = getText (configfile >> "CfgMagazines" >> _Component >> "picture");
		
		(_display displayCtrl 74514) lbAdd Format["%2 - [%1]",  _Quantity, _ComponentDispName];
		
		private _lbsize = lbSize (_display displayCtrl 74514);
		(_display displayCtrl 74514) lbSetPicture [_lbsize-1,_ComponentPicture];
		(_display displayCtrl 74514) lbSetData [_lbsize-1,_Component];
		(_display displayCtrl 74515) ctrlSetText _ComponentPicture;
      } forEach _returnedItems; 
};