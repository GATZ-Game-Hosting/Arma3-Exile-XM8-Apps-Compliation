// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************

//Configuration for Airdrop Assistance
//Author: Apoc
// https://github.com/osuapoc

/////////These few setting are used in both original Airdrop Assistance by Apoc and in Dynamic trader drops by Crito////////////////
APOC_AA_AdvancedBanking = false;		// Advanced Banking support. Change false to true if you run Advanced Banking on your server.  Not sure of 0.9.8 compatability.
APOC_AA_UseExileLockerFunds = true;	//Removes funds from player's locker stash instead of their hand
APOC_AA_DamageOnWhenLanded = true;		//Turn object allowDamage back on when object is on ground, instead of when in 'chute

APOC_AA_coolDownTime = 300; //Expressed in sec

UseAPOC_DropLayout = false; //set to false to use dynamic trader drop building by Crito.
							//More setting for Crito's dynamic drops at bottom of file
							
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////If UseAPOC_DropLayout = true use this config layout below////////////////////////////////////////////////////////////////
APOC_AA_Drops =[

	["Medical",
		[
			["Medical Pack 1",			"airdrop_Meds_1",			10000, "supply", 1],
			["Medical Pack 2",			"airdrop_Meds_2",			15000, "supply", 650000],
			["Medical Pack 3",			"airdrop_Meds_3",			20000, "supply", 2000000]
		]
	],
	["Anti Tank",
		[
			["AT Pack 1",				"AT_Pack_1",				20000, "supply", 1],
			["AT Pack 2",				"AT_Pack_2",				25000, "supply", 650000],
			["AT Pack 3",				"AT_Pack_3",				30000, "supply", 2000000]
		]
	],
	["Anti Air",
		[
			["AA Pack",				"AA_Pack",				50000, "supply", 1]
		]
	],
	["Diving",
		[	
			["Swimming Kit",			"Diving_Suit",				8000, "supply", 1]			
		]
	],
	["Boats",
		[
			["Rubber Ducky Boat",		"Exile_Boat_RubberDuck_Black",			8000, "vehicle", 1],
			["SVD Submarine",			"Exile_Boat_SDV_Digital",		      	15000, "vehicle", 25000],
			["Motorboat",		  		"C_Boat_Civil_01_F",			        35000, "vehicle", 50000]
			
		]
	],
	["Civilian Vehicles",
		[
			["Motor Bike",			"Exile_Bike_MountainBike",		    	1000, "vehicle", 1],
			["Octavius",		  	"Exile_Car_Octavius_Black",	  	  		1200, "vehicle", 1],
			["Golf",				"Golf_Civ_pink",			        	2000, "vehicle", 25000],
			["Hatchback",		  	"C_Hatchback_01_F",			      		2000, "vehicle", 25000],
			["UAZ Opem",		  	"Exile_Car_UAZ_Open_Green",				2500, "vehicle", 25000],
			["Landrover",		  	"Exile_Car_LandRover_Red",				2500, "vehicle", 50000],
			["Offroad",				"Exile_Car_Offroad_BlueCustom",	  		2500, "vehicle", 50000],
			["Volha",				"Exile_Car_Volha_White",				2800, "vehicle", 50000]
			
		]
	],
	["Light Unarmed Vehicles",
		[
			["MB 4WD",				"Exile_Car_MB4WD",						2500, "vehicle", 100000],
			["Arma 2 SUV",			"Exile_Car_SUVXL_Black",		  		12000, "vehicle", 100000],
			["Prowler",				"Exile_Car_ProwlerUnarmed",	  			18000, "vehicle", 225000],
			["Qilin",				"Exile_Car_QilinUnarmed",		    	18000, "vehicle", 225000],
			["BTR-40 Unarmed",		"Exile_Car_BTR40_Green",				25000, "vehicle", 350000],
			["HMMWV",				"Exile_Car_HMMWV_UNA_Desert",			18000, "vehicle", 350000]
		]	
	]
];

APOC_AA_Drop_Contents =[
	["airdrop_Meds_1",
		[
			["itm", ["Exile_Item_Raisins"], 2],
			["itm", ["Exile_Item_MountainDupe"], 1],
			["itm", ["Exile_Item_Bandage"], 8],
			["itm", ["Exile_Item_Defibrillator"], 1]
		]
	],
	["airdrop_Meds_2",
		[
			["itm", ["Exile_Item_Cheathas"], 2],
			["itm", ["Exile_Item_EnergyDrink"], 1],
			["itm", ["Exile_Item_Vishpirin"], 2],
			["itm", ["Exile_Item_Defibrillator"], 1]
		]
	],
	["airdrop_Meds_3",
		[
			["itm", ["Exile_Item_EMRE"], 2],
			["itm", ["Exile_Item_PlasticBottleFreshWater"], 2],
			["itm", ["Exile_Item_InstaDoc"], 1],
			["itm", ["Exile_Item_Defibrillator"], 1]
		]
	],
	["AT_Pack_1",
		[
			["wep", ["launch_MRAWS_sand_F"], 1],
			["itm", ["MRAWS_HEAT_F"], 10],
			["itm", ["MRAWS_HE_F"], 10],
			["itm", ["SatchelCharge_Remote_Mag"], 2]
		]
	],
	["AT_Pack_2",
		[
			["wep", ["launch_NLAW_F"], 1],
			["itm", ["NLAW_F"], 10],
			["itm", ["SatchelCharge_Remote_Mag"], 2],
			["itm", ["Rangefinder"], 1]
		]
	],
	["AT_Pack_3",
		[
			["wep", ["launch_B_Titan_short_F"], 1],
			["itm", ["Titan_AT"], 10],
			["itm", ["SatchelCharge_Remote_Mag"], 2],
			["itm", ["Rangefinder"], 1]
		]
	],
	["AA_Pack",
		[
			["wep", ["launch_B_Titan_F"], 1],
			["itm", ["Titan_AA"], 10]
		]
	],
	["Diving_Suit",
		[
			["itm", ["U_B_Wetsuit"], 1],
			["itm", ["V_RebreatherB"], 1],
			["itm", ["Exile_Glasses_Diving_AAF"], 1],
			["wep", ["arifle_SDAR_F"], 1],
			["itm", ["20Rnd_556x45_UW_mag"], 7]
		]
	]
];


////////////////If UseAPOC_DropLayout = false use this config layout below////////////////////////////////////////////
AD_dropItemPrice = 0.25;	//% price increase of items based off trader prices.
							//(if price is 50 tabs at trader for handgun then this set at 0.25 will make it 62 tabs. 25% of original cost added on)
							
//list of trader names to black list so they do not show up in traders drop list of xm8 app.
//these names can be found in CfgTraders either in your mission.map.pbo config.cpp or you might have moved traders 
//to a traders folder and put these traders in to a single file called CfgTraders.hpp 
////example of what to look for /////
/*
	class Exile_Trader_Armory
	{
		name = "ARMORY";
		showWeaponFilter = 1;
		categories[] =
		{
*/
//So the name to add here would be "ARMORY"
AD_tradersBlackList = 	[
							"COMMUNITY"
						];
				
//list of trader category names to black list so they do not show up in category list box of xm8 app.
//these names can be found in TraderCategories either in your mission.map.pbo config.cpp or you might have moved traders 
//to a traders folder and put these in to their own files.
////example of what to look for /////
/*
	class Launchers
	{
		name = "Launchers";
		icon = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargothrow_ca.paa";
		items[] =
		{
*/
//So the name to add here would be "Launchers"			
AD_categoryBlackList = 	[

						];

//list of item class names to black list so they do not show up in items list box of xm8 app.
//these names can be found in TraderCategories either in your mission.map.pbo config.cpp or you might have moved traders 
//to a traders folder and put these in to their own files.	
////example of what to look for /////
/*
	class Drinks
	{
		name = "Drinks";
		icon = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemacc_ca.paa";
		items[] =
		{
			"Exile_Item_Beer"
*/
//So the name to add here would be "Exile_Item_Beer"							
AD_itemBlackList = 	[

					];